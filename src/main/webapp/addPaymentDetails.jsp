<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">
<meta charset="UTF-8">
<title>Payment Details</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Segoe UI, sans-serif;
}

body {
	background: #f4f7fc;
}

.header {
	background: linear-gradient(135deg, #1e3a8a, #2563eb);
	color: white;
	padding: 30px;
	text-align: center;
}

.header h1 {
	font-size: 36px;
}

.header p {
	margin-top: 8px;
}

.container {
	width: 600px;
	margin: 40px auto;
	background: white;
	padding: 35px;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .1);
}

.container h2 {
	text-align: center;
	color: #1e3a8a;
	margin-bottom: 25px;
}

.form-group {
	margin-bottom: 18px;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 7px;
}

.form-group input {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 8px;
	font-size: 15px;
}

.form-group input:focus {
	border-color: #1e3a8a;
	outline: none;
}

.btn {
	width: 100%;
	padding: 14px;
	background: #1e3a8a;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 17px;
	font-weight: bold;
	cursor: pointer;
}

.btn:hover {
	background: #163172;
}

.back {
	text-align: center;
	margin-top: 20px;
}

.back a {
	text-decoration: none;
	color: #1e3a8a;
	font-weight: bold;
}

.footer {
	margin-top: 50px;
	background: #1e3a8a;
	color: white;
	text-align: center;
	padding: 18px;
}
</style>

</head>

<body>

	<div class="header">

		<h1>💳 Owner Payment Details</h1>

		<p>Configure Bank and UPI Information</p>

	</div>

	<div class="container">

		<h2>Add Payment Details</h2>

		<form action="add-payment-details" method="post" enctype="multipart/form-data">

			<div class="form-group">

				<label>Owner Name</label> <input type="text" name="ownerName"
					required>

			</div>

			<div class="form-group">

				<label>Bank Name</label> <input type="text" name="bankName" required>

			</div>

			<div class="form-group">

				<label>Account Number</label> <input type="text"
					name="accountNumber" required>

			</div>

			<div class="form-group">

				<label>IFSC Code</label> <input type="text" name="ifscCode" required>

			</div>

			<div class="form-group">

				<label>UPI ID</label> <input type="text" name="upiId" required>

			</div>

			<div class="form-group">

				<label>Upload QR Code Image</label> <input type="file" name="qrImage"
					accept="image/*" required>

			</div>

			<button type="submit" class="btn">Save Details</button>

		</form>

		<div class="back">

			<a href="dashboard"> ⬅ Back To Dashboard </a>

		</div>

	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>