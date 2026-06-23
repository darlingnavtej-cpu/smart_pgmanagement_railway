<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("resultSet");

int totalPendingTenants = 0;
int totalPendingAmount = 0;
String selectedMonth = (String) request.getAttribute("selectedMonth");
if (selectedMonth == null || selectedMonth.trim().isEmpty()) {
	selectedMonth = java.time.LocalDate.now().getMonth().getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH);
}
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Pending Rent Tenants</title>

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

.back-btn {
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

.back-btn:hover {
	background: rgba(255, 255, 255, .25);
	transform: translateY(-1px);
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
	border: 1px solid rgba(226, 232, 240, .8);
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
	color: var(--muted);
}

/* ACTION BAR */
.action-bar {
	display: flex;
	justify-content: center;
	align-items: center;
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
	transition: .3s;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
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
	white-space: nowrap;
}

tr:hover {
	background: #f8faff;
}

.amount {
	color: var(--danger);
	font-weight: 700;
}

/* SUMMARY */
.summary {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
	gap: 20px;
	margin-top: 25px;
}

.card {
	background: white;
	padding: 25px;
	border-radius: 20px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	text-align: center;
	border: 1px solid rgba(226, 232, 240, .8);
	transition: .3s;
}

.card:hover {
	transform: translateY(-4px);
}

.card i {
	font-size: 42px;
	color: #1e3a8a;
	margin-bottom: 15px;
}

.card h3 {
	color: #334155;
	margin-bottom: 10px;
	font-size: 18px;
}

.card p {
	font-size: 30px;
	font-weight: 700;
	color: #1e3a8a;
}

/* EMPTY */
.no-data {
	padding: 25px;
	font-weight: 600;
	color: var(--danger);
	text-align: center;
}

/* FOOTER */
.footer {
	margin-top: auto;
	text-align: center;
	padding: 20px;
	color: var(--muted);
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
	.logo-text h1 {
		font-size: 20px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.table-card {
		padding: 18px;
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
	.logo-text p {
		font-size: 12px;
	}
	.page-title h2 {
		font-size: 22px;
	}
	.card {
		padding: 18px;
	}
	.card p {
		font-size: 24px;
	}
}

/* PRINT BUTTON */
.print-btn {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	border: none;
	padding: 12px 18px;
	border-radius: 12px;
	font-weight: 600;
	cursor: pointer;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: all 0.3s ease;
	box-shadow: 0 4px 10px rgba(79, 70, 229, 0.2);
}

.print-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 15px rgba(79, 70, 229, 0.3);
}

.print-btn:active {
	transform: translateY(0);
}

/* PRINT ONLY ELEMENT */
.print-only {
	display: none;
}

@media print {
	@page {
		size: auto;
		margin: 15mm 15mm 15mm 15mm;
	}
	body {
		background: white !important;
		color: black !important;
		font-size: 12pt;
	}
	.header, .back-btn, .footer, .action-bar, .no-print,
	.update-btn, .delete-btn, .checkout-btn, .view-btn, .receipt-btn {
		display: none !important;
	}
	.container {
		width: 100% !important;
		margin: 0 !important;
		padding: 0 !important;
	}
	.table-card {
		box-shadow: none !important;
		border: none !important;
		padding: 0 !important;
		margin: 0 !important;
	}
	.table-wrapper {
		overflow: visible !important;
	}
	table {
		width: 100% !important;
		min-width: unset !important;
		border-collapse: collapse !important;
		page-break-inside: auto;
	}
	tr {
		page-break-inside: avoid;
		page-break-after: auto;
	}
	thead {
		display: table-header-group;
	}
	tr:nth-child(even) {
		background-color: #f9f9f9 !important;
		-webkit-print-color-adjust: exact;
		print-color-adjust: exact;
	}
	th, td {
		border: 1px solid #ccc !important;
		padding: 8px !important;
		text-align: center !important;
		font-size: 10pt !important;
		white-space: normal !important;
	}
	th {
		background-color: #eaeaea !important;
		color: #000 !important;
		font-weight: bold !important;
		-webkit-print-color-adjust: exact;
		print-color-adjust: exact;
	}
	.page-title h2 {
		color: #000 !important;
		font-size: 20pt !important;
		margin-bottom: 5px !important;
	}
	.page-title p {
		color: #555 !important;
		font-size: 11pt !important;
	}
	.print-only {
		display: block !important;
		text-align: center;
		margin-bottom: 20px;
		font-size: 16px;
		color: #333;
	}
	/* Summary cards in pendingRentTenants.jsp */
	.summary {
		display: flex !important;
		flex-direction: row !important;
		justify-content: space-around !important;
		margin-top: 30px !important;
		page-break-inside: avoid;
	}
	.card {
		flex: 1 !important;
		border: 1px solid #ccc !important;
		box-shadow: none !important;
		margin: 0 10px !important;
		padding: 15px !important;
		background: #fff !important;
	}
	.card i {
		display: none !important;
	}
	.card h3 {
		font-size: 12pt !important;
		color: #000 !important;
	}
	.card p {
		font-size: 18pt !important;
		color: #000 !important;
	}
}

</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-money-bill-wave"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Pending Rent Report</p>
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
					<i class="fa-solid fa-triangle-exclamation"></i> Pending Rent
					Tenants
				</h2>

				<p>Tenants with outstanding rent payments</p>
				<p class="print-only">Filtered Month: <%= selectedMonth %></p>

			</div>

			<div class="action-bar">
				<form action="fetch-pending-fees" method="get" id="filterForm" style="display: flex; align-items: center; gap: 10px;">
					<label for="monthFilter" style="font-weight: 600; color: #1e3a8a;"><i class="fa-solid fa-filter"></i> Filter by Month:</label>
					<select name="month" id="monthFilter" onchange="this.form.submit()" style="padding: 10px 14px; border-radius: 12px; border: 1px solid var(--border); background: white; font-weight: 600; color: #1e3a8a; cursor: pointer; min-width: 140px; outline: none; box-shadow: 0 4px 10px rgba(0,0,0,0.03);">
						<option value="All" <%= "All".equals(selectedMonth) ? "selected" : "" %>>All Months</option>
						<% 
						String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
						for(String m : months) {
						%>
							<option value="<%= m %>" <%= m.equals(selectedMonth) ? "selected" : "" %>><%= m %></option>
						<% } %>
					</select>
				</form>

				<a href="dashboard" class="action-btn"> <i
					class="fa-solid fa-house"></i> Dashboard
				</a> <a href="fetch-pending-fees?month=<%= selectedMonth %>" class="action-btn"> <i
					class="fa-solid fa-rotate-right"></i> Refresh
				</a>
				<button onclick="window.print()" class="action-btn print-btn" style="border: none; cursor: pointer;">
					<i class="fa-solid fa-print"></i> Print
				</button>
			</div>

			<div class="table-wrapper">

				<table>

					<tr>
						<th>Tenant ID</th>
						<th>Tenant Name</th>
						<th>Room No</th>
						<th>Phone</th>
						<th>Month</th>
						<th>Pending Amount</th>
					</tr>

					<%
					boolean found = false;

					if (rs != null) {
						while (rs.next()) {
							found = true;
							totalPendingTenants++;
							totalPendingAmount += rs.getInt("amount");
					%>

					<tr>

						<td><%=rs.getInt("tenant_id")%></td>

						<td><%=rs.getString("tenant_name")%></td>

						<td><%=rs.getInt("room_no")%></td>

						<td><%=rs.getString("phone")%></td>

						<td><%=rs.getString("month_name")%></td>

						<td class="amount">₹ <%=rs.getInt("amount")%></td>

					</tr>

					<%
					}
					}

					if (!found) {
					%>

					<tr>
						<td colspan="6" class="no-data"><i
							class="fa-solid fa-circle-info"></i> No Pending Rent Records
							Found</td>
					</tr>

					<%
					}
					%>

				</table>

			</div>

		</div>

		<div class="summary">

			<div class="card">
				<i class="fa-solid fa-user-group"></i>
				<h3>Total Pending Tenants</h3>
				<p><%=totalPendingTenants%></p>
			</div>

			<div class="card">
				<i class="fa-solid fa-indian-rupee-sign"></i>
				<h3>Total Pending Amount</h3>
				<p>
					₹
					<%=totalPendingAmount%></p>
			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>