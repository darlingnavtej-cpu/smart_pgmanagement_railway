<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tenant Login</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #4f46e5;
	--primary2: #6366f1;
	--tenant: #22c55e;
	--tenant2: #16a34a;
	--bg: #f8fafc;
	--card: #ffffff;
	--text: #0f172a;
	--muted: #64748b;
	--border: #e2e8f0;
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

/* HEADER */
.header {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 20px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, .15);
}

.header-inner {
	max-width: 1200px;
	margin: auto;
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
	gap: 15px;
}

.logo {
	display: flex;
	align-items: center;
	gap: 12px;
}

.logo-icon {
	width: 50px;
	height: 50px;
	border-radius: 15px;
	background: white;
	color: #1e3a8a;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 22px;
	font-weight: bold;
}

.logo-text h1 {
	font-size: 24px;
}

.logo-text p {
	font-size: 13px;
	opacity: .9;
}

.home-btn {
	text-decoration: none;
	color: white;
	background: rgba(255, 255, 255, .15);
	padding: 10px 18px;
	border-radius: 10px;
	font-weight: 600;
	backdrop-filter: blur(10px);
}

.home-btn:hover {
	background: rgba(255, 255, 255, .25);
}

/* MAIN */
.main {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 30px 15px;
}

/* CARD */
.login-card {
	width: 100%;
	max-width: 450px;
	background: rgba(255, 255, 255, .96);
	backdrop-filter: blur(20px);
	border: 1px solid rgba(255, 255, 255, .3);
	border-radius: 25px;
	padding: 35px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	animation: fadeUp .8s ease;
}

@
keyframes fadeUp {from { opacity:0;
	transform: translateY(30px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.login-icon {
	width: 80px;
	height: 80px;
	border-radius: 20px;
	margin: auto;
	display: flex;
	align-items: center;
	justify-content: center;
	background: linear-gradient(135deg, var(--tenant), var(--tenant2));
	color: white;
	font-size: 32px;
	margin-bottom: 20px;
}

.login-card h2 {
	text-align: center;
	color: var(--text);
	margin-bottom: 8px;
	font-size: 28px;
}

.login-card p {
	text-align: center;
	color: var(--muted);
	margin-bottom: 30px;
	font-size: 14px;
}

/* INPUTS */
.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: #334155;
}

.input-box {
	position: relative;
}

.input-box i {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: #64748b;
}

.input-box input {
	width: 100%;
	padding: 14px 14px 14px 45px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
}

.input-box input:focus {
	border-color: var(--tenant);
	box-shadow: 0 0 0 4px rgba(34, 197, 94, .15);
}

/* BUTTON */
.btn {
	width: 100%;
	padding: 14px;
	border: none;
	border-radius: 14px;
	background: linear-gradient(135deg, var(--tenant), var(--tenant2));
	color: white;
	font-size: 16px;
	font-weight: bold;
	cursor: pointer;
	transition: .3s;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(34, 197, 94, .25);
}

/* INFO CARD */
.info-card {
	margin-top: 22px;
	background: #f0fdf4;
	border: 1px solid #bbf7d0;
	padding: 15px;
	border-radius: 14px;
	text-align: center;
}

.info-card i {
	font-size: 22px;
	color: var(--tenant);
	margin-bottom: 10px;
}

.info-card p {
	margin: 0;
	color: #166534;
	font-size: 14px;
	line-height: 1.6;
}

/* FORGOT LINK */
.back-link {
	margin-top: 15px;
	text-align: center;
}

.back-link a {
	text-decoration: none;
	color: #1e3a8a;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.back-link a:hover {
	text-decoration: underline;
}

/* FEATURES */
.features {
	margin-top: 25px;
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 12px;
}

.feature {
	padding: 12px;
	text-align: center;
	background: #f8fafc;
	border-radius: 12px;
	font-size: 13px;
	color: #475569;
}

.feature i {
	display: block;
	font-size: 20px;
	color: var(--tenant);
	margin-bottom: 8px;
}

/* FOOTER */
.footer {
	text-align: center;
	padding: 20px;
	color: #64748b;
	font-size: 14px;
}

/* MOBILE */
@media ( max-width :768px) {
	.header-inner {
		flex-direction: column;
		text-align: center;
	}
	.login-card {
		padding: 25px;
	}
	.features {
		grid-template-columns: 1fr;
	}
	.logo-text h1 {
		font-size: 20px;
	}
}

@media ( max-width :480px) {
	.login-card {
		padding: 20px;
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
	.login-card h2 {
		font-size: 24px;
	}
	.login-card p {
		font-size: 13px;
	}
	.input-box input {
		padding: 12px 12px 12px 42px;
	}
}
</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">

					<i class="fa-solid fa-house-user"></i>

				</div>

				<div class="logo-text">

					<h1>SMART PG MANAGEMENT</h1>

					<p>Tenant Portal</p>

				</div>

			</div>

			<a href="index.jsp" class="home-btn"> <i
				class="fa-solid fa-house"></i> Home

			</a>

		</div>

	</header>

	<div class="main">

		<div class="login-card">

			<div class="login-icon">

				<i class="fa-solid fa-user-graduate"></i>

			</div>

			<h2>Tenant Login</h2>

			<p>Access your room, rent, notices and complaint services</p>

			<form action="tenant-login" method="post">

				<div class="form-group">

					<label>Email Address</label>

					<div class="input-box">

						<i class="fa-solid fa-envelope"></i> <input type="email"
							name="email" placeholder="Enter Email Address" required>

					</div>

				</div>

				<div class="form-group">

					<label>Password</label>

					<div class="input-box">

						<i class="fa-solid fa-lock"></i> <input type="password"
							name="password" id="password" placeholder="Enter Password"
							required>

					</div>

				</div>

				<button class="btn" type="submit">

					<i class="fa-solid fa-right-to-bracket"></i> Login

				</button>

			</form>

			<div class="back-link">
				<a href="tenantForgotPassword.jsp"> Forgot Password? </a>
			</div>

			<div class="info-card">

				<i class="fa-solid fa-circle-info"></i>

				<p>
					Default Password : <b>Last 4 digits of your mobile number</b>
				</p>

			</div>

			<div class="features">

				<div class="feature">
					<i class="fa-solid fa-credit-card"></i> Rent Payment
				</div>

				<div class="feature">
					<i class="fa-solid fa-clock-rotate-left"></i> Payment History
				</div>

				<div class="feature">
					<i class="fa-solid fa-bullhorn"></i> Notice Board
				</div>

				<div class="feature">
					<i class="fa-solid fa-comments"></i> Complaints
				</div>

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

	<script>
		document.addEventListener("DOMContentLoaded", function() {

			const password = document.getElementById("password");

			password.addEventListener("focus", function() {

				this.style.transition = ".3s";
			});
		});
	</script>

</body>
</html>