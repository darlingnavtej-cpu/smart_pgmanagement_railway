<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    String today = new java.text.SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart PG Management System</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
	:root{
		--bg:#f8fafc;
		--surface:#ffffff;
		--surface-2:#f1f5f9;
		--text:#0f172a;
		--muted:#64748b;
		--border:#e2e8f0;
		--primary:#4f46e5;
		--primary-2:#6366f1;
		--success:#22c55e;
		--warning:#f59e0b;
		--danger:#ef4444;
		--info:#06b6d4;
		--shadow:0 14px 40px rgba(15,23,42,.08);
		--shadow-soft:0 8px 24px rgba(15,23,42,.06);
		--radius:22px;
	}

	*{
		margin:0;
		padding:0;
		box-sizing:border-box;
		font-family:Segoe UI, Inter, system-ui, sans-serif;
	}

	html{
		scroll-behavior:smooth;
	}

	body{
		background:var(--bg);
		color:var(--text);
		overflow-x:hidden;
	}

	a{
		text-decoration:none;
		color:inherit;
	}

	/* Topbar */
	.topbar{
		position:sticky;
		top:0;
		z-index:1000;
		background:rgba(255,255,255,.86);
		backdrop-filter:blur(18px);
		border-bottom:1px solid rgba(226,232,240,.85);
		box-shadow:0 6px 24px rgba(15,23,42,.05);
	}

	.topbar-inner{
		width:min(1200px, calc(100% - 32px));
		margin:0 auto;
		min-height:78px;
		display:flex;
		align-items:center;
		justify-content:space-between;
		gap:16px;
		padding:10px 0;
	}

	.brand{
		display:flex;
		align-items:center;
		gap:12px;
		min-width:0;
	}

	.brand-logo{
		width:46px;
		height:46px;
		border-radius:14px;
		display:grid;
		place-items:center;
		background:linear-gradient(135deg, var(--primary), #22c55e);
		color:#fff;
		box-shadow:0 10px 24px rgba(79,70,229,.24);
		flex:0 0 auto;
	}

	.brand-title{
		display:flex;
		flex-direction:column;
		min-width:0;
	}

	.brand-title h1{
		font-size:18px;
		font-weight:900;
		line-height:1.15;
	}

	.brand-title span{
		font-size:12px;
		color:var(--muted);
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}

	.nav-links{
		display:flex;
		align-items:center;
		gap:10px;
		flex-wrap:wrap;
		justify-content:center;
	}

	.nav-links a{
		padding:10px 14px;
		border-radius:14px;
		font-weight:700;
		color:#334155;
		transition:.2s ease;
	}

	.nav-links a:hover{
		background:#eef2ff;
		color:var(--primary);
	}

	.header-actions{
		display:flex;
		align-items:center;
		gap:10px;
	}

	.menu-btn{
		display:none;
		width:44px;
		height:44px;
		border:none;
		border-radius:14px;
		background:#fff;
		box-shadow:0 10px 18px rgba(15,23,42,.06);
		cursor:pointer;
		color:var(--text);
	}

	.pill-btn{
		display:inline-flex;
		align-items:center;
		justify-content:center;
		gap:8px;
		padding:11px 16px;
		border-radius:14px;
		font-weight:800;
		border:1px solid var(--border);
		transition:.2s ease;
	}

	.pill-btn:hover{
		transform:translateY(-1px);
	}

	.pill-admin{
		background:linear-gradient(135deg, var(--primary), var(--primary-2));
		color:#fff;
		border-color:transparent;
		box-shadow:0 12px 24px rgba(79,70,229,.22);
	}

	.pill-tenant{
		background:#fff;
		color:#0f172a;
	}

	/* Mobile menu */
	.mobile-menu{
		display:none;
		position:fixed;
		inset:78px 0 auto 0;
		z-index:999;
		background:rgba(248,250,252,.98);
		backdrop-filter:blur(18px);
		border-bottom:1px solid var(--border);
		box-shadow:0 18px 28px rgba(15,23,42,.08);
	}

	.mobile-menu.show{
		display:block;
	}

	.mobile-menu-inner{
		width:min(1200px, calc(100% - 32px));
		margin:0 auto;
		padding:16px 0 18px;
		display:grid;
		grid-template-columns:1fr;
		gap:10px;
	}

	.mobile-menu-inner a{
		padding:14px 16px;
		border-radius:16px;
		background:#fff;
		border:1px solid var(--border);
		font-weight:700;
		color:#334155;
		box-shadow:0 8px 18px rgba(15,23,42,.04);
	}

	/* Hero */
	.hero{
		width:min(1200px, calc(100% - 32px));
		margin:18px auto 0;
		padding:22px;
		border:1px solid var(--border);
		border-radius:28px;
		background:
			radial-gradient(circle at top left, rgba(79,70,229,.16), transparent 30%),
			radial-gradient(circle at top right, rgba(34,197,94,.14), transparent 30%),
			linear-gradient(180deg, #ffffff 0%, #fbfdff 100%);
		box-shadow:var(--shadow);
	}

	.hero-grid{
		display:grid;
		grid-template-columns:1.5fr .95fr;
		gap:18px;
		align-items:stretch;
	}

	.hero-main,
	.hero-side{
		border-radius:24px;
		background:rgba(255,255,255,.72);
		border:1px solid rgba(226,232,240,.82);
		box-shadow:0 12px 30px rgba(15,23,42,.04);
		backdrop-filter:blur(10px);
	}

	.hero-main{
		padding:26px;
	}

	.live-tag{
		display:inline-flex;
		align-items:center;
		gap:8px;
		padding:8px 12px;
		border-radius:999px;
		background:#ecfeff;
		color:#0f766e;
		font-size:12px;
		font-weight:800;
	}

	.live-dot{
		width:9px;
		height:9px;
		border-radius:50%;
		background:#22c55e;
		box-shadow:0 0 0 6px rgba(34,197,94,.14);
	}

	.hero-main h2{
		margin-top:14px;
		font-size:clamp(28px, 4vw, 48px);
		line-height:1.1;
		font-weight:900;
		letter-spacing:-.03em;
	}

	.hero-main p{
		margin-top:12px;
		max-width:760px;
		color:var(--muted);
		font-size:15px;
		line-height:1.75;
	}

	.hero-actions{
		display:flex;
		flex-wrap:wrap;
		gap:12px;
		margin-top:22px;
	}

	.btn{
		display:inline-flex;
		align-items:center;
		justify-content:center;
		gap:10px;
		padding:13px 18px;
		border-radius:16px;
		font-weight:800;
		transition:.22s ease;
		border:1px solid transparent;
	}

	.btn:hover{
		transform:translateY(-2px);
	}

	.btn-primary{
		background:linear-gradient(135deg, var(--primary), var(--primary-2));
		color:#fff;
		box-shadow:0 16px 24px rgba(79,70,229,.22);
	}

	.btn-secondary{
		background:#fff;
		color:#0f172a;
		border-color:var(--border);
	}

	.hero-side{
		padding:18px;
		display:grid;
		gap:12px;
	}

	.side-card{
		padding:16px;
		border-radius:20px;
		background:#fff;
		border:1px solid var(--border);
		box-shadow:0 8px 18px rgba(15,23,42,.04);
	}

	.side-card .label{
		font-size:12px;
		color:var(--muted);
		font-weight:700;
	}

	.side-card .value{
		margin-top:8px;
		font-size:28px;
		font-weight:900;
		line-height:1.1;
	}

	.side-card .sub{
		margin-top:8px;
		display:flex;
		justify-content:space-between;
		gap:10px;
		font-size:13px;
		color:var(--muted);
	}

	.badge-up{
		color:var(--success);
		font-weight:800;
	}

	.badge-down{
		color:var(--danger);
		font-weight:800;
	}

	/* Sections */
	.section{
		width:min(1200px, calc(100% - 32px));
		margin:22px auto 0;
	}

	.section-title{
		display:flex;
		align-items:flex-end;
		justify-content:space-between;
		gap:12px;
		margin:8px 4px 14px;
	}

	.section-title h3{
		font-size:clamp(20px, 2vw, 28px);
		font-weight:900;
	}

	.section-title span{
		color:var(--muted);
		font-size:13px;
	}

	.stats-grid{
		display:grid;
		grid-template-columns:repeat(4, minmax(0, 1fr));
		gap:16px;
	}

	.stat-card{
		padding:18px;
		background:#fff;
		border:1px solid var(--border);
		border-radius:24px;
		box-shadow:var(--shadow-soft);
		transition:.22s ease;
	}

	.stat-card:hover{
		transform:translateY(-4px);
		box-shadow:var(--shadow);
	}

	.stat-top{
		display:flex;
		align-items:flex-start;
		justify-content:space-between;
		gap:12px;
	}

	.stat-icon{
		width:46px;
		height:46px;
		border-radius:16px;
		display:grid;
		place-items:center;
		color:#fff;
		font-size:18px;
		flex:0 0 auto;
	}

	.bg-blue{ background:linear-gradient(135deg, #2563eb, #4f46e5); }
	.bg-green{ background:linear-gradient(135deg, #22c55e, #16a34a); }
	.bg-amber{ background:linear-gradient(135deg, #f59e0b, #ea580c); }
	.bg-red{ background:linear-gradient(135deg, #ef4444, #dc2626); }
	.bg-cyan{ background:linear-gradient(135deg, #06b6d4, #0ea5e9); }
	.bg-violet{ background:linear-gradient(135deg, #8b5cf6, #6366f1); }
	.bg-slate{ background:linear-gradient(135deg, #334155, #0f172a); }
	.bg-rose{ background:linear-gradient(135deg, #fb7185, #f43f5e); }

	.stat-label{
		margin-top:12px;
		font-size:14px;
		color:var(--muted);
		font-weight:700;
	}

	.stat-value{
		margin-top:6px;
		font-size:24px;
		font-weight:900;
		line-height:1.1;
		letter-spacing:-.03em;
	}

	.stat-note{
		margin-top:8px;
		font-size:12px;
		color:#94a3b8;
		line-height:1.5;
	}

	.features-grid{
		display:grid;
		grid-template-columns:1.2fr .8fr;
		gap:16px;
	}

	.panel{
		background:#fff;
		border:1px solid var(--border);
		border-radius:28px;
		box-shadow:var(--shadow-soft);
		padding:18px;
	}

	.panel-header{
		display:flex;
		align-items:flex-start;
		justify-content:space-between;
		gap:12px;
		margin-bottom:14px;
	}

	.panel-header h4{
		font-size:18px;
		font-weight:900;
	}

	.panel-header p{
		color:var(--muted);
		font-size:13px;
		margin-top:4px;
		line-height:1.6;
	}

	.summary-grid{
		display:grid;
		grid-template-columns:1fr;
		gap:12px;
	}

	.summary-item{
		padding:16px;
		border:1px solid var(--border);
		border-radius:20px;
		background:linear-gradient(180deg, #ffffff 0%, #fbfdff 100%);
	}

	.summary-item .row{
		display:flex;
		align-items:center;
		justify-content:space-between;
		gap:10px;
	}

	.summary-item .row strong{
		font-size:14px;
	}

	.summary-item .value{
		margin-top:8px;
		font-size:26px;
		font-weight:900;
		line-height:1;
	}

	.summary-item .desc{
		margin-top:6px;
		font-size:12px;
		color:var(--muted);
		line-height:1.6;
	}

	.summary-item.room{ border-left:5px solid var(--primary); }
	.summary-item.pay{ border-left:5px solid var(--success); }
	.summary-item.complaint{ border-left:5px solid var(--warning); }
	.summary-item.notice{ border-left:5px solid var(--info); }

	.chips{
		display:flex;
		flex-wrap:wrap;
		gap:10px;
	}

	.chip{
		padding:10px 12px;
		border-radius:999px;
		background:#f8fafc;
		border:1px solid var(--border);
		font-size:13px;
		font-weight:700;
		color:#334155;
	}

	.access-grid{
		display:grid;
		grid-template-columns:repeat(2, minmax(0, 1fr));
		gap:14px;
	}

	.access-card{
		display:block;
		padding:18px;
		border-radius:24px;
		background:#fff;
		border:1px solid var(--border);
		box-shadow:var(--shadow-soft);
		transition:.22s ease;
	}

	.access-card:hover{
		transform:translateY(-4px);
		box-shadow:var(--shadow);
	}

	.access-card .icon{
		width:48px;
		height:48px;
		border-radius:16px;
		display:grid;
		place-items:center;
		color:#fff;
		font-size:18px;
		margin-bottom:12px;
	}

	.access-card h5{
		font-size:15px;
		font-weight:900;
	}

	.access-card p{
		margin-top:8px;
		font-size:13px;
		color:var(--muted);
		line-height:1.5;
	}

	.footer{
		width:min(1200px, calc(100% - 32px));
		margin:22px auto 18px;
		padding:18px 6px 0;
		color:var(--muted);
		font-size:13px;
		text-align:center;
	}

	/* Responsive */
	@media (max-width: 1100px){
		.stats-grid{
			grid-template-columns:repeat(2, minmax(0, 1fr));
		}

		.features-grid{
			grid-template-columns:1fr;
		}
	}

	@media (max-width: 920px){
		.topbar-inner{
			width:min(1200px, calc(100% - 20px));
			gap:10px;
		}

		.nav-links,
		.header-actions .pill-tenant{
			display:none;
		}

		.menu-btn{
			display:inline-grid;
			place-items:center;
		}

		.hero,
		.section,
		.footer{
			width:min(1200px, calc(100% - 20px));
		}

		.hero-grid{
			grid-template-columns:1fr;
		}
	}

	@media (max-width: 768px){
		.brand-title h1{
			font-size:16px;
		}

		.brand-title span{
			display:none;
		}

		.topbar-inner{
			min-height:70px;
		}

		.hero{
			padding:14px;
			border-radius:22px;
			margin-top:14px;
		}

		.hero-main{
			padding:18px;
		}

		.hero-main h2{
			font-size:clamp(24px, 8vw, 34px);
		}

		.hero-main p{
			font-size:14px;
		}

		.hero-actions{
			flex-direction:column;
		}

		.btn{
			width:100%;
		}

		.stats-grid{
			grid-template-columns:1fr;
		}

		.access-grid{
			grid-template-columns:1fr;
		}

		.section-title{
			flex-direction:column;
			align-items:flex-start;
		}
	}

	@media (max-width: 480px){
		.topbar-inner{
			width:min(1200px, calc(100% - 14px));
			min-height:64px;
		}

		.brand-logo{
			width:40px;
			height:40px;
		}

		.brand-title h1{
			font-size:15px;
		}

		.pill-btn{
			padding:10px 12px;
			font-size:13px;
		}

		.hero,
		.section,
		.footer{
			width:min(1200px, calc(100% - 14px));
		}

		.hero-main h2{
			font-size:24px;
		}

		.hero-main p{
			line-height:1.65;
		}

		.panel,
		.stat-card,
		.access-card{
			border-radius:20px;
		}
	}
</style>
</head>

<body>

<header class="topbar">
	<div class="topbar-inner">
		<div class="brand">
			<div class="brand-logo">
				<i class="fa-solid fa-house-chimney-user"></i>
			</div>
			<div class="brand-title">
				<h1>Smart PG Management System</h1>
				<span>Admin & Tenant access portal</span>
			</div>
		</div>

		<nav class="nav-links">
			<a href="#features">Features</a>
			<a href="#facilities">Facilities</a>
			<a href="#access">Login</a>
			<a href="#about">About</a>
		</nav>

		<div class="header-actions">
			<button class="menu-btn" type="button" onclick="toggleMenu()" aria-label="Open menu">
				<i class="fa-solid fa-bars"></i>
			</button>
			<a class="pill-btn pill-tenant" href="<%=ctx%>/tenantLogin.jsp">
				<i class="fa-solid fa-user"></i>
				Tenant
			</a>
			<a class="pill-btn pill-admin" href="<%=ctx%>/login.jsp">
				<i class="fa-solid fa-user-shield"></i>
				Admin
			</a>
		</div>
	</div>
</header>

<div class="mobile-menu" id="mobileMenu">
	<div class="mobile-menu-inner">
		<a href="#features" onclick="toggleMenu()"><i class="fa-solid fa-star"></i> Features</a>
		<a href="#facilities" onclick="toggleMenu()"><i class="fa-solid fa-wand-magic-sparkles"></i> Facilities</a>
		<a href="#access" onclick="toggleMenu()"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
		<a href="#about" onclick="toggleMenu()"><i class="fa-solid fa-circle-info"></i> About</a>
		<a href="<%=ctx%>/login.jsp" onclick="toggleMenu()"><i class="fa-solid fa-user-shield"></i> Admin Login</a>
		<a href="<%=ctx%>/tenantLogin.jsp" onclick="toggleMenu()"><i class="fa-solid fa-user"></i> Tenant Login</a>
	</div>
</div>

<section class="hero">
	<div class="hero-grid">
		<div class="hero-main">
			<div class="live-tag">
				<span class="live-dot"></span>
				Smart PG Platform
			</div>

			<h2>Manage rooms, tenants, payments and complaints from one beautiful system.</h2>

			<p>
				Smart PG Management System brings admin and tenant activities into one clean platform.
				Admins can manage operations, monitor revenue and resolve complaints, while tenants can
				pay rent, read notices and track their records from any device.
			</p>

			<div class="hero-actions">
				<a class="btn btn-primary" href="<%=ctx%>/login.jsp">
					<i class="fa-solid fa-user-shield"></i>
					Admin Login
				</a>
				<a class="btn btn-secondary" href="<%=ctx%>/tenantLogin.jsp">
					<i class="fa-solid fa-user"></i>
					Tenant Login
				</a>
			</div>
		</div>

		<div class="hero-side">
			<div class="side-card">
				<div class="label">Today</div>
				<div class="value"><%=today%></div>
				<div class="sub">
					<span>Platform status</span>
					<span class="badge-up"><i class="fa-solid fa-circle-check"></i> Online</span>
				</div>
			</div>

			<div class="side-card">
				<div class="label">Supported Roles</div>
				<div class="value">2</div>
				<div class="sub">
					<span>Admin & Tenant</span>
					<span class="badge-up"><i class="fa-solid fa-shield-heart"></i> Secure</span>
				</div>
			</div>

			<div class="side-card">
				<div class="label">Core Modules</div>
				<div class="value" style="font-size:20px;">Payments · Rooms · Complaints</div>
				<div class="sub">
					<span>All-in-one</span>
					<span class="badge-up"><i class="fa-solid fa-layer-group"></i> Ready</span>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="section" id="features">
	<div class="section-title">
		<h3>Why this system is useful</h3>
		<span>Clean, secure and responsive for every screen</span>
	</div>

	<div class="stats-grid">
		<div class="stat-card">
			<div class="stat-top">
				<div>
					<div class="stat-label">Fast Access</div>
					<div class="stat-value">Easy Login</div>
				</div>
				<div class="stat-icon bg-blue"><i class="fa-solid fa-bolt"></i></div>
			</div>
			<div class="stat-note">Quick access for both admin and tenant users.</div>
		</div>

		<div class="stat-card">
			<div class="stat-top">
				<div>
					<div class="stat-label">Mobile Ready</div>
					<div class="stat-value">Responsive UI</div>
				</div>
				<div class="stat-icon bg-green"><i class="fa-solid fa-mobile-screen"></i></div>
			</div>
			<div class="stat-note">Looks good on mobile, tablet and laptop screens.</div>
		</div>

		<div class="stat-card">
			<div class="stat-top">
				<div>
					<div class="stat-label">All Services</div>
					<div class="stat-value">One Platform</div>
				</div>
				<div class="stat-icon bg-amber"><i class="fa-solid fa-layer-group"></i></div>
			</div>
			<div class="stat-note">Rooms, rent, complaints, notices and staff.</div>
		</div>

		<div class="stat-card">
			<div class="stat-top">
				<div>
					<div class="stat-label">Secure Flow</div>
					<div class="stat-value">Role Based</div>
				</div>
				<div class="stat-icon bg-red"><i class="fa-solid fa-shield-halved"></i></div>
			</div>
			<div class="stat-note">Separate login flow for admin and tenant.</div>
		</div>
	</div>
</section>

<section class="section" id="facilities">
	<div class="section-title">
		<h3>PG Facilities</h3>
		<span>Useful amenities you can highlight on the homepage</span>
	</div>

	<div class="features-grid">
		<div class="panel">
			<div class="panel-header">
				<div>
					<h4>About the PG</h4>
					<p>
						This system helps manage the daily operations of a paying guest accommodation.
						It is designed to make room allocation, rent collection, notice publishing and complaint
						tracking simple and organized.
					</p>
				</div>
			</div>

			<div class="summary-grid">
				<div class="summary-item room">
					<div class="row">
						<strong><i class="fa-solid fa-bed"></i> Room Management</strong>
						<span class="badge-up">Live</span>
					</div>
					<div class="value">Rooms</div>
					<div class="desc">Track occupied and available rooms with ease.</div>
				</div>

				<div class="summary-item pay">
					<div class="row">
						<strong><i class="fa-solid fa-indian-rupee-sign"></i> Rent & Payments</strong>
						<span class="badge-up">Fast</span>
					</div>
					<div class="value">Payments</div>
					<div class="desc">Tenants can pay rent and verify payment history.</div>
				</div>

				<div class="summary-item complaint">
					<div class="row">
						<strong><i class="fa-solid fa-comments"></i> Complaints</strong>
						<span class="badge-down">Track</span>
					</div>
					<div class="value">Support</div>
					<div class="desc">Raise complaints and monitor status updates.</div>
				</div>

				<div class="summary-item notice">
					<div class="row">
						<strong><i class="fa-solid fa-bullhorn"></i> Notices</strong>
						<span class="badge-up">Notify</span>
					</div>
					<div class="value">Updates</div>
					<div class="desc">Show notices and daily menu information.</div>
				</div>
			</div>
		</div>

		<div class="panel" id="about">
			<div class="panel-header">
				<div>
					<h4>Login Options</h4>
					<p>
						Choose the correct access point depending on your role.
					</p>
				</div>
			</div>

			<div class="access-grid">
				<a class="access-card" href="<%=ctx%>/login.jsp">
					<div class="icon bg-blue"><i class="fa-solid fa-user-shield"></i></div>
					<h5>Admin Login</h5>
					<p>For owner and management access.</p>
				</a>

				<a class="access-card" href="<%=ctx%>/tenantLogin.jsp">
					<div class="icon bg-green"><i class="fa-solid fa-user"></i></div>
					<h5>Tenant Login</h5>
					<p>For residents to use tenant services.</p>
				</a>

				<a class="access-card" href="#features">
					<div class="icon bg-violet"><i class="fa-solid fa-star"></i></div>
					<h5>Explore Features</h5>
					<p>See the platform highlights and modules.</p>
				</a>

				<a class="access-card" href="#facilities">
					<div class="icon bg-amber"><i class="fa-solid fa-circle-info"></i></div>
					<h5>Facilities</h5>
					<p>Check the PG amenities and support.</p>
				</a>
			</div>

			<div style="margin-top:16px; padding:18px; border:1px solid var(--border); border-radius:20px; background:linear-gradient(180deg,#ffffff 0%,#fbfdff 100%);">
				<div style="display:flex; gap:12px; align-items:flex-start;">
					<div style="width:48px;height:48px;border-radius:16px;display:grid;place-items:center;background:linear-gradient(135deg, var(--primary), var(--primary-2));color:#fff;flex:0 0 auto;">
						<i class="fa-solid fa-sparkles"></i>
					</div>
					<div>
						<div style="font-size:16px;font-weight:900;">Modern responsive portal</div>
						<div style="margin-top:6px;font-size:13px;color:var(--muted);line-height:1.65;">
							This landing page uses a clean SaaS-style layout with soft cards, strong spacing,
							mobile-friendly navigation, and the same premium blue-indigo theme across all screens.
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="section">
	<div class="section-title">
		<h3>Quick Access</h3>
		<span>Direct buttons for the two user roles</span>
	</div>

	<div class="access-grid">
		<a class="access-card" href="<%=ctx%>/login.jsp">
			<div class="icon bg-blue"><i class="fa-solid fa-user-shield"></i></div>
			<h5>Admin Login</h5>
			<p>Open the administrator login screen.</p>
		</a>

		<a class="access-card" href="<%=ctx%>/tenantLogin.jsp">
			<div class="icon bg-green"><i class="fa-solid fa-user"></i></div>
			<h5>Tenant Login</h5>
			<p>Open the tenant login screen.</p>
		</a>
	</div>
</section>

<div class="footer">
	Smart PG Management System © 2026
</div>

<script>
	const mobileMenu = document.getElementById('mobileMenu');

	function toggleMenu() {
		mobileMenu.classList.toggle('show');
	}

	document.addEventListener('click', function (event) {
		const topbar = document.querySelector('.topbar');
		if (!topbar.contains(event.target) && !mobileMenu.contains(event.target)) {
			mobileMenu.classList.remove('show');
		}
	});

	window.addEventListener('resize', function () {
		if (window.innerWidth > 920) {
			mobileMenu.classList.remove('show');
		}
	});
</script>

</body>
</html>