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
import javax.servlet.http.HttpSession;

import com.pgmanagement.util.EmailUtility;

@WebServlet("/send-otp")
public class SendOtpServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			Connection con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin");

			PreparedStatement pstmt = con.prepareStatement(

					"select * from newreg where email=?");

			pstmt.setString(1, email);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {

				int otp = (int) (Math.random() * 900000) + 100000;

				HttpSession session = req.getSession();

				session.setAttribute("otp", otp);

				session.setAttribute("email", email);

				String subject = "Smart PG Password Reset OTP";

				String body = "Dear User,\n\n"

						+ "Your OTP for password reset is:\n\n"

						+ otp

						+ "\n\nThis OTP is valid for one verification only."

						+ "\n\nDo not share this OTP with anyone."

						+ "\n\nRegards,\n" + "Smart PG Management Team";

				EmailUtility.sendEmail(

						email,

						subject,

						body);

				resp.sendRedirect("verifyOtp.jsp");

			}

			else {

				resp.getWriter().println(

						"<h2 style='color:red;" + "text-align:center;" + "margin-top:100px;'>"

								+ "Email Not Registered!"

								+ "<br><br>"

								+ "<a href='forgotPassword.jsp'>Try Again</a>"

								+ "</h2>");

			}

			con.close();

		}

		catch (Exception e) {

			e.printStackTrace();

		}

	}

}