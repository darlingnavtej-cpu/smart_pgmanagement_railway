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

@WebServlet("/update-weekly-menu")
public class UpdateWeeklyMenuServlet extends HttpServlet {

	@Override
	protected void doPost(
			HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		int menuId =
				Integer.parseInt(
						req.getParameter("menuId"));

		String breakfast =
				req.getParameter("breakfast");

		String lunch =
				req.getParameter("lunch");

		String snacks =
				req.getParameter("snacks");

		String dinner =
				req.getParameter("dinner");

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(
					"com.mysql.cj.jdbc.Driver");

			con =
					com.pgmanagement.util.DBUtil.getConnection();

			pstmt =
					con.prepareStatement(

							"update weekly_menu "
							+ "set breakfast=?, "
							+ "lunch=?, "
							+ "snacks=?, "
							+ "dinner=? "
							+ "where menu_id=?");

			pstmt.setString(
					1,
					breakfast);

			pstmt.setString(
					2,
					lunch);

			pstmt.setString(
					3,
					snacks);

			pstmt.setString(
					4,
					dinner);

			pstmt.setInt(
					5,
					menuId);

			int result =
					pstmt.executeUpdate();

			if (result > 0) {

				resp.sendRedirect(
						"fetch-weekly-menu");

			}

			else {

				resp.getWriter().println(

						"<h2>Menu Update Failed!</h2>");

			}

			pstmt.close();
			con.close();

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}