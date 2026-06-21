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

@WebServlet("/add-visitor")
public class AddVisitorServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			String visitorName = req.getParameter("visitorName");

			String phone = req.getParameter("phone");

			String tenantName = req.getParameter("tenantName");

			int roomNo = Integer.parseInt(req.getParameter("roomNo"));

			String purpose = req.getParameter("purpose");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"INSERT INTO visitor "

							+

							"(visitor_name,phone,tenant_name,room_no,purpose,checkin_time,checkout_time,status) "

							+

							"VALUES(?,?,?,?,?,NOW(),NULL,'IN')"

			);

			pstmt.setString(1, visitorName);

			pstmt.setString(2, phone);

			pstmt.setString(3, tenantName);

			pstmt.setInt(4, roomNo);

			pstmt.setString(5, purpose);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				ActivityLogger.log(

						"👤 Visitor "

								+

								visitorName

								+

								" entered."

				);

				com.pgmanagement.util.JSResponse.showSweetAlertConfirm(
					resp,
					"Visitor Added",
					"Visitor Added Successfully. Do you want to add another visitor?",
					"success",
					"addVisitor.jsp",
					"fetch-visitors",
					"Add Another",
					"Go to List"
				);

			}

			else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Failed To Add Visitor", "error", "addVisitor.jsp");

			}

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);

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