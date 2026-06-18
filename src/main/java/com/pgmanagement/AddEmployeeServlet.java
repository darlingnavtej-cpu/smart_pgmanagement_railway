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

import com.pgmanagement.util.ActivityUtility;

@WebServlet("/add-employee")
public class AddEmployeeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			String employeeName = req.getParameter("employeeName");

			int age = Integer.parseInt(req.getParameter("age"));

			String gender = req.getParameter("gender");

			String phone = req.getParameter("phone");

			String role = req.getParameter("role");

			int salary = Integer.parseInt(req.getParameter("salary"));

			String joiningDate = req.getParameter("joiningDate");

			String status = req.getParameter("status");

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Insert Query

			pstmt = con.prepareStatement(

					"INSERT INTO employee "

							+

							"(employee_name,"

							+

							"age,"

							+

							"gender,"

							+

							"phone,"

							+

							"role,"

							+

							"salary,"

							+

							"joining_date,"

							+

							"status)"

							+

							" VALUES(?,?,?,?,?,?,?,?)"

			);

			pstmt.setString(1, employeeName);

			pstmt.setInt(2, age);

			pstmt.setString(3, gender);

			pstmt.setString(4, phone);

			pstmt.setString(5, role);

			pstmt.setInt(6, salary);

			pstmt.setString(7, joiningDate);

			pstmt.setString(8, status);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				// Add Activity

				ActivityUtility.addActivity(

						"👨‍🍳 New Staff Added : " + employeeName

				);

				resp.getWriter().println(

						"<script>"

								+

								"alert('Employee Added Successfully');"

								+

								"window.location='fetch-employees';"

								+

								"</script>"

				);

			}

			else {

				resp.getWriter().println(

						"<h2>Failed To Add Employee</h2>"

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