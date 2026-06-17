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
<title>Salary History</title>

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

/* Header */
.header {
	background: linear-gradient(135deg, #1e3a8a, #2563eb);
	color: white;
	padding: 25px;
	text-align: center;
	box-shadow: 0 3px 12px rgba(0, 0, 0, .2);
}

.header h1 {
	font-size: 34px;
}

.header p {
	margin-top: 8px;
}

/* Container */
.container {
	width: 95%;
	margin: 30px auto;
}

/* Top Bar */
.top-bar {
	display: flex;
	justify-content: space-between;
	margin-bottom: 20px;
}

.top-bar a {
	text-decoration: none;
	background: #1e3a8a;
	color: white;
	padding: 12px 20px;
	border-radius: 8px;
	font-weight: bold;
}

.top-bar a:hover {
	background: #163172;
}

/* Table */
table {
	width: 100%;
	background: white;
	border-collapse: collapse;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .08);
	border-radius: 12px;
	overflow: hidden;
}

th {
	background: #1e3a8a;
	color: white;
	padding: 14px;
}

td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

tr:hover {
	background: #eef3ff;
}

.paid {
	color: green;
	font-weight: bold;
}

/* Footer */
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

			<i class="fa-solid fa-sack-dollar"></i> Salary History

		</h1>

		<p>Monthly Employee Salary Payments</p>

	</div>

	<div class="container">

		<div class="top-bar">

			<a href="dashboard"> 🏠 Dashboard </a> <a href="fetch-salary-history">

				🔄 Refresh </a>

		</div>
		<div
			style="margin-bottom: 20px; background: white; padding: 15px; border-radius: 10px; box-shadow: 0 3px 10px rgba(0, 0, 0, .08);">

			<form action="fetch-salary-by-month" method="get">

				<label style="font-weight: bold; margin-right: 10px;">

					Select Month : </label> <select name="monthName"
					style="padding: 8px; border-radius: 5px;">

					<option>January</option>
					<option>February</option>
					<option>March</option>
					<option>April</option>
					<option>May</option>
					<option>June</option>
					<option>July</option>
					<option>August</option>
					<option>September</option>
					<option>October</option>
					<option>November</option>
					<option>December</option>

				</select>

				<button
					style="padding: 8px 15px; background: #1e3a8a; color: white; border: none; border-radius: 5px; cursor: pointer; margin-left: 10px;">

					Search</button>

			</form>

		</div>

		<%
		String selectedMonth = (String) request.getAttribute("selectedMonth");

		if (selectedMonth != null) {
		%>

		<h2 style="text-align: center; margin-bottom: 20px; color: #1e3a8a;">

			Salary History for

			<%=selectedMonth%>

		</h2>

		<%
		}
		%>
		<table>

			<tr>

				<th>Salary ID</th>

				<th>Employee ID</th>

				<th>Employee Name</th>

				<th>Role</th>

				<th>Month</th>

				<th>Salary</th>

				<th>Paid Date</th>

				<th>Status</th>

			</tr>

			<%
			if (rs != null) {

				while (rs.next()) {
			%>

			<tr>

				<td><%=rs.getInt("salary_id")%></td>

				<td><%=rs.getInt("employee_id")%></td>

				<td><%=rs.getString("employee_name")%></td>

				<td><%=rs.getString("role")%></td>

				<td><%=rs.getString("month_name")%></td>

				<td>₹ <%=rs.getInt("salary_amount")%>

				</td>

				<td><%=rs.getString("paid_date")%></td>

				<td class="paid"><i class="fa-solid fa-circle-check"></i> <%=rs.getString("status")%></td>

			</tr>

			<%
			}

			}
			%>

		</table>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>