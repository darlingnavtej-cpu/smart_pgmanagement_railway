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

@WebServlet("/fetch-paid-tenants")
public class FetchPaidTenantsServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			// Fetch Paid Tenants

			pstmt = con.prepareStatement(

					"SELECT "

							+ "t.tenant_id, "

							+ "t.tenant_name, "

							+ "t.room_no, "

							+ "f.month_name, "

							+ "f.amount, "

							+ "f.paid_date, "

							+ "f.status "

							+ "FROM tenant t "

							+ "INNER JOIN fee f "

							+ "ON t.tenant_id = f.tenant_id "

							+ "WHERE f.status = 'Paid' "

							+ "ORDER BY t.room_no"

			);

			rs = pstmt.executeQuery();

			req.setAttribute(

					"resultSet",

					rs

			);

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"paidTenants.jsp"

					);

			rd.forward(

					req,

					resp

			);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println(

					"<h2>Error : "

							+ e.getMessage()

							+ "</h2>"

			);

		}

	}

}