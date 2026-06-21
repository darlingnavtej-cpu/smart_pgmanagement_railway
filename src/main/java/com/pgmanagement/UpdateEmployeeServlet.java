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

@WebServlet("/update-employee")
public class UpdateEmployeeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Get Employee Details

			int employeeId = Integer.parseInt(req.getParameter("employeeId"));

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

			// Update Query

			pstmt = con.prepareStatement(

					"UPDATE employee "

							+

							"SET employee_name=?, "

							+

							"age=?, "

							+

							"gender=?, "

							+

							"phone=?, "

							+

							"role=?, "

							+

							"salary=?, "

							+

							"joining_date=?, "

							+

							"status=? "

							+

							"WHERE employee_id=?"

			);

			pstmt.setString(1, employeeName);

			pstmt.setInt(2, age);

			pstmt.setString(3, gender);

			pstmt.setString(4, phone);

			pstmt.setString(5, role);

			pstmt.setInt(6, salary);

			pstmt.setString(7, joiningDate);

			pstmt.setString(8, status);

			pstmt.setInt(9, employeeId);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Updated", "Employee Updated Successfully", "success", "fetch-employees");

			}

			else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Employee Update Failed!", "error", null);

			}

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);

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