package com.pgmanagement;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");

		String username = req.getParameter("username");
		String password = req.getParameter("password");

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection
			con = com.pgmanagement.util.DBUtil.getConnection();

			// Validation Query
			pstmt = con.prepareStatement("SELECT * FROM newreg WHERE (username=? OR email=?) AND password=?");

			pstmt.setString(1, username);
			pstmt.setString(2, username);
			pstmt.setString(3, com.pgmanagement.util.HashUtil.hashPassword(password));

			rs = pstmt.executeQuery();

			if(rs.next()){

			    HttpSession session =
			    req.getSession();

			    session.setAttribute(
			        "adminUsername",
			        username
			    );

			    session.setAttribute(
			        "role",
			        "admin"
			    );

			    String currentTenant = (String) session.getAttribute("current_tenant");
			    session.setAttribute("authenticated_tenant", currentTenant != null ? currentTenant : "admin");

			    resp.sendRedirect("dashboard");
			}
			
			
			else {

				// Login Failed
				PrintWriter pw = resp.getWriter();
				pw.println("<h1>Invalid Username or Password</h1>");
				pw.println("<a href='login.jsp'>Try Again</a>");

			}

		} catch (ClassNotFoundException | SQLException e) {

			e.printStackTrace();

			PrintWriter pw = resp.getWriter();
			pw.println("<h2>Error : " + e.getMessage() + "</h2>");

		} finally {

			try {
				if (rs != null)

					rs.close();

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
