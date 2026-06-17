package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete-tenant")
public class DeleteTenantServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int tenantId = Integer.parseInt(req.getParameter("tenantId"));

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smart_pg", "root", "admin");

			pstmt = con.prepareStatement("delete from tenant where tenant_id=?");

			pstmt.setInt(1, tenantId);

			int row = pstmt.executeUpdate();

			if (row > 0) {
				resp.sendRedirect("fetch-tenants");
			} else {
				resp.getWriter().println("<h2>Delete Failed</h2>");
			}

		} catch (Exception e) {
			e.printStackTrace();
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