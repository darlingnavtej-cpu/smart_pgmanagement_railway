<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0">

<title>Add Visitor</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>

:root{
	--primary:#4f46e5;
	--primary-dark:#1e3a8a;
	--bg:#f8fafc;
	--border:#e2e8f0;
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
	display:flex;
	flex-direction:column;
}

/* HEADER */

.header{
	background:linear-gradient(135deg,#1e3a8a,#4f46e5);
	color:white;
	padding:20px;
	box-shadow:0 4px 15px rgba(0,0,0,.15);
}

.header-inner{
	max-width:1200px;
	margin:auto;
	display:flex;
	align-items:center;
	justify-content:space-between;
	flex-wrap:wrap;
}

.logo{
	display:flex;
	align-items:center;
	gap:12px;
}

.logo-icon{
	width:50px;
	height:50px;
	border-radius:15px;
	background:white;
	color:#1e3a8a;
	display:flex;
	align-items:center;
	justify-content:center;
	font-size:22px;
}

.logo-text h1{
	font-size:24px;
}

.logo-text p{
	font-size:13px;
	opacity:.9;
}

.back-btn{
	text-decoration:none;
	color:white;
	padding:10px 18px;
	border-radius:10px;
	background:rgba(255,255,255,.15);
	transition:.3s;
}

.back-btn:hover{
	background:rgba(255,255,255,.25);
}

/* CONTAINER */

.container{
	width:min(95%,900px);
	margin:35px auto;
}

/* CARD */

.form-card{
	background:white;
	padding:35px;
	border-radius:25px;
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

/* TITLE */

.form-title{
	text-align:center;
	margin-bottom:30px;
}

.form-title h2{
	color:#1e3a8a;
	font-size:30px;
	margin-bottom:10px;
}

.form-title p{
	color:#64748b;
}

/* GRID */

.form-grid{
	display:grid;
	grid-template-columns:repeat(2,1fr);
	gap:20px;
}

.form-group{
	display:flex;
	flex-direction:column;
}

.form-group label{
	font-weight:600;
	margin-bottom:8px;
	color:#334155;
}

.form-group input,
.form-group textarea{
	width:100%;
	padding:14px;
	border:1px solid var(--border);
	border-radius:12px;
	font-size:15px;
	outline:none;
	transition:.3s;
}

.form-group input:focus,
.form-group textarea:focus{
	border-color:#4f46e5;
	box-shadow:0 0 0 4px rgba(79,70,229,.12);
}

.form-group textarea{
	height:100px;
	resize:none;
}

.readonly{
	background:#f8fafc;
}

.full-width{
	grid-column:span 2;
}

/* BUTTON */

.btn-box{
	margin-top:25px;
}

.btn{
	width:100%;
	padding:15px;
	border:none;
	border-radius:14px;
	font-size:16px;
	font-weight:600;
	cursor:pointer;
	color:white;
	background:linear-gradient(135deg,#4f46e5,#6366f1);
	transition:.3s;
}

.btn:hover{
	transform:translateY(-2px);
	box-shadow:0 10px 25px rgba(79,70,229,.25);
}

/* INFO */

.info{
	margin-top:25px;
	padding:15px;
	background:#eef2ff;
	border-radius:12px;
	text-align:center;
	color:#4338ca;
}

/* FOOTER */

.footer{
	margin-top:auto;
	text-align:center;
	padding:20px;
	color:#64748b;
}

/* TABLET */

@media(max-width:768px){

	.header-inner{
		flex-direction:column;
		gap:15px;
		text-align:center;
	}

	.form-grid{
		grid-template-columns:1fr;
	}

	.full-width{
		grid-column:span 1;
	}

	.form-card{
		padding:25px;
	}

	.form-title h2{
		font-size:24px;
	}
}

/* MOBILE */

@media(max-width:480px){

	.container{
		width:95%;
		margin:20px auto;
	}

	.form-card{
		padding:20px;
		border-radius:18px;
	}

	.logo-icon{
		width:42px;
		height:42px;
		font-size:18px;
	}

	.logo-text h1{
		font-size:18px;
	}

	.form-title h2{
		font-size:22px;
	}

	.form-group input,
	.form-group textarea{
		padding:12px;
		font-size:14px;
	}
}

</style>

</head>

<body>

<header class="header">

<div class="header-inner">

	<div class="logo">

		<div class="logo-icon">
			<i class="fa-solid fa-user-plus"></i>
		</div>

		<div class="logo-text">
			<h1>SMART PG MANAGEMENT</h1>
			<p>Visitor Management</p>
		</div>

	</div>

	<a href="dashboard" class="back-btn">

		<i class="fa-solid fa-arrow-left"></i>

		Dashboard

	</a>

</div>


</header>

	<div class="container">


		<div class="form-card">

			<div class="form-title">

				<h2>

					<i class="fa-solid fa-users"></i> Add Visitor

				</h2>

				<p>Register visitor entry details</p>

			</div>

			<form action="add-visitor" method="post">

				<div class="form-grid">

					<div class="form-group">

						<label>Visitor Name</label> <input type="text" name="visitorName"
							required>

					</div>

					<div class="form-group">

						<label>Phone Number</label> <input type="text" name="phone"
							required>

					</div>

					<div class="form-group">

						<label>Tenant Name</label> <input type="text" name="tenantName"
							required>

					</div>

					<div class="form-group">

						<label>Room Number</label> <input type="number" name="roomNo"
							required>

					</div>

					<div class="form-group full-width">

						<label>Purpose</label>

						<textarea name="purpose" required></textarea>

					</div>

					<div class="form-group">

						<label>Check-In Time</label> <input type="text" class="readonly"
							value="Auto Generated" readonly>

					</div>

					<div class="form-group">

						<label>Check-Out Time</label> <input type="text" class="readonly"
							value="Will Update On Exit" readonly>

					</div>

					<div class="form-group full-width">

						<label>Status</label> <input type="text" name="status" value="IN"
							class="readonly" readonly>

					</div>

				</div>

				<div class="btn-box">

					<button type="submit" class="btn">

						<i class="fa-solid fa-floppy-disk"></i> Save Visitor

					</button>

				</div>

			</form>

			<div class="info">

				<i class="fa-solid fa-circle-info"></i> Check-in time will be
				automatically recorded when the visitor entry is saved.

			</div>

		</div>


	</div>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>
