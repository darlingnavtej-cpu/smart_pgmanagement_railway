package com.pgmanagement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pgmanagement.util.EmailUtility;

@WebServlet("/tenant-send-otp")
public class TenantSendOtpServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String email = req.getParameter("email");

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smart_pg", "root", "admin");

			pstmt = con.prepareStatement("SELECT tenant_id, tenant_name, email FROM tenant WHERE email=?");

			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				int otp = (int) (Math.random() * 900000) + 100000;

				HttpSession session = req.getSession();

				session.setAttribute("tenantResetOtp", String.valueOf(otp));
				session.setAttribute("tenantResetEmail", email);
				session.setAttribute("tenantOtpExpiry", System.currentTimeMillis() + (5 * 60 * 1000));

				String subject = "Smart PG Tenant Password Reset OTP";

				String body = "Dear " + rs.getString("tenant_name") + ",\n\n"
						+ "Your OTP for tenant password reset is:\n\n" + otp
						+ "\n\nThis OTP is valid for 5 minutes only." + "\n\nDo not share this OTP with anyone."
						+ "\n\nRegards,\nSmart PG Management Team";

				EmailUtility.sendEmail(email, subject, body);

				resp.sendRedirect("tenantVerifyOtp.jsp?msg=sent");

			} else {

				resp.getWriter()
						.println("<h2 style='color:red;text-align:center;margin-top:100px;'>" + "Email Not Registered!"
								+ "<br><br>" + "<a href='tenantForgotPassword.jsp'>Try Again</a>" + "</h2>");
			}

		} catch (Exception e) {
			e.printStackTrace();
			resp.getWriter().println("<h2>Error : " + e.getMessage() + "</h2>");
		} finally {
			try {
				if (rs != null)
					rs.close();
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