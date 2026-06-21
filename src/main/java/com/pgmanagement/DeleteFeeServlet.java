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

@WebServlet("/delete-fee")
public class DeleteFeeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Get Fee ID
			int feeId = Integer.parseInt(req.getParameter("feeId"));

			// Load MySQL Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection
			con = com.pgmanagement.util.DBUtil.getConnection();

			// Delete Query
			pstmt = con.prepareStatement("DELETE FROM fee WHERE fee_id=?");

			pstmt.setInt(1, feeId);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				// Refresh Fee Records
				resp.sendRedirect("fetch-fees");

			} else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Fee Record Deletion Failed", "error", "fetch-fees");

			}

		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "fetch-fees");

		} finally {

			try {

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (SQLException e) {

				e.printStackTrace();

			}
		}
	}
}