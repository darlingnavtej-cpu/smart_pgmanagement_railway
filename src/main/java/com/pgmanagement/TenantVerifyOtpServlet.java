package com.pgmanagement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/tenant-verify-otp")
public class TenantVerifyOtpServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String userOtp = req.getParameter("otp");

		HttpSession session = req.getSession(false);

		if (session == null) {
			resp.sendRedirect("tenantForgotPassword.jsp");
			return;
		}

		String savedOtp = (String) session.getAttribute("tenantResetOtp");
		Long expiry = (Long) session.getAttribute("tenantOtpExpiry");

		if (savedOtp == null || expiry == null) {
			resp.sendRedirect("tenantVerifyOtp.jsp?error=expired");
			return;
		}

		if (System.currentTimeMillis() > expiry) {
			session.removeAttribute("tenantResetOtp");
			session.removeAttribute("tenantOtpExpiry");
			resp.sendRedirect("tenantVerifyOtp.jsp?error=expired");
			return;
		}

		if (!savedOtp.equals(userOtp)) {
			resp.sendRedirect("tenantVerifyOtp.jsp?error=invalid");
			return;
		}

		session.setAttribute("tenantOtpVerified", true);
		resp.sendRedirect("tenantResetPassword.jsp");
	}
}