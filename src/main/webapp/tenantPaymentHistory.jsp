<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("resultSet");
String tenantName = (String) request.getAttribute("tenantName");
Integer roomNo = (Integer) request.getAttribute("roomNo");

if (tenantName == null)
	tenantName = "N/A";
if (roomNo == null)
	roomNo = 0;
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Payment History</title>

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

/* CARD */
.card {
	background: white;
	padding: 28px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
	animation: fadeUp .6s ease;
}

@
keyframes fadeUp {from { opacity:0;
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
	font-size: 15px;
}

/* INFO BOX */
.info-box {
	background: #eef2ff;
	border: 1px solid #dbe4ff;
	padding: 20px;
	border-radius: 20px;
	margin-bottom: 24px;
}

.info-head {
	display: flex;
	align-items: center;
	gap: 10px;
	color: #1e3a8a;
	margin-bottom: 16px;
	font-size: 20px;
}

.info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 14px;
}

.info-item {
	background: white;
	padding: 14px;
	border-radius: 12px;
	border: 1px solid var(--border);
	font-size: 15px;
	line-height: 1.5;
}

.info-item b {
	color: #1e3a8a;
}

/* TABLE */
.table-wrapper {
	overflow-x: auto;
	border-radius: 16px;
	border: 1px solid var(--border);
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 900px;
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

.paid {
	color: var(--success);
	font-weight: 700;
}

.pending {
	color: var(--danger);
	font-weight: 700;
}

.receipt-btn {
	text-decoration: none;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 8px 14px;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 6px;
	transition: .3s;
}

.receipt-btn:hover {
	transform: translateY(-1px);
	box-shadow: 0 10px 20px rgba(79, 70, 229, .20);
}

.no-data {
	text-align: center;
	padding: 25px;
	color: var(--danger);
	font-weight: 600;
}

/* BACK */
.back {
	text-align: center;
	margin-top: 28px;
}

.back a {
	text-decoration: none;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 12px 24px;
	border-radius: 12px;
	font-size: 16px;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: .3s;
}

.back a:hover {
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
	.card {
		padding: 20px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.info-grid {
		grid-template-columns: 1fr;
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
	.card {
		padding: 16px;
		border-radius: 18px;
	}
	.page-title h2 {
		font-size: 22px;
	}
	.page-title p {
		font-size: 13px;
	}
	.info-head {
		font-size: 18px;
	}
	table {
		min-width: 800px;
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
					<i class="fa-solid fa-clock-rotate-left"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Payment History</p>
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
					<i class="fa-solid fa-wallet"></i> Payment History
				</h2>
				<p>View your monthly rent payments and receipt records</p>
			</div>

			<div class="info-box">

				<div class="info-head">
					<i class="fa-solid fa-user"></i> Tenant Details
				</div>

				<div class="info-grid">

					<div class="info-item">
						<b>Name :</b>
						<%=tenantName%>
					</div>

					<div class="info-item">
						<b>Room No :</b>
						<%=roomNo%>
					</div>

				</div>

			</div>

			<div class="table-wrapper">
				<table>

					<tr>
						<th>Month</th>
						<th>Amount</th>
						<th>Paid Date</th>
						<th>Status</th>
						<th>Receipt</th>
					</tr>

					<%
					boolean found = false;

					if (rs != null) {
						while (rs.next()) {
							found = true;
							String status = rs.getString("status");
					%>

					<tr>

						<td><%=rs.getString("month_name")%></td>

						<td>₹ <%=rs.getInt("amount")%></td>

						<td><%=rs.getDate("paid_date")%></td>

						<td>
							<%
							if (status != null && status.equalsIgnoreCase("Paid")) {
							%> <span class="paid"> <i class="fa-solid fa-circle-check"></i>
								Paid
						</span> <%
 } else {
 %> <span class="pending"> <i
								class="fa-solid fa-circle-exclamation"></i> Pending
						</span> <%
 }
 %>
						</td>

						<td>
							<%
							if (status != null && status.equalsIgnoreCase("Paid")) {
							%> <a class="receipt-btn"
							href="generate-receipt?tenantId=<%=session.getAttribute("tenantId")%>&month=<%=rs.getString("month_name")%>">
								<i class="fa-solid fa-receipt"></i> Receipt
						</a> <%
 } else {
 %> -- <%
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
						<td colspan="5" class="no-data">No Payment History Found</td>
					</tr>

					<%
					}
					%>

				</table>
			</div>

			<div class="back">
				<a href="tenant-dashboard"> <i class="fa-solid fa-arrow-left"></i>
					Back To Dashboard
				</a>
			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>