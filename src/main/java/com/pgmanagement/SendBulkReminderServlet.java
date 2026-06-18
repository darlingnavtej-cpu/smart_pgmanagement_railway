package com.pgmanagement;

import com.pgmanagement.util.ActivityUtility;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/send-bulk-reminder")
public class SendBulkReminderServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)

			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			String month = req.getParameter("month");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT COUNT(*) " + "FROM fee " + "WHERE " + "month_name=? " + "AND " + "status='Pending'");

			pstmt.setString(1, month);

			rs = pstmt.executeQuery();

			int total = 0;

			if (rs.next()) {
				ActivityUtility.addActivity("📧 Bulk Reminder Sent For " + month);

				total = rs.getInt(1);

			}

			resp.setContentType("text/html");

			resp.getWriter().println(

					"<script>"

							+

							"alert('Reminder sent successfully to "

							+

							total

							+

							" pending tenants for "

							+

							month

							+

							".');"

							+

							"window.location='month-wise-rent-analysis?month="

							+

							month

							+

							"';"

							+

							"</script>");

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}