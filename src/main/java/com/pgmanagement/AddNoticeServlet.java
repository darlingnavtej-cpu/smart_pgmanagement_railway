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