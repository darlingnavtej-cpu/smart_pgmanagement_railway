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

@WebServlet("/find-weekly-menu")
public class FindWeeklyMenuByIdServlet extends HttpServlet {

	@Override
	protected void doGet(
			HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		int menuId =
				Integer.parseInt(
						req.getParameter("id"));

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(
					"com.mysql.cj.jdbc.Driver");

			con =
					com.pgmanagement.util.DBUtil.getConnection();

			pstmt =
					con.prepareStatement(

							"select * from weekly_menu where menu_id=?");

			pstmt.setInt(
					1,
					menuId);

			rs =
					pstmt.executeQuery();

			req.setAttribute(
					"menuData",
					rs);

			RequestDispatcher rd =
					req.getRequestDispatcher(
							"updateWeeklyMenu.jsp");

			rd.forward(
					req,
					resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}