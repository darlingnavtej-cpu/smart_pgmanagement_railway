package com.pgmanagement;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-logout")
public class AdminLogoutServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		// Get Existing Session
		HttpSession session = req.getSession(false);

		// Invalidate Session
		if (session != null) {

			session.invalidate();

		}

		// Redirect To Login Page
		resp.sendRedirect("login.jsp");

	}
}