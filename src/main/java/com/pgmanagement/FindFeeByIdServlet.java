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

@WebServlet("/find-fee-by-id")
public class FindFeeByIdServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// Get Fee ID
			int feeId = Integer.parseInt(req.getParameter("feeId"));

			// Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection
			con = com.pgmanagement.util.DBUtil.getConnection();

			// Fetch Particular Fee Record
			pstmt = con.prepareStatement("SELECT * FROM fee WHERE fee_id=?");

			pstmt.setInt(1, feeId);

			rs = pstmt.executeQuery();

			// Send ResultSet to JSP
			req.setAttribute("resultSet", rs);

			// Forward to updateFee.jsp
			RequestDispatcher rd = req.getRequestDispatcher("updateFee.jsp");

			rd.forward(req, resp);

		} catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");

		}
	}
}