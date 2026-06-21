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

@WebServlet("/update-complaint")
public class UpdateComplaintServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Get Form Data

			int complaintId = Integer.parseInt(req.getParameter("complaintId"));

			int tenantId = Integer.parseInt(req.getParameter("tenantId"));

			String problem = req.getParameter("problem");

			String complaintDate = req.getParameter("complaintDate");

			String status = req.getParameter("status");

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Update Query

			pstmt = con.prepareStatement(

					"update complaint set " + "tenant_id=?, " + "problem=?, " + "complaint_date=?, " + "status=? "
							+ "where complaint_id=?");

			pstmt.setInt(1, tenantId);
			pstmt.setString(2, problem);
			pstmt.setString(3, complaintDate);
			pstmt.setString(4, status);
			pstmt.setInt(5, complaintId);
			
			System.out.println("Complaint ID : " + complaintId);
			System.out.println("Tenant ID : " + tenantId);
			System.out.println("Problem : " + problem);
			System.out.println("Date : " + complaintDate);
			System.out.println("Status : " + status);

			int row = pstmt.executeUpdate();
			System.out.println("Rows Updated : " + row);

			if (row > 0) {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Updated", "Complaint Updated Successfully", "success", "fetch-complaints");

			} else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Complaint Update Failed", "error", null);
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
