<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Integer tenantId = (Integer) session.getAttribute("tenantId");

if (tenantId == null) {
	response.sendRedirect("tenantLogin.jsp");
	return;
}

String msg = request.getParameter("msg");
String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Change Password</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #1e3a8a;
	--secondary: #4f46e5;
	--tenant: #22c55e;
	--tenant2: #16a34a;
	--bg: #f8fafc;
	--card: #ffffff;
	--text: #0f172a;
	--muted: #64748b;
	--border: #e2e8f0;
	--danger: #dc2626;
	--success: #16a34a;
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
	color: var(--text);
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
	width: 55px;
	height: 55px;
	border-radius: 15px;
	background: white;
	color: #1e3a8a;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	flex: 0 0 auto;
}

.logo-text h1 {
	font-size: 24px;
	line-height: 1.2;
}

.logo-text p {
	font-size: 13px;
	opacity: .9;
	margin-top: 4px;
}

.dashboard-btn {
	text-decoration: none;
	color: white;
	padding: 10px 18px;
	border-radius: 10px;
	background: rgba(255, 255, 255, .15);
	transition: .3s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.dashboard-btn:hover {
	background: rgba(255, 255, 255, .25);
	transform: translateY(-1px);
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
.card {
	width: 100%;
	max-width: 500px;
	background: white;
	border-radius: 25px;
	padding: 35px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
	animation: fadeUp .7s ease;
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
.icon-box {
	width: 80px;
	height: 80px;
	margin: auto;
	border-radius: 22px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: linear-gradient(135deg, var(--tenant), var(--tenant2));
	color: white;
	font-size: 32px;
	margin-bottom: 18px;
	box-shadow: 0 10px 25px rgba(34, 197, 94, .20);
}

.page-title {
	text-align: center;
	margin-bottom: 8px;
	color: #1e3a8a;
	font-size: 28px;
}

.page-subtitle {
	text-align: center;
	color: var(--muted);
	margin-bottom: 24px;
	font-size: 14px;
	line-height: 1.6;
}

/* MESSAGES */
.message {
	padding: 12px 14px;
	border-radius: 12px;
	margin-bottom: 18px;
	font-size: 14px;
	font-weight: 600;
	text-align: center;
}

.success {
	background: #dcfce7;
	color: #166534;
	border: 1px solid #bbf7d0;
}

.error {
	background: #fee2e2;
	color: #991b1b;
	border: 1px solid #fecaca;
}

/* FORM */
.form-group {
	margin-bottom: 18px;
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
	background: white;
}

.input-box input:focus {
	border-color: var(--tenant);
	box-shadow: 0 0 0 4px rgba(34, 197, 94, .15);
}

.btn {
	width: 100%;
	padding: 14px;
	border: none;
	border-radius: 14px;
	background: linear-gradient(135deg, var(--tenant), var(--tenant2));
	color: white;
	font-size: 16px;
	font-weight: 700;
	cursor: pointer;
	transition: .3s;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(34, 197, 94, .25);
}

/* BACK */
.back {
	text-align: center;
	margin-top: 20px;
}

.back a {
	text-decoration: none;
	color: #1e3a8a;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.back a:hover {
	text-decoration: underline;
}

/* INFO */
.info-box {
	margin-top: 22px;
	background: #f0fdf4;
	border: 1px solid #bbf7d0;
	padding: 15px;
	border-radius: 14px;
	text-align: center;
}

.info-box i {
	font-size: 22px;
	color: var(--tenant);
	margin-bottom: 10px;
}

.info-box p {
	margin: 0;
	color: #166534;
	font-size: 14px;
	line-height: 1.6;
}

/* FOOTER */
.footer {
	text-align: center;
	padding: 20px;
	color: var(--muted);
	font-size: 14px;
}

/* MOBILE */
@media ( max-width :768px) {
	.header-inner {
		flex-direction: column;
		text-align: center;
		gap: 15px;
	}
	.logo {
		flex-direction: column;
	}
	.card {
		padding: 25px;
	}
	.page-title {
		font-size: 24px;
	}
}

@media ( max-width :480px) {
	.card {
		padding: 20px;
		border-radius: 18px;
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
	.page-title {
		font-size: 22px;
	}
	.page-subtitle {
		font-size: 13px;
	}
	.input-box input {
		padding: 12px 12px 12px 42px;
	}
	.btn {
		padding: 13px;
	}
}
</style>

</head>

<body>

	<header class="header">
		<div class="header-inner">

			<div class="logo">
				<div class="logo-icon">
					<i class="fa-solid fa-lock"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant Password Management</p>
				</div>
			</div>

			<a href="tenant-dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>
	</header>

	<div class="main">
		<div class="card">

			<div class="icon-box">
				<i class="fa-solid fa-key"></i>
			</div>

			<div class="page-title">Change Password</div>

			<div class="page-subtitle">Update your tenant password securely
				from here.</div>

			<%
			if ("success".equals(msg)) {
			%>
			<div class="message success">Password updated successfully.</div>
			<%
			}
			%>

			<%
			if ("nomatch".equals(error)) {
			%>
			<div class="message error">New password and confirm password do
				not match.</div>
			<%
			}
			%>

			<%
			if ("wrongold".equals(error)) {
			%>
			<div class="message error">Current password is incorrect.</div>
			<%
			}
			%>

			<form action="change-password" method="post">

				<div class="form-group">
					<label>Current Password</label>
					<div class="input-box">
						<i class="fa-solid fa-lock"></i> <input type="password"
							name="oldPassword" placeholder="Enter current password" required>
					</div>
				</div>

				<div class="form-group">
					<label>New Password</label>
					<div class="input-box">
						<i class="fa-solid fa-lock-open"></i> <input type="password"
							name="newPassword" placeholder="Enter new password" required>
					</div>
				</div>

				<div class="form-group">
					<label>Confirm Password</label>
					<div class="input-box">
						<i class="fa-solid fa-check"></i> <input type="password"
							name="confirmPassword" placeholder="Confirm new password"
							required>
					</div>
				</div>

				<button type="submit" class="btn">
					<i class="fa-solid fa-floppy-disk"></i> Update Password
				</button>

			</form>

			<div class="info-box">
				<i class="fa-solid fa-circle-info"></i>
				<p>Use a strong password that you can remember. After updating,
					you can log in with your new password immediately.</p>
			</div>

			<div class="back">
				<a href="tenant-dashboard"> <i class="fa-solid fa-arrow-left"></i>
					Back To Dashboard
				</a>
			</div>

		</div>
	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>