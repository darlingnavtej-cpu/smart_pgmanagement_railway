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

@WebServlet("/find-notice")
public class FindNoticeByIdServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int noticeId = Integer.parseInt(req.getParameter("id"));

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"select * from notice where notice_id=?");

			pstmt.setInt(1, noticeId);

			rs = pstmt.executeQuery();

			req.setAttribute("noticeData", rs);

			RequestDispatcher rd = req.getRequestDispatcher("updateNotice.jsp");

			rd.forward(req, resp);

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}