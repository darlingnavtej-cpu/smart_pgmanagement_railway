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

		}

		else {

			resp.setContentType("text/html");

			resp.getWriter().println(

					"<html><body " + "style='font-family:Arial;" + "text-align:center;" + "margin-top:100px;'>"

							+ "<h2 style='color:red;'>"

							+ "Invalid OTP!"

							+ "</h2>"

							+ "<br><br>"

							+ "<a href='verifyOtp.jsp'>" + "Try Again" + "</a>"

							+ "</body></html>"

			);

		}

	}

}