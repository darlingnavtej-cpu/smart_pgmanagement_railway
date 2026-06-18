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
import javax.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class AdminDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 HttpSession session =
				    req.getSession(false);

				    if(session == null ||
				       session.getAttribute("adminUsername") == null)
				    {
				        resp.sendRedirect("login.jsp");
				        return;
				    }
		System.out.println("Dashboard Servlet Started...");
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			int totalTenants = 0;
			int occupiedRooms = 0;
			int pendingFees = 0;
			int pendingComplaints = 0;
			int totalRooms = 0;

			int totalCollection = 0;
			int visitorsToday = 0;
			int totalEmployees = 0;

			int totalSalaryExpense = 0;
			int paidTenants = 0;
			int totalOccupied = 0;
			int totalAvailable = 0;
			int totalExpense = 0;
			int netProfit = 0;

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con
					.prepareStatement("SELECT COUNT(*) AS totalRooms, " + "IFNULL(SUM(occupied),0) AS totalOccupied, "
							+ "IFNULL(SUM(capacity-occupied),0) AS totalAvailable " + "FROM room");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalRooms = rs.getInt("totalRooms");
				totalOccupied = rs.getInt("totalOccupied");
				totalAvailable = rs.getInt("totalAvailable");
			}

			rs.close();
			pstmt.close();
			con.close();

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("SELECT COUNT(*) FROM fee WHERE status='Paid'");

			rs = pstmt.executeQuery();

			if (rs.next()) {

				paidTenants = rs.getInt(1);

			}

			req.setAttribute("paidTenants", paidTenants);

			rs.close();

			pstmt.close();

			con.close();
			// Total Tenants
			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("SELECT COUNT(*) FROM tenant");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				totalTenants = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
			con.close();

			// Occupied Rooms

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("SELECT COUNT(DISTINCT room_no) FROM tenant");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				occupiedRooms = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
			con.close();

			// Total Rooms

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("SELECT COUNT(*) FROM room");

			rs = pstmt.executeQuery();

			if (rs.next()) {

				totalRooms = rs.getInt(1);

			}

			rs.close();

			pstmt.close();

			con.close();

			// Pending Fees

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("SELECT COUNT(*) FROM fee WHERE status='Pending'");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				pendingFees = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
			con.close();

			// Total Collection

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT IFNULL(SUM(amount),0) " + "FROM fee " + "WHERE status='Paid'"

			);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				totalCollection = rs.getInt(1);

			}

			rs.close();

			pstmt.close();

			con.close();

			// Pending Complaints

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("SELECT COUNT(*) FROM complaint WHERE status='Pending'");

			rs = pstmt.executeQuery();

			if (rs.next()) {
				pendingComplaints = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			con.close();

			// Visitors Today

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT COUNT(*) " + "FROM visitor " + "WHERE DATE(checkin_time)=CURDATE()"

			);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				visitorsToday = rs.getInt(1);

			}

			rs.close();
			pstmt.close();
			con.close();
			// Total Employees

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT COUNT(*) FROM employee "

							+

							"WHERE status='Active'"

			);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				totalEmployees = rs.getInt(1);

			}
			rs.close();
			pstmt.close();
			con.close();

			// Total Salary Expense

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT IFNULL(SUM(salary),0) "

							+

							"FROM employee "

							+

							"WHERE status='Active'"

			);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				totalSalaryExpense = rs.getInt(1);

			}

			rs.close();
			pstmt.close();
			con.close();

			// ============================
			// Total Expenses
			// ============================

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT IFNULL(SUM(amount),0) "

							+

							"FROM expense"

			);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				totalExpense = rs.getInt(1);

			}

			rs.close();

			pstmt.close();

			con.close();

			// ============================
			// Net Profit
			// ============================

			netProfit =

					totalCollection

							-

							totalSalaryExpense

							-

							totalExpense;

//			rs.close();
//			pstmt.close();
//			con.close();

			req.setAttribute("totalTenants", totalTenants);

			req.setAttribute("occupiedRooms", occupiedRooms);

			req.setAttribute("totalRooms", totalRooms);

			req.setAttribute("pendingFees", pendingFees);

			req.setAttribute("pendingComplaints", pendingComplaints);

			req.setAttribute("totalCollection", totalCollection);
			req.setAttribute("visitorsToday", visitorsToday);
			req.setAttribute("totalEmployees", totalEmployees);

			req.setAttribute("totalSalaryExpense", totalSalaryExpense);

			req.setAttribute("totalOccupied", totalOccupied);
			req.setAttribute("totalAvailable", totalAvailable);
			req.setAttribute("totalExpense", totalExpense);

			req.setAttribute("netProfit", netProfit);

			RequestDispatcher rd = req.getRequestDispatcher("home.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}