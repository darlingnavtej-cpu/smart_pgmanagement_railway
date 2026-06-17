<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("visitorResultSet");
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Visitor Management</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #4f46e5;
	--primary-dark: #1e3a8a;
	--success: #16a34a;
	--danger: #dc2626;
	--warning: #f59e0b;
	--bg: #f8fafc;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Segoe UI, sans-serif;
}

body {
	background: var(--bg);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

/* HEADER */
.header {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 20px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, .15);
}

.header-inner {
	max-width: 1200px;
	margin: auto;
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
}

.logo {
	display: flex;
	align-items: center;
	gap: 12px;
}

.logo-icon {
	width: 50px;
	height: 50px;
	border-radius: 15px;
	background: white;
	color: #1e3a8a;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 22px;
}

.logo-text h1 {
	font-size: 24px;
}

.logo-text p {
	font-size: 13px;
	opacity: .9;
}

.back-btn {
	text-decoration: none;
	color: white;
	padding: 10px 18px;
	border-radius: 10px;
	background: rgba(255, 255, 255, .15);
	transition: .3s;
}

.back-btn:hover {
	background: rgba(255, 255, 255, .25);
}

/* CONTAINER */
.container {
	width: min(98%, 1400px);
	margin: 30px auto;
}

/* CARD */
.table-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	animation: fadeIn .6s ease;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* TITLE */
.page-title {
	text-align: center;
	margin-bottom: 25px;
}

.page-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 8px;
}

.page-title p {
	color: #64748b;
}

/* ACTION BAR */
.action-bar {
	display: flex;
	justify-content: center;
	gap: 15px;
	flex-wrap: wrap;
	margin-bottom: 25px;
}

.action-btn {
	text-decoration: none;
	color: white;
	padding: 12px 18px;
	border-radius: 12px;
	font-weight: 600;
	background: linear-gradient(135deg, #4f46e5, #6366f1);
	transition: .3s;
}

.action-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

/* TABLE */
.table-wrapper {
	width: 100%;
	overflow-x: auto;
	border-radius: 15px;
}

table {
	width: 100%;
	min-width: 1300px;
	border-collapse: collapse;
}

th {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 14px;
	white-space: nowrap;
}

td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
	white-space: nowrap;
}

tr:hover {
	background: #f8faff;
}

/* STATUS */
.in-badge {
	background: #dcfce7;
	color: #15803d;
	padding: 6px 12px;
	border-radius: 20px;
	font-weight: 600;
}

.out-badge {
	background: #fee2e2;
	color: #b91c1c;
	padding: 6px 12px;
	border-radius: 20px;
	font-weight: 600;
}

/* BUTTON */
.checkout-btn {
	text-decoration: none;
	background: #f59e0b;
	color: white;
	padding: 8px 14px;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	display: inline-block;
	transition: .3s;
}

.checkout-btn:hover {
	background: #d97706;
}

.completed {
	color: #16a34a;
	font-weight: 600;
}

/* EMPTY */
.no-data {
	padding: 25px;
	font-weight: 600;
	color: #64748b;
}

/* FOOTER */
.footer {
	margin-top: auto;
	text-align: center;
	padding: 20px;
	color: #64748b;
}

/* TABLET */
@media ( max-width :768px) {
	.header-inner {
		flex-direction: column;
		gap: 15px;
		text-align: center;
	}
	.logo-text h1 {
		font-size: 20px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.table-card {
		padding: 15px;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
	}
	.logo-icon {
		width: 42px;
		height: 42px;
		font-size: 18px;
	}
	.logo-text h1 {
		font-size: 18px;
	}
	.page-title h2 {
		font-size: 22px;
	}
	.action-btn {
		width: 100%;
		text-align: center;
	}
}
</style>

</head>

<body>

	<header class="header">

		```
		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-users"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Visitor Management</p>
				</div>

			</div>

			<a href="dashboard" class="back-btn"> <i
				class="fa-solid fa-arrow-left"></i> Dashboard

			</a>

		</div>


	</header>

	<div class="container">


		<div class="table-card">

			<div class="page-title">

				<h2>

					<i class="fa-solid fa-user-group"></i> Visitor Records

				</h2>

				<p>Track visitor entries and exits</p>

			</div>

			<div class="action-bar">

				<a href="addVisitor.jsp" class="action-btn"> <i
					class="fa-solid fa-user-plus"></i> Add Visitor

				</a> <a href="fetch-visitors" class="action-btn"> <i
					class="fa-solid fa-rotate-right"></i> Refresh

				</a>

			</div>

			<div class="table-wrapper">

				<table>

					<tr>

						<th>ID</th>
						<th>Visitor Name</th>
						<th>Phone</th>
						<th>Tenant</th>
						<th>Room</th>
						<th>Purpose</th>
						<th>Check In</th>
						<th>Check Out</th>
						<th>Status</th>
						<th>Action</th>

					</tr>

					<%
					boolean found = false;

					if (rs != null) {

						while (rs.next()) {

							found = true;
					%>

					<tr>

						<td><%=rs.getInt("visitor_id")%></td>

						<td><%=rs.getString("visitor_name")%></td>

						<td><%=rs.getString("phone")%></td>

						<td><%=rs.getString("tenant_name")%></td>

						<td><%=rs.getInt("room_no")%></td>

						<td><%=rs.getString("purpose")%></td>

						<td><%=rs.getTimestamp("checkin_time")%></td>

						<td>
							<%
							if (rs.getTimestamp("checkout_time") != null) {
							%> <%=rs.getTimestamp("checkout_time")%> <%
 } else {
 %> - <%
 }
 %>

						</td>

						<td>
							<%
							String status = rs.getString("status");

							if (status.equalsIgnoreCase("IN")) {
							%> <span class="in-badge"> IN </span> <%
 } else {
 %> <span class="out-badge"> OUT </span> <%
 }
 %>

						</td>

						<td>
							<%
							if (status.equalsIgnoreCase("IN")) {
							%> <a class="checkout-btn"
							href="checkout-visitor?id=<%=rs.getInt("visitor_id")%>"> <i
								class="fa-solid fa-right-from-bracket"></i> Check Out

						</a> <%
 } else {
 %> <span class="completed"> ✓ Completed </span> <%
 }
 %>

						</td>

					</tr>

					<%
					}
					}

					if (!found) {
					%>

					<tr>

						<td colspan="10" class="no-data"><i
							class="fa-solid fa-circle-info"></i> No Visitor Records Found</td>

					</tr>

					<%
					}
					%>

				</table>

			</div>

		</div>


	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>
