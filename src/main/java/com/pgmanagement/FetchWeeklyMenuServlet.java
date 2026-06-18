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

@WebServlet("/fetch-weekly-menu")
public class FetchWeeklyMenuServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"select * from weekly_menu order by menu_id");

			rs = pstmt.executeQuery();

			req.setAttribute("menuList", rs);

			String role = (String) req.getSession().getAttribute("role");

			System.out.println("ROLE = " + role);

			RequestDispatcher rd;

			if ("admin".equals(role)) {

				rd = req.getRequestDispatcher("adminWeeklyMenu.jsp");

			}

			else {

				rd = req.getRequestDispatcher("tenantWeeklyMenu.jsp");
			}

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}