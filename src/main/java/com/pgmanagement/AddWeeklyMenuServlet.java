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

@WebServlet("/add-weekly-menu")
public class AddWeeklyMenuServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String dayName = req.getParameter("dayName");

		String breakfast = req.getParameter("breakfast");

		String lunch = req.getParameter("lunch");

		String snacks = req.getParameter("snacks");

		String dinner = req.getParameter("dinner");

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"insert into weekly_menu " + "(day_name, " + "breakfast, " + "lunch, " + "snacks, " + "dinner) "
							+ "values(?,?,?,?,?)");

			pstmt.setString(1, dayName);

			pstmt.setString(2, breakfast);

			pstmt.setString(3, lunch);

			pstmt.setString(4, snacks);

			pstmt.setString(5, dinner);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				resp.sendRedirect("fetch-weekly-menu");

			}

			else {

				resp.getWriter().println("<h2>Menu Not Added!</h2>");

			}

			pstmt.close();
			con.close();

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}