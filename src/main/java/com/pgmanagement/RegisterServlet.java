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

			pw.println("<script>" + "alert('Password and Confirm Password do not match');"
					+ "window.location='register.jsp';" + "</script>");

			return;
		}

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smart_pg", "root", "admin");

			pstmt = con.prepareStatement(

					"INSERT INTO newreg(username,password,confirm_password) VALUES(?,?,?)"

			);

			pstmt.setString(1, username);
			pstmt.setString(2, password);
			pstmt.setString(3, confirmPassword);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				pw.println(

						"<script>" + "alert('Registration Successful');" + "window.location='login.jsp';" + "</script>"

				);

			} else {

				pw.println("<h2>Registration Failed</h2>");
			}

		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();

			pw.println(

					"<h2>Error : " + e.getMessage() + "</h2>"

			);
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