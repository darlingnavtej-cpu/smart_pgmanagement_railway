package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pgmanagement.util.ActivityUtility;

@WebServlet("/add-expense")
public class AddExpenseServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int expenseId = Integer.parseInt(req.getParameter("expenseId"));

			String expenseName = req.getParameter("expenseName");

			int amount = Integer.parseInt(req.getParameter("amount"));

			String expenseDate = req.getParameter("expenseDate");

			String remarks = req.getParameter("remarks");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"insert into expense values(?,?,?,?,?)"

			);

			pstmt.setInt(1, expenseId);
			pstmt.setString(2, expenseName);
			pstmt.setInt(3, amount);
			pstmt.setString(4, expenseDate);
			pstmt.setString(5, remarks);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				ActivityUtility.addActivity(

						"💸 Expense Added : " + expenseName + " ₹" + amount

				);

				com.pgmanagement.util.JSResponse.showSweetAlertConfirm(
					resp,
					"Expense Added",
					"Expense Added Successfully. Do you want to add another expense?",
					"success",
					"addExpense.jsp",
					"fetch-expenses",
					"Add Another",
					"Go to List"
				);

			}

			else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Expense Add Failed", "error", "addExpense.jsp");

			}

		}

		catch (SQLIntegrityConstraintViolationException e) {

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Duplicate ID", "Expense ID is already used. Please enter a unique ID.", "warning", "addExpense.jsp");

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