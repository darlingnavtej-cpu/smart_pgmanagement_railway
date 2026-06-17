<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%
String currentMonth = (String) request.getAttribute("currentMonth");
if (currentMonth == null)
	currentMonth = "June";

Integer totalTenants = (Integer) request.getAttribute("totalTenants");
Integer paidTenants = (Integer) request.getAttribute("paidTenants");
Integer pendingTenants = (Integer) request.getAttribute("pendingTenants");
Integer totalCollection = (Integer) request.getAttribute("totalCollection");
Integer pendingAmount = (Integer) request.getAttribute("pendingAmount");
Integer collectionPercentage = (Integer) request.getAttribute("collectionPercentage");
ResultSet rs = (ResultSet) request.getAttribute("resultSet");

if (totalTenants == null)
	totalTenants = 0;
if (paidTenants == null)
	paidTenants = 0;
if (pendingTenants == null)
	pendingTenants = 0;
if (totalCollection == null)
	totalCollection = 0;
if (pendingAmount == null)
	pendingAmount = 0;
if (collectionPercentage == null)
	collectionPercentage = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Month Wise Rent Analysis</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
:root {
	--primary: #4f46e5;
	--dark: #1e3a8a;
	--success: #16a34a;
	--danger: #dc2626;
	--warning: #f59e0b;
	--bg: #f4f7fc;
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', sans-serif;
}

body {
	background: var(--bg);
}

.header {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	padding: 30px 20px;
	color: white;
	box-shadow: 0 8px 25px rgba(0, 0, 0, .15);
}

.header-inner {
	max-width: 1400px;
	margin: auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 20px;
	flex-wrap: wrap;
}

.logo h1 {
	font-size: 32px;
}

.logo p {
	opacity: .9;
	margin-top: 5px;
}

.dashboard-btn {
	text-decoration: none;
	color: white;
	padding: 12px 20px;
	border-radius: 12px;
	background: rgba(255, 255, 255, .15);
}

.container {
	width: min(95%, 1400px);
	margin: 30px auto;
}

.filter-card, .progress-card, .table-card {
	background: white;
	border-radius: 24px;
	padding: 25px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .08);
	margin-bottom: 25px;
}

.filter-form {
	display: flex;
	gap: 15px;
	justify-content: center;
	flex-wrap: wrap;
}

.filter-form select, .filter-form button {
	padding: 14px;
	border-radius: 12px;
	border: 1px solid #ddd;
}

.filter-form button {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	border: none;
	cursor: pointer;
}

.stats {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
	margin-bottom: 25px;
}

.card {
	background: white;
	padding: 25px;
	border-radius: 24px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	text-align: center;
}

.card i {
	font-size: 42px;
	color: var(--dark);
	margin-bottom: 10px;
}

.card h3 {
	color: #475569;
}

.card p {
	font-size: 32px;
	font-weight: bold;
	color: var(--dark);
	margin-top: 10px;
}

.progress-layout {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 40px;
	flex-wrap: wrap;
}

.circle {
	width: 220px;
	height: 220px;
	border-radius: 50%;
	background: conic-gradient(var(--success) 0deg, var(--success)
		calc(<%=collectionPercentage%>* 3.6deg), #e5e7eb 0deg);
	display: flex;
	align-items: center;
	justify-content: center;
}

.inner {
	width: 170px;
	height: 170px;
	background: white;
	border-radius: 50%;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.inner h1 {
	color: var(--success);
}

.summary {
	flex: 1;
	min-width: 300px;
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
	gap: 15px;
}

.summary-box {
	background: #f8faff;
	padding: 20px;
	border-radius: 18px;
	text-align: center;
}

.summary-box h4 {
	color: #64748b;
}

.summary-box p {
	margin-top: 10px;
	font-size: 24px;
	font-weight: bold;
	color: var(--dark);
}

.table-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
	gap: 15px;
	flex-wrap: wrap;
}

.bulk-btn {
	text-decoration: none;
	background: var(--warning);
	color: white;
	padding: 12px 20px;
	border-radius: 12px;
	font-weight: bold;
}

.table-wrapper {
	overflow: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 750px;
}

th {
	background: var(--dark);
	color: white;
	padding: 14px;
}

td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
}

tr:hover {
	background: #eef3ff;
}

