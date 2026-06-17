<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fee Records</title>

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
    padding:20px;
    box-shadow:0 2px 10px rgba(0,0,0,0.2);
}

.container{
    width:95%;
    margin:30px auto;
}

.container h2{
    text-align:center;
    color:#1e3a8a;
    margin-bottom:20px;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 2px 12px rgba(0,0,0,0.1);
}

th{
    background:#1e3a8a;
    color:white;
    padding:12px;
}

td{
    padding:12px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

tr:hover{
    background:#eef3ff;
}

.update-btn{
    text-decoration:none;
    background:#28a745;
    color:white;
    padding:8px 12px;
    border-radius:5px;
}

.delete-btn{
    text-decoration:none;
    background:#dc3545;
    color:white;
    padding:8px 12px;
    border-radius:5px;
}

.back{
    text-align:center;
    margin-top:25px;
}

.back a{
    text-decoration:none;
    color:#1e3a8a;
    font-weight:bold;
}

.paid{
    color:green;
    font-weight:bold;
}

.pending{
    color:red;
    font-weight:bold;
}
   .generate-btn {
	text-decoration: none;
	background: #28a745;
	color: white;
	padding: 8px 16px;
	border-radius: 6px;
	font-weight: bold;
	font-size: 15px;
	display: inline-block;
	transition: 0.3s;
}

.generate-btn:hover {
	background: #218838;
	transform: translateY(-2px);
	box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.2);
}

</style>

</head>
<body>

<div class="header">
    <h1>SMART PG MANAGEMENT SYSTEM</h1>
</div>

<div class="container">

    <h2>Fee Records</h2>

    <%
        ResultSet rs =
        (ResultSet)request.getAttribute("resultSet");
    %>

    <table>

        <tr>
            <th>Fee ID</th>
            <th>Tenant ID</th>
            <th>Month</th>
            <th>Amount</th>
            <th>Paid Date</th>
            <th>Status</th>
            <th>Receipt</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>

        <%
        while(rs.next()){
        %>

        <tr>

            <td><%=rs.getInt(1)%></td>
            <td><%=rs.getInt(2)%></td>
            <td><%=rs.getString(3)%></td>
            <td>₹ <%=rs.getDouble(4)%></td>
            <td><%=rs.getString(5)%></td>
            

            <td>
                <%
                if(rs.getString(6).equalsIgnoreCase("Paid")){
                %>

                    <span class="paid">
                        <%=rs.getString(6)%>
                    </span>

                <%
                }else{
                %>

                    <span class="pending">
                        <%=rs.getString(6)%>
                    </span>

                <%
                }
                %>
            </td>
              <td>

	<a class="generate-btn"
		href="generate-receipt?feeId=<%=rs.getInt("fee_id")%>">

		🧾 Generate

	</a>

</td>
            <td>
                <a class="update-btn"
                   href="find-fee-by-id?feeId=<%=rs.getInt(1)%>">
                   UPDATE
                </a>
            </td>

            <td>
                <a class="delete-btn"
                   href="delete-fee?feeId=<%=rs.getInt(1)%>"
                   onclick="return confirm('Are you sure you want to delete this fee record?')">
                   DELETE
                </a>
            </td>

        </tr>

        <%
        }
        %>

    </table>

    <div class="back">
        <a href="dashboard">
            ← Back To Dashboard
        </a>
    </div>

</div>

</body>
</html>