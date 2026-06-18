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

@WebServlet("/find-complaint-by-id")
public class FindComplaintByIdServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			int complaintId = Integer.parseInt(req.getParameter("complaintId"));

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement("SELECT * FROM complaint WHERE complaint_id=?");

			pstmt.setInt(1, complaintId);

			rs = pstmt.executeQuery();

			req.setAttribute("resultSet", rs);

			RequestDispatcher rd = req.getRequestDispatcher("updateComplaint.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}