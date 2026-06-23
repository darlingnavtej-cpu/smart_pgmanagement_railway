<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Protect page
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String tenantId = request.getParameter("id");
    String tenantName = request.getParameter("name");
    String tenantEmail = request.getParameter("email");
    
    if (tenantId == null || tenantName == null || tenantEmail == null) {
        response.sendRedirect("fetch-tenants");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Send Email to Tenant</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<style>
:root {
	--primary: #4f46e5;
	--primary-dark: #1e3a8a;
	--bg: #f8fafc;
	--card: #ffffff;
	--text: #0f172a;
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
	width: min(95%, 800px);
	margin: 35px auto;
}

/* CARD */
.form-card {
	background: white;
	padding: 35px;
	border-radius: 25px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, .08);
	animation: fadeIn .6s ease;
}

@keyframes fadeIn {
	from {
		opacity: 0;
		transform: translateY(20px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.form-title {
	text-align: center;
	margin-bottom: 30px;
}

.form-title h2 {
	color: #1e3a8a;
	font-size: 30px;
	margin-bottom: 10px;
}

.form-title p {
	color: #64748b;
}

/* GRID */
.form-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group label {
	font-weight: 600;
	margin-bottom: 8px;
	color: #334155;
}

.form-group input, .form-group select, .form-group textarea {
	width: 100%;
	padding: 14px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
}

.form-group input:focus, .form-group select:focus, .form-group textarea:focus {
	border-color: #4f46e5;
	box-shadow: 0 0 0 4px rgba(79, 70, 229, .12);
}

.full-width {
	grid-column: span 2;
}

/* BUTTON */
.btn-box {
	margin-top: 25px;
}

.btn {
	width: 100%;
	padding: 15px;
	border: none;
	border-radius: 14px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	color: white;
	background: linear-gradient(135deg, #a855f7, #7c3aed);
	transition: .3s;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(124, 58, 237, .25);
}

/* FOOTER */
.footer {
	margin-top: auto;
	text-align: center;
	padding: 20px;
	color: #64748b;
}

/* RESPONSIVE */
@media (max-width: 768px) {
	.header-inner {
		flex-direction: column;
		gap: 15px;
		text-align: center;
	}
	.form-grid {
		grid-template-columns: 1fr;
	}
	.full-width {
		grid-column: span 1;
	}
	.form-card {
		padding: 25px;
	}
	.form-title h2 {
		font-size: 24px;
	}
}
</style>
</head>
<body>

	<header class="header">
		<div class="header-inner">
			<div class="logo">
				<div class="logo-icon">
					<i class="fa-solid fa-envelope"></i>
				</div>
				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant Notifications</p>
				</div>
			</div>
			<a href="fetch-tenants" class="back-btn">
				<i class="fa-solid fa-arrow-left"></i> Back to Tenants
			</a>
		</div>
	</header>

	<div class="container">
		<div class="form-card">
			<div class="form-title">
				<h2>
					<i class="fa-solid fa-paper-plane"></i> Send Email to Tenant
				</h2>
				<p>Send custom warnings, payment reminders, or info directly to <%= tenantName %></p>
			</div>

			<form action="send-mail" method="post">
				<div class="form-grid">
					
					<!-- Read-only parameters -->
					<div class="form-group">
						<label>Tenant ID</label>
						<input type="text" name="id" value="<%= tenantId %>" readonly style="background-color: #f1f5f9; color: #94a3b8; border-color: #cbd5e1; cursor: not-allowed;">
					</div>

					<div class="form-group">
						<label>Tenant Name</label>
						<input type="text" name="name" value="<%= tenantName %>" readonly style="background-color: #f1f5f9; color: #94a3b8; border-color: #cbd5e1; cursor: not-allowed;">
					</div>

					<div class="form-group full-width">
						<label>Recipient Email</label>
						<input type="email" name="email" value="<%= tenantEmail %>" readonly style="background-color: #f1f5f9; color: #94a3b8; border-color: #cbd5e1; cursor: not-allowed;">
					</div>

					<!-- Form inputs -->
					<div class="form-group full-width">
						<label>Subject</label>
						<input type="text" name="subject" value="Important Notice from PG Management" required placeholder="Enter email subject">
					</div>

					<div class="form-group">
						<label>Date & Time</label>
						<input type="datetime-local" id="emailDateTime" name="dateTime" required>
					</div>

					<div class="form-group">
						<label>Month Context</label>
						<select name="emailMonth" required>
							<%
							String currentMonth = java.time.LocalDate.now().getMonth().getDisplayName(java.time.format.TextStyle.FULL, java.util.Locale.ENGLISH);
							String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
							for(String m : months) {
							%>
								<option value="<%= m %>" <%= m.equalsIgnoreCase(currentMonth) ? "selected" : "" %>><%= m %></option>
							<% } %>
						</select>
					</div>

					<div class="form-group full-width">
						<label>Message Content</label>
						<textarea name="content" rows="6" required style="resize: vertical;" placeholder="Type the message you want to share with the tenant..."></textarea>
					</div>

				</div>

				<div class="btn-box">
					<button type="submit" class="btn">
						<i class="fa-solid fa-paper-plane"></i> Send Email
					</button>
				</div>
			</form>
		</div>
	</div>

	<div class="footer">Smart PG Management System © 2026</div>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			let now = new Date();
			// Offset local timezone
			let tzoffset = now.getTimezoneOffset() * 60000;
			let localISOTime = (new Date(now - tzoffset)).toISOString().slice(0, 16);
			document.getElementById("emailDateTime").value = localISOTime;
		});
	</script>
</body>
</html>
