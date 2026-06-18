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

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String password = req.getParameter("password");

		String confirmPassword = req.getParameter("confirmPassword");

		if (!password.equals(confirmPassword)) {

			resp.setContentType("text/html");

			resp.getWriter().println(

					"<html><body " + "style='font-family:Arial;" + "text-align:center;" + "margin-top:100px;'>"

							+ "<h2 style='color:red;'>"

							+ "Passwords Do Not Match!"

							+ "</h2>"

							+ "<br><br>"

							+ "<a href='resetPassword.jsp'>" + "Try Again" + "</a>"

							+ "</body></html>"

			);

			return;
		}

		HttpSession session = req.getSession();

		String email = (String) session.getAttribute("email");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = com.pgmanagement.util.DBUtil.getConnection();

			PreparedStatement pstmt = con.prepareStatement(

					"update newreg " + "set password=? " + "where email=?");

			pstmt.setString(1, password);

			pstmt.setString(2, email);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				session.removeAttribute("otp");
				session.removeAttribute("email");

				resp.setContentType("text/html");

				resp.getWriter().println(

						"<html><body " + "style='font-family:Arial;" + "text-align:center;" + "margin-top:100px;'>"

								+ "<h1 style='color:green;'>"

								+ "Password Updated Successfully!"

								+ "</h1>"

								+ "<br><br>"

								+ "<a href='login.jsp'>"

								+ "Go To Login"

								+ "</a>"

								+ "</body></html>"

				);

			}

			else {

				resp.getWriter().println(

						"<h2>Password Update Failed!</h2>");

			}

			con.close();

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}