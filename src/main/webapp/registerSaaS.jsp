<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">
<meta charset="UTF-8">
<title>SaaS Onboarding - Register New PG Owner</title>
<style>
*{
	margin:0;
	padding:0;
	box-sizing:border-box;
	font-family:Segoe UI,sans-serif;
}
body{
	background:#f4f7fc;
}
.header{
	background:#1e3a8a;
	color:white;
	text-align:center;
	padding:25px;
	box-shadow:0 3px 10px rgba(0,0,0,0.2);
}
.header h1{
	font-size:34px;
}
.header p{
	margin-top:8px;
	font-size:15px;
}
.container{
	width:480px;
	background:white;
	margin:40px auto;
	padding:35px;
	border-radius:15px;
	box-shadow:0px 4px 15px rgba(0,0,0,0.1);
}
.container h2{
	text-align:center;
	color:#1e3a8a;
	margin-bottom:25px;
}
.form-group{
	margin-bottom:15px;
}
.form-group label{
	display:block;
	font-weight:600;
	margin-bottom:6px;
	color:#333;
}
.form-group input{
	width:100%;
	padding:10px 12px;
	border:1px solid #ccc;
	border-radius:8px;
	font-size:15px;
	outline:none;
	transition:0.3s;
}
.form-group input:focus{
	border-color:#1e3a8a;
	box-shadow:0 0 5px rgba(30,58,138,0.3);
}
.help-text {
	font-size: 12px;
	color: #666;
	margin-top: 4px;
}
.btn{
	width:100%;
	padding:12px;
	background:#1e3a8a;
	color:white;
	border:none;
	border-radius:8px;
	font-size:16px;
	cursor:pointer;
	transition:0.3s;
	margin-top: 10px;
}
.btn:hover{
	background:#163172;
}
.back-link{
	margin-top:20px;
	text-align:center;
	font-size:15px;
}
.back-link a{
	color:#1e3a8a;
	font-weight:bold;
	text-decoration:none;
}
.back-link a:hover{
	text-decoration:underline;
}
</style>
</head>
<body>

	<div class="header">
		<h1>SMART PG SAAS PLATFORM</h1>
		<p>PG Owner (Tenant) Registration & Provisioning Portal</p>
	</div>

	<div class="container">
		<h2>Register New PG Owner</h2>
		<form action="register-tenant" method="post">
			<div class="form-group">
				<label for="subdomain">Subdomain (PG Code)</label>
				<input type="text" id="subdomain" name="subdomain" placeholder="e.g. royal, green-valley" required pattern="^[a-zA-Z0-9\-]+$">
				<p class="help-text">Only letters, numbers, and hyphens. Determines your portal URL.</p>
			</div>

			<div class="form-group">
				<label for="pgName">PG Hostel Name</label>
				<input type="text" id="pgName" name="pgName" placeholder="e.g. Royal PG Guest House" required>
			</div>

			<div class="form-group">
				<label for="ownerName">Owner Full Name</label>
				<input type="text" id="ownerName" name="ownerName" placeholder="Enter Owner Name" required>
			</div>

			<div class="form-group">
				<label for="email">Admin Email Address</label>
				<input type="email" id="email" name="email" placeholder="e.g. owner@gmail.com" required>
			</div>

			<div class="form-group">
				<label for="password">Admin Password</label>
				<input type="password" id="password" name="password" placeholder="Create Admin Password" required>
			</div>

			<input type="submit" value="Provision Tenant Database" class="btn">
		</form>
		<div class="back-link">
			<a href="login.jsp">Back to Login</a>
		</div>
	</div>

</body>
</html>
