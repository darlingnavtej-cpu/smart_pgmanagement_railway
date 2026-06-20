<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
if (session.getAttribute("tenantId") == null) {
	response.sendRedirect("tenantLogin.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Add Complaint</title>

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

/* MAIN */
.main {
	flex: 1;
	display: flex;
	justify-content: center;
	padding: 30px 15px;
}

/* CARD */
.card {
	width: 100%;
	max-width: 700px;
	background: white;
	border-radius: 25px;
	padding: 35px;
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
	max-width: 700px;
	margin: 0 auto;
}

/* FORM */
.form-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 18px;
	margin-top: 25px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group.full-width {
	grid-column: span 2;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: #334155;
}

.input-box, .select-box, .textarea-box {
	position: relative;
}

.input-box i, .select-box i, .textarea-box i {
	position: absolute;
	left: 15px;
	top: 16px;
	color: #64748b;
	pointer-events: none;
}

.form-group input, .form-group select, .form-group textarea {
	width: 100%;
	padding: 14px 14px 14px 45px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
	background: white;
}

.form-group textarea {
	min-height: 140px;
	resize: none;
	line-height: 1.6;
}

.form-group input:focus, .form-group select:focus, .form-group textarea:focus
	{
	border-color: #4f46e5;
	box-shadow: 0 0 0 4px rgba(79, 70, 229, .12);
}

.select-box select {
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	padding-right: 42px;
}

.select-box::after {
	content: "\f078";
	font-family: "Font Awesome 6 Free";
	font-weight: 900;
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: #64748b;
	pointer-events: none;
}

/* BUTTON */
.btn {
	width: 100%;
	margin-top: 22px;
	padding: 15px;
	border: none;
	border-radius: 14px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	font-size: 16px;
	font-weight: 700;
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

/* INFO */
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

/* BACK */
.back {
	text-align: center;
	margin-top: 22px;
}

.back a {
	text-decoration: none;
	color: #1e3a8a;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.back a:hover {
	text-decoration: underline;
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
		padding: 25px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.form-grid {
		grid-template-columns: 1fr;
	}
	.form-group.full-width {
		grid-column: span 1;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.main {
		padding: 20px 12px;
	}
	.card {
		padding: 20px;
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
	.form-group input, .form-group select, .form-group textarea {
		padding: 12px 12px 12px 42px;
		font-size: 14px;
	}
	.btn {
		padding: 14px;
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
					<p>Tenant Complaint Portal</p>
				</div>

			</div>

			<a href="tenant-dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>

	</header>

	<div class="main">

		<div class="card">

			<div class="page-title">
				<h2>
					<i class="fa-solid fa-comment-medical"></i> Add Complaint
				</h2>
				<p>Submit your complaint and we will review it as soon as
					possible.</p>
			</div>

			<form action="add-complaint" method="post">

				<input type="hidden" name="tenantId"
					value="<%=session.getAttribute("tenantId")%>">

				<div class="form-grid">

					<div class="form-group">
						<label>Select Complaint</label>
						<div class="select-box">
							<i class="fa-solid fa-list"></i> <select
								onchange="document.getElementById('problem').value=this.value;">
								<option value="">-- Select Complaint --</option>
								<option>Food Quality Issue</option>
								<option>Drinking Water Problem</option>
								<option>Power Cut / Electricity Issue</option>
								<option>WiFi Not Working</option>
								<option>Fan Not Working</option>
								<option>Light Not Working</option>
								<option>AC Not Working</option>
								<option>Water Leakage</option>
								<option>Bathroom Cleaning Issue</option>
								<option>Room Cleaning Issue</option>
								<option>Bed Damage</option>
								<option>Mosquito Problem</option>
								<option>Noise Disturbance</option>
								<option>Security Issue</option>
								<option>Other</option>
							</select>
						</div>
					</div>

					<div class="form-group full-width">
						<label>Complaint Details</label>
						<div class="textarea-box">
							<i class="fa-solid fa-pen-to-square"></i>
							<textarea id="problem" name="problem"
								placeholder="Describe your complaint..." required></textarea>
						</div>
					</div>

					<div class="form-group">
						<label>Complaint Date</label>
						<div class="input-box">
							<i class="fa-solid fa-calendar-days"></i> <input type="date"
								name="complaintDate" required>
						</div>
					</div>

					<div class="form-group">
						<label>Status</label>
						<div class="select-box">
							<i class="fa-solid fa-circle-check"></i> <select name="status">
								<option value="Pending">Pending</option>
								<option value="Solved">Solved</option>
							</select>
						</div>
					</div>

				</div>

				<button type="submit" class="btn">
					<i class="fa-solid fa-paper-plane"></i> Add Complaint
				</button>

			</form>

			<div class="info-box">
				<i class="fa-solid fa-circle-info"></i> <br> Complaints are
				recorded immediately and can be tracked from your complaint history.
			</div>

			<div class="back">
				<a href="tenant-dashboard"> <i class="fa-solid fa-arrow-left"></i>
					Back To Dashboard
				</a>
			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			const dateInput = document
					.querySelector('input[name="complaintDate"]');
			if (dateInput && !dateInput.value) {
				const today = new Date().toISOString().split('T')[0];
				dateInput.value = today;
			}
		});
	</script>

</body>
</html>