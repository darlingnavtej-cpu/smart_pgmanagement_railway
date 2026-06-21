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

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Validation Error", "Passwords Do Not Match!", "warning", "resetPassword.jsp");

			return;
		}

		HttpSession session = req.getSession();

		String email = (String) session.getAttribute("email");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = com.pgmanagement.util.DBUtil.getConnection();

			PreparedStatement pstmt = con.prepareStatement(

					"update newreg " + "set password=? " + "where email=?");

			pstmt.setString(1, com.pgmanagement.util.HashUtil.hashPassword(password));

			pstmt.setString(2, email);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				session.removeAttribute("otp");
				session.removeAttribute("email");

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Success", "Password Updated Successfully!", "success", "login.jsp");

			}

			else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Password Update Failed!", "error", "resetPassword.jsp");

			}

			con.close();

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "resetPassword.jsp");

		}

	}

}