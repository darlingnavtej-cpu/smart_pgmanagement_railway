package com.pgmanagement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String userOtp = req.getParameter("otp");

		HttpSession session = req.getSession();

		Integer originalOtp = (Integer) session.getAttribute("otp");

		if (originalOtp != null && userOtp.equals(String.valueOf(originalOtp))) {

			resp.sendRedirect("resetPassword.jsp");

		} else {

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Invalid OTP", "The entered OTP is incorrect. Please try again.", "error", "verifyOtp.jsp");

		}

	}

}