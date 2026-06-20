<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Integer totalTenants = (Integer) request.getAttribute("totalTenants");
Integer totalRooms = (Integer) request.getAttribute("totalRooms");
Integer totalFees = (Integer) request.getAttribute("totalFees");
Integer paidFees = (Integer) request.getAttribute("paidFees");
Integer pendingFees = (Integer) request.getAttribute("pendingFees");

if (totalTenants == null)
	totalTenants = 0;
if (totalRooms == null)
	totalRooms = 0;
if (totalFees == null)
	totalFees = 0;
if (paidFees == null)
	paidFees = 0;
if (pendingFees == null)
	pendingFees = 0;

int collectionPercent = totalFees > 0 ? (paidFees * 100) / totalFees : 0;
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>PG Reports Dashboard</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #4f46e5;
	--dark: #1e3a8a;
	--success: #16a34a;
	--danger: #dc2626;
	--bg: #f4f7fc;
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

.header {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 25px;
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

.logo h1 {
	font-size: 28px;
}

.logo p {
	opacity: .9;
	margin-top: 5px;
}

.dashboard-btn {
	text-decoration: none;
	color: white;
	padding: 12px 18px;
	border-radius: 12px;
	background: rgba(255, 255, 255, .15);
}

.container {
	width: min(95%, 1400px);
	margin: 30px auto;
}

.title-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	text-align: center;
	margin-bottom: 25px;
}

.title-card h2 {
	color: var(--dark);
}

.cards {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
}

.card {
	background: white;
	padding: 25px;
	border-radius: 22px;
	text-align: center;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	transition: .3s;
}

.card:hover {
	transform: translateY(-5px);
}

.card i {
	font-size: 42px;
	color: var(--dark);
	margin-bottom: 12px;
}

.card h3 {
	color: #475569;
	margin-bottom: 10px;
}

.card p {
	font-size: 32px;
	font-weight: bold;
	color: var(--dark);
}

.progress-box, .summary {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	margin-top: 25px;
}

.progress-box h2, .summary h2 {
	text-align: center;
	color: var(--dark);
	margin-bottom: 20px;
}

.progress-bar {
	width: 100%;
	height: 35px;
	background: #e5e7eb;
	border-radius: 30px;
	overflow: hidden;
}

.progress {
	height: 35px;
	width: 0%;
	background: linear-gradient(90deg, #16a34a, #22c55e);
	text-align: center;
	line-height: 35px;
	color: white;
	font-weight: bold;
	transition: 2s;
}

.summary table {
	width: 100%;
	border-collapse: collapse;
}

.summary th {
	background: var(--dark);
	color: white;
	padding: 14px;
}

.summary td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
}

.summary tr:hover {
	background: #eef3ff;
}

.back {
	text-align: center;
	margin-top: 25px;
}

.back a {
	text-decoration: none;
	padding: 14px 25px;
	border-radius: 12px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	font-weight: 600;
}

.footer {
	margin-top: auto;
	text-align: center;
	padding: 20px;
	color: #64748b;
}

@media ( max-width :768px) {
	.logo h1 {
		font-size: 22px;
	}
	.card p {
		font-size: 26px;
	}
	.summary {
		overflow-x: auto;
	}
	.summary table {
		min-width: 500px;
	}
}
</style>
</head>

<body>

	<header class="header">
		<div class="header-inner">
			<div class="logo">
				<h1>
					<i class="fa-solid fa-chart-pie"></i> SMART PG MANAGEMENT
				</h1>
				<p>System Reports Dashboard</p>
			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>
		</div>
	</header>

	<div class="container">

		<div class="title-card">
			<h2>
				<i class="fa-solid fa-file-chart-column"></i> Complete PG Summary
				Report
			</h2>
			<p style="margin-top: 10px; color: #64748b;">Overview of tenants,
				rooms and fee collection status</p>
		</div>

		<div class="cards">

			<div class="card">
				<i class="fa-solid fa-users"></i>
				<h3>Total Tenants</h3>
				<p class="counter"><%=totalTenants%></p>
			</div>

			<div class="card">
				<i class="fa-solid fa-door-open"></i>
				<h3>Total Rooms</h3>
				<p class="counter"><%=totalRooms%></p>
			</div>

			<div class="card">
				<i class="fa-solid fa-file-invoice-dollar"></i>
				<h3>Total Fee Records</h3>
				<p class="counter"><%=totalFees%></p>
			</div>

			<div class="card">
				<i class="fa-solid fa-circle-check"></i>
				<h3>Paid Fees</h3>
				<p class="counter"><%=paidFees%></p>
			</div>

			<div class="card">
				<i class="fa-solid fa-clock"></i>
				<h3>Pending Fees</h3>
				<p class="counter"><%=pendingFees%></p>
			</div>

		</div>

		<div class="progress-box">
			<h2>
				<i class="fa-solid fa-chart-line"></i> Fee Collection Progress
			</h2>

			<div class="progress-bar">
				<div id="progressBar" class="progress">
					<%=collectionPercent%>%
				</div>
			</div>
		</div>

		<div class="summary">

			<h2>
				<i class="fa-solid fa-table"></i> Overall Summary
			</h2>

			<table>

				<tr>
					<th>Category</th>
					<th>Count</th>
				</tr>

				<tr>
					<td>Total Tenants</td>
					<td><%=totalTenants%></td>
				</tr>

				<tr>
					<td>Total Rooms</td>
					<td><%=totalRooms%></td>
				</tr>

				<tr>
					<td>Total Fee Records</td>
					<td><%=totalFees%></td>
				</tr>

				<tr>
					<td>Paid Fees</td>
					<td><%=paidFees%></td>
				</tr>

				<tr>
					<td>Pending Fees</td>
					<td><%=pendingFees%></td>
				</tr>

				<tr>
					<td>Collection Percentage</td>
					<td><%=collectionPercent%>%</td>
				</tr>

			</table>

		</div>

		<div class="back">
			<a href="dashboard"> <i class="fa-solid fa-arrow-left"></i> Back
				To Dashboard
			</a>
		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

	<script>
window.onload=function(){

document.getElementById("progressBar").style.width="<%=collectionPercent%>%";

document.querySelectorAll(".counter").forEach(counter=>{

const target=parseInt(counter.innerText);
let count=0;

const speed=Math.max(1,Math.ceil(target/50));

function update(){
count+=speed;

if(count>=target){
counter.innerText=target;
}
else{
counter.innerText=count;
requestAnimationFrame(update);
}
}
update();
});
};
</script>

</body>
</html>