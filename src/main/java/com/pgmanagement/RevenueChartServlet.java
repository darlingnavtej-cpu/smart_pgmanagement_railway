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

@WebServlet("/revenue-chart")
public class RevenueChartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		java.util.ArrayList<String> monthList = new java.util.ArrayList<String>();

		java.util.ArrayList<Integer> revenueList = new java.util.ArrayList<Integer>();

		try {

			// Load Driver

			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect to fee database

			con = com.pgmanagement.util.DBUtil.getConnection();

			// Fetch Monthly Revenue

			pstmt = con.prepareStatement(

					"SELECT "

							+

							"month_name, "

							+

							"SUM(amount) AS total_revenue "

							+

							"FROM fee "

							+

							"WHERE status='Paid' "

							+

							"GROUP BY month_name "

							+

							"ORDER BY "

							+

							"FIELD(month_name,"

							+

							"'January',"

							+

							"'February',"

							+

							"'March',"

							+

							"'April',"

							+

							"'May',"

							+

							"'June',"

							+

							"'July',"

							+

							"'August',"

							+

							"'September',"

							+

							"'October',"

							+

							"'November',"

							+

							"'December'"

							+

							")"

			);

			rs = pstmt.executeQuery();

			String bestMonth = "";

			int highestRevenue = 0;

			int totalRevenue = 0;

			while (rs.next()) {

				String month = rs.getString("month_name");

				int revenue = rs.getInt("total_revenue");

				monthList.add(month);

				revenueList.add(revenue);

				totalRevenue += revenue;

				if (revenue > highestRevenue) {

					highestRevenue = revenue;

					bestMonth = month;

				}

			}

			int averageRevenue = 0;

			if (revenueList.size() > 0) {

				averageRevenue = totalRevenue / revenueList.size();

			}

			req.setAttribute(

					"bestMonth",

					bestMonth

			);

			req.setAttribute(

					"highestRevenue",

					highestRevenue

			);

			req.setAttribute(

					"averageRevenue",

					averageRevenue

			);

			req.setAttribute(

					"monthList",

					monthList

			);

			req.setAttribute(

					"revenueList",

					revenueList

			);
			// Forward

			RequestDispatcher rd =

					req.getRequestDispatcher(

							"revenueChart.jsp"

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

		finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			}

			catch (Exception e) {

				e.printStackTrace();

			}

		}

	}

}