<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Room Details</title>

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
	width:min(98%,1300px);
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
	margin-bottom:8px;
}

.page-title p{
	color:#64748b;
}

/* TABLE */

.table-wrapper{
	width:100%;
	overflow-x:auto;
	border-radius:15px;
}

table{
	width:100%;
	min-width:1000px;
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

/* STATUS */

.status-full{
	background:#dc2626;
	color:white;
	padding:6px 12px;
	border-radius:20px;
	font-weight:600;
}

.status-available{
	background:#16a34a;
	color:white;
	padding:6px 12px;
	border-radius:20px;
	font-weight:600;
}

/* BUTTONS */

.update-btn,
.delete-btn,
.view-btn{
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

.view-btn{
	background:#16a34a;
}

.view-btn:hover{
	background:#15803d;
}

/* FOOTER */

.footer{
	margin-top:auto;
	text-align:center;
	padding:20px;
	color:#64748b;
}

/* RESPONSIVE */

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

@media(max-width:480px){

	.logo-text h1{
		font-size:18px;
	}

	.page-title h2{
		font-size:22px;
	}

	.container{
		width:95%;
	}
}

</style>

</head>

<body>

<header class="header">


<div class="header-inner">

	<div class="logo">

		<div class="logo-icon">
			<i class="fa-solid fa-bed"></i>
		</div>

		<div class="logo-text">
			<h1>SMART PG MANAGEMENT</h1>
			<p>Room Management</p>
		</div>

	</div>

	<a href="dashboard" class="back-btn">
		<i class="fa-solid fa-arrow-left"></i>
		Dashboard
	</a>

</div>


</header>

<div class="container">

<div class="table-card">

	<div class="page-title">

		<h2>
			<i class="fa-solid fa-door-open"></i>
			Room Details
		</h2>

		<p>Manage room occupancy and availability</p>

	</div>

	<%
	ResultSet rs=(ResultSet)request.getAttribute("resultSet");
	%>

	<div class="table-wrapper">

		<table>

			<tr>
				<th>Room No</th>
				<th>Capacity</th>
				<th>Occupied</th>
				<th>Available Beds</th>
				<th>Status</th>
				<th>Rent</th>
				<th>Update</th>
				<th>Delete</th>
				<th>View</th>
			</tr>

			<%
			while(rs.next()){
			%>

			<tr>

				<td><%=rs.getInt("room_no")%></td>

				<td><%=rs.getInt("capacity")%></td>

				<td><%=rs.getInt("occupied")%></td>

				<td><%=rs.getInt("capacity")-rs.getInt("occupied")%></td>

				<td>

					<%
					if(rs.getInt("occupied")>=rs.getInt("capacity")){
					%>

					<span class="status-full">
						🔴 Full
					</span>

					<%
					}else{
					%>

					<span class="status-available">
						🟢 Available
					</span>

					<%
					}
					%>

				</td>

				<td>₹ <%=rs.getInt("rent")%></td>

				<td>

					<a class="update-btn"
						href="find-room-by-id?roomNo=<%=rs.getInt("room_no")%>">

						<i class="fa-solid fa-pen"></i>
						Update

					</a>

				</td>

				<td>

					<a class="delete-btn"
						href="delete-room?roomNo=<%=rs.getInt("room_no")%>"
						onclick="return confirm('Are you sure you want to delete this room?')">

						<i class="fa-solid fa-trash"></i>
						Delete

					</a>

				</td>

				<td>

					<a class="view-btn"
						href="view-room-members?roomNo=<%=rs.getInt("room_no")%>">

						<i class="fa-solid fa-users"></i>
						View Members

					</a>

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
