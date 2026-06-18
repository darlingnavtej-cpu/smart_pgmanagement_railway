package com.pgmanagement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ActivityLogger {

	public static void log(String text) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName("com.mysql.cj.jdbc.Driver");

			con = com.pgmanagement.util.DBUtil.getConnection();

			pstmt = con.prepareStatement(

					"INSERT INTO activity "

							+

							"(activity_text,activity_time) "

							+

							"VALUES(?,NOW())"

			);

			pstmt.setString(

					1,

					text

			);

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