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

@WebServlet("/fetch-pending-reminders")
public class FetchPendingReminderServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT " + "t.tenant_id, " + "t.tenant_name, " + "t.email, " + "f.month_name, " + "f.amount, "
							+ "f.status " + "FROM tenant t " + "INNER JOIN fee f " + "ON t.tenant_id = f.tenant_id "
							+ "WHERE f.status=? " + "ORDER BY t.room_no"

			);

			pstmt.setString(1, "Pending");

			rs = pstmt.executeQuery();

			req.setAttribute("pendingList", rs);

			RequestDispatcher rd = req.getRequestDispatcher("pendingReminders.jsp");

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
