<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("menuData");

if (rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Weekly Menu</title>

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

.header{
	background:#1e3a8a;
	color:white;
	text-align:center;
	padding:25px;
	box-shadow:0 3px 10px rgba(0,0,0,0.2);
}

.header h1{
	font-size:34px;
}

.header p{
	margin-top:8px;
	font-size:15px;
}

.container{
	width:500px;
	background:white;
	margin:50px auto;
	padding:35px;
	border-radius:15px;
	box-shadow:0px 4px 15px rgba(0,0,0,0.1);
}

.container h2{
	text-align:center;
	color:#1e3a8a;
	margin-bottom:30px;
}

.form-group{
	margin-bottom:20px;
}

.form-group label{
	display:block;
	font-weight:600;
	margin-bottom:8px;
}

.form-group input{
	width:100%;
	padding:12px;
	border:1px solid #ccc;
	border-radius:8px;
	font-size:15px;
}

.btn{
	width:100%;
	padding:12px;
	background:#1e3a8a;
	color:white;
	border:none;
	border-radius:8px;
	font-size:16px;
	cursor:pointer;
}

.btn:hover{
	background:#163172;
}

.links{
	text-align:center;
	margin-top:20px;
}

.links a{
	text-decoration:none;
	color:#1e3a8a;
	font-weight:bold;
}

</style>

</head>

<body>

	<div class="header">
		<h1>SMART PG MANAGEMENT SYSTEM</h1>
		<p>Update Weekly Food Menu</p>
	</div>

	<div class="container">

		<h2>Edit Menu 🍽️</h2>

		<form action="update-weekly-menu" method="post">

			<input type="hidden"
				   name="menuId"
				   value="<%=rs.getInt(1)%>">

			<div class="form-group">

				<label>Day Name</label>

				<input type="text"
					   name="dayName"
					   value="<%=rs.getString(2)%>"
					   readonly>

			</div>

			<div class="form-group">

				<label>Breakfast</label>

				<input type="text"
					   name="breakfast"
					   value="<%=rs.getString(3)%>"
					   required>

			</div>

			<div class="form-group">

				<label>Lunch</label>

				<input type="text"
					   name="lunch"
					   value="<%=rs.getString(4)%>"
					   required>

			</div>

			<div class="form-group">

				<label>Snacks</label>

				<input type="text"
					   name="snacks"
					   value="<%=rs.getString(5)%>"
					   required>

			</div>

			<div class="form-group">

				<label>Dinner</label>

				<input type="text"
					   name="dinner"
					   value="<%=rs.getString(6)%>"
					   required>

			</div>

			<input type="submit"
				   value="Update Menu"
				   class="btn">

		</form>

		<div class="links">

			<br>

			<a href="fetch-weekly-menu">

				← Back to Weekly Menu

			</a>

		</div>

	</div>

</body>
</html>

<%
}
%>