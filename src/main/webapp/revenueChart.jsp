<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>

<%
ArrayList<String> monthList = (ArrayList<String>) request.getAttribute("monthList");
ArrayList<Integer> revenueList = (ArrayList<Integer>) request.getAttribute("revenueList");

String bestMonth = (String) request.getAttribute("bestMonth");
Integer highestRevenue = (Integer) request.getAttribute("highestRevenue");
Integer averageRevenue = (Integer) request.getAttribute("averageRevenue");

if (monthList == null)
	monthList = new ArrayList<String>();
if (revenueList == null)
	revenueList = new ArrayList<Integer>();
if (bestMonth == null || bestMonth.trim().isEmpty())
	bestMonth = "N/A";
if (highestRevenue == null)
	highestRevenue = 0;
if (averageRevenue == null)
	averageRevenue = 0;

StringBuilder monthsBuilder = new StringBuilder();
StringBuilder amountsBuilder = new StringBuilder();

for (int i = 0; i < monthList.size(); i++) {
	if (i > 0) {
		monthsBuilder.append(",");
		amountsBuilder.append(",");
	}
	monthsBuilder.append("'").append(monthList.get(i).replace("'", "\\'")).append("'");
	amountsBuilder.append(revenueList.get(i));
}

String months = monthsBuilder.toString();
String amounts = amountsBuilder.toString();

int chartSize = monthList.size();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Monthly Revenue Chart</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
:root {
	--primary: #1e3a8a;
	--secondary: #4f46e5;
	--bg: #f4f7fc;
	--card: #ffffff;
	--text: #0f172a;
	--muted: #64748b;
	--border: #e2e8f0;
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
	font-size: 14px;
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

/* PAGE TITLE */
.page-title {
	text-align: center;
	margin-bottom: 24px;
}

.page-title h2 {
	font-size: 32px;
	color: #1e3a8a;
	margin-bottom: 8px;
}

.page-title p {
	color: var(--muted);
	font-size: 15px;
}

/* TOP INFO */
.top-info {
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 12px;
	margin-bottom: 22px;
}

.info-pill {
	background: white;
	border: 1px solid var(--border);
	color: #334155;
	padding: 10px 14px;
	border-radius: 999px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, .05);
	font-size: 14px;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

/* SUMMARY CARDS */
.summary-box {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(230px, 1fr));
	gap: 18px;
	margin-bottom: 24px;
}

.summary-card {
	background: white;
	padding: 24px;
	border-radius: 20px;
	text-align: center;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	transition: .3s;
	border: 1px solid rgba(226, 232, 240, .8);
}

.summary-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 14px 30px rgba(0, 0, 0, .10);
}

.summary-card i {
	font-size: 40px;
	margin-bottom: 12px;
	color: #1e3a8a;
}

.summary-card h3 {
	color: var(--muted);
	margin-bottom: 10px;
	font-size: 17px;
}

.summary-card h2 {
	color: #1e3a8a;
	font-size: 30px;
	line-height: 1.2;
}

/* CHART CARD */
.chart-card {
	background: white;
	padding: 28px;
	border-radius: 25px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
}

.chart-title {
	text-align: center;
	margin-bottom: 18px;
}

.chart-title h2 {
	color: #1e3a8a;
	font-size: 26px;
}

.chart-title p {
	color: var(--muted);
	margin-top: 6px;
}

.chart-wrapper {
	position: relative;
	height: 500px;
}

/* TABLE */
.data-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .08);
	margin-top: 24px;
	border: 1px solid rgba(226, 232, 240, .8);
}

.data-card h2 {
	text-align: center;
	color: #1e3a8a;
	margin-bottom: 18px;
	font-size: 26px;
}

.table-wrapper {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 700px;
}

th {
	background: #1e3a8a;
	color: white;
	padding: 14px;
	text-align: left;
}

td {
	padding: 14px;
	border-bottom: 1px solid #e5e7eb;
}

tr:hover {
	background: #eef3ff;
}

