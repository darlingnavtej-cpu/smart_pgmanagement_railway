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

@WebServlet("/update-tenant")
public class UpdateTenantServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int tenantId = Integer.parseInt(req.getParameter("tenantId"));

			String tenantName = req.getParameter("name");

			int tenantAge = Integer.parseInt(req.getParameter("age"));

			String tenantGender = req.getParameter("gender");

			String phone = req.getParameter("phone");

			String occupation = req.getParameter("occupation");

			String institute = req.getParameter("institute");

			String joiningDate = req.getParameter("joiningDate");
			int rmnum = Integer.parseInt(req.getParameter("roomnum"));
			String email = req.getParameter("email");

			// Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection
			con = com.pgmanagement.util.DBUtil.getConnection();

			// Update Query

			pstmt = con.prepareStatement(
					"update tenant set tenant_name=?, age=?, gender=?, phone=?, occupation=?, institute=?, joining_date=?, room_no=? , email=? where tenant_id=?");

			pstmt.setString(1, tenantName);
			pstmt.setInt(2, tenantAge);
			pstmt.setString(3, tenantGender);
			pstmt.setString(4, phone);
			pstmt.setString(5, occupation);
			pstmt.setString(6, institute);
			pstmt.setString(7, joiningDate);
			pstmt.setInt(8, rmnum);
			pstmt.setString(9, email);
			pstmt.setInt(10, tenantId);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Updated", "Tenant Updated Successfully", "success", "fetch-tenants");

			} else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Update Failed", "error", null);

			}

		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);

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