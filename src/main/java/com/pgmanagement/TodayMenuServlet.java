package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.DayOfWeek;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/today-menu")
public class TodayMenuServlet extends HttpServlet {

	@Override
	protected void doGet(
			HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			String today =
					LocalDate.now()
					.getDayOfWeek()
					.toString();

			// MONDAY -> Monday

			today =
					today.substring(0, 1)
					+
					today.substring(1)
					.toLowerCase();

			Class.forName(
					"com.mysql.cj.jdbc.Driver");

			con =
					DriverManager.getConnection(

							"jdbc:mysql://localhost:3306/smart_pg",

							"root",

							"admin");

			pstmt =
					con.prepareStatement(

							"select * from weekly_menu where day_name=?");

			pstmt.setString(
					1,
					today);

			rs =
					pstmt.executeQuery();

			req.setAttribute(
					"todayMenu",
					rs);

			req.setAttribute(
					"today",
					today);

			RequestDispatcher rd =
					req.getRequestDispatcher(
							"todayMenu.jsp");

			rd.forward(
					req,
					resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}