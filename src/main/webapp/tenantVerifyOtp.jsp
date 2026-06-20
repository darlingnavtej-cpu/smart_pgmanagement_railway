<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String msg = request.getParameter("msg");
String error = request.getParameter("error");
String email = (String) session.getAttribute("tenantResetEmail");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Verify Tenant OTP</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #1e3a8a;
	--secondary: #4f46e5;
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
	color: var(--text);
}

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

.container {
	width: min(95%, 900px);
	margin: 40px auto;
}

.card {
	background: white;
	padding: 35px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
}

.page-title {
	text-align: center;
	margin-bottom: 10px;
}

.page-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 8px;
}

.page-title p {
	color: var(--muted);
	font-size: 15px;
	line-height: 1.6;
	max-width: 720px;
	margin: 0 auto;
}

.form-group {
	margin-top: 25px;
}

.form-group label {
	display: block;
	font-weight: 600;
	color: #334155;
	margin-bottom: 8px;
}

.form-group input {
	width: 100%;
	padding: 14px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 18px;
	outline: none;
	transition: .3s;
	text-align: center;
	letter-spacing: 2px;
}

.form-group input:focus {
	border-color: #4f46e5;
	box-shadow: 0 0 0 4px rgba(79, 70, 229, .12);
}

.btn {
	width: 100%;
	margin-top: 22px;
	padding: 15px;
	border: none;
	border-radius: 14px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: .3s;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

.back-link {
	margin-top: 20px;
	text-align: center;
}

.back-link a {
	color: #1e3a8a;
	font-weight: 600;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.back-link a:hover {
	text-decoration: underline;
}

.info-box {
	margin-top: 22px;
	padding: 16px;
	border-radius: 12px;
	background: #eef2ff;
	color: #4338ca;
	text-align: center;
	font-size: 14px;
	line-height: 1.6;
}

.message {
	margin-top: 15px;
	padding: 12px 14px;
	border-radius: 12px;
	text-align: center;
	font-size: 14px;
	font-weight: 600;
}

.success {
	background: #dcfce7;
	color: #166534;
}

.error {
	background: #fee2e2;
	color: #991b1b;
}

.footer {
	margin-top: auto;
	background: #1e3a8a;
	color: white;
	text-align: center;
	padding: 18px;
}

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
	.page-title h2 {
		font-size: 24px;
	}
}

@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 22px auto;
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
	.card {
		padding: 20px;
		border-radius: 18px;
	}
	.page-title h2 {
		font-size: 22px;
	}
	.page-title p {
		font-size: 13px;
	}
	.form-group input {
		padding: 12px;
		font-size: 16px;
	}
	.btn {
		padding: 14px;
	}
}
</style>
</head>

<body>

	<header class="header">
		<div class="header-inner">
			<div class="logo">
				<div class="logo-icon">
					<i class="fa-solid fa-shield-halved"></i>
				</div>
				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant OTP Verification</p>
				</div>
			</div>
		</div>
	</header>

	<div class="container">
		<div class="card">

			<div class="page-title">
				<h2>
					<i class="fa-solid fa-key"></i> Verify OTP
				</h2>
				<p>An OTP has been sent to your registered email address. Please
					enter it below.</p>
			</div>

			<%
			if ("sent".equals(msg)) {
			%>
			<div class="message success">
				OTP sent successfully to
				<%=email%>.
			</div>
			<%
			}
			%>

			<%
			if ("expired".equals(error)) {
			%>
			<div class="message error">OTP expired. Please request a new
				one.</div>
			<%
			}
			%>

			<%
			if ("invalid".equals(error)) {
			%>
			<div class="message error">Invalid OTP. Please try again.</div>
			<%
			}
			%>

			<form action="tenant-verify-otp" method="post">

				<div class="form-group">
					<label>Enter OTP</label> <input type="text" name="otp"
						placeholder="Enter 6 digit OTP" maxlength="6" pattern="[0-9]{6}"
						inputmode="numeric" required>
				</div>

				<button type="submit" class="btn">
					<i class="fa-solid fa-circle-check"></i> Verify OTP
				</button>

			</form>

			<div class="info-box">
				<i class="fa-solid fa-circle-info"></i> <br> Enter the 6-digit
				OTP sent to your email. If you did not receive it, go back and
				request again.
			</div>

			<div class="back-link">
				<a href="tenantForgotPassword.jsp"> <i
					class="fa-solid fa-arrow-left"></i> Back
				</a>
			</div>

		</div>
	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>