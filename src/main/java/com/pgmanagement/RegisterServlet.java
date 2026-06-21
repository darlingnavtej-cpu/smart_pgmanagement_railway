package com.pgmanagement;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");

		String username = req.getParameter("username");

		String password = req.getParameter("password");

		String confirmPassword = req.getParameter("confirmPassword");

		PrintWriter pw = resp.getWriter();

		if (!password.equals(confirmPassword)) {
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Validation Error", "Password and Confirm Password do not match", "warning", "register.jsp");
			return;
		}

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"INSERT INTO newreg(username,password,confirm_password) VALUES(?,?,?)"

			);

			pstmt.setString(1, username);
			pstmt.setString(2, com.pgmanagement.util.HashUtil.hashPassword(password));
			pstmt.setString(3, com.pgmanagement.util.HashUtil.hashPassword(confirmPassword));

			int row = pstmt.executeUpdate();

			if (row > 0) {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Registration Successful", "You can now log in with your credentials.", "success", "login.jsp");
			} else {
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Registration Failed", "Please try again.", "error", "register.jsp");
			}

		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "register.jsp");
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