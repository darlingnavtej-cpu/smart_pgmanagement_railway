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

@WebServlet("/fetch-employees")
public class FetchEmployeeServlet extends HttpServlet {

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

			// Fetch Employees With Salary Status

			pstmt = con.prepareStatement(

					"SELECT e.*, "

							+ "CASE "

							+ "WHEN EXISTS ("

							+ "SELECT 1 "

							+ "FROM employee_salary_history esh "

							+ "WHERE esh.employee_id = e.employee_id "

							+ "AND esh.month_name = MONTHNAME(CURDATE())"

							+ ") "

							+ "THEN 'Paid' "

							+ "ELSE 'Pending' "

							+ "END AS payment_status "

							+ "FROM employee e"

			);

			rs = pstmt.executeQuery();

			// Send ResultSet To JSP

			req.setAttribute(

					"employeeResultSet",

					rs

			);

			// Forward To JSP

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"employeeList.jsp"

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