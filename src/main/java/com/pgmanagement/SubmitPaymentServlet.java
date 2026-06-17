package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.pgmanagement.util.ActivityUtility;

@WebServlet("/submit-payment")
public class SubmitPaymentServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int tenantId = Integer.parseInt(req.getParameter("tenantId"));

			String tenantName = req.getParameter("tenantName");

			int roomNo = Integer.parseInt(req.getParameter("roomNo"));

			String monthName = req.getParameter("monthName");

			int amount = Integer.parseInt(req.getParameter("amount"));

			String utrNumber = req.getParameter("utrNumber");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			pstmt = con.prepareStatement(

					"INSERT INTO payment_request"

							+

							"(tenant_id,"

							+

							"tenant_name,"

							+

							"room_no,"

							+

							"amount,"

							+

							"month_name,"

							+

							"utr_number,"

							+

							"submitted_on,"

							+

							"status)"

							+

							" VALUES(?,?,?,?,?,?,?,?)"

			);

			pstmt.setInt(1, tenantId);

			pstmt.setString(2, tenantName);

			pstmt.setInt(3, roomNo);

			pstmt.setInt(4, amount);

			pstmt.setString(5, monthName);

			pstmt.setString(6, utrNumber);

			pstmt.setString(7, LocalDateTime.now().toString());

			pstmt.setString(8, "Submitted");

			int row = pstmt.executeUpdate();

			if (row > 0) {

				ActivityUtility.addActivity(

						"💳 Rent Payment Submitted : "

								+

								tenantName

				);

				resp.getWriter().println(

						"<script>"

								+

								"alert('Payment Submitted Successfully!');"

								+

								"window.location='tenant-dashboard';"

								+

								"</script>"

				);

			}

			else {

				resp.getWriter().println(

						"<h2>Payment Submission Failed</h2>"

				);

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