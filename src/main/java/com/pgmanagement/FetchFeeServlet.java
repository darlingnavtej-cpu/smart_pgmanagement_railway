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

@WebServlet("/fetch-fees")
public class FetchFeeServlet extends HttpServlet {

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

			// Fetch All Fee Records
			String type = req.getParameter("type");

			if (type != null && type.equals("pending")) {

				pstmt = con.prepareStatement(
						"SELECT * FROM fee WHERE status='Pending'");

			} else {

				pstmt = con.prepareStatement(
						"SELECT * FROM fee");

			}

			rs = pstmt.executeQuery();

			// Send ResultSet to JSP
			req.setAttribute("resultSet", rs);

			// Forward to displayFees.jsp
			RequestDispatcher rd = req.getRequestDispatcher("displayFees.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");

		}
	}
}