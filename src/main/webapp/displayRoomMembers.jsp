<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Room Members</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
:root {
	--primary: #4f46e5;
	--primary-dark: #1e3a8a;
	--bg: #f8fafc;
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
}

.logo-text h1 {
	font-size: 24px;
}

.logo-text p {
	font-size: 13px;
	opacity: .9;
}

.back-btn {
	text-decoration: none;
	color: white;
	padding: 10px 18px;
	border-radius: 10px;
	background: rgba(255, 255, 255, .15);
	transition: .3s;
}

.back-btn:hover {
	background: rgba(255, 255, 255, .25);
}

/* CONTAINER */
.container {
	width: min(98%, 1200px);
	margin: 30px auto;
}

/* ROOM INFO CARD */
.room-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	margin-bottom: 25px;
	animation: fadeIn .6s ease;
}

.room-card h2 {
	color: #1e3a8a;
	font-size: 28px;
	text-align: center;
}

.room-card p {
	text-align: center;
	color: #64748b;
	margin-top: 8px;
}

/* TABLE CARD */
.table-card {
	background: white;
	padding: 25px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	animation: fadeIn .6s ease;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* TABLE */
.table-wrapper {
	width: 100%;
	overflow-x: auto;
	border-radius: 15px;
}

table {
	width: 100%;
	min-width: 900px;
	border-collapse: collapse;
	background: white;
}

th {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 14px;
	white-space: nowrap;
}

td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #e5e7eb;
	white-space: nowrap;
}

tr:hover {
	background: #f8faff;
}

/* EMPTY MESSAGE */
.no-data {
	font-weight: 600;
	color: #64748b;
	padding: 20px;
}

/* BACK BUTTON */
.back-section {
	text-align: center;
	margin-top: 25px;
}

.back-room-btn {
	display: inline-block;
	padding: 12px 22px;
	text-decoration: none;
	color: white;
	background: linear-gradient(135deg, #4f46e5, #6366f1);
	border-radius: 12px;
	font-weight: 600;
	transition: .3s;
}

.back-room-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

/* FOOTER */
.footer {
	margin-top: auto;
	text-align: center;
	padding: 20px;
	color: #64748b;
}

/* TABLET */
@media ( max-width :768px) {
	.header-inner {
		flex-direction: column;
		gap: 15px;
		text-align: center;
	}
	.logo-text h1 {
		font-size: 20px;
	}
	.room-card h2 {
		font-size: 24px;
	}
	.table-card {
		padding: 15px;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
	}
	.logo-text h1 {
		font-size: 18px;
	}
	.room-card h2 {
		font-size: 22px;
	}
	.room-card, .table-card {
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
					<i class="fa-solid fa-users"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Room Members</p>
				</div>

			</div>

			<a href="fetch-rooms" class="back-btn"> <i
				class="fa-solid fa-arrow-left"></i> Room Details
			</a>

		</div>


	</header>

	<%
	ResultSet rs = (ResultSet) request.getAttribute("resultSet");
	Integer roomNo = (Integer) request.getAttribute("roomNo");
	%>

	<div class="container">

		<div class="room-card">

			<h2>
				<i class="fa-solid fa-bed"></i> Room Number :
				<%=roomNo%>
			</h2>

			<p>Tenant members currently allocated to this room</p>

		</div>

		<div class="table-card">

			<div class="table-wrapper">

				<table>

					<tr>
						<th>Tenant ID</th>
						<th>Name</th>
						<th>Age</th>
						<th>Gender</th>
						<th>Phone</th>
						<th>Occupation</th>
						<th>Institute</th>
						<th>Joining Date</th>
					</tr>

					<%
					boolean found = false;

					while (rs.next()) {
						found = true;
					%>

					<tr>

						<td><%=rs.getInt(1)%></td>
						<td><%=rs.getString(2)%></td>
						<td><%=rs.getInt(3)%></td>
						<td><%=rs.getString(4)%></td>
						<td><%=rs.getString(5)%></td>
						<td><%=rs.getString(6)%></td>
						<td><%=rs.getString(7)%></td>
						<td><%=rs.getString(8)%></td>

					</tr>

					<%
					}

					if (!found) {
					%>

					<tr>

						<td colspan="8" class="no-data"><i
							class="fa-solid fa-circle-info"></i> No Members Assigned To This
							Room</td>

					</tr>

					<%
					}
					%>

				</table>

			</div>

			<div class="back-section">

				<a href="fetch-rooms" class="back-room-btn"> <i
					class="fa-solid fa-arrow-left"></i> Back To Room Details

				</a>

			</div>

		</div>


	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>
