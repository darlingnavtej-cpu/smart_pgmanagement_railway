<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Integer tenantId = (Integer) request.getAttribute("tenantId");
String tenantName = (String) request.getAttribute("tenantName");
Integer roomNo = (Integer) request.getAttribute("roomNo");
String monthName = (String) request.getAttribute("monthName");
Double amount = (Double) request.getAttribute("amount");
java.sql.Date paidDate = (java.sql.Date) request.getAttribute("paidDate");
%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Rent Receipt</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>

:root{
	--primary:#4f46e5;
	--primary-dark:#1e3a8a;
	--success:#16a34a;
	--bg:#f8fafc;
}

*{
	margin:0;
	padding:0;
	box-sizing:border-box;
	font-family:Segoe UI,sans-serif;
}

body{
	background:var(--bg);
	min-height:100vh;
	padding:25px;
}

/* RECEIPT CARD */

.receipt{
	width:min(95%,850px);
	margin:auto;
	background:white;
	border-radius:25px;
	overflow:hidden;
	box-shadow:0 20px 40px rgba(0,0,0,.08);
	animation:fadeIn .6s ease;
}

@keyframes fadeIn{

	from{
		opacity:0;
		transform:translateY(20px);
	}

	to{
		opacity:1;
		transform:translateY(0);
	}
}

/* HEADER */

.receipt-header{
	background:linear-gradient(135deg,#1e3a8a,#4f46e5);
	color:white;
	padding:30px;
	text-align:center;
}

.receipt-header h1{
	font-size:32px;
	margin-bottom:10px;
}

.receipt-header h3{
	font-weight:400;
	opacity:.95;
}

/* CONTENT */

.content{
	padding:35px;
}

.row{
	display:flex;
	justify-content:space-between;
	gap:20px;
	margin-bottom:18px;
	flex-wrap:wrap;
}

.info-box{
	flex:1;
	min-width:250px;
}

.label{
	font-weight:700;
	color:#1e3a8a;
}

.value{
	color:#334155;
}

.line{
	border-top:2px dashed #d1d5db;
	margin:25px 0;
}

/* AMOUNT */

.amount{
	text-align:center;
	font-size:38px;
	font-weight:700;
	color:var(--success);
	margin:25px 0;
}

.status{
	text-align:center;
	font-size:22px;
	font-weight:700;
	color:var(--success);
}

/* SIGNATURES */

.sign{
	margin-top:50px;
	display:flex;
	justify-content:space-between;
	gap:30px;
}

.sign-box{
	flex:1;
	text-align:center;
}

.sign-box hr{
	margin-bottom:10px;
	border:none;
	border-top:2px solid #94a3b8;
}

/* FOOTER NOTE */

.note{
	margin-top:25px;
	text-align:center;
	color:#64748b;
	font-size:14px;
}

/* BUTTONS */

.buttons{
	display:flex;
	justify-content:center;
	gap:15px;
	flex-wrap:wrap;
	margin-top:30px;
}

.btn{
	border:none;
	padding:14px 22px;
	border-radius:12px;
	font-size:15px;
	font-weight:600;
	cursor:pointer;
	text-decoration:none;
	color:white;
	transition:.3s;
}

.print-btn{
	background:linear-gradient(135deg,#4f46e5,#6366f1);
}

.back-btn{
	background:linear-gradient(135deg,#1e3a8a,#2563eb);
}

.btn:hover{
	transform:translateY(-2px);
	box-shadow:0 10px 25px rgba(79,70,229,.25);
}

/* MOBILE */

@media(max-width:768px){

	.content{
		padding:20px;
	}

	.receipt-header h1{
		font-size:24px;
	}

	.receipt-header h3{
		font-size:14px;
	}

	.amount{
		font-size:30px;
	}

	.status{
		font-size:18px;
	}

	.sign{
		flex-direction:column;
		gap:25px;
	}
}

@media(max-width:480px){

	body{
		padding:10px;
	}

	.receipt{
		border-radius:18px;
	}

	.receipt-header{
		padding:20px;
	}

	.receipt-header h1{
		font-size:20px;
	}

	.amount{
		font-size:26px;
	}

	.buttons{
		flex-direction:column;
	}

	.btn{
		width:100%;
		text-align:center;
	}
}

/* PRINT */

@media print{

	body{
		background:white;
		padding:0;
	}

	.receipt{
		width:100%;
		box-shadow:none;
		border-radius:0;
	}

	.buttons{
		display:none;
	}
}

</style>

</head>

<body>

<div class="receipt">

	<div class="receipt-header">

		<h1>
			<i class="fa-solid fa-house"></i>
			SMART PG MANAGEMENT
		</h1>

		<h3>Rent Payment Receipt</h3>

	</div>

	<div class="content">

		<div class="row">

			<div class="info-box">

				<span class="label">Receipt Date :</span>
				<span class="value"> <%=paidDate%> </span>

			</div>

			<div class="info-box">

				<span class="label">Status :</span>
				<span class="value"> PAID </span>

			</div>

		</div>

		<div class="line"></div>

		<div class="row">

			<div class="info-box">

				<span class="label">Tenant ID :</span>
				<span class="value"> <%=tenantId%> </span>

			</div>

			<div class="info-box">

				<span class="label">Room Number :</span>
				<span class="value"> <%=roomNo%> </span>

			</div>

		</div>

		<div class="row">

			<div class="info-box">

				<span class="label">Tenant Name :</span>
				<span class="value"> <%=tenantName%> </span>

			</div>

			<div class="info-box">

				<span class="label">Month :</span>
				<span class="value"> <%=monthName%> </span>

			</div>

		</div>

		<div class="line"></div>

		<div class="amount">
			₹ <%=amount%>
		</div>

		<div class="status">
			<i class="fa-solid fa-circle-check"></i>
			PAYMENT RECEIVED
		</div>

		<div class="line"></div>

		<div class="note">

			Thank you for your payment.<br>
			This is a computer generated receipt.

		</div>

		<div class="sign">

			<div class="sign-box">

				<hr>
				Tenant Signature

			</div>

			<div class="sign-box">

				<hr>
				Owner Signature

			</div>

		</div>

		<div class="buttons">

			<button class="btn print-btn"
				onclick="window.print()">

				<i class="fa-solid fa-print"></i>
				Print Receipt

			</button>

			<a href="tenant-payment-history"
				class="btn back-btn">

				<i class="fa-solid fa-arrow-left"></i>
				Back

			</a>

		</div>

	</div>

</div>

</body>
</html>