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

@WebServlet("/delete-employee")
public class DeleteEmployeeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Get Employee ID

			int employeeId = Integer.parseInt(

					req.getParameter("employeeId")

			);

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Delete Employee

			pstmt = con.prepareStatement(

					"DELETE FROM employee "

							+

							"WHERE employee_id=?"

			);

			pstmt.setInt(

					1,

					employeeId

			);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				resp.sendRedirect(

						"fetch-employees"

				);

			}

			else {

				resp.getWriter().println(

						"<h2>Employee Not Found!</h2>"

				);

			}

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