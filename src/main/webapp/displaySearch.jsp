<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet tenantRs = (ResultSet) request.getAttribute("tenantResult");
ResultSet roomRs = (ResultSet) request.getAttribute("roomResult");
ResultSet employeeRs = (ResultSet) request.getAttribute("employeeResult");
String keyword = (String) request.getAttribute("keyword");

if (keyword == null) {
	keyword = "";
}
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Global Search</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #1e3a8a;
	--secondary: #4f46e5;
	--bg: #f8fafc;
	--border: #e2e8f0;
	--text: #0f172a;
	--muted: #64748b;
	--success: #16a34a;
	--danger: #dc2626;
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
	color: var(--text);
}

/* HEADER */
.header {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 20px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, .15);
}

.header-inner {
	max-width: 1400px;
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
	background: white;
	color: #1e3a8a;
	border-radius: 15px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	flex: 0 0 auto;
}

.logo-text h1 {
	font-size: 24px;
	line-height: 1.2;
}

.logo-text p {
	font-size: 13px;
	opacity: .9;
	margin-top: 4px;
}

.dashboard-btn {
	text-decoration: none;
	color: white;
	padding: 10px 18px;
	border-radius: 10px;
	background: rgba(255, 255, 255, .15);
	transition: .3s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.dashboard-btn:hover {
	background: rgba(255, 255, 255, .25);
	transform: translateY(-1px);
}

/* CONTAINER */
.container {
	width: min(95%, 1400px);
	margin: 30px auto;
}

/* SECTION CARD */
.card {
	background: white;
	border-radius: 25px;
	padding: 25px;
	margin-bottom: 25px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
}

.card-title {
	display: flex;
	align-items: center;
	gap: 10px;
	color: #1e3a8a;
	margin-bottom: 16px;
	font-size: 24px;
}

.card-subtitle {
	color: var(--muted);
	margin-bottom: 18px;
}

/* SEARCH KEYWORD */
.keyword-box {
	background: #eef2ff;
	border: 1px solid #dbe4ff;
	padding: 16px;
	border-radius: 14px;
	text-align: center;
	color: #4338ca;
	font-size: 18px;
	font-weight: 600;
}

/* TABLE */
.table-wrapper {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 780px;
}

th {
	background: #1e3a8a;
	color: white;
	padding: 14px;
	text-align: center;
	font-size: 15px;
}

td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
	color: #334155;
}

tr:hover {
	background: #f8faff;
}

.empty-row {
	text-align: center;
	padding: 24px;
	color: #dc2626;
	font-weight: 600;
}

/* BADGES */
.badge {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 7px 12px;
	border-radius: 999px;
	font-size: 13px;
	font-weight: 600;
}

.badge-green {
	background: #dcfce7;
	color: #15803d;
}

.badge-blue {
	background: #dbeafe;
	color: #1d4ed8;
}

.badge-purple {
	background: #ede9fe;
	color: #6d28d9;
}

/* BACK */
.back {
	text-align: center;
	margin-top: 8px;
}

.back a {
	text-decoration: none;
	font-weight: 600;
	color: white;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	padding: 12px 24px;
	border-radius: 12px;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	box-shadow: 0 10px 25px rgba(79, 70, 229, .18);
	transition: .3s;
}

.back a:hover {
	transform: translateY(-2px);
}

/* FOOTER */
.footer {
	margin-top: auto;
	background: #1e3a8a;
	color: white;
	text-align: center;
	padding: 18px;
}

/* MOBILE */
@media ( max-width :768px) {
	.header-inner {
		flex-direction: column;
		text-align: center;
		gap: 14px;
	}
	.logo {
		flex-direction: column;
	}
	.card {
		padding: 18px;
	}
	.card-title {
		font-size: 20px;
	}
	.keyword-box {
		font-size: 16px;
	}
	table {
		min-width: 700px;
	}
}

