<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Fee Details</title>

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
	padding: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

.container {
	width: 600px;
	margin: 40px auto;
	background: white;
	padding: 30px;
	border-radius: 15px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.container h2 {
	text-align: center;
	color: #1e3a8a;
	margin-bottom: 25px;
}

.form-group {
	margin-bottom: 18px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

input, select {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.btn {
	width: 100%;
	padding: 12px;
	border: none;
	background: #1e3a8a;
	color: white;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

.btn:hover {
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
	</div>

	<%
	ResultSet rs = (ResultSet) request.getAttribute("resultSet");

	rs.next();
	%>

	<div class="container">

		<h2>Update Fee Details</h2>

		<form action="update-fee" method="post">

			<div class="form-group">
				<label>Fee ID</label> <input type="number" name="feeId"
					value="<%=rs.getInt(1)%>" readonly>
			</div>

			<div class="form-group">
				<label>Tenant ID</label> <input type="number" name="tenantId"
					value="<%=rs.getInt(2)%>" required>
			</div>

			<div class="form-group">
				<label>Month Name</label> <select name="monthName">

					<option <%=rs.getString(3).equals("January") ? "selected" : ""%>>January</option>
					<option <%=rs.getString(3).equals("February") ? "selected" : ""%>>February</option>
					<option <%=rs.getString(3).equals("March") ? "selected" : ""%>>March</option>
					<option <%=rs.getString(3).equals("April") ? "selected" : ""%>>April</option>
					<option <%=rs.getString(3).equals("May") ? "selected" : ""%>>May</option>
					<option <%=rs.getString(3).equals("June") ? "selected" : ""%>>June</option>
					<option <%=rs.getString(3).equals("July") ? "selected" : ""%>>July</option>
					<option <%=rs.getString(3).equals("August") ? "selected" : ""%>>August</option>
					<option <%=rs.getString(3).equals("September") ? "selected" : ""%>>September</option>
					<option <%=rs.getString(3).equals("October") ? "selected" : ""%>>October</option>
					<option <%=rs.getString(3).equals("November") ? "selected" : ""%>>November</option>
					<option <%=rs.getString(3).equals("December") ? "selected" : ""%>>December</option>

				</select>

			</div>

			<div class="form-group">
				<label>Amount</label> <input type="number" name="amount"
					value="<%=rs.getDouble(4)%>" required>
			</div>

			<div class="form-group">
				<label>Paid Date</label> <input type="date" name="paidDate"
					value="<%=rs.getString(5)%>" required>
			</div>

			<div class="form-group">
				<label>Status</label> <select name="status">

					<option value="Paid"
						<%=rs.getString(6).equals("Paid") ? "selected" : ""%>>Paid</option>

					<option value="Pending"
						<%=rs.getString(6).equals("Pending") ? "selected" : ""%>>
						Pending</option>

				</select>

			</div>

			<input type="submit" value="Update Fee" class="btn">

		</form>

		<div class="back">
			<a href="fetch-fees"> ← Back To Fee Records </a>
		</div>

	</div>

</body>
</html>