<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("resultSet");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reminder History</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

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
	padding: 30px;
	box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
}

.header h1 {
	font-size: 36px;
}

.header p {
	margin-top: 8px;
	font-size: 17px;
}

.container {
	width: 90%;
	margin: 35px auto;
}

.table-box {
	background: white;
	padding: 25px;
	border-radius: 15px;
	box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
}

.table-box h2 {
	text-align: center;
	color: #1e3a8a;
	margin-bottom: 25px;
}

table {
	width: 100%;
	border-collapse: collapse;
}

table th {
	background: #1e3a8a;
	color: white;
	padding: 14px;
}

table td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

table tr:hover {
	background: #eef3ff;
}

.back {
	text-align: center;
	margin-top: 30px;
}

.back a {
	text-decoration: none;
	background: #1e3a8a;
	color: white;
	padding: 12px 25px;
	border-radius: 8px;
	font-size: 17px;
}

.back a:hover {
	background: #163172;
}

.footer {
	margin-top: 50px;
	background: #1e3a8a;
	color: white;
	text-align: center;
	padding: 18px;
}
</style>

</head>

<body>

	<div class="header">

		<h1>

			<i class="fa-solid fa-envelope-circle-check"></i> Reminder History

		</h1>

		<p>Smart PG Management System</p>

	</div>

	<div class="container">

		<div class="table-box">

			<h2>📜 Reminder Activity Log</h2>

			<table>

				<tr>

					<th>Reminder ID</th>

					<th>Month</th>

					<th>Emails Sent</th>

					<th>Sent On</th>

				</tr>

				<%
				if (rs != null) {

					boolean found = false;

					while (rs.next()) {

						found = true;
				%>

				<tr>

					<td><%=rs.getInt("reminder_id")%></td>

					<td><%=rs.getString("month_name")%></td>

					<td><%=rs.getInt("total_sent")%></td>

					<td><%=rs.getString("sent_on")%></td>

				</tr>

				<%
				}

				if (!found) {
				%>

				<tr>

					<td colspan="4" style="color: red; font-weight: bold;">No
						Reminder History Available</td>

				</tr>

				<%
				}

				}
				%>

			</table>

		</div>

		<div class="back">

			<a href="dashboard"> <i class="fa-solid fa-arrow-left"></i> Back
				To Dashboard

			</a>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>