@media ( max-width :480px) {
	.logo-icon {
		width: 42px;
		height: 42px;
		font-size: 18px;
	}
	.logo-text h1 {
		font-size: 18px;
	}
	.logo-text p {
		font-size: 12px;
	}
	.card-title {
		font-size: 18px;
	}
	.card-subtitle {
		font-size: 13px;
	}
	.keyword-box {
		font-size: 15px;
	}
	.back a {
		width: 100%;
		justify-content: center;
	}
}
</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-magnifying-glass"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Global Search Result</p>
				</div>

			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard

			</a>

		</div>

	</header>

	<div class="container">

		<div class="card">

			<div class="card-title">
				<i class="fa-solid fa-search"></i> Search Summary
			</div>

			<div class="keyword-box">
				Search Keyword :
				<%=keyword%>
			</div>

		</div>

		<div class="card">

			<div class="card-title">
				<i class="fa-solid fa-users"></i> Tenant Details
			</div>

			<div class="card-subtitle">Tenant matching records for the
				searched keyword.</div>

			<div class="table-wrapper">
				<table>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Age</th>
						<th>Phone</th>
						<th>Room</th>
						<th>Email</th>
					</tr>

					<%
					boolean tenantFound = false;

					if (tenantRs != null) {
						while (tenantRs.next()) {
							tenantFound = true;
					%>

					<tr>
						<td><%=tenantRs.getInt("tenant_id")%></td>
						<td><%=tenantRs.getString("tenant_name")%></td>
						<td><%=tenantRs.getInt("age")%></td>
						<td><%=tenantRs.getString("phone")%></td>
						<td><%=tenantRs.getInt("room_no")%></td>
						<td><%=tenantRs.getString("email")%></td>
					</tr>

					<%
					}
					}

					if (!tenantFound) {
					%>

					<tr>
						<td colspan="6" class="empty-row">No Tenant Records Found</td>
					</tr>

					<%
					}
					%>

				</table>
			</div>

		</div>

		<div class="card">

			<div class="card-title">
				<i class="fa-solid fa-building"></i> Room Details
			</div>

			<div class="card-subtitle">Room matching records for the
				searched keyword.</div>

			<div class="table-wrapper">
				<table>
					<tr>
						<th>Room No</th>
						<th>Capacity</th>
						<th>Occupied</th>
						<th>Status</th>
						<th>Rent</th>
					</tr>

					<%
					boolean roomFound = false;

					if (roomRs != null) {
						while (roomRs.next()) {
							roomFound = true;
					%>

					<tr>
						<td><%=roomRs.getInt("room_no")%></td>
						<td><%=roomRs.getInt("capacity")%></td>
						<td><%=roomRs.getInt("occupied")%></td>
						<td><%=roomRs.getString("status")%></td>
						<td>₹ <%=roomRs.getInt("rent")%></td>
					</tr>

					<%
					}
					}

					if (!roomFound) {
					%>

					<tr>
						<td colspan="5" class="empty-row">No Room Records Found</td>
					</tr>

					<%
					}
					%>

				</table>
			</div>

		</div>

		<div class="card">

			<div class="card-title">
				<i class="fa-solid fa-user-tie"></i> Employee Details
			</div>

			<div class="card-subtitle">Employee matching records for the
				searched keyword.</div>

			<div class="table-wrapper">
				<table>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Role</th>
						<th>Phone</th>
						<th>Salary</th>
						<th>Status</th>
					</tr>

					<%
					boolean employeeFound = false;

					if (employeeRs != null) {
						while (employeeRs.next()) {
							employeeFound = true;
					%>

					<tr>
						<td><%=employeeRs.getInt("employee_id")%></td>
						<td><%=employeeRs.getString("employee_name")%></td>
						<td><%=employeeRs.getString("role")%></td>
						<td><%=employeeRs.getString("phone")%></td>
						<td>₹ <%=employeeRs.getInt("salary")%></td>
						<td><%=employeeRs.getString("status")%></td>
					</tr>

					<%
					}
					}

					if (!employeeFound) {
					%>

					<tr>
						<td colspan="6" class="empty-row">No Employee Records Found</td>
					</tr>

					<%
					}
					%>

				</table>
			</div>

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