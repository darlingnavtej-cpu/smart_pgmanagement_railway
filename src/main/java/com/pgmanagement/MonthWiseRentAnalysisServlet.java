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

@WebServlet("/month-wise-rent-analysis")
public class MonthWiseRentAnalysisServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;

		PreparedStatement pstmt = null;

		ResultSet rs = null;

		try {

			String month = req.getParameter("month");

			if (month == null || month.trim().equals("")) {

				month = java.time.LocalDate.now().getMonth().getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH);
			}

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			// ==========================
			// Total Tenants
			// ==========================

			pstmt = con.prepareStatement(

					"SELECT COUNT(*) FROM tenant");

			rs = pstmt.executeQuery();

			int totalTenants = 0;

			if (rs.next()) {

				totalTenants = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			// ==========================
			// Paid Tenants
			// ==========================

			pstmt = con.prepareStatement(

					"SELECT COUNT(*) " + "FROM fee " + "WHERE month_name=? " + "AND status='Paid'"

			);

			pstmt.setString(1, month);

			rs = pstmt.executeQuery();

			int paidTenants = 0;

			if (rs.next()) {

				paidTenants = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			// ==========================
			// Pending Tenants
			// ==========================

			pstmt = con.prepareStatement(

					"SELECT COUNT(*) " + "FROM fee " + "WHERE month_name=? " + "AND status='Pending'"

			);

			pstmt.setString(1, month);

			rs = pstmt.executeQuery();

			int pendingTenants = 0;

			if (rs.next()) {

				pendingTenants = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			// ==========================
			// Total Collection
			// ==========================

			pstmt = con.prepareStatement(

					"SELECT IFNULL(SUM(amount),0) " + "FROM fee " + "WHERE month_name=? " + "AND status='Paid'"

			);

			pstmt.setString(1, month);

			rs = pstmt.executeQuery();

			int totalCollection = 0;

			if (rs.next()) {

				totalCollection = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			// ==========================
			// Pending Amount
			// ==========================

			pstmt = con.prepareStatement(

					"SELECT IFNULL(SUM(amount),0) " + "FROM fee " + "WHERE month_name=? " + "AND status='Pending'"

			);

			pstmt.setString(1, month);

			rs = pstmt.executeQuery();

			int pendingAmount = 0;

			if (rs.next()) {

				pendingAmount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

			// ==========================
			// Collection Percentage
			// ==========================

			int collectionPercentage = 0;

			if (totalTenants > 0) {

				collectionPercentage = (paidTenants * 100) / totalTenants;
			}

			// ==========================
			// Pending Tenant List
			// ==========================

			pstmt = con.prepareStatement(

					"SELECT " + "t.tenant_id, " + "t.tenant_name, " + "t.room_no, " + "t.phone, " + "f.amount, "
							+ "f.month_name " + "FROM tenant t " + "INNER JOIN fee f " + "ON t.tenant_id = f.tenant_id "
							+ "WHERE f.month_name=? " + "AND f.status='Pending' " + "ORDER BY t.room_no"

			);

			pstmt.setString(1, month);

			rs = pstmt.executeQuery();

			req.setAttribute("currentMonth", month);

			req.setAttribute("totalTenants", totalTenants);

			req.setAttribute("paidTenants", paidTenants);

			req.setAttribute("pendingTenants", pendingTenants);

			req.setAttribute("totalCollection", totalCollection);

			req.setAttribute("pendingAmount", pendingAmount);

			req.setAttribute("collectionPercentage", collectionPercentage);

			req.setAttribute("resultSet", rs);

			RequestDispatcher rd = req.getRequestDispatcher("monthlyRentSummary.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println(

					"<h2>Error : " + e.getMessage() + "</h2>"

			);

		}

	}

}