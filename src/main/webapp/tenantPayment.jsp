<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.TextStyle"%>
<%@ page import="java.util.Locale"%>

<%
Integer tenantId = (Integer) request.getAttribute("tenantId");
String tenantName = (String) request.getAttribute("tenantName");
Integer roomNo = (Integer) request.getAttribute("roomNo");
String monthName = (String) request.getAttribute("monthName");
Integer amount = (Integer) request.getAttribute("amount");
String status = (String) request.getAttribute("status");

String ownerName = (String) request.getAttribute("ownerName");
String bankName = (String) request.getAttribute("bankName");
String accountNumber = (String) request.getAttribute("accountNumber");
String ifscCode = (String) request.getAttribute("ifscCode");
String upiId = (String) request.getAttribute("upiId");
String qrImage = (String) request.getAttribute("qrImage");

if (tenantName == null)
	tenantName = "N/A";
if (roomNo == null)
	roomNo = 0;
if (monthName == null) {
	monthName = LocalDate.now().getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH);
}
if (amount == null)
	amount = 0;
if (status == null)
	status = "Pending";

if (ownerName == null)
	ownerName = "N/A";
if (bankName == null)
	bankName = "N/A";
if (accountNumber == null)
	accountNumber = "N/A";
if (ifscCode == null)
	ifscCode = "N/A";
if (upiId == null)
	upiId = "N/A";
if (qrImage == null)
	qrImage = "";
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Tenant Payment Portal</title>

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
	--warning: #f59e0b;
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
	max-width: 1400px;
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
	width: min(95%, 1200px);
	margin: 30px auto;
}

