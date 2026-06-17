package com.pgmanagement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pgmanagement.util.EmailUtility;

@WebServlet("/test-email")
public class TestEmailServlet extends HttpServlet {

	@Override
	protected void doGet(
			HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		EmailUtility.sendEmail(

				"darlingnavtej@gmail.com"
				+ "",

				"Welcome to Smart PG",

				"Congratulations!\n\n"
				+ "Your Smart PG "
				+ "Management System "
				+ "has successfully "
				+ "sent its first email.\n\n"
				+ "Next step:\n"
				+ "Automatic Rent Reminder System.\n\n"

				+ "Regards,\n"
				+ "Smart PG Team Navatejajale"

		);
		System.out.println("Sending to: darlingnavtej@gmail.com");

		resp.getWriter().println(
				"<h1>Email Sent Successfully!</h1>");

	}

}