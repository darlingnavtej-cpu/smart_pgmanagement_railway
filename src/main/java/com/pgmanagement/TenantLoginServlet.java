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

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin");

			pstmt = con.prepareStatement(

					"select * from tenant " + "where email=? " + "and password=?");

			pstmt.setString(1, email);

			pstmt.setString(2, password);

			rs = pstmt.executeQuery();
			if (rs.next()) {

				req.getSession().setAttribute("tenantId", rs.getInt("tenant_id"));
				System.out.println("LOGIN TENANT ID = " + rs.getInt("tenant_id"));

				req.getSession().setAttribute("tenantName", rs.getString("tenant_name"));

				req.getSession().setAttribute("roomNo", rs.getInt("room_no"));

				req.getSession().setAttribute("phone", rs.getString("phone"));

				req.getSession().setAttribute("occupation", rs.getString("occupation"));

				req.getSession().setAttribute("email", rs.getString("email"));

				// Add this line
				req.getSession().setAttribute("role", "tenant");

				resp.sendRedirect("tenant-dashboard");

			}

			else {

				resp.getWriter().println(

						"<html><body " + "style='font-family:Arial;" + "text-align:center;" + "margin-top:100px;'>"

								+ "<h2 style='color:red;'>" + "Invalid Email or Password" + "</h2><br>"

								+ "<a href='tenantLogin.jsp'>" + "Try Again" + "</a>"

								+ "</body></html>");

			}

		}

		catch (Exception e) {

			e.printStackTrace();

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