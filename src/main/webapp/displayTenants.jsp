<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tenant Records</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>

:root{
	--primary:#4f46e5;
	--primary-dark:#1e3a8a;
	--bg:#f8fafc;
	--border:#e2e8f0;
}

*{
	margin:0;
	padding:0;
	box-sizing:border-box;
	font-family:Segoe UI,sans-serif;
}

body{
	background:var(--bg);
	min-height:100vh;
	display:flex;
	flex-direction:column;
}

/* HEADER */

.header{
	background:linear-gradient(135deg,#1e3a8a,#4f46e5);
	color:white;
	padding:20px;
	box-shadow:0 4px 15px rgba(0,0,0,.15);
}

.header-inner{
	max-width:1200px;
	margin:auto;
	display:flex;
	align-items:center;
	justify-content:space-between;
	flex-wrap:wrap;
}

.logo{
	display:flex;
	align-items:center;
	gap:12px;
}

.logo-icon{
	width:50px;
	height:50px;
	border-radius:15px;
	background:white;
	color:#1e3a8a;
	display:flex;
	align-items:center;
	justify-content:center;
	font-size:22px;
}

.logo-text h1{
	font-size:24px;
}

.logo-text p{
	font-size:13px;
	opacity:.9;
}

.back-btn{
	text-decoration:none;
	color:white;
	padding:10px 18px;
	border-radius:10px;
	background:rgba(255,255,255,.15);
	transition:.3s;
}

.back-btn:hover{
	background:rgba(255,255,255,.25);
}

/* CONTAINER */

.container{
	width:min(98%,1400px);
	margin:30px auto;
}

/* CARD */

.table-card{
	background:white;
	padding:25px;
	border-radius:25px;
	box-shadow:0 20px 40px rgba(0,0,0,.08);
	animation:fadeIn .6s ease;
}

@keyframes fadeIn{

	from{
		opacity:0;
		transform:translateY(20px);
	}

	to{
		opacity:1;
		transform:translateY(0);
	}
}

.page-title{
	text-align:center;
	margin-bottom:25px;
}

.page-title h2{
	color:#1e3a8a;
	font-size:30px;
}

.page-title p{
	color:#64748b;
	margin-top:8px;
}

/* TABLE */

.table-wrapper{
	width:100%;
	overflow-x:auto;
	border-radius:15px;
}

table{
	width:100%;
	min-width:1300px;
	border-collapse:collapse;
	background:white;
}

th{
	background:linear-gradient(135deg,#1e3a8a,#4f46e5);
	color:white;
	padding:14px;
	white-space:nowrap;
}

td{
	padding:12px;
	text-align:center;
	border-bottom:1px solid #e5e7eb;
	white-space:nowrap;
}

tr:hover{
	background:#f8faff;
}

/* BUTTONS */

.update-btn,
.delete-btn,
.checkout-btn{
	text-decoration:none;
	color:white;
	padding:8px 12px;
	border-radius:8px;
	font-size:14px;
	font-weight:600;
	display:inline-block;
	transition:.3s;
}

.update-btn{
	background:#4f46e5;
}

.update-btn:hover{
	background:#4338ca;
}

.delete-btn{
	background:#dc2626;
}

.delete-btn:hover{
	background:#b91c1c;
}

.checkout-btn{
	background:#f97316;
}

.checkout-btn:hover{
	background:#ea580c;
}

/* FOOTER */

.footer{
	margin-top:auto;
	text-align:center;
	padding:20px;
	color:#64748b;
}

/* MOBILE */

@media(max-width:768px){

	.header-inner{
		flex-direction:column;
		gap:15px;
		text-align:center;
	}

	.logo-text h1{
		font-size:20px;
	}

	.page-title h2{
		font-size:24px;
	}

	.table-card{
		padding:15px;
	}
}

/* PRINT BUTTON */
.print-btn {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 10px;
	font-size: 14px;
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
}

</style>

</head>

<body>

<header class="header">

<div class="header-inner">

	<div class="logo">

		<div class="logo-icon">
			<i class="fa-solid fa-users"></i>
		</div>

		<div class="logo-text">
			<h1>SMART PG MANAGEMENT</h1>
			<p>Tenant Management</p>
		</div>

	</div>

	<a href="dashboard" class="back-btn">
		<i class="fa-solid fa-arrow-left"></i> Dashboard
	</a>

</div>

</header>

<div class="container">


<div class="table-card">

	<div class="page-title">
		<h2>Tenant Details</h2>
		<p>Manage tenant information and room allocation</p>
	</div>

	<div class="action-bar no-print" style="display: flex; justify-content: flex-end; margin-bottom: 20px;">
		<button onclick="window.print()" class="print-btn">
			<i class="fa-solid fa-print"></i> Print Records
		</button>
	</div>

	<%
	ResultSet rs = (ResultSet)request.getAttribute("resultSet");
	%>

	<div class="table-wrapper">

		<table>

			<tr>
				<th>Tenant ID</th>
				<th>Name</th>
				<th>Age</th>
				<th>Gender</th>
				<th>Phone</th>
				<th>Occupation</th>
				<th>Institute</th>
				<th>Joining Date</th>
				<th>Room Number</th>
				<th>Email</th>
				<th class="no-print">Checkout</th>
				<th class="no-print">Update</th>
				<th class="no-print">Delete</th>
			</tr>

			<%
			if(rs!=null){

				while(rs.next()){
			%>

			<tr>

				<td><%=rs.getInt(1)%></td>
				<td><%=rs.getString(2)%></td>
				<td><%=rs.getInt(3)%></td>
				<td><%=rs.getString(4)%></td>
				<td><%=rs.getString(5)%></td>
				<td><%=rs.getString(6)%></td>
				<td><%=rs.getString(7)%></td>
				<td><%=rs.getString(8)%></td>
				<td><%=rs.getInt(9)%></td>
				<td><%=rs.getString(10)%></td>

				<td class="no-print">

					<a class="checkout-btn"
						href="checkoutTenant.jsp?tenantId=<%=rs.getInt("tenant_id")%>&tenantName=<%=rs.getString("tenant_name")%>&roomNo=<%=rs.getInt("room_no")%>">

						<i class="fa-solid fa-right-from-bracket"></i>
						Checkout

					</a>

				</td>

				<td class="no-print">

					<a class="update-btn"
						href="find-tenant-by-id?tenantId=<%=rs.getInt(1)%>">

						<i class="fa-solid fa-pen"></i>
						Update

					</a>

				</td>

				<td class="no-print">

					<a class="delete-btn"
						href="delete-tenant?tenantId=<%=rs.getInt(1)%>"
						onclick="return confirm('Are you sure you want to delete this tenant?')">

						<i class="fa-solid fa-trash"></i>
						Delete

					</a>

				</td>

			</tr>

			<%
				}
			}
			%>

		</table>

	</div>

</div>


</div>

<div class="footer">
	Smart PG Management System © 2026
</div>

</body>
</html>
