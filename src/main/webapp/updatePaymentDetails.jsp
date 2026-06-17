<%@page import="java.sql.ResultSet"%>
<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs =
(ResultSet) request.getAttribute(
"paymentData");

if(rs.next()){
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Payment Details</title>

<style>

*{
	margin:0;
	padding:0;
	box-sizing:border-box;
	font-family:Segoe UI,sans-serif;
}

body{
	background:#f4f7fc;
}

/* Header */

.header{

	background:linear-gradient(135deg,#1e3a8a,#2563eb);
	color:white;
	text-align:center;
	padding:30px;
	box-shadow:0 3px 12px rgba(0,0,0,.2);

}

.header h1{

	font-size:35px;

}

.header p{

	margin-top:8px;
	font-size:16px;

}

/* Container */

.container{

	width:650px;
	margin:40px auto;
	background:white;
	padding:35px;
	border-radius:18px;
	box-shadow:0 5px 15px rgba(0,0,0,.1);

}

.container h2{

	text-align:center;
	color:#1e3a8a;
	margin-bottom:25px;

}

.form-group{

	margin-bottom:18px;

}

.form-group label{

	display:block;
	margin-bottom:7px;
	font-weight:bold;
	color:#333;

}

.form-group input{

	width:100%;
	padding:12px;
	border:1px solid #ccc;
	border-radius:8px;
	font-size:15px;

}

.form-group input:focus{

	border-color:#1e3a8a;
	outline:none;

}

.qr-box{

	text-align:center;
	margin-top:15px;
	margin-bottom:20px;

}

.qr-box img{

	width:180px;
	height:180px;
	border:3px solid #1e3a8a;
	border-radius:12px;
	padding:5px;
	background:white;

}

.note{

	text-align:center;
	color:#666;
	font-size:14px;
	margin-top:10px;

}

.btn{

	width:100%;
	background:#1e3a8a;
	color:white;
	border:none;
	padding:14px;
	font-size:17px;
	font-weight:bold;
	border-radius:8px;
	cursor:pointer;
	transition:.3s;

}

.btn:hover{

	background:#163172;

}

.back{

	text-align:center;
	margin-top:20px;

}

.back a{

	text-decoration:none;
	color:#1e3a8a;
	font-weight:bold;

}

.back a:hover{

	text-decoration:underline;

}

/* Footer */

.footer{

	margin-top:50px;
	background:#1e3a8a;
	color:white;
	text-align:center;
	padding:18px;

}

</style>

</head>

<body>

<div class="header">

	<h1>💳 Update Payment Details</h1>

	<p>Modify Bank, UPI and QR Information</p>

</div>

<div class="container">

	<h2>Edit Details</h2>

	<form action="update-payment-details"
		method="post">

		<input
		type="hidden"
		name="paymentId"
		value="<%=rs.getInt("payment_id")%>">

		<div class="form-group">

			<label>Owner Name</label>

			<input
			type="text"
			name="ownerName"
			value="<%=rs.getString("owner_name")%>"
			required>

		</div>

		<div class="form-group">

			<label>Bank Name</label>

			<input
			type="text"
			name="bankName"
			value="<%=rs.getString("bank_name")%>"
			required>

		</div>

		<div class="form-group">

			<label>Account Number</label>

			<input
			type="text"
			name="accountNumber"
			value="<%=rs.getString("account_number")%>"
			required>

		</div>

		<div class="form-group">

			<label>IFSC Code</label>

			<input
			type="text"
			name="ifscCode"
			value="<%=rs.getString("ifsc_code")%>"
			required>

		</div>

		<div class="form-group">

			<label>UPI ID</label>

			<input
			type="text"
			name="upiId"
			value="<%=rs.getString("upi_id")%>"
			required>

		</div>

		<div class="form-group">

			<label>QR Image Name</label>

			<input
			type="text"
			name="qrImage"
			value="<%=rs.getString("qr_image")%>"
			required>

		</div>

		<div class="qr-box">

			<h3 style="color:#1e3a8a;margin-bottom:15px;">

				Current QR Code

			</h3>

			<img
			src="images/<%=rs.getString("qr_image")%>">

		</div>

		<div class="note">

			To change the QR Code,
			replace the image inside
			<b>WebContent/images</b>
			and update the image name above.

		</div>

		<br>

		<button
		type="submit"
		class="btn">

			Update Payment Details

		</button>

	</form>

	<div class="back">

		<a href="fetch-payment-details">

			⬅ Back

		</a>

	</div>

</div>

<div class="footer">

	Smart PG Management System © 2026

</div>

</body>
</html>

<%
}
%>