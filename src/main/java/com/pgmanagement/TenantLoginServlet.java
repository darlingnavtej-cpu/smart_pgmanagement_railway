package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/tenant-login")
public class TenantLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");

		String password = req.getParameter("password");

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"select * from tenant " + "where email=? " + "and password=?");

			pstmt.setString(1, email);

			pstmt.setString(2, com.pgmanagement.util.HashUtil.hashPassword(password));

			rs = pstmt.executeQuery();
			if (rs.next()) {

				javax.servlet.http.HttpSession session = req.getSession();
				session.setAttribute("tenantId", rs.getInt("tenant_id"));
				System.out.println("LOGIN TENANT ID = " + rs.getInt("tenant_id"));

				session.setAttribute("tenantName", rs.getString("tenant_name"));

				session.setAttribute("roomNo", rs.getInt("room_no"));

				session.setAttribute("phone", rs.getString("phone"));

				session.setAttribute("occupation", rs.getString("occupation"));

				session.setAttribute("email", rs.getString("email"));

				session.setAttribute("role", "tenant");

				String currentTenant = (String) session.getAttribute("current_tenant");
				session.setAttribute("authenticated_tenant", currentTenant != null ? currentTenant : "admin");

				resp.sendRedirect("tenant-dashboard");

			}

			else {
				javax.servlet.http.HttpSession session = req.getSession(false);
				String currentTenant = session != null ? (String) session.getAttribute("current_tenant") : null;
				String retryUrl = "tenantLogin.jsp" + (currentTenant != null ? "?tenant=" + currentTenant : "");
				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Login Failed", "Invalid Email or Password", "error", retryUrl);
			}

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);

		}

		finally {

			try {

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			}

			catch (Exception e) {

				e.printStackTrace();

			}

		}

	}

}