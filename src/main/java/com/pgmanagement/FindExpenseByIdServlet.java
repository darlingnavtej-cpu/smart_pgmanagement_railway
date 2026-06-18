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

@WebServlet("/find-expense-by-id")
public class FindExpenseByIdServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// Get Expense ID

			int expenseId = Integer.parseInt(req.getParameter("expenseId"));

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Fetch Expense

			pstmt = con.prepareStatement("SELECT * FROM expense WHERE expense_id=?");

			pstmt.setInt(1, expenseId);

			rs = pstmt.executeQuery();

			// Send ResultSet to JSP

			req.setAttribute("expenseResultSet", rs);

			// Forward to JSP

			RequestDispatcher rd = req.getRequestDispatcher("updateExpense.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");

		}

		/*
		 * Do NOT close ResultSet, PreparedStatement, Connection here
		 *
		 * JSP still needs ResultSet.
		 */

	}
}