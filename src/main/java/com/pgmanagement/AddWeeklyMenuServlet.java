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

				pstmt.close();
				con.close();
				com.pgmanagement.util.JSResponse.showSweetAlertConfirm(
					resp,
					"Menu Added",
					"Menu Added Successfully. Do you want to add another menu item?",
					"success",
					"addWeeklyMenu.jsp",
					"fetch-weekly-menu",
					"Add Another",
					"Go to List"
				);

			}

			else {

				pstmt.close();
				con.close();
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Menu Not Added!", "error", "addWeeklyMenu.jsp");

			}

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);

		}

	}

}