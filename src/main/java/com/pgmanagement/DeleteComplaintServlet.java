package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete-complaint")
public class DeleteComplaintServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException{

        try{

            int complaintId =
            Integer.parseInt(
            req.getParameter("complaintId"));

            Class.forName(
            "com.mysql.cj.jdbc.Driver");

            Connection con =
            com.pgmanagement.util.DBUtil.getConnection();

            PreparedStatement pstmt =
            con.prepareStatement(

            "DELETE FROM complaint WHERE complaint_id=?"

            );

            pstmt.setInt(1,
            complaintId);

            pstmt.executeUpdate();

            resp.sendRedirect(
            "fetch-complaints");

            pstmt.close();
            con.close();

        } catch(Exception e){

            e.printStackTrace();
            com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "fetch-complaints");

        }

    }

}