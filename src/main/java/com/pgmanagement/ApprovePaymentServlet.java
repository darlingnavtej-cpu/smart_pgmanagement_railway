package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pgmanagement.util.ActivityUtility;

@WebServlet("/approve-payment")
public class ApprovePaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Connection con = null;
        PreparedStatement pstmt = null;
        PreparedStatement monthStmt = null;
        ResultSet rs = null;

        try {
            int requestId = Integer.parseInt(req.getParameter("requestId"));
            int tenantId = Integer.parseInt(req.getParameter("tenantId"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = com.pgmanagement.util.DBUtil.getConnection();

            monthStmt = con.prepareStatement(
                    "SELECT month_name, amount FROM payment_request WHERE request_id=?"
            );
            monthStmt.setInt(1, requestId);
            rs = monthStmt.executeQuery();

            String monthName = null;
            double requestAmount = 0;

            if (rs.next()) {
                monthName = rs.getString("month_name");
                requestAmount = rs.getDouble("amount");
            }

            rs.close();
            monthStmt.close();

            pstmt = con.prepareStatement(
                    "UPDATE payment_request SET status='Approved' WHERE request_id=?"
            );
            pstmt.setInt(1, requestId);
            pstmt.executeUpdate();
            pstmt.close();

            pstmt = con.prepareStatement(
                    "UPDATE fee SET status='Paid', paid_date=CURDATE() "
                            + "WHERE tenant_id=? AND month_name=?"
            );
            pstmt.setInt(1, tenantId);
            pstmt.setString(2, monthName);
            int row = pstmt.executeUpdate();
            pstmt.close();

            if (row == 0) {
                pstmt = con.prepareStatement(
                        "INSERT INTO fee (tenant_id, month_name, amount, paid_date, status) "
                                + "VALUES (?, ?, ?, CURDATE(), 'Paid')"
                );
                pstmt.setInt(1, tenantId);
                pstmt.setString(2, monthName);
                pstmt.setDouble(3, requestAmount);
                pstmt.executeUpdate();
                pstmt.close();
            }

            ActivityUtility.addActivity("💰 Rent Payment Approved");
            resp.sendRedirect("fetch-payment-requests");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (monthStmt != null) monthStmt.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
