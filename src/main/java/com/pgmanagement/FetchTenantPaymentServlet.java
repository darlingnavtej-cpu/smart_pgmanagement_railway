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
import javax.servlet.http.HttpSession;

@WebServlet("/tenant-payment")
public class FetchTenantPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            HttpSession session = req.getSession();
            int tenantId = (Integer) session.getAttribute("tenantId");
            String tenantName = (String) session.getAttribute("tenantName");
            int roomNo = (Integer) session.getAttribute("roomNo");

            req.setAttribute("tenantId", tenantId);
            req.setAttribute("tenantName", tenantName);
            req.setAttribute("roomNo", roomNo);

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = com.pgmanagement.util.DBUtil.getConnection();
            pstmt = con.prepareStatement(
                    "SELECT * FROM fee "
                            + "WHERE tenant_id=? "
                            + "ORDER BY fee_id DESC "
                            + "LIMIT 1"
            );
            pstmt.setInt(1, tenantId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                req.setAttribute("monthName", rs.getString("month_name"));
                req.setAttribute("amount", rs.getInt("amount"));
                req.setAttribute("status", rs.getString("status"));
            }

            rs.close();
            pstmt.close();
            con.close();

            con = com.pgmanagement.util.DBUtil.getConnection();
            pstmt = con.prepareStatement(
                    "SELECT * FROM payment_details "
                            + "ORDER BY payment_id DESC "
                            + "LIMIT 1"
            );
            rs = pstmt.executeQuery();

            if (rs.next()) {
                req.setAttribute("ownerName", rs.getString("owner_name"));
                req.setAttribute("bankName", rs.getString("bank_name"));
                req.setAttribute("accountNumber", rs.getString("account_number"));
                req.setAttribute("ifscCode", rs.getString("ifsc_code"));
                req.setAttribute("upiId", rs.getString("upi_id"));
                req.setAttribute("qrImage", rs.getString("qr_image"));
            }

            RequestDispatcher rd = req.getRequestDispatcher("tenantPayment.jsp");
            rd.forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
