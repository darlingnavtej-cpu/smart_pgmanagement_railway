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

            resp.getWriter().println(
            "<h2>New Password and Confirm Password do not match</h2>");

            return;
        }

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try{

            Class.forName(
            "com.mysql.cj.jdbc.Driver");

            con =
            DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/smart_pg",
            "root",
            "admin");

            pstmt =
            con.prepareStatement(
            "SELECT * FROM tenant WHERE tenant_id=? AND password=?");

            pstmt.setInt(1, tenantId);

            pstmt.setString(2, oldPassword);

            rs = pstmt.executeQuery();

            if(rs.next()){

                pstmt.close();

                pstmt =
                con.prepareStatement(
                "UPDATE tenant SET password=? WHERE tenant_id=?");

                pstmt.setString(
                1,
                newPassword);

                pstmt.setInt(
                2,
                tenantId);

                int row =
                pstmt.executeUpdate();

                if(row > 0){

                    resp.getWriter().println(

                    "<script>" +

                    "alert('Password Changed Successfully');" +

                    "window.location='tenant-dashboard';" +

                    "</script>"

                    );

                }

            }
            else{

                resp.getWriter().println(

                "<script>" +

                "alert('Current Password Incorrect');" +

                "window.location='changePassword.jsp';" +

                "</script>"

                );

            }

        }
        catch(Exception e){

            e.printStackTrace();

        }

    }
}