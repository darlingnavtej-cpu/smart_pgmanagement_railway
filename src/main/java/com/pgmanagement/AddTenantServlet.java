package com.pgmanagement;

import com.pgmanagement.util.ActivityUtility;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/add-tenant")
public class AddTenantServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setContentType("text/html");

		String name = req.getParameter("name");
		int age = Integer.parseInt(req.getParameter("age"));
		String gender = req.getParameter("gender");
		String phone = req.getParameter("phone");
		String occupation = req.getParameter("occupation");
		String institute = req.getParameter("institute");
		String joiningDate = req.getParameter("joiningDate");
		int roomnum = Integer.parseInt(req.getParameter("roomnnum"));
		String email = req.getParameter("email");
		String password = phone.substring(phone.length() - 4);
		String hashedPassword = com.pgmanagement.util.HashUtil.hashPassword(password);

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			// Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect to tenant_table schema
			con = com.pgmanagement.util.DBUtil.getConnection();

			// Insert Query using auto-increment key returning
			pstmt = con.prepareStatement(
				"INSERT INTO tenant (tenant_name, age, gender, phone, occupation, institute, joining_date, room_no, email, password) VALUES(?,?,?,?,?,?,?,?,?,?)",
				Statement.RETURN_GENERATED_KEYS
			);
			pstmt.setString(1, name);
			pstmt.setInt(2, age);
			pstmt.setString(3, gender);
			pstmt.setString(4, phone);
			pstmt.setString(5, occupation);
			pstmt.setString(6, institute);
			pstmt.setString(7, joiningDate);
			pstmt.setInt(8, roomnum);
			pstmt.setString(9, email);
			pstmt.setString(10, hashedPassword);

			int row = pstmt.executeUpdate();
			int tenantId = 0;

			PrintWriter pw = resp.getWriter();

			if (row > 0) {
				try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
					if (generatedKeys.next()) {
						tenantId = generatedKeys.getInt(1);
					}
				}

				ActivityUtility.addActivity(

						"🟢 New tenant "

								+

								name

								+

								" joined Room "

								+

								roomnum

				);

				// Update Room Occupancy

				Connection roomCon = com.pgmanagement.util.DBUtil.getConnection();

				PreparedStatement roomStmt = roomCon.prepareStatement(

						"UPDATE room "

								+

								"SET occupied=occupied+1 "

								+

								"WHERE room_no=?"

				);

				roomStmt.setInt(

						1,

						roomnum

				);

				roomStmt.executeUpdate();
				// Retrieve room rent dynamically
				double roomRent = 10000; // Default fallback
				try (PreparedStatement rentStmt = roomCon.prepareStatement("SELECT rent FROM room WHERE room_no = ?")) {
					rentStmt.setInt(1, roomnum);
					try (ResultSet rentRs = rentStmt.executeQuery()) {
						if (rentRs.next()) {
							roomRent = rentRs.getDouble("rent");
						}
					}
				}

				PreparedStatement feeStmt = roomCon.prepareStatement(
						"INSERT INTO fee " + "(tenant_id, month_name, amount, paid_date, status) " + "VALUES(?,?,?,?,?)"
				);

				feeStmt.setInt(1, tenantId);

				String monthName = java.time.LocalDate.now().getMonth().toString();

				monthName = monthName.substring(0, 1) + monthName.substring(1).toLowerCase();

				feeStmt.setString(2, monthName); // or current month

				feeStmt.setDouble(3, roomRent); // room rent

				feeStmt.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));

				feeStmt.setString(5, "Pending");

				feeStmt.executeUpdate();

				feeStmt.close();

				roomStmt.close();

				// Update Room Status

				roomCon.close();

				com.pgmanagement.util.JSResponse.showSweetAlertConfirm(
					resp,
					"Tenant Added",
					"Tenant Added Successfully. Do you want to add another tenant?",
					"success",
					"addTenant.jsp",
					"fetch-tenants",
					"Add Another",
					"Go to List"
				);

			}

			else {

				com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Failed", "Failed To Add Tenant", "error", "addTenant.jsp");

			}

		} catch (ClassNotFoundException e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "System Error", "MySQL Driver Not Found", "error", null);

		} catch (SQLException e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "SQL Error", e.getMessage(), "error", null);

		} catch (NumberFormatException e) {

			e.printStackTrace();
			com.pgmanagement.util.JSResponse.showSweetAlert(resp, "Validation Error", "Age must be a valid number", "warning", null);

		} finally {

			try {

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (SQLException e) {

				e.printStackTrace();

			}
		}
	}
}