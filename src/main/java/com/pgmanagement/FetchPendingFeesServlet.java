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

@WebServlet("/fetch-pending-fees")
public class FetchPendingFeesServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String month = req.getParameter("month");
		req.setAttribute("selectedMonth", month);

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = com.pgmanagement.util.DBUtil.getConnection();

			if (month != null && !month.trim().isEmpty() && !month.equalsIgnoreCase("All")) {
				pstmt = con.prepareStatement(
						"SELECT t.tenant_id, t.tenant_name, t.room_no, t.phone, f.month_name, f.amount "
								+ "FROM tenant t "
								+ "INNER JOIN fee f ON t.tenant_id = f.tenant_id "
								+ "WHERE f.status='Pending' AND f.month_name = ? "
								+ "ORDER BY t.room_no"
				);
				pstmt.setString(1, month);
			} else {
				pstmt = con.prepareStatement(
						"SELECT t.tenant_id, t.tenant_name, t.room_no, t.phone, f.month_name, f.amount "
								+ "FROM tenant t "
								+ "INNER JOIN fee f ON t.tenant_id = f.tenant_id "
								+ "WHERE f.status='Pending' "
								+ "ORDER BY t.room_no"
				);
			}

			rs = pstmt.executeQuery();
			req.setAttribute("resultSet", rs);

			RequestDispatcher rd = req.getRequestDispatcher("pendingRentTenants.jsp");
			rd.forward(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
		}
	}

}