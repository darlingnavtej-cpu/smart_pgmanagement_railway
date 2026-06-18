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

@WebServlet("/tenant-profile")
public class FetchTenantProfileServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Integer tenantId = (Integer) req.getSession().getAttribute("tenantId");

			if (tenantId == null) {

				resp.sendRedirect("tenantLogin.jsp");

				return;

			}

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"select * from tenant " + "where tenant_id=?");

			pstmt.setInt(1, tenantId);

			rs = pstmt.executeQuery();

			req.setAttribute("profileData", rs);

			RequestDispatcher rd = req.getRequestDispatcher("tenantProfile.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}