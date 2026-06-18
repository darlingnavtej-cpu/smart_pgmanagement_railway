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

@WebServlet("/fetch-activities")
public class FetchActivitiesServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)

			throws ServletException, IOException {

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = com.pgmanagement.util.DBUtil.getConnection();

			PreparedStatement pstmt = con.prepareStatement(

					"SELECT * FROM activity " + "ORDER BY activity_time DESC");

			ResultSet rs = pstmt.executeQuery();

			req.setAttribute("activityResultSet", rs);

			RequestDispatcher rd = req.getRequestDispatcher("recentActivities.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}