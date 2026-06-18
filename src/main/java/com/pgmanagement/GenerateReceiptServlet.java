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

@WebServlet("/generate-receipt")
public class GenerateReceiptServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			int tenantId =
					Integer.parseInt(
							req.getParameter("tenantId"));

			String month =
					req.getParameter("month");

			Class.forName(
					"com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT "

					+

					"t.tenant_id, "

					+

					"t.tenant_name, "

					+

					"t.room_no, "

					+

					"f.month_name, "

					+

					"f.amount, "

					+

					"f.paid_date "

					+

					"FROM tenant t "

					+

					"INNER JOIN fee f "

					+

					"ON t.tenant_id = f.tenant_id "

					+

					"WHERE t.tenant_id=? "

					+

					"AND f.month_name=?"

			);

			pstmt.setInt(1, tenantId);

			pstmt.setString(2, month);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				req.setAttribute(
						"tenantId",
						rs.getInt("tenant_id"));

				req.setAttribute(
						"tenantName",
						rs.getString("tenant_name"));

				req.setAttribute(
						"roomNo",
						rs.getInt("room_no"));

				req.setAttribute(
						"monthName",
						rs.getString("month_name"));

				req.setAttribute(
						"amount",
						rs.getDouble("amount"));

				req.setAttribute(
						"paidDate",
						rs.getDate("paid_date"));

				RequestDispatcher rd =
						req.getRequestDispatcher(
								"receipt.jsp");

				rd.forward(
						req,
						resp);

			}

			else {

				resp.getWriter().println(
						"<h2>No Receipt Found</h2>");

			}

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