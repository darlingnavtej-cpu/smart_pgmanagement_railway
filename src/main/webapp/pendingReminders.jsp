<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("pendingList");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Pending Rent Reminders</title>

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
	--danger: #dc2626;
	--success: #16a34a;
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

/* CARD */
.panel {
	background: white;
	border-radius: 25px;
	padding: 25px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
}

.page-title {
	text-align: center;
	margin-bottom: 20px;
}

.page-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 6px;
}

.page-title p {
	color: var(--muted);
}

/* TABLE */
.table-wrapper {
	overflow-x: auto;
	border-radius: 15px;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 800px;
}

th {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 14px;
	text-align: center;
	white-space: nowrap;
}

td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
	white-space: nowrap;
}

tr:hover {
	background: #f8faff;
}

.pending {
	color: var(--danger);
	font-weight: 700;
}

.email {
	color: #334155;
}

/* EMPTY */
.empty {
	text-align: center;
	padding: 25px;
	color: var(--danger);
	font-weight: 600;
}

/* BUTTONS */
.button-section {
	display: flex;
	justify-content: center;
	gap: 15px;
	flex-wrap: wrap;
	margin-top: 25px;
}

.btn {
	text-decoration: none;
	padding: 12px 22px;
	border-radius: 12px;
	font-size: 15px;
	font-weight: 600;
	transition: .3s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.dashboard-btn-2 {
	background: #e2e8f0;
	color: #0f172a;
}

.dashboard-btn-2:hover {
	background: #cbd5e1;
	transform: translateY(-2px);
}

.send-btn {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
}

.send-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
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
		gap: 15px;
	}
	.logo {
		flex-direction: column;
	}
	.panel {
		padding: 18px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.button-section {
		flex-direction: column;
	}
	.btn {
		width: 100%;
		justify-content: center;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 20px auto;
	}
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
	.page-title h2 {
		font-size: 22px;
	}
	.page-title p {
		font-size: 13px;
	}
	table {
		min-width: 760px;
	}
	.panel {
		padding: 15px;
	}
}
</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-bell"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Pending Rent Reminder Center</p>
				</div>

			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>

	</header>

	<div class="container">

		<div class="panel">

			<div class="page-title">

				<h2>
					<i class="fa-solid fa-triangle-exclamation"></i> Pending Rent List
				</h2>

				<p>Tenants who still need to pay rent</p>

			</div>

			<div class="table-wrapper">

				<table>

					<tr>
						<th>Tenant ID</th>
						<th>Tenant Name</th>
						<th>Email</th>
						<th>Month</th>
						<th>Amount</th>
						<th>Status</th>
					</tr>

					<%
					boolean found = false;

					if (rs != null) {
						while (rs.next()) {
							found = true;
					%>

					<tr>

						<td><%=rs.getInt("tenant_id")%></td>

						<td><%=rs.getString("tenant_name")%></td>

						<td class="email"><%=rs.getString("email")%></td>

						<td><%=rs.getString("month_name")%></td>

						<td class="pending">₹ <%=rs.getInt("amount")%></td>

						<td class="pending"><%=rs.getString("status")%></td>

					</tr>

					<%
					}
					}

					if (!found) {
					%>

					<tr>
						<td colspan="6" class="empty">No Pending Rent Records Found</td>
					</tr>

					<%
					}
					%>

				</table>

			</div>

			<div class="button-section">

				<a href="dashboard" class="btn dashboard-btn-2"> <i
					class="fa-solid fa-arrow-left"></i> Dashboard
				</a> <a href="send-reminders" class="btn send-btn"> <i
					class="fa-solid fa-paper-plane"></i> Send All Reminder Emails
				</a>

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>