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

@WebServlet("/update-pg-info")
public class UpdatePgInfoServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			String pgName = req.getParameter("pgName");

			String ownerName = req.getParameter("ownerName");

			String phone = req.getParameter("phone");

			String email = req.getParameter("email");

			String address = req.getParameter("address");

			String wifi = req.getParameter("wifi");

			String cctv = req.getParameter("cctv");

			String parking = req.getParameter("parking");

			String laundry = req.getParameter("laundry");

			String hotWater = req.getParameter("hotWater");

			String visitorTime = req.getParameter("visitorTime");

			String rentDueDate = req.getParameter("rentDueDate");
			String googleMapLink = req.getParameter("googleMapLink");

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"UPDATE pg_info SET "

							+ "pg_name=?,"

							+ "owner_name=?,"

							+ "phone=?,"

							+ "email=?,"

							+ "address=?,"

							+ "wifi=?,"

							+ "cctv=?,"

							+ "parking=?,"

							+ "laundry=?,"

							+ "hot_water=?,"

							+ "visitor_time=?,"

							+ "rent_due_date=? " + "google_map_link=? "

							+ "WHERE id=1");

			pstmt.setString(1, pgName);

			pstmt.setString(2, ownerName);

			pstmt.setString(3, phone);

			pstmt.setString(4, email);

			pstmt.setString(5, address);

			pstmt.setString(6, wifi);

			pstmt.setString(7, cctv);

			pstmt.setString(8, parking);

			pstmt.setString(9, laundry);

			pstmt.setString(10, hotWater);

			pstmt.setString(11, visitorTime);

			pstmt.setString(12, rentDueDate);
			pstmt.setString(13, googleMapLink);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Updated", "PG Information Updated Successfully!", "success", "home.jsp");

			}

			else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Update Failed!", "error", "fetch-pg-info");

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