.pending-tag {
	background: #fee2e2;
	color: #b91c1c;
	padding: 6px 10px;
	border-radius: 20px;
	font-weight: bold;
}

.footer {
	margin-top: 30px;
	text-align: center;
	padding: 25px;
	color: #64748b;
}

@media ( max-width :768px) {
	.logo h1 {
		font-size: 24px;
	}
	.card p {
		font-size: 26px;
	}
	.circle {
		width: 180px;
		height: 180px;
	}
	.inner {
		width: 140px;
		height: 140px;
	}
	.table-card, .filter-card, .progress-card {
		padding: 18px;
	}
}
</style>
</head>
<body>

	<header class="header">
		<div class="header-inner">
			<div class="logo">
				<h1>
					<i class="fa-solid fa-chart-line"></i> SMART PG MANAGEMENT
				</h1>
				<p>Advanced Month Wise Rent Analytics Dashboard</p>
			</div>
			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>
		</div>
	</header>

	<div class="container">

		<div class="filter-card">
			<form action="month-wise-rent-analysis" method="get"
				class="filter-form">
				<select name="month">
					<option selected><%=currentMonth%></option>
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
				<button type="submit">
					<i class="fa-solid fa-magnifying-glass"></i> Analyze
				</button>
			</form>
		</div>

		<div class="stats">
			<div class="card">
				<i class="fa-solid fa-users"></i>
				<h3>Total Tenants</h3>
				<p><%=totalTenants%></p>
			</div>
			<div class="card">
				<i class="fa-solid fa-circle-check"></i>
				<h3>Paid</h3>
				<p><%=paidTenants%></p>
			</div>
			<div class="card">
				<i class="fa-solid fa-clock"></i>
				<h3>Pending</h3>
				<p><%=pendingTenants%></p>
			</div>
			<div class="card">
				<i class="fa-solid fa-indian-rupee-sign"></i>
				<h3>Collection</h3>
				<p>
					₹<%=totalCollection%></p>
			</div>
			<div class="card">
				<i class="fa-solid fa-wallet"></i>
				<h3>Pending Amount</h3>
				<p>
					₹<%=pendingAmount%></p>
			</div>
		</div>

		<div class="progress-card">
			<div class="progress-layout">
				<div class="circle">
					<div class="inner">
						<span>Collection</span>
						<h1><%=collectionPercentage%>%
						</h1>
					</div>
				</div>

				<div class="summary">
					<div class="summary-box">
						<h4>Total Tenants</h4>
						<p><%=totalTenants%></p>
					</div>
					<div class="summary-box">
						<h4>Paid</h4>
						<p><%=paidTenants%></p>
					</div>
					<div class="summary-box">
						<h4>Pending</h4>
						<p><%=pendingTenants%></p>
					</div>
					<div class="summary-box">
						<h4>Collection</h4>
						<p>
							₹<%=totalCollection%></p>
					</div>
					<div class="summary-box">
						<h4>Balance</h4>
						<p>
							₹<%=pendingAmount%></p>
					</div>
				</div>
			</div>
		</div>

		<div class="table-card">

			<div class="table-header">
				<h2>
					<i class="fa-solid fa-user-clock"></i> Pending Tenant List
				</h2>

				<a class="bulk-btn"
					href="send-bulk-email-reminder?month=<%=currentMonth%>"> <i
					class="fa-solid fa-bell"></i> Send Reminder To All
				</a>
			</div>

			<div class="table-wrapper">
				<table>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Room</th>
						<th>Phone</th>
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
						<td><%=rs.getInt("room_no")%></td>
						<td><%=rs.getString("phone")%></td>
						<td><%=rs.getString("month_name")%></td>
						<td>₹ <%=rs.getInt("amount")%></td>
						<td><span class="pending-tag">Pending</span></td>
					</tr>
					<%
					}
					}
					if (!found) {
					%>
					<tr>
						<td colspan="7" style="color: red; font-weight: bold;">No
							Pending Tenants Found</td>
					</tr>
					<%
					}
					%>

				</table>
			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

	<script>
window.onload=function(){
Swal.fire({
toast:true,
position:'top-end',
icon:'success',
title:'<%=currentMonth%>
		Analysis Loaded',
				showConfirmButton : false,
				timer : 2000
			});
		}
	</script>

</body>
</html>
