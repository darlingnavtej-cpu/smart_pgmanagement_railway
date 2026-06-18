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

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int totalTenants = 0;
		int totalRooms = 0;
		int totalFees = 0;
		int paidFees = 0;
		int pendingFees = 0;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			// -------------------------
			// Total Tenants
			// -------------------------

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from tenant");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalTenants = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
			con.close();

			// -------------------------
			// Total Rooms
			// -------------------------

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("select count(*) from room");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalRooms = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
			con.close();

			// -------------------------
			// Fee Statistics
			// -------------------------

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Total Fee Records

			pstmt = con.prepareStatement("select count(*) from fee");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalFees = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			// Paid Fees

			pstmt = con.prepareStatement("select count(*) from fee where status='Paid'");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				paidFees = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			// Pending Fees

			pstmt = con.prepareStatement("select count(*) from fee where status='Pending'");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				pendingFees = rs.getInt(1);
			}

			// Send Data

			req.setAttribute("totalTenants", totalTenants);
			req.setAttribute("totalRooms", totalRooms);
			req.setAttribute("totalFees", totalFees);
			req.setAttribute("paidFees", paidFees);
			req.setAttribute("pendingFees", pendingFees);

			RequestDispatcher rd = req.getRequestDispatcher("reports.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
		}

		finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			}

			catch (Exception e) {

				e.printStackTrace();

			}
		}
	}
}