/* CARD */
.card {
	background: white;
	padding: 28px;
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

/* TOP SUMMARY */
.summary-strip {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 14px;
	margin-bottom: 24px;
}

.summary-item {
	background: #eef2ff;
	border: 1px solid #dbe4ff;
	padding: 14px 16px;
	border-radius: 16px;
	display: flex;
	align-items: center;
	gap: 12px;
}

.summary-item i {
	width: 42px;
	height: 42px;
	border-radius: 12px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
	flex: 0 0 auto;
}

.summary-item div {
	min-width: 0;
}

.summary-item span {
	display: block;
	font-size: 12px;
	color: var(--muted);
	margin-bottom: 4px;
}

.summary-item strong {
	color: #1e3a8a;
	font-size: 15px;
	word-break: break-word;
}

/* SECTIONS */
.section {
	margin-bottom: 28px;
	padding: 20px;
	border: 1px solid var(--border);
	border-radius: 20px;
	background: #fff;
}

.section h2 {
	color: #1e3a8a;
	margin-bottom: 18px;
	padding-bottom: 10px;
	border-bottom: 2px solid #eef2ff;
	font-size: 22px;
	display: flex;
	align-items: center;
	gap: 10px;
}

/* INFO GRID */
.info {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 14px;
}

.info div {
	background: #f8fafc;
	padding: 14px;
	border-radius: 12px;
	font-size: 15px;
	line-height: 1.5;
	border: 1px solid #e5e7eb;
	overflow-wrap: anywhere;
}

.info b {
	color: #1e3a8a;
}

/* STATUS */
.pending {
	color: var(--danger);
	font-weight: 700;
}

.paid {
	color: var(--success);
	font-weight: 700;
}

/* QR */
.qr-box {
	text-align: center;
}

.qr-box img {
	width: 260px;
	height: 260px;
	max-width: 100%;
	object-fit: cover;
	border: 3px solid #1e3a8a;
	border-radius: 18px;
	padding: 6px;
	background: white;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
}

.qr-fallback {
	width: 260px;
	height: 260px;
	max-width: 100%;
	margin: 0 auto;
	border: 3px dashed #cbd5e1;
	border-radius: 18px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #64748b;
	background: #f8fafc;
	font-weight: 600;
}

/* FORM */
.form-group {
	margin-top: 18px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 700;
	color: #334155;
}

.form-group input {
	width: 100%;
	padding: 14px;
	border: 1px solid var(--border);
	border-radius: 12px;
	font-size: 15px;
	outline: none;
	transition: .3s;
	background: white;
}

.form-group input:focus {
	border-color: #4f46e5;
	box-shadow: 0 0 0 4px rgba(79, 70, 229, .12);
}

.btn {
	width: 100%;
	margin-top: 18px;
	padding: 15px;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	color: white;
	border: none;
	border-radius: 14px;
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

/* BACK */
.back {
	text-align: center;
	margin-top: 24px;
}

.back a {
	text-decoration: none;
	color: white;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	padding: 12px 24px;
	border-radius: 12px;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	font-weight: 600;
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
		padding: 22px;
	}
	.page-title h2 {
		font-size: 24px;
	}
	.info {
		grid-template-columns: 1fr;
	}
	.section h2 {
		font-size: 20px;
	}
	.qr-box img, .qr-fallback {
		width: 220px;
		height: 220px;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.container {
		width: 95%;
		margin: 20px auto;
	}
	.card {
		padding: 16px;
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
	.section {
		padding: 15px;
		border-radius: 16px;
	}
	.section h2 {
		font-size: 18px;
	}
	.info div {
		font-size: 14px;
		padding: 12px;
	}
	.qr-box img, .qr-fallback {
		width: 200px;
		height: 200px;
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
					<i class="fa-solid fa-credit-card"></i>
				</div>

				<div class="logo-text">
					<h1>SMART PG MANAGEMENT</h1>
					<p>Tenant Payment Portal</p>
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
					<i class="fa-solid fa-wallet"></i> Monthly Payment Portal
				</h2>
				<p>View rent details and submit payment securely</p>
			</div>

			<div class="summary-strip">
				<div class="summary-item">
					<i class="fa-solid fa-user"></i>
					<div>
						<span>Tenant</span> <strong><%=tenantName%></strong>
					</div>
				</div>

				<div class="summary-item">
					<i class="fa-solid fa-door-open"></i>
					<div>
						<span>Room No</span> <strong><%=roomNo%></strong>
					</div>
				</div>

				<div class="summary-item">
					<i class="fa-solid fa-calendar-days"></i>
					<div>
						<span>Month</span> <strong><%=monthName%></strong>
					</div>
				</div>

				<div class="summary-item">
					<i class="fa-solid fa-indian-rupee-sign"></i>
					<div>
						<span>Rent</span> <strong>₹ <%=amount%></strong>
					</div>
				</div>
			</div>

			<div class="section">

				<h2>
					<i class="fa-solid fa-user-check"></i> Tenant Information
				</h2>

				<div class="info">

					<div>
						<b>Name :</b>
						<%=tenantName%>
					</div>

					<div>
						<b>Room No :</b>
						<%=roomNo%>
					</div>

					<div>
						<b>Month :</b>
						<%=monthName%>
					</div>

					<div>
						<b>Rent :</b> ₹
						<%=amount%>
					</div>

					<div>
						<b>Status :</b>
						<%
						if (status.equalsIgnoreCase("Paid")) {
						%>
						<span class="paid">Paid <i class="fa-solid fa-circle-check"></i></span>
						<%
						} else {
						%>
						<span class="pending">Pending <i
							class="fa-solid fa-circle-exclamation"></i></span>
						<%
						}
						%>
					</div>

				</div>
			</div>

			<div class="section">

				<h2>
					<i class="fa-solid fa-building-columns"></i> Owner Payment Details
				</h2>

				<div class="info">

					<div>
						<b>Owner :</b>
						<%=ownerName%>
					</div>

					<div>
						<b>Bank :</b>
						<%=bankName%>
					</div>

					<div>
						<b>Account No :</b>
						<%=accountNumber%>
					</div>

					<div>
						<b>IFSC :</b>
						<%=ifscCode%>
					</div>

					<div>
						<b>UPI ID :</b>
						<%=upiId%>
					</div>

				</div>
			</div>

			<div class="section">

				<h2>
					<i class="fa-solid fa-qrcode"></i> Scan QR Code
				</h2>

				<div class="qr-box">
					<%
					if (qrImage != null && !qrImage.trim().isEmpty()) {
					%>
					<img src="images/<%=qrImage%>" alt="QR Code">
					<%
					} else {
					%>
					<div class="qr-fallback">QR Code Not Available</div>
					<%
					}
					%>
				</div>
			</div>

			<div class="section">

				<h2>
					<i class="fa-solid fa-paper-plane"></i> Submit Payment
				</h2>

				<form action="submit-payment" method="post">

					<input type="hidden" name="tenantId" value="<%=tenantId%>">
					<input type="hidden" name="tenantName" value="<%=tenantName%>">
					<input type="hidden" name="roomNo" value="<%=roomNo%>"> <input
						type="hidden" name="monthName" value="<%=monthName%>"> <input
						type="hidden" name="amount" value="<%=amount%>">

					<div class="form-group">
						<label>Enter UTR Number</label> <input type="text"
							name="utrNumber" placeholder="Enter UTR / Reference Number"
							required>
					</div>

					<button class="btn" type="submit">
						<i class="fa-solid fa-circle-check"></i> Submit Payment
					</button>

				</form>

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