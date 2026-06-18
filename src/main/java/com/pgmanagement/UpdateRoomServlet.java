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

@WebServlet("/update-room")
public class UpdateRoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {

            // Get Form Data
            int roomNo =
                    Integer.parseInt(req.getParameter("roomNo"));

            int capacity =
                    Integer.parseInt(req.getParameter("capacity"));

            int occupied =
                    Integer.parseInt(req.getParameter("occupied"));

            double rent =
                    Double.parseDouble(req.getParameter("rent"));

            // Load Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create Connection
            con = com.pgmanagement.util.DBUtil.getConnection();

            // Update Query
            pstmt = con.prepareStatement(
                    "update room set capacity=?, occupied=?, rent=? where room_no=?");

            pstmt.setInt(1, capacity);
            pstmt.setInt(2, occupied);
            pstmt.setDouble(3, rent);
            pstmt.setInt(4, roomNo);

            int row = pstmt.executeUpdate();

            if (row > 0) {

                // Redirect to Room List
                resp.sendRedirect("fetch-rooms");

            } else {

                resp.getWriter().println("<h2>Room Update Failed</h2>");

            }

        } catch (ClassNotFoundException | SQLException e) {

            e.printStackTrace();

            resp.getWriter().println(
                    "<h2>Error : " + e.getMessage() + "</h2>");

        } catch (NumberFormatException e) {

            resp.getWriter().println(
                    "<h2>Please Enter Valid Numbers</h2>");

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