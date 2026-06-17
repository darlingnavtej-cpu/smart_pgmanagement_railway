<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("paymentResultSet");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Details</title>

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
	text-align: center;
	padding: 25px;
	box-shadow: 0 3px 10px rgba(0, 0, 0, .2);
}

.header h1 {
	font-size: 35px;
}

.header p {
	margin-top: 8px;
	font-size: 16px;
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
	transition: .3s;
}

.top-bar a:hover {
	background: #163172;
}

/* Table */
table {
	width: 100%;
	border-collapse: collapse;
	background: white;
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

/* QR */
.qr {
	color: #1e3a8a;
	font-weight: bold;
}

/* Button */
.edit {
	background: #28a745;
	color: white;
	padding: 8px 12px;
	border-radius: 6px;
	text-decoration: none;
	font-size: 14px;
}

.edit:hover {
	background: #1f7d34;
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

		<h1>💳 Payment Settings</h1>

		<p>Manage Bank, UPI and QR Details</p>

	</div>

	<div class="container">

		<div class="top-bar">

			<a href="addPaymentDetails.jsp"> ➕ Add Payment Details </a> <a
				href="dashboard"> 🏠 Dashboard </a>

		</div>

		<table>

			<tr>

				<th>ID</th>

				<th>Owner Name</th>

				<th>Bank Name</th>

				<th>Account Number</th>

				<th>IFSC Code</th>

				<th>UPI ID</th>

				<th>QR Image</th>

				<th>Created On</th>

				<th>Action</th>

			</tr>

			<%
			if (rs != null) {

				while (rs.next()) {
			%>

			<tr>

				<td><%=rs.getInt("payment_id")%></td>

				<td><%=rs.getString("owner_name")%></td>

				<td><%=rs.getString("bank_name")%></td>

				<td><%=rs.getString("account_number")%></td>

				<td><%=rs.getString("ifsc_code")%></td>

				<td><%=rs.getString("upi_id")%></td>

				<td><img src="images/<%=rs.getString("qr_image")%>" width="120"
					height="120"
					style="border: 2px solid #1e3a8a; border-radius: 10px;"></td>

				<td><%=rs.getTimestamp("created_on")%></td>

				<td><a class="edit"
					href="edit-payment-details?id=<%=rs.getInt("payment_id")%>">

						Edit </a></td>

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