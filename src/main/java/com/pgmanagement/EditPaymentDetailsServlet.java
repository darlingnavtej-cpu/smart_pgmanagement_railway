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

@WebServlet("/edit-payment-details")
public class EditPaymentDetailsServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			int paymentId = Integer.parseInt(

					req.getParameter("id")

			);

			Class.forName(

					"com.mysql.cj.jdbc.Driver"

			);

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin"

			);

			pstmt = con.prepareStatement(

					"SELECT * FROM payment_details "

							+

							"WHERE payment_id=?"

			);

			pstmt.setInt(

					1,

					paymentId

			);

			rs = pstmt.executeQuery();

			req.setAttribute(

					"paymentData",

					rs

			);

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"updatePaymentDetails.jsp"

					);

			rd.forward(

					req,

					resp

			);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}