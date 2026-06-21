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

@WebServlet("/delete-weekly-menu")
public class DeleteWeeklyMenuServlet extends HttpServlet {

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

		try {

			Class.forName(
					"com.mysql.cj.jdbc.Driver");

			con =
					com.pgmanagement.util.DBUtil.getConnection();

			pstmt =
					con.prepareStatement(

							"delete from weekly_menu "
							+ "where menu_id=?");

			pstmt.setInt(
					1,
					menuId);

			int result =
					pstmt.executeUpdate();

			if (result > 0) {

				pstmt.close();
				con.close();
				resp.sendRedirect("fetch-weekly-menu");

			}

			else {

				pstmt.close();
				con.close();
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Menu Deletion Failed!", "error", "fetch-weekly-menu");

			}

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "fetch-weekly-menu");

		}

	}

}