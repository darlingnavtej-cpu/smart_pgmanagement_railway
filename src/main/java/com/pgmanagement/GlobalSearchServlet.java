package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/global-search")
public class GlobalSearchServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection tenantCon = null;
		Connection roomCon = null;
		Connection employeeCon = null;

		PreparedStatement tenantStmt = null;
		PreparedStatement roomStmt = null;
		PreparedStatement employeeStmt = null;

		ResultSet tenantRs = null;
		ResultSet roomRs = null;
		ResultSet employeeRs = null;

		try {

			String keyword = req.getParameter("keyword");

			Class.forName("com.mysql.cj.jdbc.Driver");

			// ==========================
			// Search Tenant
			// ==========================

			tenantCon = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg", "root", "admin"

			);

			tenantStmt = tenantCon.prepareStatement(

					"SELECT * FROM tenant WHERE tenant_name LIKE ?"

			);

			tenantStmt.setString(1, "%" + keyword + "%");

			tenantRs = tenantStmt.executeQuery();

			req.setAttribute("tenantResult", tenantRs);

//			// ==========================
//			// Search Room
//			// ==========================
//
//			roomCon = DriverManager.getConnection(
//
//					"jdbc:mysql://localhost:3306/room_table",
//
//					"root",
//
//					"admin"
//
//			);
//
//			roomStmt = roomCon.prepareStatement("SELECT * FROM room");
////			roomStmt.setString(
////
////					1,
////
////					"%"
////
////							+
////
////							keyword
////
////							+
////
////							"%"
////
////			);
//
//			roomRs = roomStmt.executeQuery();
//			boolean found = false;
//
//			while (roomRs.next()) {
//
//				found = true;
//
//				System.out.println("Room Found : " + roomRs.getInt("room_no"));
//			}
//
//			System.out.println("Room Search Found = " + found);
//
//			req.setAttribute(
//
//					"roomResult",
//
//					roomRs
//
//			);

			// ==========================
			// Search Employee
			// ==========================

			employeeCon = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			employeeStmt = employeeCon.prepareStatement(

					"SELECT * FROM employee "

							+

							"WHERE employee_name LIKE ?"

			);

			employeeStmt.setString(

					1,

					"%"

							+

							keyword

							+

							"%"

			);

			employeeRs = employeeStmt.executeQuery();

			req.setAttribute(

					"employeeResult",

					employeeRs

			);

			req.setAttribute(

					"keyword",

					keyword

			);

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"displaySearch.jsp"

					);

			rd.forward(

					req,

					resp

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

	}

}