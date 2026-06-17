<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Integer tenantId = (Integer) session.getAttribute("tenantId");

if (tenantId == null) {
	response.sendRedirect("tenantLogin.jsp");
	return;
}

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");

	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/smart_pg", "root", "admin");

	pstmt = con.prepareStatement("SELECT * FROM tenant WHERE tenant_id=?");

	pstmt.setInt(1, tenantId);

	rs = pstmt.executeQuery();

} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Profile</title>

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

.home-btn {
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

.home-btn:hover {
	background: rgba(255, 255, 255, .25);
	transform: translateY(-1px);
}

/* MAIN CONTAINER */
.container {
	width: min(95%, 1000px);
	margin: 35px auto;
}

/* CARD */
.profile-card {
	background: white;
	padding: 35px;
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

/* PROFILE TOP */
.profile-top {
	display: flex;
	align-items: center;
	gap: 18px;
	padding: 18px;
	background: #eef2ff;
	border-radius: 18px;
	margin-bottom: 25px;
}

.avatar {
	width: 72px;
	height: 72px;
	border-radius: 18px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 30px;
	flex: 0 0 auto;
}

.profile-meta h3 {
	font-size: 22px;
	color: #1e3a8a;
	margin-bottom: 4px;
}

.profile-meta p {
	color: #475569;
	font-size: 14px;
	line-height: 1.5;
}

/* TABLE */
.table-wrapper {
	overflow-x: auto;
	border-radius: 16px;
	border: 1px solid var(--border);
}

table {
	width: 100%;
	border-collapse: collapse;
}

td {
	padding: 14px 16px;
	border-bottom: 1px solid #e5e7eb;
	font-size: 16px;
}

tr:last-child td {
	border-bottom: none;
}

tr:hover {
	background: #f8faff;
}

.label {
	font-weight: 700;
	color: #1e3a8a;
	width: 35%;
	white-space: nowrap;
	background: #f8fafc;
}

/* BACK */
.back {
	text-align: center;
	margin-top: 28px;
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

/* EMPTY */
.empty-box {
	text-align: center;
	padding: 35px 20px;
	color: #dc2626;
	font-weight: 600;
	background: #fff1f2;
	border-radius: 16px;
	border: 1px solid #fecdd3;
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
	.profile-card {
		padding: 25px;
	}
	.profile-top {
		flex-direction: column;
		text-align: center;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.logo {
		flex-direction: column;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 20px auto;
	}
	.profile-card {
		padding: 18px;
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
	td {
		padding: 12px;
		font-size: 14px;
	}
	.label {
		width: 40%;
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
					<i class="fa-solid fa-user"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant Profile</p>
				</div>

			</div>

			<a href="tenant-dashboard" class="home-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>

	</header>

	<div class="container">

		<div class="profile-card">

			<div class="page-title">
				<h2>
					<i class="fa-solid fa-id-card"></i> My Profile
				</h2>
				<p>View your registered tenant details</p>
			</div>

			<%
			if (rs != null && rs.next()) {
			%>

			<div class="profile-top">
				<div class="avatar">
					<i class="fa-solid fa-user-graduate"></i>
				</div>
				<div class="profile-meta">
					<h3><%=rs.getString("tenant_name")%></h3>
					<p>
						Tenant ID :
						<%=rs.getInt("tenant_id")%><br> Room No :
						<%=rs.getInt("room_no")%>
					</p>
				</div>
			</div>

			<div class="table-wrapper">
				<table>
					<tr>
						<td class="label">Tenant ID</td>
						<td><%=rs.getInt("tenant_id")%></td>
					</tr>
					<tr>
						<td class="label">Name</td>
						<td><%=rs.getString("tenant_name")%></td>
					</tr>
					<tr>
						<td class="label">Age</td>
						<td><%=rs.getInt("age")%></td>
					</tr>
					<tr>
						<td class="label">Gender</td>
						<td><%=rs.getString("gender")%></td>
					</tr>
					<tr>
						<td class="label">Phone</td>
						<td><%=rs.getString("phone")%></td>
					</tr>
					<tr>
						<td class="label">Occupation</td>
						<td><%=rs.getString("occupation")%></td>
					</tr>
					<tr>
						<td class="label">Institute</td>
						<td><%=rs.getString("institute")%></td>
					</tr>
					<tr>
						<td class="label">Joining Date</td>
						<td><%=rs.getString("joining_date")%></td>
					</tr>
					<tr>
						<td class="label">Room Number</td>
						<td><%=rs.getInt("room_no")%></td>
					</tr>
					<tr>
						<td class="label">Email</td>
						<td><%=rs.getString("email")%></td>
					</tr>
				</table>
			</div>

			<%
			} else {
			%>

			<div class="empty-box">Tenant profile not found.</div>

			<%
			}
			%>

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

<%
try {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (con != null)
		con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>