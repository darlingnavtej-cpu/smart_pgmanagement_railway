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
import javax.servlet.http.HttpSession;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session =
        req.getSession(false);

        Integer tenantId =
        (Integer)session.getAttribute("tenantId");

        String oldPassword =
        req.getParameter("oldPassword");

        String newPassword =
        req.getParameter("newPassword");

        String confirmPassword =
        req.getParameter("confirmPassword");

        if(!newPassword.equals(confirmPassword)){

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Validation Error", "New Password and Confirm Password do not match", "warning", "changePassword.jsp");

            return;
        }

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try{

            Class.forName(
            "com.mysql.cj.jdbc.Driver");

            con =
            com.pgmanagement.util.DBUtil.getConnection();

            pstmt =
            con.prepareStatement(
            "SELECT * FROM tenant WHERE tenant_id=? AND password=?");

            pstmt.setInt(1, tenantId);

            pstmt.setString(2, com.pgmanagement.util.HashUtil.hashPassword(oldPassword));

            rs = pstmt.executeQuery();

            if(rs.next()){

                pstmt.close();

                pstmt =
                con.prepareStatement(
                "UPDATE tenant SET password=? WHERE tenant_id=?");

                pstmt.setString(
                1,
                com.pgmanagement.util.HashUtil.hashPassword(newPassword));

                pstmt.setInt(
                2,
                tenantId);

                int row =
                pstmt.executeUpdate();

                if(row > 0){

					com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Success", "Password Changed Successfully", "success", "tenant-dashboard");

                }

            }
            else{

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Incorrect Password", "Current Password Incorrect", "error", "changePassword.jsp");

            }

        }
        catch(Exception e){

            e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "changePassword.jsp");

        }

    }
}