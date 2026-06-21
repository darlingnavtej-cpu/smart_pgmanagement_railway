package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete-room")
public class DeleteRoomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            // Get Room Number
            int roomNo = Integer.parseInt(
                    req.getParameter("roomNo"));

            // Load Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create Connection
            con = com.pgmanagement.util.DBUtil.getConnection();

            // Delete Query
            pstmt = con.prepareStatement(
                    "delete from room where room_no=?");

            pstmt.setInt(1, roomNo);

            int row = pstmt.executeUpdate();

            if (row > 0) {

                // Refresh room list
                resp.sendRedirect("fetch-rooms");

            } else {

                com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Room Deletion Failed", "error", "fetch-rooms");

            }

        } catch (ClassNotFoundException | SQLException e) {

            e.printStackTrace();
            com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "fetch-rooms");

        } finally {

            try {

                if (pstmt != null)
                    pstmt.close();

                if (con != null)
                    con.close();

            } catch (SQLException e) {

                e.printStackTrace();

            }
        }
    }
}