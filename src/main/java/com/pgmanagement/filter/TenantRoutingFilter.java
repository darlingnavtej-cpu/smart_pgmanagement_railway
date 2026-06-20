package com.pgmanagement.filter;

import com.pgmanagement.util.DBUtil;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class TenantRoutingFilter implements Filter {

    private static final Map<String, String> tenantDbCache = new ConcurrentHashMap<>();

    static {
        // Pre-populate default static mappings to prevent database query on startup/healthchecks
        tenantDbCache.put("admin", "smart_pg");
        tenantDbCache.put("royal", "smart_pg_royal");
        tenantDbCache.put("palms", "smart_pg_palms");
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        
        // Bypass connection routing for static resources (CSS, JS, images, etc.) to optimize performance
        String path = req.getRequestURI().substring(req.getContextPath().length());
        if (path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/") ||
            path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") ||
            path.endsWith(".jpg") || path.endsWith(".jpeg") || path.endsWith(".gif") ||
            path.endsWith(".svg") || path.endsWith(".ico") || path.endsWith(".woff") ||
            path.endsWith(".woff2") || path.endsWith(".ttf")) {
            chain.doFilter(request, response);
            return;
        }

        String tenant = null;

        // 1. Check for 'tenant' query parameter first (ideal for local development/testing)
        String paramTenant = req.getParameter("tenant");
        HttpSession session = req.getSession(false);

        if (paramTenant != null && !paramTenant.trim().isEmpty()) {
            tenant = paramTenant.trim();
            // Store it in session so subsequent requests without the parameter stay on this tenant
            req.getSession(true).setAttribute("current_tenant", tenant);
        } else if (session != null) {
            // Check session
            tenant = (String) session.getAttribute("current_tenant");
        }

        // 2. Fallback to Subdomain routing if no query param or session is set
        if (tenant == null) {
            String serverName = req.getServerName(); // e.g. royal.smartpg.com
            
            // Check for direct IP address, localhost, or Railway internal domains
            if (serverName.equalsIgnoreCase("localhost") || 
                serverName.equals("127.0.0.1") || 
                serverName.contains("internal") || 
                serverName.contains("railway") ||
                serverName.contains("smart-pg-management")) {
                tenant = "admin";
            } else {
                String[] parts = serverName.split("\\.");
                if (parts.length > 2 && !parts[0].equalsIgnoreCase("www")) {
                    tenant = parts[0];
                } else if (parts.length == 2 && serverName.endsWith(".localhost")) {
                    // e.g. royal.localhost
                    tenant = parts[0];
                }
            }
        }

        // Default fallback
        if (tenant == null) {
            tenant = "admin"; // default to default smart_pg DB
        }

        // 3. Resolve database name from cache or database lookup
        String dbSchema = resolveDatabaseName(tenant);

        // 4. Bind connection context to this thread
        DBUtil.setCurrentDb(dbSchema);

        javax.servlet.http.HttpServletResponse resp = (javax.servlet.http.HttpServletResponse) response;

        // 5. Authenticate and authorize tenant database context
        if (!isPublicPath(path)) {
            session = req.getSession(false);
            if (isTenantPath(path)) {
                if (session == null || session.getAttribute("tenantId") == null) {
                    resp.sendRedirect(req.getContextPath() + "/tenantLogin.jsp");
                    return;
                }
                String authTenant = (String) session.getAttribute("authenticated_tenant");
                if (authTenant == null || !authTenant.equalsIgnoreCase(tenant)) {
                    resp.sendRedirect(req.getContextPath() + "/tenantLogin.jsp?error=unauthorized");
                    return;
                }
            } else {
                if (session == null || session.getAttribute("adminUsername") == null) {
                    resp.sendRedirect(req.getContextPath() + "/login.jsp");
                    return;
                }
                String authTenant = (String) session.getAttribute("authenticated_tenant");
                if (authTenant == null || !authTenant.equalsIgnoreCase(tenant)) {
                    resp.sendRedirect(req.getContextPath() + "/login.jsp?error=unauthorized");
                    return;
                }
            }
        }

        try {
            chain.doFilter(request, response);
        } finally {
            // 6. Always clear current DB context to avoid thread pollution
            DBUtil.clear();
        }
    }

    private boolean isPublicPath(String path) {
        if (path == null || path.trim().isEmpty() || path.equals("/")) {
            return true;
        }
        String p = path.trim();
        if (p.equals("/index.jsp") ||
            p.equals("/login.jsp") || p.equals("/login") ||
            p.equals("/tenantLogin.jsp") || p.equals("/tenant-login") ||
            p.equals("/registerSaaS.jsp") || p.equals("/register-tenant") ||
            p.equals("/super-admin") || p.equals("/superAdmin.jsp") ||
            p.equals("/forgotPassword.jsp") || p.equals("/forgot-password") ||
            p.equals("/send-otp") || p.equals("/verify-otp") || p.equals("/verifyOtp.jsp") ||
            p.equals("/reset-password") || p.equals("/resetPassword.jsp") ||
            p.equals("/tenantForgotPassword.jsp") || p.equals("/tenant-forgot-password") ||
            p.equals("/tenant-send-otp") || p.equals("/tenant-verify-otp") || p.equals("/tenantVerifyOtp.jsp") ||
            p.equals("/tenant-reset-password") || p.equals("/tenantResetPassword.jsp") ||
            p.equals("/logout") || p.equals("/tenant-logout") ||
            p.equals("/test-email")) {
            return true;
        }
        return false;
    }

    private boolean isTenantPath(String path) {
        String lower = path.toLowerCase();
        
        // Admin-specific paths that might contain 'complaint' or other keyword matches
        if (lower.startsWith("/fetch-") || 
            lower.contains("display") || 
            lower.contains("resolve") || 
            lower.contains("delete") || 
            lower.contains("update") || 
            lower.contains("find-") ||
            lower.contains("approve") ||
            lower.contains("reject") ||
            lower.contains("salary")) {
            return false;
        }

        return lower.contains("tenant") || 
               lower.contains("complaint") || 
               lower.contains("submit") || 
               lower.contains("contactadmin") || 
               lower.contains("changepassword");
    }

    private String resolveDatabaseName(String subdomain) {
        if (tenantDbCache.containsKey(subdomain)) {
            return tenantDbCache.get(subdomain);
        }

        String dbSchema = "smart_pg"; // default fallback
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            con = DBUtil.getMasterConnection();
            pstmt = con.prepareStatement("SELECT db_name FROM tenant_routing WHERE subdomain = ? AND status = 'active'");
            pstmt.setString(1, subdomain);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                dbSchema = rs.getString("db_name");
            }
            // Cache the resolved DB schema (whether default or custom) to avoid future DB lookups
            tenantDbCache.put(subdomain, dbSchema);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return dbSchema;
    }

    @Override
    public void destroy() {}

    // Public method to invalidate cache when a new tenant registers
    public static void clearCacheForTenant(String subdomain) {
        tenantDbCache.remove(subdomain);
    }
}
