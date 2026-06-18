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

@WebServlet("/send-reminders")
public class SendReminderServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT " + "t.tenant_name, " + "t.email, " + "f.month_name, " + "f.amount " + "FROM tenant t "
							+ "INNER JOIN fee f " + "ON t.tenant_id = f.tenant_id " + "WHERE f.status = ?"

			);

			pstmt.setString(1, "Pending");

			rs = pstmt.executeQuery();

			int count = 0;

			while (rs.next()) {

				String tenantName = rs.getString("tenant_name");

				String email = rs.getString("email");

				String month = rs.getString("month_name");

				int amount = rs.getInt("amount");

				String subject = "PG Rent Reminder";

				String body =

						"Dear " + tenantName + ",\n\n"

								+ "This is a friendly reminder that your " + month + " PG rent payment is pending.\n\n"

								+ "Amount : ₹" + amount

								+ "\n\nKindly complete your payment at your earliest convenience.\n\n"

								+ "Thank You,\n" + "Smart PG Management Team";

				EmailUtility.sendEmail(email, subject, body);

				count++;
			}

			resp.setContentType("text/html");

			resp.getWriter().println(

					"<html><body " + "style='font-family:Arial;" + "text-align:center;" + "margin-top:100px;'>"

							+ "<h1 style='color:green;'>" + count + " Reminder Emails Sent Successfully!" + "</h1>"

							+ "<br><br>"

							+ "<a href='dashboard'>" + "Back To Dashboard" + "</a>"

							+ "</body></html>"

			);

		} catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println(

					"<h2>Error : " + e.getMessage() + "</h2>"

			);
		} finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (Exception e) {

				e.printStackTrace();
			}
		}
	}

}
