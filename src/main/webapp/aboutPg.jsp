
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {

	Class.forName("com.mysql.cj.jdbc.Driver");

	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pg_info_table", "root", "admin");

	pstmt = con.prepareStatement("select * from pg_info where id=1");

	rs = pstmt.executeQuery();

} catch (Exception e) {

	e.printStackTrace();

}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>About Our PG</title>

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
	text-align: center;
	padding: 40px 20px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, .15);
}

.header h1 {
	font-size: 40px;
	margin-bottom: 10px;
}

.header p {
	font-size: 18px;
	opacity: .95;
}

.rating {
	margin-top: 15px;
	font-size: 24px;
	color: #facc15;
}

/* CONTAINER */
.container {
	width: min(95%, 1200px);
	margin: 30px auto;
}

/* SECTION */
.section {
	background: white;
	padding: 30px;
	border-radius: 25px;
	margin-bottom: 25px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, .08);
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
.section h2 {
	text-align: center;
	color: #1e3a8a;
	margin-bottom: 25px;
	font-size: 30px;
}

/* HERO IMAGE */
.hero-image img {
	width: 100%;
	height: 450px;
	object-fit: cover;
	border-radius: 20px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, .15);
}

/* OWNER INFO */
.info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
}

.info-card {
	background: #f8fafc;
	padding: 20px;
	border-radius: 15px;
	border: 1px solid var(--border);
	transition: .3s;
}

.info-card:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(0, 0, 0, .08);
}

.info-card h4 {
	color: #1e3a8a;
	margin-bottom: 10px;
	font-size: 18px;
}

.info-card i {
	margin-right: 10px;
	color: #1e3a8a;
}

.info-card p {
	color: #475569;
	line-height: 1.6;
	word-break: break-word;
}

/* FACILITY */
.facility-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
	gap: 20px;
}

.facility {
	background: #f8fafc;
	padding: 25px;
	border-radius: 18px;
	text-align: center;
	border: 1px solid var(--border);
	transition: .3s;
}

.facility:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, .08);
}

.facility i {
	font-size: 34px;
	color: #1e3a8a;
	margin-bottom: 12px;
	display: block;
}

.facility h4 {
	color: #1e3a8a;
	margin-bottom: 10px;
}

.facility p {
	color: #475569;
}

/* GALLERY */
.gallery {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
	gap: 20px;
}

.gallery img {
	width: 100%;
	height: 220px;
	object-fit: cover;
	border-radius: 18px;
	transition: .3s;
	box-shadow: 0 5px 15px rgba(0, 0, 0, .1);
}

.gallery img:hover {
	transform: scale(1.03);
}

/* BUTTONS */
.button-area {
	text-align: center;
	margin-top: 20px;
}

