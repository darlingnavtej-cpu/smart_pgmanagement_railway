<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("noticeData");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tenant Notice Board</title>

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

/* CONTAINER */
.container {
	width: min(95%, 1200px);
	margin: 30px auto;
}

/* PAGE TITLE */
.page-title {
	text-align: center;
	margin-bottom: 25px;
}

.page-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 8px;
}

.page-title p {
	color: var(--muted);
	font-size: 15px;
}

/* NOTICE GRID */
.notice-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 20px;
}

/* NOTICE CARD */
.notice-card {
	background: white;
	padding: 25px;
	border-radius: 22px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
	transition: .3s;
}

.notice-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 14px 30px rgba(0, 0, 0, .10);
}

.notice-head {
	display: flex;
	align-items: flex-start;
	gap: 12px;
	margin-bottom: 14px;
}

.notice-icon {
	width: 46px;
	height: 46px;
	border-radius: 14px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
	flex: 0 0 auto;
}

.notice-card h3 {
	color: #1e3a8a;
	font-size: 20px;
	line-height: 1.4;
}

.notice-card p {
	color: #334155;
	line-height: 1.8;
	font-size: 15px;
	white-space: pre-line;
}

.date {
	margin-top: 16px;
	padding-top: 12px;
	border-top: 1px solid var(--border);
	color: var(--muted);
	font-size: 13px;
	display: flex;
	align-items: center;
	gap: 8px;
}

/* EMPTY STATE */
.empty-state {
	background: white;
	padding: 35px 25px;
	border-radius: 22px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
	text-align: center;
	color: #dc2626;
	font-weight: 600;
	border: 1px solid #fecaca;
}

.empty-state i {
	font-size: 42px;
	margin-bottom: 12px;
	display: block;
}

/* BACK */
.back {
	text-align: center;
	margin-top: 30px;
}

.back a {
	text-decoration: none;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 12px 24px;
	border-radius: 12px;
	font-size: 16px;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: .3s;
}

.back a:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
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
		gap: 15px;
	}
	.logo {
		flex-direction: column;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.notice-card {
		padding: 20px;
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
	.page-title h2 {
		font-size: 22px;
	}
	.page-title p {
		font-size: 13px;
	}
	.notice-card h3 {
		font-size: 18px;
	}
	.notice-card p {
		font-size: 14px;
	}
	.back a {
		width: 100%;
		justify-content: center;
	}
}
</style>

</head>

<body>

	<header class="header">

		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-bullhorn"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant Notice Board</p>
				</div>

			</div>

			<a href="tenant-dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>

	</header>

	<div class="container">

		<div class="page-title">
			<h2>
				<i class="fa-solid fa-clipboard-list"></i> Notice Board
			</h2>
			<p>Latest announcements and updates for tenants</p>
		</div>

		<div class="notice-grid">

			<%
			boolean found = false;

			if (rs != null) {
				while (rs.next()) {
					found = true;
			%>

			<div class="notice-card">

				<div class="notice-head">
					<div class="notice-icon">
						<i class="fa-solid fa-circle-info"></i>
					</div>

					<h3><%=rs.getString("title")%></h3>
				</div>

				<p><%=rs.getString("description")%></p>

				<div class="date">
					<i class="fa-regular fa-calendar-days"></i> Posted On :
					<%=rs.getString("created_at")%>
				</div>

			</div>

			<%
			}
			}

			if (!found) {
			%>

			<div class="empty-state">
				<i class="fa-solid fa-bell-slash"></i> No Notices Available
			</div>

			<%
			}
			%>

		</div>

		<div class="back">
			<a href="tenant-dashboard"> <i class="fa-solid fa-arrow-left"></i>
				Back To Dashboard
			</a>
		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>