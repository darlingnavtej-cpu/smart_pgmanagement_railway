<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.ResultSet"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("activityResultSet");
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1.0">

<title>Activity Log</title>

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

	background:linear-gradient(
	135deg,
	#1e3a8a,
	#4f46e5
	);

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

	width:min(95%,1100px);
	margin:35px auto;

}

/* CARD */

.activity-card{

	background:white;
	padding:35px;
	border-radius:25px;
	box-shadow:0 20px 40px rgba(0,0,0,.08);

}

.card-title{

	text-align:center;
	margin-bottom:35px;

}

.card-title h2{

	color:#1e3a8a;
	font-size:30px;
	margin-bottom:10px;

}

.card-title p{

	color:#64748b;

}

/* TIMELINE */

.timeline{

	position:relative;
	border-left:4px solid #4f46e5;
	padding-left:35px;

}

.activity{

	position:relative;
	background:#f8faff;
	padding:18px;
	border-radius:15px;
	margin-bottom:25px;
	transition:.3s;

}

.activity:hover{

	transform:translateX(5px);
	box-shadow:0 10px 25px rgba(79,70,229,.12);

}

.activity::before{

	content:"";
	position:absolute;
	left:-46px;
	top:22px;
	width:18px;
	height:18px;
	border-radius:50%;
	background:#4f46e5;
	border:4px solid white;
	box-shadow:0 0 0 3px #4f46e5;

}

.time{

	font-size:13px;
	color:#64748b;
	margin-bottom:8px;

}

.message{

	font-size:16px;
	font-weight:600;
	color:#334155;
	line-height:1.5;

}

.empty-box{

	text-align:center;
	padding:50px 20px;
	color:#64748b;

}

.empty-box i{

	font-size:60px;
	color:#cbd5e1;
	margin-bottom:15px;

}

.empty-box h3{

	color:#334155;
	margin-bottom:10px;

}
/* BACK BUTTON */

.back{

	text-align:center;
	margin-top:30px;

}

.back a{

	text-decoration:none;
	padding:12px 24px;
	border-radius:10px;
	color:white;
	font-weight:600;

	background:linear-gradient(
	135deg,
	#4f46e5,
	#6366f1
	);

	transition:.3s;

}

.back a:hover{

	transform:translateY(-2px);

	box-shadow:0 10px 25px rgba(79,70,229,.25);

}

/* FOOTER */

.footer{

	margin-top:auto;
	text-align:center;
	padding:20px;
	color:#64748b;

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

				<p>System Activity Log</p>

			</div>

		</div>

		<a href="dashboard" class="dashboard-btn">

			<i class="fa-solid fa-house"></i>

			Dashboard

		</a>

	</div>

</header>

<div class="container">

	<div class="activity-card">

		<div class="card-title">

			<h2>

				<i class="fa-solid fa-timeline"></i>

				Activity Timeline

			</h2>

			<p>

				View recent activities performed in the Smart PG Management System

			</p>

		</div>

		<div class="timeline">

		<%

		boolean found = false;

		if(rs != null){

			while(rs.next()){

				found = true;

		%>

			<div class="activity">

				<div class="time">

					<i class="fa-solid fa-clock"></i>

					<%=rs.getTimestamp("activity_time")%>

				</div>

				<div class="message">

					<%=rs.getString("activity_text")%>

				</div>

			</div>

		<%

			}

		}

		if(!found){

		%>

			<div class="empty-box">

				<i class="fa-solid fa-inbox"></i>

				<h3>No Activities Found</h3>

				<p>

					No recent system activities available.

				</p>

			</div>

		<%

		}

		%>

		</div>

	</div>

	<div class="back">

		<a href="dashboard">

			<i class="fa-solid fa-arrow-left"></i>

			Back To Dashboard

		</a>

	</div>

</div>
<!-- RESPONSIVE DESIGN -->

<style>

@media(max-width:768px){

	.header-inner{

		flex-direction:column;
		text-align:center;
		gap:15px;

	}

	.container{

		width:95%;

	}

	.activity-card{

		padding:22px;

	}

	.card-title h2{

		font-size:24px;

	}

	.timeline{

		padding-left:25px;

	}

	.activity::before{

		left:-36px;

	}

	.message{

		font-size:15px;

	}

}

@media(max-width:480px){

	.logo{

		flex-direction:column;

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

	.card-title h2{

		font-size:22px;

	}

	.card-title p{

		font-size:13px;

	}

	.activity{

		padding:14px;

	}

	.activity::before{

		width:14px;
		height:14px;
		left:-31px;

	}

	.time{

		font-size:12px;

	}

	.message{

		font-size:14px;
		line-height:1.6;

	}

	.dashboard-btn{

		width:100%;
		text-align:center;

	}

	.back a{

		display:block;
		width:100%;

	}

}

</style>

<div class="footer">

	Smart PG Management System © 2026

</div>

</body>

</html>