.button-area a {
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 10px;
	padding: 14px 22px;
	margin: 8px;
	border-radius: 12px;
	font-weight: 600;
	color: white;
	background: linear-gradient(135deg, #1e3a8a, #4f46e5);
	transition: .3s;
}

.button-area a:hover {
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
	.header h1 {
		font-size: 30px;
	}
	.section {
		padding: 22px;
	}
	.section h2 {
		font-size: 24px;
	}
	.info-grid {
		grid-template-columns: 1fr;
	}
	.hero-image img {
		height: 300px;
	}
}

/* MOBILE */
@media ( max-width :480px) {
	.header {
		padding: 25px 15px;
	}
	.header h1 {
		font-size: 24px;
	}
	.header p {
		font-size: 14px;
	}
	.rating {
		font-size: 18px;
	}
	.container {
		width: 95%;
	}
	.section {
		padding: 18px;
		border-radius: 18px;
	}
	.section h2 {
		font-size: 20px;
	}
	.hero-image img {
		height: 220px;
	}
	.gallery {
		grid-template-columns: 1fr;
	}
	.button-area a {
		width: 100%;
		justify-content: center;
	}
}
</style>

</head>

<body>

	<%
	if (rs.next()) {
	%>

	<div class="header">

		<h1>
			<i class="fa-solid fa-building"></i>
			<%=rs.getString("pg_name")%>
		</h1>

		<p>Premium Accommodation For Students & Professionals</p>

		<div class="rating">
			⭐⭐⭐⭐⭐
			<%=rs.getDouble("rating")%>/5
		</div>

	</div>

	<div class="container">

		<!-- HERO IMAGE -->

		<div class="section">

			<div class="hero-image">

				<img src="<%=rs.getString("image1")%>" alt="PG Image">

			</div>

		</div>

		<!-- OWNER DETAILS -->

		<div class="section">

			<h2>

				<i class="fa-solid fa-user-tie"></i> Owner Details

			</h2>

			<div class="info-grid">

				<div class="info-card">

					<h4>

						<i class="fa-solid fa-user"></i> Owner Name

					</h4>

					<p>

						<%=rs.getString("owner_name")%>

					</p>

				</div>

				<div class="info-card">

					<h4>

						<i class="fa-solid fa-phone"></i> Phone Number

					</h4>

					<p>

						<%=rs.getString("phone")%>

					</p>

				</div>

				<div class="info-card">

					<h4>

						<i class="fa-solid fa-envelope"></i> Email Address

					</h4>

					<p>

						<%=rs.getString("email")%>

					</p>

				</div>

				<div class="info-card">

					<h4>

						<i class="fa-solid fa-location-dot"></i> Address

					</h4>

					<p>

						<%=rs.getString("address")%>

					</p>

				</div>

			</div>

		</div>

		<!-- FACILITIES -->

		<div class="section">

			<h2>

				<i class="fa-solid fa-star"></i> Facilities

			</h2>

			<div class="facility-grid">

				<div class="facility">

					<i class="fa-solid fa-wifi"></i>

					<h4>WiFi</h4>

					<p>

						<%=rs.getString("wifi")%>

					</p>

				</div>

				<div class="facility">

					<i class="fa-solid fa-video"></i>

					<h4>CCTV</h4>

					<p>

						<%=rs.getString("cctv")%>

					</p>

				</div>

				<div class="facility">

					<i class="fa-solid fa-square-parking"></i>

					<h4>Parking</h4>

					<p>

						<%=rs.getString("parking")%>

					</p>

				</div>

				<div class="facility">

					<i class="fa-solid fa-shirt"></i>

					<h4>Laundry</h4>

					<p>

						<%=rs.getString("laundry")%>

					</p>

				</div>

				<div class="facility">

					<i class="fa-solid fa-temperature-high"></i>

					<h4>Hot Water</h4>

					<p>

						<%=rs.getString("hot_water")%>

					</p>

				</div>

			</div>

		</div>

		<!-- GALLERY -->

		<div class="section">

			<h2>

				<i class="fa-solid fa-images"></i> PG Gallery

			</h2>

			<div class="gallery">

				<img src="<%=rs.getString("image1")%>" alt="Gallery Image"> <img
					src="<%=rs.getString("image2")%>" alt="Gallery Image"> <img
					src="<%=rs.getString("image3")%>" alt="Gallery Image">

			</div>

		</div>

		<!-- IMPORTANT INFORMATION -->

		<div class="section">

			<h2>

				<i class="fa-solid fa-circle-info"></i> Important Information

			</h2>

			<div class="info-grid">

				<div class="info-card">

					<h4>

						<i class="fa-solid fa-clock"></i> Visitor Timing

					</h4>

					<p>

						<%=rs.getString("visitor_time")%>

					</p>

				</div>

				<div class="info-card">

					<h4>

						<i class="fa-solid fa-calendar-days"></i> Rent Due Date

					</h4>

					<p>

						<%=rs.getString("rent_due_date")%>

					</p>

				</div>

			</div>

		</div>

		<!-- BUTTONS -->

		<div class="button-area">

			<a href="<%=rs.getString("google_map_link")%>" target="_blank"> <i
				class="fa-solid fa-map-location-dot"></i> Open Google Maps

			</a> <a href="tenant-dashboard"> <i class="fa-solid fa-arrow-left"></i>

				Back To Dashboard

			</a>

		</div>

	</div>

	<%
	}
	%>

	<div class="footer">Smart PG Management System © 2026</div>

</body>
</html>


