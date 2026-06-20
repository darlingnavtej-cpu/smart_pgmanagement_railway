<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("noticeList");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Notice Board</title>

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
	--success: #16a34a;
	--danger: #dc2626;
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
}

.logo-text p {
	font-size: 14px;
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
}

.dashboard-btn:hover {
	background: rgba(255, 255, 255, .25);
}

/* CONTAINER */
.container {
	width: min(95%, 1400px);
	margin: 30px auto;
}

/* TOP BAR */
.top-bar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 15px;
	flex-wrap: wrap;
	margin-bottom: 25px;
}

.page-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 6px;
}

.page-title p {
	color: #64748b;
}

.action-btn {
	text-decoration: none;
	background: linear-gradient(135deg, #4f46e5, #6366f1);
	color: white;
	padding: 12px 18px;
	border-radius: 12px;
	font-weight: 600;
	transition: .3s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.action-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

/* CARD */
.table-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, .08);
}

/* TABLE */
.table-wrapper {
	overflow-x: auto;
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 900px;
}

th {
	background: #1e3a8a;
	color: white;
	padding: 14px;
	text-align: center;
	font-size: 15px;
}

td {
	padding: 14px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
	color: #334155;
}

tr:hover {
	background: #eef3ff;
}

/* BUTTONS */
.btn {
	text-decoration: none;
	padding: 9px 14px;
	border-radius: 10px;
	color: white;
	font-size: 14px;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 6px;
	transition: .3s;
}

.update {
	background: #16a34a;
}

.update:hover {
	background: #15803d;
}

.delete {
	background: #dc2626;
}

.delete:hover {
	background: #b91c1c;
}

/* EMPTY */
.empty {
	text-align: center;
	padding: 25px;
	color: #dc2626;
	font-weight: 600;
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
	.top-bar {
		flex-direction: column;
		align-items: stretch;
	}
	.action-btn {
		justify-content: center;
	}
	.page-title h2 {
		font-size: 24px;
	}
}

/* MOBILE */
@media ( max-width :480px) {
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
	.table-card {
		padding: 18px;
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
					<p>Notice Board Management</p>
				</div>

			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard

			</a>

		</div>

	</header>

	<div class="container">

		<div class="top-bar">

			<div class="page-title">

				<h2>
					<i class="fa-solid fa-bullhorn"></i> Published Notices
				</h2>

				<p>Manage and update all PG notices</p>

			</div>

			<a href="addNotice.jsp" class="action-btn"> <i
				class="fa-solid fa-plus"></i> Add Notice

			</a>

		</div>

		<div class="table-card">

			<div class="table-wrapper">

				<table>

					<tr>
						<th>ID</th>
						<th>Title</th>
						<th>Description</th>
						<th>Notice Date</th>
						<th>Update</th>
						<th>Delete</th>
					</tr>

					<%
					boolean found = false;

					if (rs != null) {

						while (rs.next()) {

							found = true;
					%>

					<tr>

						<td><%=rs.getInt(1)%></td>

						<td><%=rs.getString(2)%></td>

						<td><%=rs.getString(3)%></td>

						<td><%=rs.getString(4)%></td>

						<td><a class="btn update"
							href="find-notice?id=<%=rs.getInt(1)%>"> <i
								class="fa-solid fa-pen"></i> Update

						</a></td>

						<td><a class="btn delete"
							href="delete-notice?id=<%=rs.getInt(1)%>"
							onclick="return confirm('Are you sure you want to delete this notice?')">

								<i class="fa-solid fa-trash"></i> Delete

						</a></td>

					</tr>

					<%
					}
					}

					if (!found) {
					%>

					<tr>
						<td colspan="6" class="empty">No Notices Available</td>
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