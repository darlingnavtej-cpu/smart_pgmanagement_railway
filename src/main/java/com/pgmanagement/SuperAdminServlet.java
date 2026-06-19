package com.pgmanagement;

import com.pgmanagement.util.DBUtil;
import com.pgmanagement.filter.TenantRoutingFilter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/super-admin")
public class SuperAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        String action = req.getParameter("action");

        // Handle logout
        if ("logout".equals(action)) {
            session.removeAttribute("superAdminLoggedIn");
            resp.sendRedirect(req.getContextPath() + "/super-admin");
            return;
        }

        // Handle login challenge
        if ("login".equals(action)) {
            String password = req.getParameter("password");
            String configPassword = System.getenv("SUPER_ADMIN_PASSWORD");
            if (configPassword == null || configPassword.trim().isEmpty()) {
                configPassword = "superadmin123"; // default fallback
            }

            if (configPassword.equals(password)) {
                session.setAttribute("superAdminLoggedIn", true);
                resp.sendRedirect(req.getContextPath() + "/super-admin");
            } else {
                req.setAttribute("errorMessage", "Invalid super admin password!");
                req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            }
            return;
        }

        // Validate super admin authentication
        Boolean loggedIn = (Boolean) session.getAttribute("superAdminLoggedIn");
        if (loggedIn == null || !loggedIn) {
            req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            return;
        }

        // Handle admin actions
        if (action != null) {
            String subdomain = req.getParameter("subdomain");
            if (subdomain != null && !subdomain.trim().isEmpty()) {
                subdomain = subdomain.trim().toLowerCase();
                try {
                    if ("toggle".equals(action)) {
                        toggleTenantStatus(subdomain);
                    } else if ("delete".equals(action)) {
                        deleteTenant(subdomain);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    req.setAttribute("errorMessage", "Action failed: " + e.getMessage());
                }
            }
        }

        // Load tenants list
        List<Map<String, String>> pgList = new ArrayList<>();
        Connection masterCon = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            masterCon = DBUtil.getMasterConnection();
            pstmt = masterCon.prepareStatement("SELECT subdomain, db_name, status FROM tenant_routing ORDER BY subdomain ASC");
            rs = pstmt.executeQuery();

            Class.forName("com.mysql.cj.jdbc.Driver");
            while (rs.next()) {
                String sub = rs.getString("subdomain");
                String dbName = rs.getString("db_name");
                String status = rs.getString("status");

                String pgName = "N/A";
                String ownerName = "N/A";
                String email = "N/A";
                boolean dbOnline = false;

                // Query details directly from the isolated tenant database
                try (Connection tenantCon = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, "root", "admin");
                     PreparedStatement tPstmt = tenantCon.prepareStatement("SELECT pg_name, owner_name, email FROM pg_info LIMIT 1");
                     ResultSet tRs = tPstmt.executeQuery()) {
                    if (tRs.next()) {
                        pgName = tRs.getString("pg_name");
                        ownerName = tRs.getString("owner_name");
                        email = tRs.getString("email");
                        dbOnline = true;
                    }
                } catch (Exception tenantEx) {
                    // Fail silently so a corrupt/offline database does not crash the entire list
                    System.err.println("SuperAdminServlet: Cannot read details for schema " + dbName + ": " + tenantEx.getMessage());
                }

                Map<String, String> pg = new HashMap<>();
                pg.put("subdomain", sub);
                pg.put("dbName", dbName);
                pg.put("status", status);
                pg.put("pgName", pgName);
                pg.put("ownerName", ownerName);
                pg.put("email", email);
                pg.put("dbOnline", String.valueOf(dbOnline));
                pgList.add(pg);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Error loading tenant list: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (masterCon != null) masterCon.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        req.setAttribute("pgList", pgList);
        req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
    }

    private void toggleTenantStatus(String subdomain) throws Exception {
        Connection masterCon = null;
        PreparedStatement selectStmt = null;
        PreparedStatement updateStmt = null;
        ResultSet rs = null;

        try {
            masterCon = DBUtil.getMasterConnection();
            selectStmt = masterCon.prepareStatement("SELECT status FROM tenant_routing WHERE subdomain = ?");
            selectStmt.setString(1, subdomain);
            rs = selectStmt.executeQuery();

            if (rs.next()) {
                String currentStatus = rs.getString("status");
                String newStatus = "active".equalsIgnoreCase(currentStatus) ? "inactive" : "active";

                updateStmt = masterCon.prepareStatement("UPDATE tenant_routing SET status = ? WHERE subdomain = ?");
                updateStmt.setString(1, newStatus);
                updateStmt.setString(2, subdomain);
                updateStmt.executeUpdate();

                // Clear tenant context cache to apply change instantly
                TenantRoutingFilter.clearCacheForTenant(subdomain);
                System.out.println("SuperAdminServlet: Tenant '" + subdomain + "' status toggled to " + newStatus);
            }
        } finally {
            if (rs != null) rs.close();
            if (selectStmt != null) selectStmt.close();
            if (updateStmt != null) updateStmt.close();
            if (masterCon != null) masterCon.close();
        }
    }

    private void deleteTenant(String subdomain) throws Exception {
        // Prevent deleting core system routes
        if ("admin".equalsIgnoreCase(subdomain)) {
            throw new IllegalArgumentException("Cannot delete default admin routing database.");
        }

        Connection masterCon = null;
        PreparedStatement deleteStmt = null;
        Statement dropStmt = null;

        try {
            masterCon = DBUtil.getMasterConnection();
            
            // 1. Remove from master database registry
            deleteStmt = masterCon.prepareStatement("DELETE FROM tenant_routing WHERE subdomain = ?");
            deleteStmt.setString(1, subdomain);
            deleteStmt.executeUpdate();

            // 2. Drop the isolated database
            String dbName = "smart_pg_" + subdomain;
            dropStmt = masterCon.createStatement();
            dropStmt.executeUpdate("DROP DATABASE " + dbName);

            // 3. Invalidate route cache
            TenantRoutingFilter.clearCacheForTenant(subdomain);
            System.out.println("SuperAdminServlet: Tenant '" + subdomain + "' registry removed and database '" + dbName + "' dropped.");
        } finally {
            if (deleteStmt != null) deleteStmt.close();
            if (dropStmt != null) dropStmt.close();
            if (masterCon != null) masterCon.close();
        }
    }
}
