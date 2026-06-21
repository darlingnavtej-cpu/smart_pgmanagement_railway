<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String currentTenant = (String) session.getAttribute("current_tenant");
	if (currentTenant == null) {
		currentTenant = request.getParameter("tenant");
	}
	boolean hasTenant = (currentTenant != null && !currentTenant.trim().isEmpty() && !currentTenant.equalsIgnoreCase("admin"));
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Login</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>

:root{
	--primary:#4f46e5;
	--primary2:#6366f1;
	--bg:#f8fafc;
	--card:#ffffff;
	--text:#0f172a;
	--muted:#64748b;
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
	gap:15px;
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
	font-weight:bold;
}

.logo-text h1{
	font-size:24px;
}

.logo-text p{
	font-size:13px;
	opacity:.9;
}

.home-btn{
	text-decoration:none;
	color:white;
	background:rgba(255,255,255,.15);
	padding:10px 18px;
	border-radius:10px;
	font-weight:600;
	backdrop-filter:blur(10px);
}

.home-btn:hover{
	background:rgba(255,255,255,.25);
}

/* MAIN */

.main{
	flex:1;
	display:flex;
	align-items:center;
	justify-content:center;
	padding:30px 15px;
}

.login-card{

	width:100%;
	max-width:450px;

	background:rgba(255,255,255,.95);

	backdrop-filter:blur(20px);

	border:1px solid rgba(255,255,255,.3);

	border-radius:25px;

	padding:35px;

	box-shadow:
	0 20px 40px rgba(0,0,0,.08);

	animation:fadeUp .8s ease;
}

@keyframes fadeUp{

	from{
		opacity:0;
		transform:translateY(30px);
	}

	to{
		opacity:1;
		transform:translateY(0);
	}
}

.login-icon{

	width:80px;
	height:80px;

	border-radius:20px;

	margin:auto;

	display:flex;
	align-items:center;
	justify-content:center;

	background:
	linear-gradient(
	135deg,
	var(--primary),
	var(--primary2));

	color:white;

	font-size:32px;

	margin-bottom:20px;
}

.login-card h2{
	text-align:center;
	color:var(--text);
	margin-bottom:8px;
	font-size:28px;
}

.login-card p{
	text-align:center;
	color:var(--muted);
	margin-bottom:30px;
	font-size:14px;
}

/* INPUTS */

.form-group{
	margin-bottom:20px;
}

.form-group label{
	display:block;
	margin-bottom:8px;
	font-weight:600;
	color:#334155;
}

.input-box{
	position:relative;
}

.input-box i{

	position:absolute;

	left:15px;
	top:50%;

	transform:translateY(-50%);

	color:#64748b;
}

.input-box input{

	width:100%;

	padding:14px 14px 14px 45px;

	border:1px solid var(--border);

	border-radius:12px;

	font-size:15px;

	outline:none;

	transition:.3s;
}

.input-box input:focus{

	border-color:var(--primary);

	box-shadow:
	0 0 0 4px
	rgba(79,70,229,.12);
}

/* BUTTON */

.btn{

	width:100%;

	padding:14px;

	border:none;

	border-radius:14px;

	background:
	linear-gradient(
	135deg,
	var(--primary),
	var(--primary2));

	color:white;

	font-size:16px;

	font-weight:bold;

	cursor:pointer;

	transition:.3s;
}

.btn:hover{

	transform:translateY(-2px);

	box-shadow:
	0 10px 25px
	rgba(79,70,229,.25);
}

/* LINKS */

.links{

	text-align:center;

	margin-top:22px;

	line-height:2;
}

.links a{

	text-decoration:none;

	font-weight:600;

	color:#4f46e5;
}

.links a:hover{
	text-decoration:underline;
}

/* FEATURES */

.features{

	margin-top:25px;

	display:grid;

	grid-template-columns:
	repeat(2,1fr);

	gap:12px;
}

