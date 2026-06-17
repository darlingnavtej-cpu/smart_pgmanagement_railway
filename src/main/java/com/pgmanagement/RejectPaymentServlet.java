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

@WebServlet("/reject-payment")
public class RejectPaymentServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int requestId = Integer.parseInt(

					req.getParameter("requestId")

			);

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect Database

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			// Update Status

			pstmt = con.prepareStatement(

					"UPDATE payment_request "

							+

							"SET status='Rejected' "

							+

							"WHERE request_id=?"

			);

			pstmt.setInt(

					1,

					requestId

			);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				ActivityUtility.addActivity(

						"❌ Rent Payment Rejected"

				);

			}

			// Redirect Back

			resp.sendRedirect(

					"fetch-payment-requests"

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