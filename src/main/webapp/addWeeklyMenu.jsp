<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

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
	width: min(95%, 900px);
	margin: 35px auto;
}

/* CARD */
.card {
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

.input-box, .select-box {
	position: relative;
}

.input-box i, .select-box i {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: #64748b;
	pointer-events: none;
}

.form-group input, .form-group select {
	width: 100%;
	padding: 14px 14px 14px 45px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
	background: white;
}

.form-group input:focus, .form-group select:focus {
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

/* LINKS */
.links {
	text-align: center;
	margin-top: 22px;
	display: flex;
	justify-content: center;
	flex-wrap: wrap;
	gap: 12px;
}

.links a {
	text-decoration: none;
	color: #1e3a8a;
	font-weight: 600;
	background: #f8fafc;
	border: 1px solid #dbe4ff;
	padding: 12px 18px;
	border-radius: 12px;
	transition: .3s;
	display: inline-flex;
	align-items: center;
	gap: 8px;
}

.links a:hover {
	background: #eef2ff;
	transform: translateY(-1px);
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
	.links {
		flex-direction: column;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 20px auto;
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
	.form-group input, .form-group select {
		padding: 12px 12px 12px 42px;
		font-size: 14px;
	}
	.btn {
		padding: 14px;
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
					<p>Weekly Food Menu</p>
				</div>

			</div>

			<a href="dashboard" class="dashboard-btn"> <i
				class="fa-solid fa-house"></i> Dashboard
			</a>

		</div>

	</header>

	<div class="container">

		<div class="card">

			<div class="page-title">
				<h2>
					<i class="fa-solid fa-calendar-week"></i> Add Weekly Menu
				</h2>
				<p>Set the food menu for each day of the week</p>
			</div>

			<form action="add-weekly-menu" method="post">

				<div class="form-grid">

					<div class="form-group full-width">
						<label>Day</label>
						<div class="select-box">
							<i class="fa-solid fa-calendar-day"></i> <select name="dayName">
								<option>Monday</option>
								<option>Tuesday</option>
								<option>Wednesday</option>
								<option>Thursday</option>
								<option>Friday</option>
								<option>Saturday</option>
								<option>Sunday</option>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label>Breakfast</label>
						<div class="input-box">
							<i class="fa-solid fa-mug-hot"></i> <input type="text"
								name="breakfast" placeholder="Breakfast items" required>
						</div>
					</div>

					<div class="form-group">
						<label>Lunch</label>
						<div class="input-box">
							<i class="fa-solid fa-bowl-food"></i> <input type="text"
								name="lunch" placeholder="Lunch items" required>
						</div>
					</div>

					<div class="form-group">
						<label>Snacks</label>
						<div class="input-box">
							<i class="fa-solid fa-cookie-bite"></i> <input type="text"
								name="snacks" placeholder="Snacks items" required>
						</div>
					</div>

					<div class="form-group">
						<label>Dinner</label>
						<div class="input-box">
							<i class="fa-solid fa-moon"></i> <input type="text" name="dinner"
								placeholder="Dinner items" required>
						</div>
					</div>

				</div>

				<button type="submit" class="btn">
					<i class="fa-solid fa-floppy-disk"></i> Save Weekly Menu
				</button>

			</form>

			<div class="info-box">
				<i class="fa-solid fa-circle-info"></i> <br> This weekly menu
				will be available to all tenants from the food menu section.
			</div>

			<div class="links">

				<a href="fetch-admin-weekly-menu"> <i class="fa-solid fa-list"></i>
					View Weekly Menu
				</a> <a href="dashboard"> <i class="fa-solid fa-house"></i>
					Dashboard
				</a>

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>