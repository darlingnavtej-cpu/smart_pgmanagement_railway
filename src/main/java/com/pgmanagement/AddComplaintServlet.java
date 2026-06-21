package com.pgmanagement;

import com.pgmanagement.util.ActivityUtility;
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

@WebServlet("/add-complaint")
public class AddComplaintServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

//			int complaintId = Integer.parseInt(req.getParameter("complaintId"));

			int tenantId = Integer.parseInt(req.getParameter("tenantId"));

			String problem = req.getParameter("problem");

			String complaintDate = req.getParameter("complaintDate");

			String status = req.getParameter("status");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"INSERT INTO complaint("

							+ "tenant_id,"

							+ "problem,"

							+ "complaint_date,"

							+ "status"

							+ ") VALUES(?,?,?,?)"

			);

			pstmt.setInt(1, Integer.parseInt(req.getParameter("tenantId")));

			pstmt.setString(2, req.getParameter("problem"));

			pstmt.setString(3, req.getParameter("complaintDate"));

			pstmt.setString(4, req.getParameter("status"));

			int row = pstmt.executeUpdate();

			if (row > 0) {

			    ActivityUtility.addActivity(
			        "📝 Complaint Submitted by tenantId : " + tenantId
			    );

			    com.pgmanagement.util.JSResponse.showSweetAlertConfirm(
			        resp, 
			        "Complaint Submitted", 
			        "Your complaint has been submitted successfully. Do you want to submit another complaint?", 
			        "success", 
			        "addComplaint.jsp", 
			        "tenant-dashboard", 
			        "Submit Another", 
			        "Go to Dashboard"
			    );

			} 
			else {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Submission Failed", "Complaint Not Added.", "error", "addComplaint.jsp");
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

			catch (SQLException e) {

				e.printStackTrace();

			}
		}

	}

}