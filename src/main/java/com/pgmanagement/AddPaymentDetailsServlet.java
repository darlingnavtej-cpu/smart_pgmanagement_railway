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

@WebServlet("/add-payment-details")
public class AddPaymentDetailsServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			String ownerName = req.getParameter("ownerName");

			String bankName = req.getParameter("bankName");

			String accountNumber = req.getParameter("accountNumber");

			String ifscCode = req.getParameter("ifscCode");

			String upiId = req.getParameter("upiId");

			String qrImage = req.getParameter("qrImage");

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Create Connection

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Insert Query

			pstmt = con.prepareStatement(

					"INSERT INTO payment_details "

							+

							"(owner_name,"

							+

							"bank_name,"

							+

							"account_number,"

							+

							"ifsc_code,"

							+

							"upi_id,"

							+

							"qr_image)"

							+

							" VALUES(?,?,?,?,?,?)"

			);

			pstmt.setString(1, ownerName);

			pstmt.setString(2, bankName);

			pstmt.setString(3, accountNumber);

			pstmt.setString(4, ifscCode);

			pstmt.setString(5, upiId);

			pstmt.setString(6, qrImage);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				ActivityUtility.addActivity(

						"💳 Payment Details Updated"

				);

				resp.getWriter().println(

						"<script>"

								+

								"alert('Payment Details Saved Successfully');"

								+

								"window.location='fetch-payment-details';"

								+

								"</script>"

				);

			}

			else {

				resp.getWriter().println(

						"<h2>Failed To Save Details</h2>"

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