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
import javax.servlet.http.HttpSession;

@WebServlet("/tenant-dashboard")
public class TenantDashboardServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			HttpSession session = req.getSession(false);

			// Check Login
			if (session == null || session.getAttribute("tenantId") == null) {

				resp.sendRedirect("tenantLogin.jsp");

				return;
			}

			int tenantId = (Integer) session.getAttribute("tenantId");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			pstmt = con.prepareStatement(

					"SELECT * FROM tenant WHERE tenant_id=?"

			);

			pstmt.setInt(1, tenantId);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				req.setAttribute(

						"tenantName",

						rs.getString("tenant_name")

				);

				req.setAttribute(

						"roomNo",

						rs.getInt("room_no")

				);

				req.setAttribute(

						"phone",

						rs.getString("phone")

				);

				req.setAttribute(

						"occupation",

						rs.getString("occupation")

				);

				req.setAttribute(

						"email",

						rs.getString("email")

				);

			}

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"tenantDashboard.jsp"

					);

			rd.forward(

					req,

					resp

			);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println(

					"<h2>Error : "

							+

							e.getMessage()

							+

							"</h2>"

			);

		}

		finally {

			try {

				if (rs != null)
					rs.close();

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