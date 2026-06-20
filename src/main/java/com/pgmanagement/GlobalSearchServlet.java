package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/global-search")
public class GlobalSearchServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement tenantStmt = null;
		PreparedStatement roomStmt = null;
		PreparedStatement employeeStmt = null;
		ResultSet tenantRs = null;
		ResultSet roomRs = null;
		ResultSet employeeRs = null;

		try {
			String keyword = req.getParameter("keyword");
			if (keyword == null) {
				keyword = "";
			}
			keyword = keyword.trim();

			con = com.pgmanagement.util.DBUtil.getConnection();

			// 1. Search Tenant (by name or exact room number)
			tenantStmt = con.prepareStatement(
				"SELECT * FROM tenant WHERE tenant_name LIKE ? OR CAST(room_no AS CHAR) = ?"
			);
			tenantStmt.setString(1, "%" + keyword + "%");
			tenantStmt.setString(2, keyword);
			tenantRs = tenantStmt.executeQuery();
			req.setAttribute("tenantResult", tenantRs);

			// 2. Search Room (by exact room number)
			roomStmt = con.prepareStatement(
				"SELECT * FROM room WHERE CAST(room_no AS CHAR) = ?"
			);
			roomStmt.setString(1, keyword);
			roomRs = roomStmt.executeQuery();
			req.setAttribute("roomResult", roomRs);

			// 3. Search Employee (by name)
			employeeStmt = con.prepareStatement(
				"SELECT * FROM employee WHERE employee_name LIKE ?"
			);
			employeeStmt.setString(1, "%" + keyword + "%");
			employeeRs = employeeStmt.executeQuery();
			req.setAttribute("employeeResult", employeeRs);

			req.setAttribute("keyword", keyword);

			RequestDispatcher rd = req.getRequestDispatcher("displaySearch.jsp");
			rd.forward(req, resp);

		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
		} finally {
			try {
				if (tenantRs != null) tenantRs.close();
				if (roomRs != null) roomRs.close();
				if (employeeRs != null) employeeRs.close();
				if (tenantStmt != null) tenantStmt.close();
				if (roomStmt != null) roomStmt.close();
				if (employeeStmt != null) employeeStmt.close();
				if (con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}