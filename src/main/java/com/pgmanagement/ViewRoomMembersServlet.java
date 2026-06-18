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

@WebServlet("/view-room-members")
public class ViewRoomMembersServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// Get Room Number
			int roomNo = Integer.parseInt(req.getParameter("roomNo"));

			// Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect to Tenant Database
			con = com.pgmanagement.util.DBUtil.getConnection();

			// Fetch All Members in that Room
			pstmt = con.prepareStatement("SELECT * FROM tenant WHERE room_no=?");

			pstmt.setInt(1, roomNo);

			rs = pstmt.executeQuery();

			// Send Data to JSP
			req.setAttribute("resultSet", rs);
			req.setAttribute("roomNo", roomNo);

			// Forward to JSP
			RequestDispatcher rd = req.getRequestDispatcher("displayRoomMembers.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
		}
	}
}