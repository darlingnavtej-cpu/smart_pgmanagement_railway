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

@WebServlet("/delete-expense")
public class DeleteExpenseServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Get Expense Details

			int expenseId = Integer.parseInt(

					req.getParameter("expenseId")

			);

			String expenseName = req.getParameter(

					"expenseName"

			);

			// Load Driver

			Class.forName(

					"com.mysql.cj.jdbc.Driver"

			);

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Delete Query

			pstmt = con.prepareStatement(

					"DELETE FROM expense "

							+

							"WHERE expense_id=?"

			);

			pstmt.setInt(

					1,

					expenseId

			);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				// Activity Log

				ActivityUtility.addActivity(

						"🗑️ Expense Deleted : "

								+

								expenseName

				);

				// Redirect

				resp.sendRedirect(

						"fetch-expenses"

				);

			}

			else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Expense Not Deleted!", "error", "fetch-expenses");

			}

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "fetch-expenses");

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