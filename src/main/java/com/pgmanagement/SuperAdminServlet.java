package com.pgmanagement;

import com.pgmanagement.util.DBUtil;
import com.pgmanagement.filter.TenantRoutingFilter;
import com.pgmanagement.util.EmailUtility;
import com.pgmanagement.util.HashUtil;

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

    private void ensureSuperAdminTable() {
        try (Connection con = DBUtil.getMasterConnection();
             Statement stmt = con.createStatement()) {
            // Create table in the master database if it doesn't exist
            stmt.execute("CREATE TABLE IF NOT EXISTS `super_admin_config` (" +
                         "  `email` varchar(100) NOT NULL," +
                         "  `password_hash` varchar(100) NOT NULL," +
                         "  PRIMARY KEY (`email`)" +
                         ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
            
            // Seed default super admin if database is blank
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM super_admin_config")) {
                if (rs.next() && rs.getInt(1) == 0) {
                    String defaultPass = System.getenv("SUPER_ADMIN_PASSWORD");
                    if (defaultPass == null || defaultPass.trim().isEmpty()) {
                        defaultPass = "superadmin123";
                    }
                    String hashed = HashUtil.hashPassword(defaultPass);
                    try (PreparedStatement pstmt = con.prepareStatement(
                            "INSERT INTO super_admin_config (email, password_hash) VALUES (?, ?)")) {
                        pstmt.setString(1, "smartpgmanage@gmail.com");
                        pstmt.setString(2, hashed);
                        pstmt.executeUpdate();
                        System.out.println("SuperAdminServlet: Seeded default super admin account for smartpgmanage@gmail.com");
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("SuperAdminServlet: Error checking/creating super_admin_config table:");
            e.printStackTrace();
        }
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(true);
        String action = req.getParameter("action");

        // Ensure table exists on first touch
        ensureSuperAdminTable();

        // Handle logout
        if ("logout".equals(action)) {
            session.removeAttribute("superAdminLoggedIn");
            resp.sendRedirect(req.getContextPath() + "/super-admin");
            return;
        }

        // =====================================================================
        // UNRESTRICTED ACTIONS (Forgot Password OTP flow)
        // =====================================================================
        if ("forgot-form".equals(action)) {
            req.setAttribute("state", "forgot-password");
            req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            return;
        }

        if ("send-otp".equals(action)) {
            String email = req.getParameter("email");
            if ("smartpgmanage@gmail.com".equalsIgnoreCase(email)) {
                int otp = (int) (Math.random() * 900000) + 100000;
                session.setAttribute("superAdminOtp", otp);
                session.setAttribute("superAdminResetEmail", email);
                
                String subject = "Smart PG Super Admin Passcode Reset OTP";
                String body = "Dear Super Admin,\n\n"
                        + "Your OTP for resetting the Master Passcode is:\n\n"
                        + otp + "\n\n"
                        + "This OTP is valid for 5 minutes. Do not share this OTP with anyone.\n\n"
                        + "Regards,\n"
                        + "Smart PG SaaS Ecosystem";
                
                EmailUtility.sendEmail(email, subject, body);
                req.setAttribute("state", "verify-otp");
                req.setAttribute("successMessage", "OTP sent successfully to smartpgmanage@gmail.com!");
            } else {
                req.setAttribute("state", "forgot-password");
                req.setAttribute("errorMessage", "Invalid registered email address!");
            }
            req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            return;
        }

        if ("verify-otp".equals(action)) {
            String userOtp = req.getParameter("otp");
            Integer originalOtp = (Integer) session.getAttribute("superAdminOtp");
            if (originalOtp != null && userOtp != null && userOtp.trim().equals(String.valueOf(originalOtp))) {
                req.setAttribute("state", "reset-password");
            } else {
                req.setAttribute("state", "verify-otp");
                req.setAttribute("errorMessage", "Invalid OTP code entered. Please try again.");
            }
            req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            return;
        }

        if ("reset-password".equals(action)) {
            String password = req.getParameter("password");
            String confirmPassword = req.getParameter("confirmPassword");
            String email = (String) session.getAttribute("superAdminResetEmail");
            
            if (email == null) {
                resp.sendRedirect(req.getContextPath() + "/super-admin");
                return;
            }
            
            if (password == null || !password.equals(confirmPassword)) {
                req.setAttribute("state", "reset-password");
                req.setAttribute("errorMessage", "Passwords do not match!");
                req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
                return;
            }
            
            try (Connection con = DBUtil.getMasterConnection();
                 PreparedStatement pstmt = con.prepareStatement(
                         "UPDATE super_admin_config SET password_hash = ? WHERE email = ?")) {
                pstmt.setString(1, HashUtil.hashPassword(password));
                pstmt.setString(2, email);
                pstmt.executeUpdate();
                
                session.removeAttribute("superAdminOtp");
                session.removeAttribute("superAdminResetEmail");
                
                req.setAttribute("successMessage", "Master Passcode reset successfully! Log in now.");
            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("state", "reset-password");
                req.setAttribute("errorMessage", "Database update failed: " + e.getMessage());
            }
            req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            return;
        }

        // Handle login challenge
        if ("login".equals(action)) {
            String password = req.getParameter("password");
            boolean authenticated = false;
            String email = "smartpgmanage@gmail.com";
            
            try (Connection con = DBUtil.getMasterConnection();
                 PreparedStatement pstmt = con.prepareStatement(
                         "SELECT password_hash FROM super_admin_config WHERE email = ?")) {
                pstmt.setString(1, email);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String dbHash = rs.getString("password_hash");
                        if (dbHash != null && dbHash.equals(HashUtil.hashPassword(password))) {
                            authenticated = true;
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (authenticated) {
                session.setAttribute("superAdminLoggedIn", true);
                resp.sendRedirect(req.getContextPath() + "/super-admin");
            } else {
                req.setAttribute("errorMessage", "Invalid master passcode!");
                req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            }
            return;
        }

        // =====================================================================
        // RESTRICTED ACTIONS (Requires authentication)
        // =====================================================================
        Boolean loggedIn = (Boolean) session.getAttribute("superAdminLoggedIn");
        if (loggedIn == null || !loggedIn) {
            req.getRequestDispatcher("/superAdmin.jsp").forward(req, resp);
            return;
        }

        // Handle password change request
        if ("change-password".equals(action)) {
            String oldPassword = req.getParameter("oldPassword");
            String newPassword = req.getParameter("newPassword");
            String confirmNewPassword = req.getParameter("confirmNewPassword");
            String email = "smartpgmanage@gmail.com";
            
            if (newPassword == null || !newPassword.equals(confirmNewPassword)) {
                req.setAttribute("errorMessage", "New passwords do not match!");
            } else {
                boolean verified = false;
                try (Connection con = DBUtil.getMasterConnection();
                     PreparedStatement pstmt = con.prepareStatement(
                             "SELECT password_hash FROM super_admin_config WHERE email = ?")) {
                    pstmt.setString(1, email);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            String dbHash = rs.getString("password_hash");
                            if (dbHash != null && dbHash.equals(HashUtil.hashPassword(oldPassword))) {
                                verified = true;
                            }
                        }
                    }
                    
                    if (verified) {
                        try (PreparedStatement updatePstmt = con.prepareStatement(
                                "UPDATE super_admin_config SET password_hash = ? WHERE email = ?")) {
                            updatePstmt.setString(1, HashUtil.hashPassword(newPassword));
                            updatePstmt.setString(2, email);
                            updatePstmt.executeUpdate();
                            req.setAttribute("successMessage", "Master passcode updated successfully!");
                        }
                    } else {
                        req.setAttribute("errorMessage", "Incorrect current passcode!");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    req.setAttribute("errorMessage", "Database update failed: " + e.getMessage());
                }
            }
        }

        // Handle admin tenant actions
        if (action != null) {
            String subdomain = req.getParameter("subdomain");
            if (subdomain != null && !subdomain.trim().isEmpty()) {
                subdomain = subdomain.trim().toLowerCase();
                try {
                    if ("toggle".equals(action)) {
                        toggleTenantStatus(subdomain);
                    } else if ("delete".equals(action)) {
                        deleteTenant(subdomain);
                    } else if ("impersonate".equals(action)) {
                        // Bind tenant database context to browser session
                        session.setAttribute("current_tenant", subdomain);
                        // Bind administrator role credentials to bypass login page
                        session.setAttribute("adminUsername", "admin");
                        session.setAttribute("role", "admin");
                        session.setAttribute("authenticated_tenant", subdomain);
                        
                        resp.sendRedirect(req.getContextPath() + "/dashboard");
                        return;
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
                try (Connection tenantCon = DBUtil.getConnection(dbName);
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
            dropStmt.executeUpdate("DROP DATABASE `" + dbName + "`");

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
