<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Update Room</title>

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
	width:min(95%,900px);
	margin:35px auto;
}

/* CARD */

.form-card{
	background:white;
	padding:35px;
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

.form-title{
	text-align:center;
	margin-bottom:30px;
}

.form-title h2{
	color:#1e3a8a;
	font-size:30px;
	margin-bottom:10px;
}

.form-title p{
	color:#64748b;
}

/* FORM */

.form-grid{
	display:grid;
	grid-template-columns:repeat(2,1fr);
	gap:20px;
}

.form-group{
	display:flex;
	flex-direction:column;
}

.form-group label{
	font-weight:600;
	margin-bottom:8px;
	color:#334155;
}

.form-group input{
	width:100%;
	padding:14px;
	border:1px solid var(--border);
	border-radius:12px;
	font-size:15px;
	outline:none;
	transition:.3s;
}

.form-group input:focus{
	border-color:#4f46e5;
	box-shadow:0 0 0 4px rgba(79,70,229,.12);
}

.readonly{
	background:#f8faff;
}

.btn-box{
	margin-top:25px;
}

.btn{
	width:100%;
	padding:15px;
	border:none;
	border-radius:14px;
	font-size:16px;
	font-weight:600;
	cursor:pointer;
	color:white;
	background:linear-gradient(135deg,#4f46e5,#6366f1);
	transition:.3s;
}

.btn:hover{
	transform:translateY(-2px);
	box-shadow:0 10px 25px rgba(79,70,229,.25);
}

.info{
	margin-top:25px;
	padding:15px;
	background:#eef2ff;
	border-radius:12px;
	text-align:center;
	color:#4338ca;
}

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
		text-align:center;
		gap:15px;
	}

	.back-btn{
		width:100%;
		max-width:250px;
		text-align:center;
	}

	.form-grid{
		grid-template-columns:1fr;
	}

	.form-card{
		padding:22px;
	}

	.logo-text h1{
		font-size:20px;
	}

	.form-title h2{
		font-size:24px;
	}
}

@media(max-width:480px){

	.container{
		width:95%;
		margin:20px auto;
	}

	.form-card{
		padding:18px;
		border-radius:18px;
	}

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

	.form-title h2{
		font-size:22px;
	}

	.form-group input{
		padding:12px;
		font-size:14px;
	}

	.btn{
		padding:14px;
		font-size:15px;
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

		<a href="fetch-rooms" class="back-btn">
			<i class="fa-solid fa-arrow-left"></i>
			Room Records
		</a>

	</div>

</header>

<%
ResultSet rs = (ResultSet) request.getAttribute("resultSet");

if(rs == null){
%>

<div class="container">
	<div class="form-card">
		<h2 style="text-align:center;color:red;">No Room Data Available</h2>
	</div>
</div>

<%
	return;
}

if(!rs.next()){
%>

<div class="container">
	<div class="form-card">
		<h2 style="text-align:center;color:red;">Room Not Found</h2>
	</div>
</div>

<%
	return;
}
%>

<div class="container">

	<div class="form-card">

		<div class="form-title">

			<h2>
				<i class="fa-solid fa-pen-to-square"></i>
				Update Room Details
			</h2>

			<p>Modify room capacity, occupancy and rent information</p>

		</div>

		<form action="update-room" method="post">

			<div class="form-grid">

				<div class="form-group">

					<label>Room Number</label>

					<input type="number"
						class="readonly"
						name="roomNo"
						value="<%=rs.getInt("room_no")%>"
						readonly>

				</div>

				<div class="form-group">

					<label>Capacity</label>

					<input type="number"
						name="capacity"
						value="<%=rs.getInt("capacity")%>"
						required>

				</div>

				<div class="form-group">

					<label>Occupied</label>

					<input type="number"
						name="occupied"
						value="<%=rs.getInt("occupied")%>"
						required>

				</div>

				<div class="form-group">

					<label>Rent (₹)</label>

					<input type="number"
						name="rent"
						value="<%=rs.getInt("rent")%>"
						required>

				</div>

			</div>

			<div class="btn-box">

				<button type="submit" class="btn">

					<i class="fa-solid fa-floppy-disk"></i>
					Update Room

				</button>

			</div>

		</form>

		<div class="info">

			<i class="fa-solid fa-circle-info"></i>

			Room updates will be reflected immediately in the system.

		</div>

	</div>

</div>

<div class="footer">
	Smart PG Management System © 2026
</div>

</body>
</html>