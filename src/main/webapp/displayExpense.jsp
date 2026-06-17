<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("expenseResultSet");
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0">

<title>Expense Management</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>

:root{
	--primary:#4f46e5;
	--primary-dark:#1e3a8a;
	--success:#16a34a;
	--danger:#dc2626;
	--bg:#f8fafc;
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

.dashboard-btn{
	text-decoration:none;
	color:white;
	padding:10px 18px;
	border-radius:10px;
	background:rgba(255,255,255,.15);
	transition:.3s;
}

.dashboard-btn:hover{
	background:rgba(255,255,255,.25);
}

/* CONTAINER */

.container{
	width:95%;
	max-width:1400px;
	margin:30px auto;
}

/* TOP BAR */

.top-bar{
	display:flex;
	justify-content:space-between;
	align-items:center;
	gap:15px;
	margin-bottom:20px;
	flex-wrap:wrap;
}

.action-btn{
	text-decoration:none;
	background:linear-gradient(135deg,#4f46e5,#6366f1);
	color:white;
	padding:12px 18px;
	border-radius:10px;
	font-weight:600;
	transition:.3s;
}

.action-btn:hover{
	transform:translateY(-2px);
	box-shadow:0 10px 20px rgba(79,70,229,.25);
}

/* TABLE CARD */

.table-card{
	background:white;
	border-radius:25px;
	padding:25px;
	box-shadow:0 20px 40px rgba(0,0,0,.08);
	overflow:hidden;
}

.table-title{
	text-align:center;
	margin-bottom:25px;
}

.table-title h2{
	color:#1e3a8a;
	font-size:28px;
}

.table-title p{
	color:#64748b;
	margin-top:8px;
}

/* TABLE */

.table-wrapper{
	overflow-x:auto;
}

table{
	width:100%;
	border-collapse:collapse;
	min-width:900px;
}

th{
	background:#1e3a8a;
	color:white;
	padding:14px;
	font-size:15px;
}

td{
	padding:14px;
	text-align:center;
	border-bottom:1px solid #e2e8f0;
}

tr:hover{
	background:#f8faff;
}

.amount{
	color:#16a34a;
	font-weight:700;
}

/* BUTTONS */

.edit-btn{
	text-decoration:none;
	background:#16a34a;
	color:white;
	padding:8px 14px;
	border-radius:8px;
	font-size:14px;
	font-weight:600;
	display:inline-block;
}

.edit-btn:hover{
	background:#15803d;
}

.delete-btn{
	text-decoration:none;
	background:#dc2626;
	color:white;
	padding:8px 14px;
	border-radius:8px;
	font-size:14px;
	font-weight:600;
	display:inline-block;
}

.delete-btn:hover{
	background:#b91c1c;
}

/* EMPTY MESSAGE */

.no-record{
	text-align:center;
	padding:25px;
	color:#dc2626;
	font-weight:600;
}

/* FOOTER */

.footer{
	margin-top:auto;
	text-align:center;
	padding:20px;
	color:#64748b;
}

/* TABLET */

@media(max-width:768px){

	.header-inner{
		flex-direction:column;
		text-align:center;
		gap:15px;
	}

	.top-bar{
		flex-direction:column;
		align-items:stretch;
	}

	.action-btn{
		text-align:center;
	}

	.table-card{
		padding:18px;
	}

	.table-title h2{
		font-size:24px;
	}
}

/* MOBILE */

@media(max-width:480px){

	.logo-icon{
		width:42px;
		height:42px;
		font-size:18px;
	}

	.logo-text h1{
		font-size:18px;
	}

	.logo-text p{
		font-size:12px;
	}

	.table-title h2{
		font-size:22px;
	}

	th,
	td{
		padding:12px;
		font-size:13px;
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
			<p>Expense Management</p>
		</div>

	</div>

	<a href="dashboard" class="dashboard-btn">

		<i class="fa-solid fa-house"></i>

		Dashboard

	</a>

</div>


</header>

<div class="container">


<div class="top-bar">

	<a href="addExpense.jsp" class="action-btn">

		<i class="fa-solid fa-plus"></i>

		Add Expense

	</a>

	<a href="fetch-expenses" class="action-btn">

		<i class="fa-solid fa-rotate-right"></i>

		Refresh

	</a>

</div>

<div class="table-card">

	<div class="table-title">

		<h2>

			<i class="fa-solid fa-wallet"></i>

			Expense Records

		</h2>

		<p>Manage all PG expenses and spending records</p>

	</div>

	<div class="table-wrapper">

		<table>

			<tr>

				<th>Expense ID</th>

				<th>Expense Name</th>

				<th>Amount</th>

				<th>Expense Date</th>

				<th>Remarks</th>

				<th>Update</th>

				<th>Delete</th>

			</tr>

			<%
			boolean found = false;

			if (rs != null) {

				while (rs.next()) {

					found = true;
			%>

			<tr>

				<td><%=rs.getInt("expense_id")%></td>

				<td><%=rs.getString("expense_name")%></td>

				<td class="amount">

					₹ <%=rs.getInt("amount")%>

				</td>

				<td><%=rs.getString("expense_date")%></td>

				<td><%=rs.getString("remarks")%></td>

				<td>

					<a class="edit-btn"
						href="find-expense-by-id?expenseId=<%=rs.getInt("expense_id")%>">

						<i class="fa-solid fa-pen"></i>

						Update

					</a>

				</td>

				<td>

					<a class="delete-btn"
						href="delete-expense?expenseId=<%=rs.getInt("expense_id")%>&expenseName=<%=rs.getString("expense_name")%>"
						onclick="return confirm('Are you sure you want to delete this expense?')">

						<i class="fa-solid fa-trash"></i>

						Delete

					</a>

				</td>

			</tr>

			<%
				}
			}

			if (!found) {
			%>

			<tr>

				<td colspan="7" class="no-record">

					No Expense Records Found

				</td>

			</tr>

			<%
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
