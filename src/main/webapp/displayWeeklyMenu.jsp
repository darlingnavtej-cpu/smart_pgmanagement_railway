<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("menuList");

String role = (String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Weekly Food Menu</title>

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
	--success: #16a34a;
	--success-dark: #15803d;
	--danger: #dc2626;
	--danger-dark: #b91c1c;
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
	max-width: 1300px;
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
	display: flex;
	align-items: center;
	gap: 8px;
}

.dashboard-btn:hover {
	background: rgba(255, 255, 255, .25);
	transform: translateY(-1px);
}

/* CONTAINER */
.container {
	width: min(95%, 1300px);
	margin: 35px auto;
}

/* CARD */
.card {
	background: white;
	padding: 30px;
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
	font-size: 30px;
	color: #1e3a8a;
	margin-bottom: 8px;
}

.page-title p {
	color: var(--muted);
	font-size: 15px;
}

/* TOP BUTTONS */
.top-buttons {
	display: flex;
	justify-content: flex-end;
	flex-wrap: wrap;
	gap: 12px;
	margin-bottom: 25px;
}

.top-buttons a {
	text-decoration: none;
	padding: 12px 18px;
	border-radius: 12px;
	font-weight: 600;
	transition: .3s;
	display: flex;
	align-items: center;
	gap: 8px;
}

.add-btn {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
}

.add-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

.home-btn {
	background: #eef2ff;
	color: #1e3a8a;
	border: 1px solid #c7d2fe;
}

.home-btn:hover {
	background: #dbeafe;
}

/* TABLE */
.table-wrapper {
	width: 100%;
	overflow-x: auto;
	border-radius: 18px;
	border: 1px solid var(--border);
}

table {
	width: 100%;
	min-width: 1000px;
	border-collapse: collapse;
}

th {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 15px;
	white-space: nowrap;
}

td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
	white-space: nowrap;
}

tr:hover {
	background: #f8faff;
}

/* ACTION BUTTONS */
.btn {
	padding: 9px 15px;
	border-radius: 8px;
	text-decoration: none;
	color: white;
	font-size: 14px;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 6px;
	transition: .3s;
}

.update {
	background: var(--success);
}

.update:hover {
	background: var(--success-dark);
}

.delete {
	background: var(--danger);
}

.delete:hover {
	background: var(--danger-dark);
}

.no-data {
	padding: 25px;
	text-align: center;
	font-weight: 700;
	color: #dc2626;
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
	.card {
		padding: 20px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.top-buttons {
		justify-content: center;
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
	.page-title h2 {
		font-size: 22px;
	}
	.top-buttons {
		flex-direction: column;
	}
	.top-buttons a {
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

					<p>Weekly Food Menu Management</p>

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

					<i class="fa-solid fa-calendar-week"></i> Weekly Food Schedule

				</h2>

				<p>View and Manage Weekly Food Menu</p>

			</div>

			<div class="top-buttons">

				<%
				if ("admin".equals(role)) {
				%>

				<a href="addWeeklyMenu.jsp" class="add-btn"> <i
					class="fa-solid fa-plus"></i> Add Menu

				</a>

				<%
				}
				%>

			</div>

			<div class="table-wrapper">

				<table>

					<tr>

						<th>ID</th>

						<th>Day</th>

						<th>Breakfast</th>

						<th>Lunch</th>

						<th>Snacks</th>

						<th>Dinner</th>

						<%
						if ("admin".equals(role)) {
						%>

						<th>Update</th>

						<th>Delete</th>

						<%
						}
						%>

					</tr>

					<%
					boolean found = false;

					if (rs != null) {

						while (rs.next()) {

							found = true;
					%>

					<tr>

						<td><%=rs.getInt(1)%></td>

						<td><b> <%=rs.getString(2)%>

						</b></td>

						<td><%=rs.getString(3)%></td>

						<td><%=rs.getString(4)%></td>

						<td><%=rs.getString(5)%></td>

						<td><%=rs.getString(6)%></td>

						<%
						if ("admin".equals(role)) {
						%>

						<td><a class="btn update"
							href="find-weekly-menu?id=<%=rs.getInt(1)%>"> <i
								class="fa-solid fa-pen"></i> Update

						</a></td>

						<td><a class="btn delete"
							href="delete-weekly-menu?id=<%=rs.getInt(1)%>"
							onclick="return confirm('Delete this menu?')"> <i
								class="fa-solid fa-trash"></i> Delete

						</a></td>

						<%
						}
						%>

					</tr>

					<%
					}
					}

					if (!found) {
					%>

					<tr>

						<td colspan="<%="admin".equals(role) ? 8 : 6%>" class="no-data">

							<i class="fa-solid fa-circle-info"></i> No Weekly Menu Records
							Found

						</td>

					</tr>

					<%
					}
					%>

				</table>

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>