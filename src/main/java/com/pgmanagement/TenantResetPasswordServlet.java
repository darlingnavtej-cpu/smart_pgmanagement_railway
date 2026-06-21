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
import javax.servlet.http.HttpSession;

@WebServlet("/tenant-reset-password")
public class TenantResetPasswordServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String newPassword = req.getParameter("newPassword");
		String confirmPassword = req.getParameter("confirmPassword");

		HttpSession session = req.getSession(false);

		try {

			if (session == null || session.getAttribute("tenantOtpVerified") == null) {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Unauthorized", "Session expired or OTP not verified.", "error", "tenantForgotPassword.jsp");
				return;
			}

			if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Validation Error", "Passwords do not match!", "warning", "tenantResetPassword.jsp");
				return;
			}

			String email = (String) session.getAttribute("tenantResetEmail");

			if (email == null) {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Error", "Email not found in session.", "error", "tenantForgotPassword.jsp");
				return;
			}

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = com.pgmanagement.util.DBUtil.getConnection();

			PreparedStatement pstmt = con.prepareStatement("UPDATE tenant SET password=? WHERE email=?");

			pstmt.setString(1, com.pgmanagement.util.HashUtil.hashPassword(newPassword));
			pstmt.setString(2, email);

			int row = pstmt.executeUpdate();

			pstmt.close();
			con.close();

			session.removeAttribute("tenantResetOtp");
			session.removeAttribute("tenantOtpExpiry");
			session.removeAttribute("tenantOtpVerified");

			if (row > 0) {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Success", "Password updated successfully!", "success", "tenantLogin.jsp");
			} else {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Password update failed.", "error", "tenantResetPassword.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "tenantResetPassword.jsp");
		}
	}
}