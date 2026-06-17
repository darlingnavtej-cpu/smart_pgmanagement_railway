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

@WebServlet("/tenant-payment-history")
public class FetchTenantPaymentHistoryServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			// Get Tenant Details From Session

			HttpSession session = req.getSession();
			System.out.println("tenantId = " + session.getAttribute("tenantId"));
			

			System.out.println("tenantName = " + session.getAttribute("tenantName"));

			System.out.println("roomNo = " + session.getAttribute("roomNo"));

			Integer tenantId = (Integer) session.getAttribute("tenantId");
			System.out.println("HISTORY TENANT ID = " + tenantId);

			String tenantName = (String) session.getAttribute("tenantName");

			Integer roomNo = (Integer) session.getAttribute("roomNo");

			if (tenantId == null) {

				resp.getWriter().println("<h2>Session Expired. Please Login Again.</h2>");

				return;
			}

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect Database

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			// Fetch Payment History

			pstmt = con.prepareStatement(

					"SELECT * "

							+

							"FROM fee "

							+

							"WHERE tenant_id=? "

							+

							"ORDER BY fee_id DESC"

			);

			pstmt.setInt(

					1,

					tenantId

			);

			rs = pstmt.executeQuery();

			// Send Data To JSP

			req.setAttribute(

					"resultSet",

					rs

			);

			req.setAttribute(

					"tenantName",

					tenantName

			);

			req.setAttribute(

					"roomNo",

					roomNo

			);

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"tenantPaymentHistory.jsp"

					);

			rd.forward(req,resp);

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