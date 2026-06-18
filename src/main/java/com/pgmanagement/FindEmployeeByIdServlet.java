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

@WebServlet("/find-employee-by-id")
public class FindEmployeeByIdServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// Get Employee ID

			int employeeId = Integer.parseInt(

					req.getParameter(
							"employeeId")

			);

			// Load Driver

			Class.forName(
					"com.mysql.cj.jdbc.Driver"
			);

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Fetch Employee

			pstmt = con.prepareStatement(

					"SELECT * "

							+

							"FROM employee "

							+

							"WHERE employee_id=?"

			);

			pstmt.setInt(

					1,

					employeeId

			);

			rs = pstmt.executeQuery();

			// Send ResultSet to JSP

			req.setAttribute(

					"resultSet",

					rs

			);

			// Forward

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"updateEmployee.jsp"

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

							+

							e.getMessage()

							+

							"</h2>"

			);

		}

		finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			}

			catch (Exception e) {

				e.printStackTrace();

			}

		}

	}

}