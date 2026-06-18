package com.pgmanagement;

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

import com.pgmanagement.util.EmailUtility;

@WebServlet("/send-bulk-email-reminder")
public class SendBulkEmailReminderServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;

		try {

			String month = req.getParameter("month");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT " + "t.tenant_name, " + "t.email, " + "f.amount, " + "f.month_name " + "FROM tenant t "
							+ "INNER JOIN fee f " + "ON t.tenant_id = f.tenant_id " + "WHERE f.month_name=? "
							+ "AND f.status='Pending'"

			);

			pstmt.setString(1, month);

			rs = pstmt.executeQuery();

			int count = 0;

			while (rs.next()) {

				String tenantName = rs.getString("tenant_name");

				String email = rs.getString("email");

				int amount = rs.getInt("amount");

				String subject = "Smart PG Rent Reminder";

				String body =

						"Dear " + tenantName + ",\n\n"

								+ "This is a friendly reminder that your PG rent for "

								+ month

								+ " is still pending.\n\n"

								+ "Pending Amount : ₹"

								+ amount

								+ "\n\nKindly complete your payment as soon as possible.\n\n"

								+ "If you have already paid, please ignore this email.\n\n"

								+ "Regards,\n"

								+ "Smart PG Management Team";

				EmailUtility.sendEmail(

						email,

						subject,

						body);

				count++;

				System.out.println("Reminder Sent To : " + email);
			}

			// Save Reminder History

			ps2 = con.prepareStatement(

					"INSERT INTO reminder_history " + "(month_name,total_sent,sent_on) " + "VALUES(?,?,NOW())"

			);

			ps2.setString(1, month);

			ps2.setInt(2, count);

			ps2.executeUpdate();

			resp.setContentType("text/html");

			resp.getWriter().println(

					"<script>"

							+ "alert('"

							+ count

							+ " Reminder Emails Sent Successfully!');"

							+ "window.location='month-wise-rent-analysis?month="

							+ month

							+ "';"

							+ "</script>"

			);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.setContentType("text/html");

			resp.getWriter().println(

					"<h2 style='color:red;'>Error : "

							+ e.getMessage()

							+ "</h2>"

			);

		}

		finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (ps2 != null)
					ps2.close();

				if (con != null)
					con.close();

			}

			catch (Exception e) {

				e.printStackTrace();

			}

		}

	}

}