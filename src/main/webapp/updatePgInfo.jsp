<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {

	Class.forName("com.mysql.cj.jdbc.Driver");

	con = com.pgmanagement.util.DBUtil.getConnection();

	pstmt = con.prepareStatement("select * from pg_info where id=1");

	rs = pstmt.executeQuery();

} catch (Exception e) {

	e.printStackTrace();

}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update PG Information</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Segoe UI, sans-serif;
}

body {
	background: #f4f7fc;
}

.header {
	background: #1e3a8a;
	color: white;
	text-align: center;
	padding: 25px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.container {
	width: 60%;
	margin: 40px auto;
	background: white;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.container h2 {
	text-align: center;
	color: #1e3a8a;
	margin-bottom: 30px;
}

table {
	width: 100%;
}

td {
	padding: 12px;
}

input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
}

.btn {
	text-align: center;
	margin-top: 20px;
}

.btn input {
	width: 200px;
	background: #1e3a8a;
	color: white;
	border: none;
	cursor: pointer;
	font-size: 16px;
}

.btn input:hover {
	background: #163172;
}

.back {
	text-align: center;
	margin-top: 20px;
}

.back a {
	text-decoration: none;
	color: #1e3a8a;
	font-weight: bold;
}
</style>

</head>

<body>

	<div class="header">

		<h1>SMART PG MANAGEMENT SYSTEM</h1>

		<p>Update PG Information</p>

	</div>

	<div class="container">

		<h2>⚙️ Update PG Details</h2>

		<%
		if (rs.next()) {
		%>

		<form action="update-pg-info" method="post">

			<table>

				<tr>

					<td>PG Name</td>

					<td><input type="text" name="pgName"
						value="<%=rs.getString("pg_name")%>"></td>

				</tr>

				<tr>

					<td>Owner Name</td>

					<td><input type="text" name="ownerName"
						value="<%=rs.getString("owner_name")%>"></td>

				</tr>

				<tr>

					<td>Phone</td>

					<td><input type="text" name="phone"
						value="<%=rs.getString("phone")%>"></td>

				</tr>

				<tr>

					<td>Email</td>

					<td><input type="email" name="email"
						value="<%=rs.getString("email")%>"></td>

				</tr>

				<tr>

					<td>Address</td>

					<td><input type="text" name="address"
						value="<%=rs.getString("address")%>"></td>

				</tr>

				<tr>

					<td>WiFi</td>

					<td><input type="text" name="wifi"
						value="<%=rs.getString("wifi")%>"></td>

				</tr>

				<tr>

					<td>CCTV</td>

					<td><input type="text" name="cctv"
						value="<%=rs.getString("cctv")%>"></td>

				</tr>

				<tr>

					<td>Parking</td>

					<td><input type="text" name="parking"
						value="<%=rs.getString("parking")%>"></td>

				</tr>

				<tr>

					<td>Laundry</td>

					<td><input type="text" name="laundry"
						value="<%=rs.getString("laundry")%>"></td>

				</tr>

				<tr>

					<td>Hot Water</td>

					<td><input type="text" name="hotWater"
						value="<%=rs.getString("hot_water")%>"></td>

				</tr>

				<tr>

					<td>Visitor Time</td>

					<td><input type="text" name="visitorTime"
						value="<%=rs.getString("visitor_time")%>"></td>

				</tr>

				<tr>

					<td>Rent Due Date</td>

					<td><input type="text" name="rentDueDate"
						value="<%=rs.getString("rent_due_date")%>"></td>

				</tr>
				<tr>

					<td>Google Map Link</td>

					<td><input type="text" name="googleMapLink"
						value="<%=rs.getString("google_map_link")%>"></td>

				</tr>

			</table>

			<div class="btn">

				<input type="submit" value="Update PG Information">

			</div>

		</form>

		<%
		}
		%>

		<div class="back">
			<a href="dashboard"> ← Back To Dashboard </a>

		</div>

	</div>

</body>
</html>