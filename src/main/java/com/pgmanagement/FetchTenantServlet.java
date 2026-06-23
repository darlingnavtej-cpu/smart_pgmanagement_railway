package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fetch-tenants")
public class FetchTenantServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {

        // Load Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Create Connection
        con = com.pgmanagement.util.DBUtil.getConnection();

        // Run migrations dynamically to ensure columns exist in active schema
        try (java.sql.Statement migrationStmt = con.createStatement()) {
            migrationStmt.executeUpdate("ALTER TABLE tenant ADD COLUMN IF NOT EXISTS aadhar_number varchar(20) DEFAULT NULL");
            migrationStmt.executeUpdate("ALTER TABLE tenant ADD COLUMN IF NOT EXISTS address varchar(255) DEFAULT NULL");
        } catch (Exception migrationEx) {
            System.err.println("Database auto-migration warning: " + migrationEx.getMessage());
        }

        // Fetch Query
        pstmt = con.prepareStatement(
                "SELECT * FROM tenant");

        rs = pstmt.executeQuery();

        // Store ResultSet in Request Scope
        req.setAttribute("resultSet", rs);

        // Forward to JSP
        RequestDispatcher rd =
                req.getRequestDispatcher("displayTenants.jsp");

        rd.forward(req, resp);

    } catch (Exception e) {

        e.printStackTrace();

    }
}

}
