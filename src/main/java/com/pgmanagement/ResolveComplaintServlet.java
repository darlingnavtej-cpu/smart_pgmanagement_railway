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

@WebServlet("/resolve-complaint")
public class ResolveComplaintServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			int complaintId = Integer.parseInt(req.getParameter("complaintId"));

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"UPDATE complaint " + "SET status=? " + "WHERE complaint_id=?");

			pstmt.setString(1, "Resolved");

			pstmt.setInt(2, complaintId);

			int row = pstmt.executeUpdate();

			if (row > 0) {

				resp.sendRedirect("fetch-complaints");

			} else {

				resp.getWriter().println("<h2>Unable to Update Complaint</h2>");

			}

		}

		catch (Exception e) {

			e.printStackTrace();

		}

		finally {

			try {

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (Exception e) {

				e.printStackTrace();

			}

		}

	}

}