.feature{

	padding:12px;

	text-align:center;

	background:#f8fafc;

	border-radius:12px;

	font-size:13px;

	color:#475569;
}

.feature i{

	display:block;

	font-size:20px;

	color:#4f46e5;

	margin-bottom:8px;
}

/* FOOTER */

.footer{

	text-align:center;

	padding:20px;

	color:#64748b;

	font-size:14px;
}

/* MOBILE */

@media(max-width:768px){

	.header-inner{
		flex-direction:column;
		text-align:center;
	}

	.login-card{
		padding:25px;
	}

	.features{
		grid-template-columns:1fr;
	}

	.logo-text h1{
		font-size:20px;
	}
}

</style>

</head>

<body>

<header class="header">

	<div class="header-inner">

		<div class="logo">

			<div class="logo-icon">
				<i class="fa-solid fa-building"></i>
			</div>

			<div class="logo-text">

				<h1>SMART PG MANAGEMENT</h1>

				<p>Administrator Portal</p>

			</div>

		</div>

		<a href="index.jsp" class="home-btn">

			<i class="fa-solid fa-house"></i>

			Home

		</a>

	</div>

</header>

<div class="main">

	<div class="login-card">

		<div class="login-icon">

			<i class="fa-solid fa-user-shield"></i>

		</div>

		<h2>Admin Login</h2>

		<p>Login to access the Smart PG Management Dashboard</p>
		
		<% if (hasTenant) { %>
			<div style="background-color: #eef2ff; color: #4f46e5; padding: 10px; border-radius: 10px; text-align: center; margin-bottom: 20px; font-weight: 600; font-size: 14px;">
				<i class="fa-solid fa-circle-info"></i> Logging into PG Domain: <span style="text-transform: uppercase; color: #1e3a8a;"><%= currentTenant %></span>
			</div>
		<% } %>

		<form action="login" method="post">
			<% if (hasTenant) { %>
				<input type="hidden" name="tenant" value="<%= currentTenant %>">
			<% } else { %>
				<div class="form-group">
					<label>PG Subdomain / Code</label>
					<div class="input-box">
						<i class="fa-solid fa-building"></i>
						<input
							type="text"
							name="tenant"
							placeholder="Enter PG Subdomain (e.g., royal)"
							required>
					</div>
				</div>
			<% } %>

			<div class="form-group">

				<label>Username</label>

				<div class="input-box">

					<i class="fa-solid fa-user"></i>

					<input
						type="text"
						name="username"
						placeholder="Enter Username"
						required>

				</div>

			</div>

			<div class="form-group">

				<label>Password</label>

				<div class="input-box">

					<i class="fa-solid fa-lock"></i>

					<input
						type="password"
						name="password"
						id="password"
						placeholder="Enter Password"
						required>

				</div>

			</div>

			<button class="btn" type="submit">

				<i class="fa-solid fa-right-to-bracket"></i>

				 Login

			</button>

		</form>

		<div class="links">

			<a href="forgotPassword.jsp">

				Forgot Password?

			</a>

			<br>

			New User?

			<a href="register.jsp">

				Register Here

			</a>

		</div>

		<div class="features">

			<div class="feature">

				<i class="fa-solid fa-bed"></i>

				Room Management

			</div>

			<div class="feature">

				<i class="fa-solid fa-money-bill"></i>

				Rent Tracking

			</div>

			<div class="feature">

				<i class="fa-solid fa-users"></i>

				Tenant Records

			</div>

			<div class="feature">

				<i class="fa-solid fa-bullhorn"></i>

				Notices

			</div>

		</div>

	</div>

</div>

<div class="footer">

	Smart PG Management System © 2026

</div>

<script>

document.addEventListener(
	"DOMContentLoaded",
	function(){

		const password =
		document.getElementById("password");

		password.addEventListener(
			"focus",
			function(){

				this.style.transition=".3s";

			}
		);
	}
);

</script>

</body>
</html>