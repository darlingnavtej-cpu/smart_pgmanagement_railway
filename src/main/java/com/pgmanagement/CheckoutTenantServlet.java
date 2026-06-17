package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pgmanagement.util.ActivityUtility;

@WebServlet("/checkout-tenant")
public class CheckoutTenantServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int tenantId = Integer.parseInt(req.getParameter("tenantId"));

			String tenantName = req.getParameter("tenantName");

			int roomNo = Integer.parseInt(req.getParameter("roomNo"));

			String exitDate = req.getParameter("exitDate");

			int refundAmount = Integer.parseInt(req.getParameter("refundAmount"));

			String reason = req.getParameter("reason");

			Class.forName("com.mysql.cj.jdbc.Driver");

			// -------------------------
			// Save Checkout History
			// ----------------------

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			pstmt = con.prepareStatement(

					"INSERT INTO tenant_checkout "

							+

							"(tenant_id,"

							+

							"tenant_name,"

							+

							"room_no,"

							+

							"exit_date,"

							+

							"refund_amount,"

							+

							"reason)"

							+

							"VALUES(?,?,?,?,?,?)"

			);

			pstmt.setInt(1, tenantId);

			pstmt.setString(2, tenantName);

			pstmt.setInt(3, roomNo);

			pstmt.setString(4, exitDate);

			pstmt.setInt(5, refundAmount);

			pstmt.setString(6, reason);

			pstmt.executeUpdate();
			pstmt.close();
			con.close();

			// -------------------------
			// Remove Active Tenant
			// -------------------------

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			pstmt = con.prepareStatement(

					"DELETE FROM tenant "

							+

							"WHERE tenant_id=?"

			);

			pstmt.setInt(1, tenantId);

			pstmt.executeUpdate();

			// -------------------------
			// Update Room Occupancy
			// -------------------------

			con.close();

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			PreparedStatement roomStmt = con.prepareStatement(

					"UPDATE room "

							+

							"SET occupied=occupied-1 "

							+

							"WHERE room_no=?"

			);

			roomStmt.setInt(

					1,

					roomNo

			);

			roomStmt.executeUpdate();

			roomStmt.close();

			// -------------------------
			// Update Room Status
			// -------------------------

		
			// -------------------------
			// Activity
			// -------------------------

			ActivityUtility.addActivity(

					"🚪 "

							+

							tenantName

							+

							" checked out from Room "

							+

							roomNo

			);

			// -------------------------

			resp.sendRedirect(

					"fetch-tenants"

			);

		}

		catch (Exception e) {

			e.printStackTrace();

			resp.getWriter().println(

					"<h2>Error : "

							+

							e.getMessage()

							+

							"</h2>");

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