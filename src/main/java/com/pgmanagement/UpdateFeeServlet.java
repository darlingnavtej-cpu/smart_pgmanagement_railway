package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/update-fee")
public class UpdateFeeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Get Form Data

			int feeId = Integer.parseInt(req.getParameter("feeId"));

			int tenantId = Integer.parseInt(req.getParameter("tenantId"));

			String monthName = req.getParameter("monthName");

			double amount = Double.parseDouble(req.getParameter("amount"));

			String paidDate = req.getParameter("paidDate");

			String status = req.getParameter("status");

			// Load MySQL Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Update Query

			pstmt = con.prepareStatement(
					"update fee set tenant_id=?, month_name=?, amount=?, paid_date=?, status=? where fee_id=?");

			pstmt.setInt(1, tenantId);
			pstmt.setString(2, monthName);
			pstmt.setDouble(3, amount);
			pstmt.setString(4, paidDate);
			pstmt.setString(5, status);
			pstmt.setInt(6, feeId);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Updated", "Fee Details Updated Successfully", "success", "fetch-fees");

			} else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Fee Update Failed", "error", null);

			}

		}

		catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);

		}

		catch (NumberFormatException e) {

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Validation Error", "Please Enter Valid Numbers", "warning", null);

		}

		finally {

			try {

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			}

			catch (SQLException e) {

				e.printStackTrace();

			}
		}
	}
}