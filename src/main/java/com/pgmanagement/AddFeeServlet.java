package com.pgmanagement;

import com.pgmanagement.util.ActivityUtility;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/add-fee")
public class AddFeeServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");

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

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Insert Query

			pstmt = con.prepareStatement("INSERT INTO fee VALUES(?,?,?,?,?,?)");

			pstmt.setInt(1, feeId);
			pstmt.setInt(2, tenantId);
			pstmt.setString(3, monthName);
			pstmt.setDouble(4, amount);
			pstmt.setString(5, paidDate);
			pstmt.setString(6, status);

			int row = pstmt.executeUpdate();

			PrintWriter pw = resp.getWriter();

			if (row > 0) {

				String tenantName = "";

				Connection tenantCon = com.pgmanagement.util.DBUtil.getConnection();

				PreparedStatement tenantStmt = tenantCon.prepareStatement(

						"SELECT tenant_name "

								+

								"FROM tenant "

								+

								"WHERE tenant_id=?"

				);

				tenantStmt.setInt(

						1,

						tenantId

				);

				ResultSet tenantRs = tenantStmt.executeQuery();

				if (tenantRs.next()) {

					tenantName = tenantRs.getString("tenant_name");

				}

				tenantRs.close();
				tenantStmt.close();
				tenantCon.close();
				ActivityUtility.addActivity(

						"💰 "

								+

								tenantName

								+

								" paid ₹"

								+

								amount

								+

								" for "

								+

								monthName

								+

								" rent."

				);

				com.pgmanagement.util.JSResponse.showSweetAlertConfirm(
					resp, 
					"Fee Added", 
					"Fee Details Added Successfully. Do you want to add another fee record?", 
					"success", 
					"addFee.jsp", 
					"dashboard", 
					"Add Another", 
					"Go to Dashboard"
				);

			} else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Failed To Add Fee Details", "error", "addFee.jsp");

			}

		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);

		} catch (NumberFormatException e) {

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Validation Error", "Please Enter Valid Numbers", "warning", null);

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