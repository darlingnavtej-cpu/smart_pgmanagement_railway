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

@WebServlet("/fetch-reminder-history")
public class FetchReminderHistoryServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)

			throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"SELECT * " + "FROM reminder_history " + "ORDER BY " + "reminder_id DESC");

			rs = pstmt.executeQuery();

			req.setAttribute(

					"resultSet",

					rs);

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"reminderHistory.jsp");

			rd.forward(

					req,

					resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}