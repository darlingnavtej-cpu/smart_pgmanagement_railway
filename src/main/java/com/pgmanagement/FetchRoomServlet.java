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

@WebServlet("/fetch-rooms")
public class FetchRoomServlet extends HttpServlet {

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

			// Fetch All Rooms
			pstmt = con.prepareStatement("SELECT * FROM room");

			rs = pstmt.executeQuery();

			// Send ResultSet to JSP
			req.setAttribute("resultSet", rs);

			// Forward to displayRooms.jsp
			RequestDispatcher rd = req.getRequestDispatcher("displayRooms.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");

		}
	}
}