package com.pgmanagement;

import com.pgmanagement.util.ActivityUtility;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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

		int tenantId = Integer.parseInt(req.getParameter("tenantId"));
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

			// Insert Query
			pstmt = con.prepareStatement("INSERT INTO tenant VALUES(?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setInt(1, tenantId);
			pstmt.setString(2, name);
			pstmt.setInt(3, age);
			pstmt.setString(4, gender);
			pstmt.setString(5, phone);
			pstmt.setString(6, occupation);
			pstmt.setString(7, institute);
			pstmt.setString(8, joiningDate);
			pstmt.setInt(9, roomnum);
			pstmt.setString(10, email);
			pstmt.setString(11, hashedPassword);

			int row = pstmt.executeUpdate();

			PrintWriter pw = resp.getWriter();

			if (row > 0) {

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
				PreparedStatement feeStmt = roomCon.prepareStatement(

						"INSERT INTO fee " + "(tenant_id, month_name, amount, paid_date, status) " + "VALUES(?,?,?,?,?)"

				);

				feeStmt.setInt(1, tenantId);

				String monthName = java.time.LocalDate.now().getMonth().toString();

				monthName = monthName.substring(0, 1) + monthName.substring(1).toLowerCase();

				feeStmt.setString(2, monthName); // or current month

				feeStmt.setDouble(3, 10000); // room rent

				feeStmt.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));

				feeStmt.setString(5, "Pending");

				feeStmt.executeUpdate();

				feeStmt.close();

				roomStmt.close();

				// Update Room Status

				roomCon.close();

				resp.sendRedirect("fetch-tenants");

//
//				pw.println("<html><body style='font-family:Arial;text-align:center;margin-top:100px;'>");
//				pw.println("<h1 style='color:green;'>Tenant Added Successfully</h1>");
//				pw.println("<br>");
//				pw.println("<a href='addTenant.jsp'>Add Another Tenant</a>");
//				pw.println("<br><br>");
//				pw.println("<a href='dashboard'>Go To Dashboard</a>");
//				pw.println("</body></html>");

			}

			else {

				pw.println("<h1>Failed To Add Tenant</h1>");

			}

		} catch (ClassNotFoundException e) {

			e.printStackTrace();
			resp.getWriter().println("<h2>MySQL Driver Not Found</h2>");

		} catch (SQLException e) {

			e.printStackTrace();
			resp.getWriter().println("<h2>SQL Error : " + e.getMessage() + "</h2>");

		} catch (NumberFormatException e) {

			e.printStackTrace();
			resp.getWriter().println("<h2>Age must be a valid number</h2>");

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