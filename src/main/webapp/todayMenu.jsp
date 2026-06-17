<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("todayMenu");
String today = (String) request.getAttribute("today");
String role = (String) session.getAttribute("role");

if (today == null) {
	today = "Today";
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Today's Food Menu</title>

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
	width: min(95%, 1000px);
	margin: 30px auto;
}

/* CARD */
.card {
	background: white;
	padding: 28px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	border: 1px solid rgba(226, 232, 240, .8);
	animation: fadeUp .6s ease;
}

@
keyframes fadeUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
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

/* TODAY BOX */
.today-box {
	background: #eef2ff;
	border: 1px solid #dbe4ff;
	padding: 16px 18px;
	border-radius: 16px;
	text-align: center;
	font-size: 18px;
	font-weight: 700;
	color: #4338ca;
	margin-bottom: 25px;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
}

/* MENU GRID */
.menu-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
	gap: 18px;
}

/* MENU CARD */
.menu-box {
	background: white;
	border: 1px solid var(--border);
	border-radius: 20px;
	padding: 22px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .06);
	transition: .3s;
}

.menu-box:hover {
	transform: translateY(-4px);
	box-shadow: 0 14px 30px rgba(0, 0, 0, .1);
}

.menu-head {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 12px;
}

.menu-icon {
	width: 44px;
	height: 44px;
	border-radius: 14px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
	flex: 0 0 auto;
}

.menu-box h3 {
	color: #1e3a8a;
	font-size: 19px;
}

.menu-box p {
	font-size: 16px;
	color: #334155;
	line-height: 1.8;
	white-space: pre-line;
}

/* NO DATA */
.no-menu {
	text-align: center;
	padding: 30px 20px;
	background: #fff1f2;
	border: 1px solid #fecdd3;
	color: #dc2626;
	border-radius: 18px;
	font-weight: 700;
}

/* LINKS */
.links {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-wrap: wrap;
	gap: 12px;
	margin-top: 28px;
}

.links a {
	text-decoration: none;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 12px 22px;
	border-radius: 12px;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: .3s;
}

.links a:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .22);
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
	.card {
		padding: 22px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.today-box {
		font-size: 16px;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 20px auto;
	}
	.card {
		padding: 16px;
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
	.page-title h2 {
		font-size: 22px;
	}
	.page-title p {
		font-size: 13px;
	}
	.today-box {
		font-size: 15px;
		padding: 14px;
	}
	.menu-box {
		padding: 18px;
	}
	.menu-box h3 {
		font-size: 17px;
	}
	.menu-box p {
		font-size: 15px;
	}
	.links {
		flex-direction: column;
	}
	.links a {
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
					<i class="fa-solid fa-utensils"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Today's Food Menu</p>
				</div>

			</div>

			<%
			if ("admin".equals(role)) {
			%>
			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>
			<%
			} else {
			%>
			<a href="tenant-dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>
			<%
			}
			%>

		</div>

	</header>

	<div class="container">

		<div class="card">

			<div class="page-title">
				<h2>
					<i class="fa-solid fa-bowl-food"></i> Today's Menu
				</h2>
				<p>See what is served today in the PG mess</p>
			</div>

			<div class="today-box">
				<i class="fa-solid fa-calendar-day"></i>
				<div>
					Today :
					<%=today%></div>
			</div>

			<div class="menu-grid">

				<%
				if (rs != null && rs.next()) {
				%>

				<div class="menu-box">
					<div class="menu-head">
						<div class="menu-icon">
							<i class="fa-solid fa-sun"></i>
						</div>
						<h3>Breakfast</h3>
					</div>
					<p><%=rs.getString("breakfast")%></p>
				</div>

				<div class="menu-box">
					<div class="menu-head">
						<div class="menu-icon">
							<i class="fa-solid fa-carrot"></i>
						</div>
						<h3>Lunch</h3>
					</div>
					<p><%=rs.getString("lunch")%></p>
				</div>

				<div class="menu-box">
					<div class="menu-head">
						<div class="menu-icon">
							<i class="fa-solid fa-cookie-bite"></i>
						</div>
						<h3>Snacks</h3>
					</div>
					<p><%=rs.getString("snacks")%></p>
				</div>

				<div class="menu-box">
					<div class="menu-head">
						<div class="menu-icon">
							<i class="fa-solid fa-moon"></i>
						</div>
						<h3>Dinner</h3>
					</div>
					<p><%=rs.getString("dinner")%></p>
				</div>

				<%
				} else {
				%>

				<div class="no-menu">
					<i class="fa-solid fa-circle-info"></i> <br>
					<br> Menu Not Available
				</div>

				<%
				}
				%>

			</div>

			<div class="links">

				<a href="fetch-weekly-menu"> <i
					class="fa-solid fa-calendar-week"></i> Weekly Menu
				</a>

				<%
				if ("admin".equals(role)) {
				%>
				<a href="dashboard"> <i class="fa-solid fa-house"></i> Dashboard
				</a>
				<%
				} else {
				%>
				<a href="tenant-dashboard"> <i class="fa-solid fa-house"></i>
					Dashboard
				</a>
				<%
				}
				%>

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>