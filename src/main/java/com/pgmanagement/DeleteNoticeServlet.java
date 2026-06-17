package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete-notice")
public class DeleteNoticeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int noticeId = Integer.parseInt(req.getParameter("id"));

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin");

			pstmt = con.prepareStatement(

					"delete from notice " + "where notice_id=?");

			pstmt.setInt(1, noticeId);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				resp.sendRedirect("fetch-notices");

			}

			else {

				resp.getWriter().println(

						"<h2>Notice Not Deleted!</h2>");

			}

			pstmt.close();
			con.close();

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}