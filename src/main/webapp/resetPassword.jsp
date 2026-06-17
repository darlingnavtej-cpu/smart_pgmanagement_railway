<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>

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

/* HEADER */

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

/* FORM */

.container{
	width:420px;
	background:white;
	margin:70px auto;
	padding:35px;
	border-radius:15px;
	box-shadow:0px 4px 15px rgba(0,0,0,0.1);
}

.container h2{
	text-align:center;
	color:#1e3a8a;
	margin-bottom:15px;
}

.container p{
	text-align:center;
	color:#555;
	margin-bottom:25px;
	font-size:14px;
}

.form-group{
	margin-bottom:20px;
}

.form-group label{
	display:block;
	font-weight:600;
	margin-bottom:8px;
	color:#333;
}

.form-group input{
	width:100%;
	padding:12px;
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
}

.btn:hover{
	background:#163172;
}

.back-link{
	margin-top:20px;
	text-align:center;
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
		<h1>SMART PG MANAGEMENT SYSTEM</h1>
		<p>Reset Your Password</p>
	</div>

	<div class="container">

		<h2>Create New Password</h2>

		<p>
			Enter your new password below.
		</p>

		<form action="reset-password" method="post">

			<div class="form-group">

				<label>New Password</label>

				<input
					type="password"
					name="password"
					placeholder="Enter New Password"
					required>

			</div>

			<div class="form-group">

				<label>Confirm Password</label>

				<input
					type="password"
					name="confirmPassword"
					placeholder="Confirm Password"
					required>

			</div>

			<input
				type="submit"
				value="Update Password"
				class="btn">

		</form>

		<div class="back-link">

			<a href="login.jsp">
				← Back to Login
			</a>

		</div>

	</div>

</body>
</html>