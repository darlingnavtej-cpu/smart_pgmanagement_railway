package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/add-room")
public class AddRoomServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req,
			HttpServletResponse resp)
			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement checkStmt = null;
		ResultSet rs = null;

		try {

			// Get Room Details
			int roomNo = Integer.parseInt(
					req.getParameter("roomNo"));

			int capacity = Integer.parseInt(
					req.getParameter("capacity"));

			int occupied = Integer.parseInt(
					req.getParameter("occupied"));

			int rent = Integer.parseInt(
					req.getParameter("rent"));

			// Auto Status
			String status;

			if (occupied >= capacity) {

				status = "Full";

			} else {

				status = "Available";
			}

			// Load Driver
			Class.forName(
					"com.mysql.cj.jdbc.Driver");

			// Create Connection
			con = com.pgmanagement.util.DBUtil.getConnection();

			// Check Duplicate Room Number
			checkStmt = con.prepareStatement(

					"SELECT * FROM room WHERE room_no=?");

			checkStmt.setInt(1, roomNo);

			rs = checkStmt.executeQuery();

			if (rs.next()) {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Duplicate Room", "Room Number Already Exists!", "warning", "addRoom.jsp");

				return;
			}

			// Insert Room
			pstmt = con.prepareStatement(

					"INSERT INTO room "
					+ "(room_no, capacity, occupied, status, rent) "
					+ "VALUES(?,?,?,?,?)");

			pstmt.setInt(1, roomNo);

			pstmt.setInt(2, capacity);

			pstmt.setInt(3, occupied);

			pstmt.setString(4, status);

			pstmt.setInt(5, rent);

			int result = pstmt.executeUpdate();

			if (result > 0) {

				com.pgmanagement.util.JSResponse.showSweetAlertConfirm(
					resp,
					"Room Added",
					"Room Added Successfully. Do you want to add another room?",
					"success",
					"addRoom.jsp",
					"fetch-rooms",
					"Add Another",
					"Go to List"
				);

			} else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Room Not Added!", "error", "addRoom.jsp");
			}

		}

		catch (Exception e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", e.getMessage(), "error", null);
		}

		finally {

			try {

				if (rs != null)
					rs.close();

				if (checkStmt != null)
					checkStmt.close();

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