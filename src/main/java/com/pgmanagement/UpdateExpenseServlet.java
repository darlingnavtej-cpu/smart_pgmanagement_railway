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

@WebServlet("/update-expense")
public class UpdateExpenseServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Get Updated Details

			int expenseId = Integer.parseInt(req.getParameter("expenseId"));

			String expenseName = req.getParameter("expenseName");

			int amount = Integer.parseInt(req.getParameter("amount"));

			String expenseDate = req.getParameter("expenseDate");

			String remarks = req.getParameter("remarks");

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Update Query

			pstmt = con.prepareStatement(

					"UPDATE expense "

							+

							"SET expense_name=?, "

							+

							"amount=?, "

							+

							"expense_date=?, "

							+

							"remarks=? "

							+

							"WHERE expense_id=?"

			);

			pstmt.setString(

					1,

					expenseName

			);

			pstmt.setInt(

					2,

					amount

			);

			pstmt.setString(

					3,

					expenseDate

			);

			pstmt.setString(

					4,

					remarks

			);

			pstmt.setInt(

					5,

					expenseId

			);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				// Activity Logger

				ActivityUtility.addActivity(

						"✏️ Expense Updated : "

								+

								expenseName

								+

								" ₹"

								+

								amount

				);

				// Redirect

				resp.sendRedirect("fetch-expenses");

			}

			else {

				resp.getWriter().println(

						"<h2>Expense Update Failed!</h2>"

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