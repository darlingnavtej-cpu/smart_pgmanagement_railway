<%@page import="java.sql.*" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

		<% if (session.getAttribute("tenantId")==null) { response.sendRedirect("tenantLogin.jsp"); return; } Connection
			con=null; PreparedStatement pstmt=null; ResultSet rs=null; try { Class.forName("com.mysql.cj.jdbc.Driver");
			con=com.pgmanagement.util.DBUtil.getConnection();
			pstmt=con.prepareStatement( "select * from pg_info where id=1" ); rs=pstmt.executeQuery(); } catch
			(Exception e) { e.printStackTrace(); } %>

			<!DOCTYPE html>
			<html>

			<head>

				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0">

				<title>Contact Admin</title>

				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

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
					}

					/* HEADER */

					.header {

						background:
							linear-gradient(135deg,
								#1e3a8a,
								#4f46e5);

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
					}

					.logo-text h1 {

						font-size: 24px;
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

						background:
							rgba(255, 255, 255, .15);

						transition: .3s;
					}

					.dashboard-btn:hover {

						background:
							rgba(255, 255, 255, .25);
					}

					/* CONTAINER */

					.container {

						width: min(95%, 1100px);
						margin: 35px auto;
					}

					/* CARD */

					.card {

						background: white;

						padding: 35px;

						border-radius: 25px;

						box-shadow:
							0 20px 40px rgba(0, 0, 0, .08);

						border: 1px solid rgba(226, 232, 240, .8);
					}

					.page-title {

						text-align: center;
						margin-bottom: 30px;
					}

					.page-title h2 {

						color: #1e3a8a;
						font-size: 30px;
						margin-bottom: 8px;
					}

					.page-title p {

						color: #64748b;
					}

					/* INFO GRID */

					.contact-grid {

						display: grid;

						grid-template-columns:
							repeat(2, 1fr);

						gap: 20px;
					}

					.info-card {

						background: #f8fafc;

						border: 1px solid var(--border);

						padding: 25px;

						border-radius: 18px;

						text-align: center;

						transition: .3s;
					}

					.info-card:hover {

						transform: translateY(-4px);

						box-shadow:
							0 10px 25px rgba(0, 0, 0, .08);
					}

					.info-card i {

						font-size: 28px;

						color: #1e3a8a;

						margin-bottom: 12px;
					}

					.info-card h3 {

						color: #1e3a8a;
						margin-bottom: 10px;
					}

					.info-card p {

						color: #475569;
						word-break: break-word;
						font-size: 15px;
					}

					.address-card {

						grid-column: span 2;
					}

					/* BUTTONS */

					.action-buttons {

						display: flex;

						justify-content: center;

						flex-wrap: wrap;

						gap: 15px;

						margin-top: 30px;
					}

					.btn {

						text-decoration: none;

						padding: 14px 22px;

						border-radius: 12px;

						color: white;

						font-weight: 600;

						display: flex;
						align-items: center;
						gap: 8px;

						transition: .3s;
					}

					.call-btn {

						background: #16a34a;
					}

					.call-btn:hover {

						background: #15803d;
					}

					.mail-btn {

						background: #4f46e5;
					}

					.mail-btn:hover {

						background: #4338ca;
					}

					.back-btn {

						background: #1e3a8a;
					}

					.back-btn:hover {

						background: #163172;
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

					@media(max-width:768px) {

						.header-inner {

							flex-direction: column;
							text-align: center;
						}

						.contact-grid {

							grid-template-columns: 1fr;
						}

						.address-card {

							grid-column: span 1;
						}

						.action-buttons {

							flex-direction: column;
						}

						.btn {

							width: 100%;
							justify-content: center;
						}
					}

					/* MOBILE */

					@media(max-width:480px) {

						.container {

							width: 95%;
							margin: 20px auto;
						}

						.card {

							padding: 20px;
						}

						.page-title h2 {

							font-size: 24px;
						}

						.logo-text h1 {

							font-size: 18px;
						}

						.logo-icon {

							width: 42px;
							height: 42px;
							font-size: 18px;
						}
					}
				</style>

			</head>

			<body>

				<header class="header">

					<div class="header-inner">

						<div class="logo">

							<div class="logo-icon">
								<i class="fa-solid fa-headset"></i>
							</div>

							<div class="logo-text">
								<h1>SMART PG MANAGEMENT</h1>
								<p>Contact PG Management</p>
							</div>

						</div>

						<a href="tenant-dashboard" class="dashboard-btn">

							<i class="fa-solid fa-house"></i>

							Dashboard

						</a>

					</div>

				</header>

				<div class="container">

					<div class="card">

						<div class="page-title">

							<h2>
								<i class="fa-solid fa-address-book"></i>
								Contact Admin
							</h2>

							<p>
								Reach out to PG Management anytime
							</p>

						</div>

						<% if(rs!=null && rs.next()){ %>

							<div class="contact-grid">

								<div class="info-card">

									<i class="fa-solid fa-building"></i>

									<h3>PG Name</h3>

									<p>
										<%=rs.getString("pg_name")%>
									</p>

								</div>

								<div class="info-card">

									<i class="fa-solid fa-user-tie"></i>

									<h3>Owner Name</h3>

									<p>
										<%=rs.getString("owner_name")%>
									</p>

								</div>

								<div class="info-card">

									<i class="fa-solid fa-phone"></i>

									<h3>Phone Number</h3>

									<p>
										<%=rs.getString("phone")%>
									</p>

								</div>

								<div class="info-card">

									<i class="fa-solid fa-envelope"></i>

									<h3>Email Address</h3>

									<p>
										<%=rs.getString("email")%>
									</p>

								</div>

								<div class="info-card address-card">

									<i class="fa-solid fa-location-dot"></i>

									<h3>Address</h3>

									<p>
										<%=rs.getString("address")%>
									</p>

								</div>

							</div>

							<div class="action-buttons">

								<a href="tel:<%=rs.getString("phone")%>"
									class="btn call-btn">

									<i class="fa-solid fa-phone"></i>

									Call Admin

								</a>

								<a href="mailto:<%=rs.getString("email")%>"
									class="btn mail-btn">

									<i class="fa-solid fa-envelope"></i>

									Send Email

								</a>

								<a href="tenant-dashboard" class="btn back-btn">

									<i class="fa-solid fa-arrow-left"></i>

									Back To Dashboard

								</a>

							</div>

							<% } %>

					</div>

				</div>

				<div class="footer">

					Smart PG Management System © 2026

				</div>

			</body>

			</html>