<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("resultSet");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Checkout History</title>

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
	justify-content: space-between;
	align-items: center;
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

/* TOP BAR */
.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 15px;
	flex-wrap: wrap;
	margin-bottom: 20px;
}

.page-title {
	margin-right: auto;
}

.page-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 6px;
}

.page-title p {
	color: var(--muted);
}

.action-btn {
	text-decoration: none;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 12px 18px;
	border-radius: 12px;
	font-weight: 600;
	transition: .3s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.action-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

/* CARD */
.table-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
}

.table-wrapper {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 900px;
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

.refund {
	color: var(--success);
	font-weight: 700;
}

/* EMPTY */
.no-data {
	text-align: center;
	padding: 25px;
	color: #dc2626;
	font-weight: 600;
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
	.page-title {
		margin-right: 0;
		text-align: center;
		width: 100%;
	}
	.top-bar {
		flex-direction: column;
		align-items: stretch;
	}
	.action-btn {
		justify-content: center;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.table-card {
		padding: 18px;
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
	.page-title h2 {
		font-size: 22px;
	}
	table {
		min-width: 800px;
	}
}
</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-right-from-bracket"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Checkout History</p>
				</div>

			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>

	</header>

	<div class="container">

		<div class="top-bar">

			<div class="page-title">
				<h2>
					<i class="fa-solid fa-clock-rotate-left"></i> Checkout History
				</h2>
				<p>List of all checked out tenants</p>
			</div>

			<a href="fetch-checkout-history" class="action-btn"> <i
				class="fa-solid fa-rotate-right"></i> Refresh
			</a>

		</div>

		<div class="table-card">

			<div class="table-wrapper">

				<table>

					<tr>
						<th>Checkout ID</th>
						<th>Tenant ID</th>
						<th>Tenant Name</th>
						<th>Room No</th>
						<th>Exit Date</th>
						<th>Refund Amount</th>
						<th>Reason</th>
					</tr>

					<%
					boolean found = false;

					if (rs != null) {
						while (rs.next()) {
							found = true;
					%>

					<tr>

						<td><%=rs.getInt("checkout_id")%></td>

						<td><%=rs.getInt("tenant_id")%></td>

						<td><%=rs.getString("tenant_name")%></td>

						<td><%=rs.getInt("room_no")%></td>

						<td><%=rs.getString("exit_date")%></td>

						<td class="refund">₹ <%=rs.getInt("refund_amount")%></td>

						<td><%=rs.getString("reason")%></td>

					</tr>

					<%
					}
					}

					if (!found) {
					%>

					<tr>
						<td colspan="7" class="no-data">No Checkout History Found</td>
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