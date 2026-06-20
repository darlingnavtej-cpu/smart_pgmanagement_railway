package com.pgmanagement;
import com.pgmanagement.util.ActivityUtility;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/add-notice")
public class AddNoticeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String title = req.getParameter("title");

		String description = req.getParameter("description");

		String noticeDate = req.getParameter("noticeDate");

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"insert into notice " + "(title," + "description," + "notice_date) " + "values(?,?,?)");

			pstmt.setString(1, title);

			pstmt.setString(2, description);

			pstmt.setString(3, noticeDate);

			int result = pstmt.executeUpdate();

			if (result > 0) {
				ActivityUtility.addActivity(
						"📢 New Notice Published");

				final String fTitle = title;
				final String fDescription = description;
				final String fNoticeDate = noticeDate;
				final java.util.List<String[]> tenantList = new java.util.ArrayList<>();

				try (PreparedStatement tenantStmt = con.prepareStatement("SELECT tenant_name, email FROM tenant")) {
					try (java.sql.ResultSet rs = tenantStmt.executeQuery()) {
						while (rs.next()) {
							tenantList.add(new String[]{rs.getString("tenant_name"), rs.getString("email")});
						}
					}
				} catch (Exception ex) {
					System.err.println("Error fetching tenant emails for notice notification:");
					ex.printStackTrace();
				}

				if (!tenantList.isEmpty()) {
					new Thread(new Runnable() {
						@Override
						public void run() {
							for (String[] tenant : tenantList) {
								String tenantName = tenant[0];
								String tenantEmail = tenant[1];
								String subject = "🔔 New Notice: " + fTitle;
								String body = "Dear " + tenantName + ",\n\n"
										+ "A new notice has been published by the PG Management:\n\n"
										+ "Title: " + fTitle + "\n"
										+ "Date: " + fNoticeDate + "\n\n"
										+ "Description:\n" + fDescription + "\n\n"
										+ "Please log in to your dashboard to view more details.\n\n"
										+ "Regards,\n"
										+ "Smart PG Management Team";
								try {
									com.pgmanagement.util.EmailUtility.sendEmail(tenantEmail, subject, body);
								} catch (Exception e) {
									System.err.println("Failed to send notice email to " + tenantEmail);
									e.printStackTrace();
								}
							}
						}
					}).start();
				}

				resp.sendRedirect("fetch-notices");

			}

			else {

				resp.getWriter().println("<h2>Notice Not Added!</h2>");

			}

			pstmt.close();
			con.close();

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}