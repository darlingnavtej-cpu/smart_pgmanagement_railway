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

@WebServlet("/pay-salary")
public class PaySalaryServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int employeeId = Integer.parseInt(req.getParameter("employeeId"));

			String employeeName = req.getParameter("employeeName");

			String role = req.getParameter("role");

			int salaryAmount = Integer.parseInt(req.getParameter("salaryAmount"));

			String monthName = req.getParameter("monthName");

			String paidDate = req.getParameter("paidDate");

			String status = req.getParameter("status");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"INSERT INTO employee_salary_history "

							+

							"(employee_id,"

							+

							"employee_name,"

							+

							"role,"

							+

							"month_name,"

							+

							"salary_amount,"

							+

							"paid_date,"

							+

							"status)"

							+

							"VALUES(?,?,?,?,?,?,?)"

			);

			pstmt.setInt(1, employeeId);

			pstmt.setString(2, employeeName);

			pstmt.setString(3, role);

			pstmt.setString(4, monthName);

			pstmt.setInt(5, salaryAmount);

			pstmt.setString(6, paidDate);

			pstmt.setString(7, status);

			pstmt.executeUpdate();

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Paid", "Salary paid successfully", "success", "fetch-employees");

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "fetch-employees");

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