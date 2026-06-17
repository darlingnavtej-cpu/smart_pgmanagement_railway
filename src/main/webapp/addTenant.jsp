<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Add Tenant</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

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
	width: min(95%, 1000px);
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

@
keyframes fadeIn {from { opacity:0;
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

.form-group input, .form-group select {
	width: 100%;
	padding: 14px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
}

.form-group input:focus, .form-group select:focus {
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
	background: linear-gradient(135deg, #4f46e5, #6366f1);
	transition: .3s;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(79, 70, 229, .25);
}

/* INFO BOX */
.info {
	margin-top: 25px;
	padding: 15px;
	background: #eef2ff;
	border-radius: 12px;
	text-align: center;
	color: #4338ca;
}

.info i {
	margin-right: 8px;
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

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
	}
	.form-card {
		padding: 20px;
	}
	.logo-text h1 {
		font-size: 18px;
	}
	.form-title h2 {
		font-size: 22px;
	}
	.form-group input, .form-group select {
		padding: 12px;
	}
	.btn {
		padding: 14px;
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
					<p>Tenant Management</p>
				</div>

			</div>

			<a href="dashboard" class="back-btn"> <i
				class="fa-solid fa-arrow-left"></i> Dashboard
			</a>

		</div>


	</header>

	<div class="container">


		<div class="form-card">

			<div class="form-title">

				<h2>
					<i class="fa-solid fa-user-plus"></i> Add New Tenant
				</h2>

				<p>Register tenant details and allocate room</p>

			</div>

			<form action="add-tenant" method="post"
				onsubmit="return validateForm()">

				<div class="form-grid">

					<div class="form-group">
						<label>Tenant ID</label> <input type="number" name="tenantId"
							required>
					</div>

					<div class="form-group">
						<label>Tenant Name</label> <input type="text" name="name" required>
					</div>

					<div class="form-group">
						<label>Age</label> <input type="number" name="age" min="18"
							max="100" required>
					</div>

					<div class="form-group">
						<label>Gender</label> <select name="gender" required>
							<option value="">Select Gender</option>
							<option>Male</option>
							<option>Female</option>
							<option>Other</option>
						</select>
					</div>

					<div class="form-group">
						<label>Phone Number</label> <input type="text" id="phone"
							name="phone" maxlength="10" required>
					</div>

					<div class="form-group">
						<label>Occupation</label> <select name="occupation" required>
							<option value="">Select Occupation</option>
							<option>Student</option>
							<option>Employee</option>
						</select>
					</div>

					<div class="form-group full-width">
						<label>Institute / Company</label> <input type="text"
							name="institute" required>
					</div>

					<div class="form-group">
						<label>Joining Date</label> <input type="date" id="joiningDate"
							name="joiningDate" required>
					</div>

					<div class="form-group">
						<label>Room Number</label> <input type="number" name="roomnnum"
							required>
					</div>

					<div class="form-group full-width">
						<label>Email</label> <input type="email" name="email" required>
					</div>

				</div>

				<div class="btn-box">

					<button type="submit" class="btn">
						<i class="fa-solid fa-user-plus"></i> Add Tenant
					</button>

				</div>

			</form>

			<div class="info">

				<i class="fa-solid fa-circle-info"></i> New tenants added here will
				be available for room allocation and fee management.

			</div>

		</div>
	

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

	<script>
		function validateForm() {

			let phone = document.getElementById("phone").value;

			if (!/^[0-9]{10}$/.test(phone)) {
				alert("Phone number must contain exactly 10 digits");
				return false;
			}

			return true;
		}

		document.addEventListener("DOMContentLoaded", function() {

			let today = new Date().toISOString().split("T")[0];

			document.getElementById("joiningDate").value = today;

		});
	</script>

</body>
</html>