.no-data {
	text-align: center;
	padding: 24px;
	color: #dc2626;
	font-weight: 600;
}

/* BACK BUTTON */
.back {
	text-align: center;
	margin-top: 25px;
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
	.logo-text h1 {
		font-size: 20px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.chart-title h2, .data-card h2 {
		font-size: 22px;
	}
	.chart-wrapper {
		height: 360px;
	}
	.summary-card h2 {
		font-size: 26px;
	}
}

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
	.summary-card {
		padding: 18px;
	}
	.summary-card i {
		font-size: 34px;
	}
	.summary-card h2 {
		font-size: 24px;
	}
	.chart-card, .data-card {
		padding: 18px;
	}
	.chart-wrapper {
		height: 300px;
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
					<i class="fa-solid fa-chart-line"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Revenue Analytics Dashboard</p>
				</div>

			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>

	</header>

	<div class="container">

		<div class="page-title">
			<h2>
				<i class="fa-solid fa-chart-column"></i> Monthly Revenue Analytics
			</h2>
			<p>Track monthly PG revenue performance</p>
		</div>

		<div class="top-info">
			<div class="info-pill">
				<i class="fa-solid fa-calendar-days"></i> <label>Months
					Found:</label> <span><%=chartSize%></span>
			</div>
			<div class="info-pill">
				<i class="fa-solid fa-trophy"></i> <label>Best Month:</label> <span><%=bestMonth%></span>
			</div>
		</div>

		<div class="summary-box">

			<div class="summary-card">
				<i class="fa-solid fa-trophy"></i>
				<h3>Best Month</h3>
				<h2><%=bestMonth%></h2>
			</div>

			<div class="summary-card">
				<i class="fa-solid fa-indian-rupee-sign"></i>
				<h3>Highest Revenue</h3>
				<h2>
					₹
					<%=highestRevenue%></h2>
			</div>

			<div class="summary-card">
				<i class="fa-solid fa-chart-simple"></i>
				<h3>Average Revenue</h3>
				<h2>
					₹
					<%=averageRevenue%></h2>
			</div>

		</div>

		<div class="chart-card">

			<div class="chart-title">
				<h2>
					<i class="fa-solid fa-chart-bar"></i> Monthly Revenue Overview
				</h2>
				<p>Revenue collected from paid fees month by month</p>
			</div>

			<div class="chart-wrapper">
				<canvas id="myChart"></canvas>
			</div>

		</div>

		<div class="data-card">
			<h2>
				<i class="fa-solid fa-table"></i> Revenue Data Table
			</h2>

			<div class="table-wrapper">
				<table>
					<tr>
						<th>Month</th>
						<th>Revenue</th>
					</tr>

					<%
					if (monthList.size() > 0) {
						for (int i = 0; i < monthList.size(); i++) {
					%>
					<tr>
						<td><%=monthList.get(i)%></td>
						<td>₹ <%=revenueList.get(i)%></td>
					</tr>
					<%
					}
					} else {
					%>
					<tr>
						<td colspan="2" class="no-data">No revenue data found</td>
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

	<script>
		const ctx = document.getElementById('myChart');

		const labels = [
	<%=months%>
		];
		const dataValues = [
	<%=amounts%>
		];

		new Chart(ctx, {
			type : 'bar',
			data : {
				labels : labels,
				datasets : [ {
					label : 'Revenue',
					data : dataValues,
					backgroundColor : [ '#1e3a8a', '#2563eb', '#4f46e5',
							'#6366f1', '#8b5cf6', '#3b82f6', '#1d4ed8',
							'#4338ca', '#7c3aed', '#5b21b6', '#2563eb',
							'#4f46e5' ],
					borderColor : '#1e3a8a',
					borderWidth : 1,
					borderRadius : 10,
					borderSkipped : false
				} ]
			},
			options : {
				responsive : true,
				maintainAspectRatio : false,
				plugins : {
					legend : {
						display : true,
						position : 'top'
					}
				},
				scales : {
					y : {
						beginAtZero : true
					}
				}
			}
		});
	</script>

</body>
</html>