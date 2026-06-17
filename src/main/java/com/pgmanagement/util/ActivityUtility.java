package com.pgmanagement.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ActivityUtility {

	public static void addActivity(String activityText) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = DriverManager.getConnection(

					"jdbc:mysql://localhost:3306/smart_pg",

					"root",

					"admin");

			pstmt = con.prepareStatement(

					"INSERT INTO activity"

							+ "(activity_text,activity_time)"

							+ "VALUES(?,NOW())");

			pstmt.setString(1, activityText);

			pstmt.executeUpdate();

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

			}

			catch (Exception e) {

				e.printStackTrace();

			}

		}

	}

}