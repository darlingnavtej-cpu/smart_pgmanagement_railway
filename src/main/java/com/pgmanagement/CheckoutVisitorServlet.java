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

@WebServlet("/checkout-visitor")
public class CheckoutVisitorServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int visitorId =
					Integer.parseInt(
							req.getParameter("id"));

			Class.forName(
					"com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"UPDATE visitor "

							+

							"SET "

							+

							"checkout_time=NOW(), "

							+

							"status='OUT' "

							+

							"WHERE visitor_id=?"

			);

			pstmt.setInt(
					1,
					visitorId);

			int row =
					pstmt.executeUpdate();

			if (row > 0) {

				ActivityUtility.addActivity(

						"🚶 Visitor Checked Out (ID : "
								+
								visitorId
								+
								")"

				);

			}

			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Checked Out", "Visitor checked out successfully", "success", "fetch-visitors");

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", "fetch-visitors");

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