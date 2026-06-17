<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String tenantId = request.getParameter("tenantId");
String tenantName = request.getParameter("tenantName");
String roomNo = request.getParameter("roomNo");
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tenant Checkout</title>

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
	width: min(95%, 700px);
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

/* FORM */
.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px;
	color: #334155;
}

.form-group input, .form-group textarea {
	width: 100%;
	padding: 14px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
}

.form-group input:focus, .form-group textarea:focus {
	border-color: #4f46e5;
	box-shadow: 0 0 0 4px rgba(79, 70, 229, .12);
}

.form-group textarea {
	resize: none;
	min-height: 120px;
}

.readonly {
	background: #f8faff;
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
	background: linear-gradient(135deg, #dc2626, #ef4444);
	transition: .3s;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 10px 25px rgba(220, 38, 38, .25);
}

/* INFO */
.info {
	margin-top: 25px;
	padding: 15px;
	background: #fef2f2;
	border-radius: 12px;
	text-align: center;
	color: #dc2626;
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
	.logo-text h1 {
		font-size: 20px;
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
	.logo-text h1 {
		font-size: 18px;
	}
	.form-title h2 {
		font-size: 22px;
	}
	.form-card {
		padding: 20px;
	}
	.form-group input, .form-group textarea {
		padding: 12px;
	}
}
</style>

</head>

<body>

	<header class="header">


		<div class="header-inner">

			<div class="logo">

				<div class="logo-icon">
					<i class="fa-solid fa-right-from-bracket"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant Checkout</p>
				</div>

			</div>

			<a href="fetch-tenants" class="back-btn"> <i
				class="fa-solid fa-arrow-left"></i> Tenant List
			</a>

		</div>


	</header>

	<div class="container">

		<div class="form-card">

			<div class="form-title">

				<h2>

					<i class="fa-solid fa-user-minus"></i> Complete Tenant Checkout

				</h2>

				<p>Remove tenant and release room allocation</p>

			</div>

			<form action="checkout-tenant" method="post">

				<input type="hidden" name="tenantId" value="<%=tenantId%>">

				<input type="hidden" name="tenantName" value="<%=tenantName%>">

				<input type="hidden" name="roomNo" value="<%=roomNo%>">

				<div class="form-group">

					<label>Tenant Name</label> <input type="text" class="readonly"
						value="<%=tenantName%>" readonly>

				</div>

				<div class="form-group">

					<label>Room Number</label> <input type="text" class="readonly"
						value="<%=roomNo%>" readonly>

				</div>

				<div class="form-group">

					<label>Exit Date</label> <input type="date" id="exitDate"
						name="exitDate" required>

				</div>

				<div class="form-group">

					<label>Refund Amount (₹)</label> <input type="number"
						name="refundAmount" min="0" placeholder="Enter refund amount"
						required>

				</div>

				<div class="form-group">

					<label>Reason For Checkout</label>

					<textarea name="reason" placeholder="Enter reason..." required></textarea>

				</div>

				<div class="btn-box">

					<button class="btn" type="submit">

						<i class="fa-solid fa-check"></i> Complete Checkout

					</button>

				</div>

			</form>

			<div class="info">

				<i class="fa-solid fa-circle-info"></i> This action will free the
				allocated room and remove the tenant from active occupancy.

			</div>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

	<script>
		document.addEventListener("DOMContentLoaded", function() {

			let today = new Date().toISOString().split("T")[0];

			document.getElementById("exitDate").value = today;

		});
	</script>

</body>
</html>
