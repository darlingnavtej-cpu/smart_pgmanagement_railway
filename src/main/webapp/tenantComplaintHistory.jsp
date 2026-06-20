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

	con = com.pgmanagement.util.DBUtil.getConnection();

	pstmt = con.prepareStatement("SELECT * FROM complaint WHERE tenant_id=? ORDER BY complaint_id DESC");

	pstmt.setInt(1, tenantId);

	rs = pstmt.executeQuery();

} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Complaints</title>

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
	width: min(95%, 1400px);
	margin: 30px auto;
}

/* CARD */
.card {
	background: white;
	padding: 25px;
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

/* TABLE */
.table-wrapper {
	overflow-x: auto;
	border-radius: 16px;
	border: 1px solid var(--border);
}

table {
	width: 100%;
	border-collapse: collapse;
	min-width: 800px;
}

th {
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	padding: 14px;
	text-align: center;
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

.pending {
	color: var(--danger);
	font-weight: 700;
}

.resolved {
	color: var(--success);
	font-weight: 700;
}

/* EMPTY */
.empty-row {
	text-align: center;
	padding: 24px;
	color: var(--danger);
	font-weight: 600;
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
		padding: 20px;
	}
	.page-title h2 {
		font-size: 24px;
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
	.card {
		padding: 16px;
		border-radius: 18px;
	}
	.page-title h2 {
		font-size: 22px;
	}
	.page-title p {
		font-size: 13px;
	}
	table {
		min-width: 760px;
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
					<i class="fa-solid fa-comments"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>My Complaints</p>
				</div>
			</div>

			<a href="tenant-dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>
	</header>

	<div class="container">

		<div class="card">

			<div class="page-title">
				<h2>
					<i class="fa-solid fa-clipboard-list"></i> My Complaints
				</h2>
				<p>Track your complaint status and history</p>
			</div>

			<div class="table-wrapper">
				<table>

					<tr>
						<th>Complaint ID</th>
						<th>Problem</th>
						<th>Date</th>
						<th>Status</th>
					</tr>

					<%
					boolean found = false;

					if (rs != null) {
						while (rs.next()) {
							found = true;
							String status = rs.getString("status");
					%>

					<tr>

						<td><%=rs.getInt("complaint_id")%></td>

						<td><%=rs.getString("problem")%></td>

						<td><%=rs.getString("complaint_date")%></td>

						<td>
							<%
							if (status != null && status.equalsIgnoreCase("Resolved")) {
							%> <span class="resolved"> <i
								class="fa-solid fa-circle-check"></i> Resolved
						</span> <%
 } else {
 %> <span class="pending"> <i
								class="fa-solid fa-circle-exclamation"></i> Pending
						</span> <%
 }
 %>
						</td>

					</tr>

					<%
					}
					}

					if (!found) {
					%>

					<tr>
						<td colspan="4" class="empty-row">No Complaint Records Found
						</td>
					</tr>

					<%
					}
					%>

				</table>
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