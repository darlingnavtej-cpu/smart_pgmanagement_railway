<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("noticeData");

if (rs != null && rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Update Notice</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #1e3a8a;
	--secondary: #4f46e5;
	--bg: #f8fafc;
	--border: #e2e8f0;
	--text: #0f172a;
	--muted: #64748b;
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
	max-width: 1400px;
	margin: auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
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
	background: white;
	color: #1e3a8a;
	border-radius: 15px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
}

.logo-text h1 {
	font-size: 24px;
}

.logo-text p {
	font-size: 14px;
	margin-top: 4px;
	opacity: .9;
}

.dashboard-btn {
	text-decoration: none;
	color: white;
	padding: 10px 18px;
	border-radius: 10px;
	background: rgba(255, 255, 255, .15);
	transition: .3s;
}

.dashboard-btn:hover {
	background: rgba(255, 255, 255, .25);
}

/* CONTAINER */
.container {
	width: min(95%, 900px);
	margin: 35px auto;
}

/* FORM CARD */
.form-card {
	background: white;
	padding: 35px;
	border-radius: 25px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, .08);
}

.form-title {
	text-align: center;
	margin-bottom: 30px;
}

.form-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 8px;
}

.form-title p {
	color: #64748b;
}

/* FORM */
.form-group {
	margin-bottom: 22px;
}

.form-group label {
	display: block;
	font-weight: 600;
	color: #334155;
	margin-bottom: 8px;
}

.form-group input, .form-group textarea {
	width: 100%;
	padding: 14px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
}

.form-group input:focus, .form-group textarea:focus {
	border-color: #4f46e5;
	box-shadow: 0 0 0 4px rgba(79, 70, 229, .12);
}

.form-group textarea {
	min-height: 150px;
	resize: none;
}

/* BUTTON */
.submit-btn {
	width: 100%;
	padding: 15px;
	border: none;
	border-radius: 14px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: .3s;
}

.submit-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

/* ACTION BUTTONS */
.action-links {
	margin-top: 25px;
	display: flex;
	gap: 15px;
	flex-wrap: wrap;
}

.action-links a {
	flex: 1;
	text-align: center;
	text-decoration: none;
	padding: 13px;
	border-radius: 12px;
	font-weight: 600;
	transition: .3s;
}

.notice-btn {
	background: #eef2ff;
	color: #4338ca;
}

.notice-btn:hover {
	background: #dbe4ff;
}

.home-btn {
	background: #1e3a8a;
	color: white;
}

.home-btn:hover {
	background: #163172;
}

/* INFO BOX */
.info-box {
	margin-top: 25px;
	padding: 16px;
	border-radius: 12px;
	background: #eef2ff;
	color: #4338ca;
	text-align: center;
}

/* FOOTER */
.footer {
	margin-top: auto;
	background: #1e3a8a;
	color: white;
	text-align: center;
	padding: 18px;
}

/* TABLET */
@media ( max-width :768px) {
	.header-inner {
		flex-direction: column;
		text-align: center;
	}
	.logo {
		flex-direction: column;
	}
	.form-card {
		padding: 25px;
	}
	.form-title h2 {
		font-size: 24px;
	}
	.action-links {
		flex-direction: column;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 20px auto;
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
	.form-card {
		padding: 20px;
		border-radius: 18px;
	}
	.form-title h2 {
		font-size: 22px;
	}
	.form-group input, .form-group textarea {
		padding: 12px;
		font-size: 14px;
	}
}
</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-pen-to-square"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Notice Board Management</p>
				</div>

			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard

			</a>

		</div>

	</header>

	<div class="container">

		<div class="form-card">

			<div class="form-title">

				<h2>

					<i class="fa-solid fa-pen"></i> Update Notice

				</h2>

				<p>Edit and update notice information</p>

			</div>

			<form action="update-notice" method="post">

				<input type="hidden" name="noticeId" value="<%=rs.getInt(1)%>">

				<div class="form-group">

					<label> <i class="fa-solid fa-heading"></i> Notice Title
					</label> <input type="text" name="title" value="<%=rs.getString(2)%>"
						required>

				</div>

				<div class="form-group">

					<label> <i class="fa-solid fa-file-lines"></i> Notice
						Description
					</label>

					<textarea name="description" required><%=rs.getString(3)%></textarea>

				</div>

				<div class="form-group">

					<label> <i class="fa-solid fa-calendar-days"></i> Notice
						Date
					</label> <input type="date" name="noticeDate" value="<%=rs.getString(4)%>"
						required>

				</div>

				<button type="submit" class="submit-btn">

					<i class="fa-solid fa-floppy-disk"></i> Update Notice

				</button>

			</form>

			<div class="action-links">

				<a href="fetch-notices" class="notice-btn"> <i
					class="fa-solid fa-list"></i> Notice List

				</a> <a href="dashboard" class="home-btn"> <i
					class="fa-solid fa-house"></i> Dashboard

				</a>

			</div>

			<div class="info-box">

				<i class="fa-solid fa-circle-info"></i> Updated notice information
				will be visible immediately.

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>

<%
}
%>