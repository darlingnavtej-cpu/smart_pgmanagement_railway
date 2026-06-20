
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("menuList");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tenant Weekly Food Menu</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #1e3a8a;
	--secondary: #4f46e5;
	--bg: #f8fafc;
	--card: #ffffff;
	--text: #0f172a;
	--muted: #64748b;
	--border: #e2e8f0;
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
	gap: 15px;
}

.logo {
	display: flex;
	align-items: center;
	gap: 12px;
}

.logo-icon {
	width: 55px;
	height: 55px;
	border-radius: 15px;
	background: white;
	color: #1e3a8a;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
}

.logo-text h1 {
	font-size: 24px;
}

.logo-text p {
	font-size: 13px;
	opacity: .9;
}

.dashboard-btn {
	text-decoration: none;
	color: white;
	padding: 10px 18px;
	border-radius: 10px;
	background: rgba(255, 255, 255, .15);
	transition: .3s;
}

.dashboard-btn:hover {
	background: rgba(255, 255, 255, .25);
}

/* CONTAINER */
.container {
	width: min(98%, 1400px);
	margin: 35px auto;
}

.card {
	background: white;
	padding: 30px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
}

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

/* TABLE */
.table-wrapper {
	overflow-x: auto;
	border-radius: 15px;
}

table {
	width: 100%;
	min-width: 900px;
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
}

tr:hover {
	background: #f8faff;
}

.day {
	font-weight: 700;
	color: #1e3a8a;
}

/* EMPTY DATA */
.no-data {
	text-align: center;
	padding: 20px;
	color: #dc2626;
	font-weight: 600;
}

/* INFO BOX */
.info-box {
	margin-top: 20px;
	padding: 18px;
	border-radius: 15px;
	background: #eef2ff;
	color: #4338ca;
	text-align: center;
	line-height: 1.6;
}

/* FOOTER */
.footer {
	margin-top: auto;
	background: #1e3a8a;
	color: white;
	text-align: center;
	padding: 18px;
}

/* TABLET */
@media ( max-width :768px) {
	.header-inner {
		flex-direction: column;
		text-align: center;
	}
	.logo {
		flex-direction: column;
	}
	.card {
		padding: 20px;
	}
	.page-title h2 {
		font-size: 24px;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 20px auto;
	}
	.card {
		padding: 18px;
		border-radius: 18px;
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
}
</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-utensils"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant Weekly Food Menu</p>
				</div>

			</div>

			<a href="tenant-dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard

			</a>

		</div>

	</header>

	<div class="container">

		<div class="card">

			<div class="page-title">

				<h2>
					<i class="fa-solid fa-calendar-week"></i> Weekly Food Schedule
				</h2>

				<p>View the complete weekly food menu provided by PG Management
				</p>

			</div>

			<div class="table-wrapper">

				<table>

					<tr>

						<th>ID</th>
						<th>Day</th>
						<th>Breakfast</th>
						<th>Lunch</th>
						<th>Snacks</th>
						<th>Dinner</th>

					</tr>

					<%
					boolean found = false;

					while (rs != null && rs.next()) {

						found = true;
					%>

					<tr>

						<td><%=rs.getInt("menu_id")%></td>

						<td class="day"><%=rs.getString("day_name")%></td>

						<td><%=rs.getString("breakfast")%></td>

						<td><%=rs.getString("lunch")%></td>

						<td><%=rs.getString("snacks")%></td>

						<td><%=rs.getString("dinner")%></td>

					</tr>

					<%
					}

					if (!found) {
					%>

					<tr>

						<td colspan="6" class="no-data">No Weekly Menu Available</td>

					</tr>

					<%
					}
					%>

				</table>

			</div>

			<div class="info-box">

				<i class="fa-solid fa-circle-info"></i> <br> The menu may be
				updated by the PG management based on availability and special
				occasions.

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>

