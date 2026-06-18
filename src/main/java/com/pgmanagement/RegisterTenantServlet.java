package com.pgmanagement;

import com.pgmanagement.util.DBUtil;
import com.pgmanagement.filter.TenantRoutingFilter;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register-tenant")
public class RegisterTenantServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        String subdomain = req.getParameter("subdomain");
        String pgName = req.getParameter("pgName");
        String ownerName = req.getParameter("ownerName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (subdomain == null || subdomain.trim().isEmpty() ||
            pgName == null || pgName.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            out.println("<h2>Error: Missing required fields.</h2>");
            return;
        }

        // Clean subdomain
        subdomain = subdomain.trim().toLowerCase().replaceAll("[^a-z0-9-]", "");
        String dbName = "smart_pg_" + subdomain;

        Connection masterCon = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;
        ResultSet rs = null;

        try {
            masterCon = DBUtil.getMasterConnection();
            
            // 1. Check if tenant already exists
            checkStmt = masterCon.prepareStatement("SELECT COUNT(*) FROM tenant_routing WHERE subdomain = ?");
            checkStmt.setString(1, subdomain);
            rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                out.println("<h2>Error: Subdomain '" + subdomain + "' is already registered.</h2>");
                return;
            }
            rs.close();
            checkStmt.close();

            // 2. Create the Database Schema
            Statement createDbStmt = masterCon.createStatement();
            createDbStmt.executeUpdate("CREATE DATABASE " + dbName);
            createDbStmt.close();
            System.out.println("RegisterTenantServlet: Database schema '" + dbName + "' created.");

            // 3. Initialize Tables in the new database by parsing init.sql
            initializeTenantTables(dbName);

            // 4. Seed PG details & Admin Account inside the new database
            seedNewTenant(dbName, pgName, ownerName, email, password);

            // 5. Register in Master routing database
            insertStmt = masterCon.prepareStatement("INSERT INTO tenant_routing (subdomain, db_name, status) VALUES (?, ?, 'active')");
            insertStmt.setString(1, subdomain);
            insertStmt.setString(2, dbName);
            insertStmt.executeUpdate();

            // 6. Invalidate tenant cache to force reload
            TenantRoutingFilter.clearCacheForTenant(subdomain);

            // 7. Redirect or output success
            out.println("<h2>Tenant registered successfully!</h2>");
            out.println("<p>Your PG SaaS portal is ready at: <a href='http://" + subdomain + ".localhost:8080/spg/login.jsp'>http://" + subdomain + ".localhost:8080/spg/login.jsp</a></p>");
            out.println("<p>(Or test locally at: <a href='login.jsp?tenant=" + subdomain + "'>login.jsp?tenant=" + subdomain + "</a>)</p>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h2>Registration Error: " + e.getMessage() + "</h2>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (checkStmt != null) checkStmt.close();
                if (insertStmt != null) insertStmt.close();
                if (masterCon != null) masterCon.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    private void initializeTenantTables(String dbName) throws Exception {
        // Find init.sql file
        File sqlFile = new File("/opt/init.sql");
        if (!sqlFile.exists()) {
            sqlFile = new File("C:/Users/Navateja/Desktop/spg/init.sql");
        }
        if (!sqlFile.exists()) {
            sqlFile = new File("init.sql");
        }

        if (!sqlFile.exists()) {
            throw new IOException("init.sql schema file not found in common locations.");
        }

        // Read and parse sql file
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(sqlFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                // Ignore comments
                if (line.trim().startsWith("--") || line.trim().startsWith("#")) {
                    continue;
                }
                sb.append(line).append("\n");
            }
        }

        // Split queries by semicolon
        String[] rawStatements = sb.toString().split(";");
        List<String> statementsToExecute = new ArrayList<>();

        for (String rawStmt : rawStatements) {
            String stmt = rawStmt.trim();
            if (stmt.isEmpty()) {
                continue;
            }

            // Skip database creation, use commands, and compatibility views
            String upper = stmt.toUpperCase();
            if (upper.startsWith("CREATE DATABASE") || 
                upper.startsWith("USE ") || 
                upper.contains("CREATE OR REPLACE VIEW") ||
                upper.contains("PG_INFO_TABLE") || 
                upper.contains("TENANT_TABLE")) {
                continue;
            }
            statementsToExecute.add(stmt);
        }

        // Run DDL statements on the new database schema
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, "root", "admin");
             Statement sqlStatement = conn.createStatement()) {
            for (String sql : statementsToExecute) {
                try {
                    sqlStatement.execute(sql);
                } catch (Exception stmtEx) {
                    System.err.println("RegisterTenantServlet: Warning - statement failed: " + sql + " | Error: " + stmtEx.getMessage());
                }
            }
        }
    }

    private void seedNewTenant(String dbName, String pgName, String ownerName, String email, String password) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, "root", "admin")) {
            
            // Seed PG Info (id=1 is hardcoded throughout the application)
            String insertPgInfo = "INSERT INTO pg_info (id, pg_name, owner_name, email, rating) VALUES (1, ?, ?, ?, 5.0) " +
                                  "ON DUPLICATE KEY UPDATE pg_name=?, owner_name=?, email=?";
            try (PreparedStatement pstmt = conn.prepareStatement(insertPgInfo)) {
                pstmt.setString(1, pgName);
                pstmt.setString(2, ownerName != null ? ownerName : "PG Owner");
                pstmt.setString(3, email != null ? email : "admin@smartpg.com");
                pstmt.setString(4, pgName);
                pstmt.setString(5, ownerName != null ? ownerName : "PG Owner");
                pstmt.setString(6, email != null ? email : "admin@smartpg.com");
                pstmt.executeUpdate();
            }

            // Seed Admin Credentials
            String insertAdmin = "INSERT INTO newreg (username, password, email) VALUES ('admin', ?, ?) " +
                                 "ON DUPLICATE KEY UPDATE password=?, email=?";
            try (PreparedStatement pstmt = conn.prepareStatement(insertAdmin)) {
                pstmt.setString(1, password);
                pstmt.setString(2, email != null ? email : "admin@smartpg.com");
                pstmt.setString(3, password);
                pstmt.setString(4, email != null ? email : "admin@smartpg.com");
                pstmt.executeUpdate();
            }
        }
    }
}
