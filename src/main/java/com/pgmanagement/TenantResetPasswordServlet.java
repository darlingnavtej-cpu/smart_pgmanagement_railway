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
				resp.sendRedirect("tenantForgotPassword.jsp");
				return;
			}

			if (newPassword == null || confirmPassword == null || !newPassword.equals(confirmPassword)) {
				resp.sendRedirect("tenantResetPassword.jsp?error=nomatch");
				return;
			}

			String email = (String) session.getAttribute("tenantResetEmail");

			if (email == null) {
				resp.sendRedirect("tenantForgotPassword.jsp");
				return;
			}

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = com.pgmanagement.util.DBUtil.getConnection();

			PreparedStatement pstmt = con.prepareStatement("UPDATE tenant SET password=? WHERE email=?");

			pstmt.setString(1, newPassword);
			pstmt.setString(2, email);

			int row = pstmt.executeUpdate();

			pstmt.close();
			con.close();

			session.removeAttribute("tenantResetOtp");
			session.removeAttribute("tenantOtpExpiry");
			session.removeAttribute("tenantOtpVerified");

			if (row > 0) {
				resp.sendRedirect("tenantLogin.jsp?msg=passwordupdated");
			} else {
				resp.sendRedirect("tenantResetPassword.jsp?error=updatefailed");
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
		}
	}
}