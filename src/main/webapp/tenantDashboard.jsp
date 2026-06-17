<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
if (session.getAttribute("tenantId") == null) {
	response.sendRedirect("tenantLogin.jsp");
	return;
}

String ctx = request.getContextPath();

String tenantName = (String) request.getAttribute("tenantName");
if (tenantName == null) tenantName = (String) session.getAttribute("tenantName");
if (tenantName == null || tenantName.trim().isEmpty()) tenantName = "Tenant";

Integer roomNoObj = (Integer) request.getAttribute("roomNo");
if (roomNoObj == null) roomNoObj = (Integer) session.getAttribute("roomNo");
int roomNo = (roomNoObj != null) ? roomNoObj : 0;

String phone = (String) request.getAttribute("phone");
if (phone == null) phone = (String) session.getAttribute("phone");
if (phone == null || phone.trim().isEmpty()) phone = "-";

String occupation = (String) request.getAttribute("occupation");
if (occupation == null) occupation = (String) session.getAttribute("occupation");
if (occupation == null || occupation.trim().isEmpty()) occupation = "-";

String email = (String) request.getAttribute("email");
if (email == null) email = (String) session.getAttribute("email");
if (email == null || email.trim().isEmpty()) email = "-";

String tenantIdStr = String.valueOf(session.getAttribute("tenantId"));

String displayName = tenantName;
String avatar = displayName.substring(0, 1).toUpperCase();

String today = new java.text.SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tenant Dashboard</title>
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
		--radius-sm:16px;
	}

	*{
		margin:0;
		padding:0;
		box-sizing:border-box;
		font-family:Segoe UI, Inter, system-ui, sans-serif;
	}

	body{
		background:var(--bg);
		color:var(--text);
		overflow-x:hidden;
	}

	a{
		color:inherit;
	}

	.overlay{
		position:fixed;
		inset:0;
		background:rgba(15,23,42,.45);
		backdrop-filter:blur(2px);
		z-index:900;
		opacity:0;
		pointer-events:none;
		transition:.25s ease;
	}

	.overlay.show{
		opacity:1;
		pointer-events:auto;
	}

	.sidebar{
		position:fixed;
		left:0;
		top:0;
		height:100vh;
		width:292px;
		background:linear-gradient(180deg, #0f172a 0%, #111827 100%);
		color:#fff;
		padding:22px 18px;
		z-index:1000;
		display:flex;
		flex-direction:column;
		border-right:1px solid rgba(255,255,255,.08);
		box-shadow:20px 0 50px rgba(2,6,23,.18);
		transition:transform .28s ease;
	}

	.brand{
		display:flex;
		align-items:center;
		gap:12px;
		padding:8px 8px 18px 8px;
		margin-bottom:10px;
	}

	.brand-logo{
		width:44px;
		height:44px;
		border-radius:14px;
		display:grid;
		place-items:center;
		background:linear-gradient(135deg, var(--primary), #22c55e);
		box-shadow:0 10px 24px rgba(79,70,229,.35);
		flex:0 0 auto;
	}

	.brand-title{
		display:flex;
		flex-direction:column;
		gap:2px;
		min-width:0;
	}

	.brand-title h1{
		font-size:16px;
		line-height:1.2;
		font-weight:800;
		letter-spacing:.3px;
	}

	.brand-title span{
		font-size:12px;
		color:#94a3b8;
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}

	.sidebar-scroll{
		flex:1;
		overflow:auto;
		padding-right:4px;
		margin-right:-4px;
	}

	.sidebar-scroll::-webkit-scrollbar{
		width:8px;
	}

	.sidebar-scroll::-webkit-scrollbar-thumb{
		background:rgba(148,163,184,.25);
		border-radius:999px;
	}

	.nav-group{
		margin-top:18px;
	}

	.nav-group-title{
		font-size:11px;
		text-transform:uppercase;
		letter-spacing:.14em;
		color:#94a3b8;
		padding:0 10px 8px;
	}

	.nav-link{
		display:flex;
		align-items:center;
		gap:12px;
		padding:12px 14px;
		margin:6px 4px;
		border-radius:16px;
		text-decoration:none;
		color:#e2e8f0;
		font-weight:600;
		transition:.22s ease;
		border:1px solid transparent;
	}

	.nav-link i{
		width:22px;
		text-align:center;
		font-size:15px;
		color:#a5b4fc;
	}

	.nav-link:hover,
	.nav-link.active{
		background:rgba(79,70,229,.16);
		border-color:rgba(99,102,241,.22);
		transform:translateX(4px);
		color:#fff;
	}

	.sidebar-footer{
		padding:16px 10px 6px;
		margin-top:14px;
		border-top:1px solid rgba(255,255,255,.08);
	}

	.logout-btn{
		display:flex;
		align-items:center;
		justify-content:center;
		gap:10px;
		width:100%;
		padding:13px 16px;
		border-radius:16px;
		background:linear-gradient(135deg, #ef4444, #dc2626);
		color:#fff;
		font-weight:700;
		text-decoration:none;
		box-shadow:0 12px 28px rgba(239,68,68,.24);
	}

	.main{
		margin-left:292px;
		min-height:100vh;
		padding:24px 24px 92px;
	}

	.topbar{
		position:sticky;
		top:16px;
		z-index:300;
		display:flex;
		align-items:center;
		justify-content:space-between;
		gap:16px;
		padding:14px 16px;
		border:1px solid rgba(226,232,240,.9);
		background:rgba(255,255,255,.78);
		backdrop-filter:blur(18px);
		border-radius:24px;
		box-shadow:var(--shadow-soft);
	}

	.topbar-left{
		display:flex;
		align-items:center;
		gap:14px;
		min-width:0;
	}

	.menu-btn{
		display:none;
		align-items:center;
		justify-content:center;
		width:46px;
		height:46px;
		border:none;
		border-radius:16px;
		background:var(--surface);
		box-shadow:0 10px 24px rgba(15,23,42,.08);
		color:var(--text);
		cursor:pointer;
	}

	.page-title{
		display:flex;
		flex-direction:column;
		gap:2px;
		min-width:0;
	}

	.page-title h2{
		font-size:20px;
		line-height:1.1;
		font-weight:800;
	}

	.page-title span{
		font-size:13px;
		color:var(--muted);
	}

	.topbar-right{
		display:flex;
		align-items:center;
		gap:12px;
		flex:1;
		justify-content:flex-end;
	}

	.search-form{
		flex:1;
		max-width:640px;
		display:flex;
		align-items:center;
		gap:10px;
		padding:8px;
		border:1px solid var(--border);
		background:#fff;
		border-radius:18px;
		box-shadow:0 8px 18px rgba(15,23,42,.04);
	}

	.search-form i{
		color:#94a3b8;
		padding-left:8px;
	}

	.search-input{
		flex:1;
		border:none;
		outline:none;
		font-size:15px;
		background:transparent;
		color:var(--text);
		min-width:0;
	}

	.search-btn{
		border:none;
		outline:none;
		padding:11px 16px;
		border-radius:14px;
		background:linear-gradient(135deg, var(--primary), var(--primary-2));
		color:#fff;
		font-weight:700;
		cursor:pointer;
	}

	.top-icons{
		display:flex;
		align-items:center;
		gap:10px;
	}

	.icon-chip{
		width:46px;
		height:46px;
		border-radius:16px;
		background:#fff;
		border:1px solid var(--border);
		display:grid;
		place-items:center;
		box-shadow:0 10px 18px rgba(15,23,42,.05);
		color:#334155;
		position:relative;
		text-decoration:none;
	}

	.icon-badge{
		position:absolute;
		top:-4px;
		right:-4px;
		min-width:18px;
		height:18px;
		padding:0 5px;
		border-radius:999px;
		background:var(--danger);
		color:#fff;
		font-size:11px;
		font-weight:800;
		display:grid;
		place-items:center;
		border:2px solid #fff;
	}

	.profile-chip{
		display:flex;
		align-items:center;
		gap:12px;
		padding:8px 10px 8px 8px;
		background:#fff;
		border:1px solid var(--border);
		border-radius:18px;
		box-shadow:0 10px 18px rgba(15,23,42,.05);
	}

	.avatar{
		width:40px;
		height:40px;
		border-radius:14px;
		background:linear-gradient(135deg, #0ea5e9, #4f46e5);
		display:grid;
		place-items:center;
		color:#fff;
		font-weight:800;
	}

	.profile-text{
		display:flex;
		flex-direction:column;
		line-height:1.15;
		min-width:0;
	}

	.profile-text strong{
		font-size:14px;
		white-space:nowrap;
		overflow:hidden;
		text-overflow:ellipsis;
	}

	.profile-text span{
		font-size:12px;
		color:var(--muted);
	}

	.hero{
		margin-top:20px;
		padding:22px;
		background:
			radial-gradient(circle at top left, rgba(79,70,229,.16), transparent 32%),
			radial-gradient(circle at top right, rgba(34,197,94,.14), transparent 30%),
			linear-gradient(180deg, #ffffff 0%, #fbfdff 100%);
		border:1px solid var(--border);
		border-radius:28px;
		box-shadow:var(--shadow);
	}

	.hero-grid{
		display:grid;
		grid-template-columns: 1.6fr .9fr;
		gap:18px;
		align-items:stretch;
	}

	.hero-main,
	.hero-side{
		border-radius:24px;
		background:rgba(255,255,255,.7);
		border:1px solid rgba(226,232,240,.8);
		backdrop-filter:blur(10px);
		box-shadow:0 12px 30px rgba(15,23,42,.04);
	}

	.hero-main{
		padding:24px;
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
		letter-spacing:.03em;
	}

	.live-dot{
		width:9px;
		height:9px;
		border-radius:50%;
		background:#22c55e;
		box-shadow:0 0 0 6px rgba(34,197,94,.14);
	}

	.hero-main h3{
		margin-top:14px;
		font-size:28px;
		line-height:1.18;
		font-weight:900;
	}

	.hero-main p{
		margin-top:10px;
		color:var(--muted);
		font-size:15px;
		line-height:1.65;
		max-width:760px;
	}

	.hero-meta{
		display:flex;
		flex-wrap:wrap;
		gap:10px;
		margin-top:18px;
	}

	.meta-pill{
		display:inline-flex;
		align-items:center;
		gap:8px;
		padding:10px 14px;
		border-radius:999px;
		background:#f8fafc;
		border:1px solid var(--border);
		color:#334155;
		font-size:13px;
		font-weight:700;
	}

	.hero-actions{
		display:flex;
		flex-wrap:wrap;
		gap:12px;
		margin-top:20px;
	}

	.btn{
		display:inline-flex;
		align-items:center;
		justify-content:center;
		gap:10px;
		padding:12px 16px;
		border-radius:16px;
		text-decoration:none;
		font-weight:800;
		transition:.22s ease;
		border:1px solid transparent;
	}

	.btn-primary{
		background:linear-gradient(135deg, var(--primary), var(--primary-2));
		color:#fff;
		box-shadow:0 16px 24px rgba(79,70,229,.22);
	}

	.btn-secondary{
		background:#fff;
		border-color:var(--border);
		color:var(--text);
	}

	.btn:hover{
		transform:translateY(-2px);
	}

	.hero-side{
		padding:18px;
		display:flex;
		flex-direction:column;
		gap:12px;
	}

	.side-card{
		padding:16px;
		background:#fff;
		border:1px solid var(--border);
		border-radius:20px;
		box-shadow:0 8px 18px rgba(15,23,42,.04);
	}

	.side-card .small-label{
		display:block;
		font-size:12px;
		color:var(--muted);
		font-weight:700;
		margin-bottom:6px;
	}

	.side-card .big-value{
		font-size:28px;
		font-weight:900;
		line-height:1.1;
	}

	.side-card .subline{
		display:flex;
		align-items:center;
		justify-content:space-between;
		margin-top:8px;
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

	.stats-grid{
		display:grid;
		grid-template-columns:repeat(4, minmax(0, 1fr));
		gap:16px;
		margin-top:20px;
	}

	.stat-card{
		display:block;
		padding:18px;
		background:var(--surface);
		border:1px solid var(--border);
		border-radius:24px;
		box-shadow:var(--shadow-soft);
		text-decoration:none;
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
		font-size:18px;
		color:#fff;
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
		font-size:26px;
		font-weight:900;
		line-height:1;
		letter-spacing:-.03em;
	}

	.stat-note{
		margin-top:8px;
		font-size:12px;
		color:#94a3b8;
	}

	.section-title{
		display:flex;
		align-items:flex-end;
		justify-content:space-between;
		gap:12px;
		margin:26px 4px 14px;
	}

	.section-title h4{
		font-size:20px;
		font-weight:900;
	}

	.section-title span{
		color:var(--muted);
		font-size:13px;
	}

	.analytics-grid{
		display:grid;
		grid-template-columns:1.15fr .95fr;
		gap:16px;
		margin-top:6px;
	}

	.panel{
		background:var(--surface);
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

	.panel-header h5{
		font-size:18px;
		font-weight:900;
	}

	.panel-header p{
		color:var(--muted);
		font-size:13px;
		margin-top:4px;
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
	}

	.summary-item.room{ border-left:5px solid var(--primary); }
	.summary-item.contact{ border-left:5px solid var(--info); }
	.summary-item.occupation{ border-left:5px solid var(--warning); }
	.summary-item.email{ border-left:5px solid var(--success); }

	.chips{
		display:flex;
		flex-wrap:wrap;
		gap:10px;
		margin-top:12px;
	}

	.chip{
		padding:10px 12px;
		border-radius:999px;
		background:#f8fafc;
		border:1px solid var(--border);
		font-size:13px;
		font-weight:700;
		color:#334155;
		text-decoration:none;
	}

	.quick-actions{
		margin-top:20px;
	}

	.action-grid{
		display:grid;
		grid-template-columns:repeat(4, minmax(0, 1fr));
		gap:16px;
	}

	.action-card{
		display:block;
		text-decoration:none;
		padding:18px;
		background:var(--surface);
		border:1px solid var(--border);
		border-radius:24px;
		box-shadow:var(--shadow-soft);
		transition:.22s ease;
	}

	.action-card:hover{
		transform:translateY(-4px);
		box-shadow:var(--shadow);
	}

	.action-card .icon{
		width:48px;
		height:48px;
		border-radius:16px;
		display:grid;
		place-items:center;
		color:#fff;
		font-size:18px;
		margin-bottom:14px;
	}

	.action-card h6{
		font-size:15px;
		font-weight:900;
	}

	.action-card p{
		margin-top:8px;
		font-size:13px;
		color:var(--muted);
		line-height:1.5;
	}

	.footer{
		margin-top:24px;
		padding:18px 6px 0;
		color:var(--muted);
		font-size:13px;
		text-align:center;
	}

	.bottom-nav{
		display:none;
		position:fixed;
		left:0;
		right:0;
		bottom:0;
		z-index:1100;
		background:rgba(255,255,255,.92);
		backdrop-filter:blur(16px);
		border-top:1px solid var(--border);
		padding:10px 10px calc(10px + env(safe-area-inset-bottom));
		box-shadow:0 -12px 30px rgba(15,23,42,.08);
	}

	.bottom-nav-inner{
		display:grid;
		grid-template-columns:repeat(5, 1fr);
		gap:8px;
	}

	.bottom-item{
		display:flex;
		flex-direction:column;
		align-items:center;
		justify-content:center;
		gap:6px;
		padding:8px 4px;
		border-radius:16px;
		text-decoration:none;
		color:#334155;
		font-size:11px;
		font-weight:800;
	}

	.bottom-item i{
		font-size:17px;
	}

	.bottom-item.more{
		background:linear-gradient(135deg, var(--primary), var(--primary-2));
		color:#fff;
		border:none;
		cursor:pointer;
	}

	@media (max-width: 1280px){
		.stats-grid{
			grid-template-columns:repeat(2, minmax(0, 1fr));
		}

		.action-grid{
			grid-template-columns:repeat(2, minmax(0, 1fr));
		}

		.analytics-grid{
			grid-template-columns:1fr;
		}
	}

	@media (max-width: 992px){
		.sidebar{
			transform:translateX(-105%);
			width:min(90vw, 320px);
		}

		.sidebar.open{
			transform:translateX(0);
		}

		.main{
			margin-left:0;
			padding:16px 16px 100px;
		}

		.menu-btn{
			display:inline-flex;
		}

		.search-form{
			max-width:none;
		}

		.topbar{
			gap:12px;
			padding:12px;
			top:10px;
		}

		.page-title h2{
			font-size:18px;
		}

		.hero-grid{
			grid-template-columns:1fr;
		}
	}

	@media (max-width: 768px){
		.topbar-right{
			display:none;
		}

		.hero{
			padding:16px;
			border-radius:22px;
		}

		.hero-main{
			padding:18px;
		}

		.hero-main h3{
			font-size:22px;
		}

		.stats-grid{
			grid-template-columns:1fr;
		}

		.action-grid{
			grid-template-columns:1fr;
		}

		.section-title{
			flex-direction:column;
			align-items:flex-start;
		}

		.bottom-nav{
			display:block;
		}
	}

	@media (max-width: 480px){
		.main{
			padding:12px 12px 106px;
		}

		.topbar{
			border-radius:20px;
		}

		.hero{
			border-radius:20px;
		}

		.panel{
			border-radius:22px;
		}

		.action-card,
		.stat-card{
			border-radius:20px;
		}
	}
</style>
</head>

<body>

<div class="overlay" id="overlay" onclick="closeSidebar()"></div>

<aside class="sidebar" id="sidebar">
	<div class="brand">
		<div class="brand-logo">
			<i class="fa-solid fa-house-user"></i>
		</div>
		<div class="brand-title">
			<h1>Smart PG Tenant</h1>
			<span>Personal dashboard</span>
		</div>
	</div>

	<div class="sidebar-scroll">
		<div class="nav-group">
			<div class="nav-group-title">Overview</div>
			<a class="nav-link active" href="<%=ctx%>/tenant-dashboard" onclick="closeSidebar()">
				<i class="fa-solid fa-gauge-high"></i> Dashboard
			</a>
			<a class="nav-link" href="<%=ctx%>/tenant-profile" onclick="closeSidebar()">
				<i class="fa-solid fa-user"></i> My Profile
			</a>
			<a class="nav-link" href="<%=ctx%>/tenant-payment-history" onclick="closeSidebar()">
				<i class="fa-solid fa-clock-rotate-left"></i> Payment History
			</a>
			<a class="nav-link" href="<%=ctx%>/tenant-rent-status" onclick="closeSidebar()">
				<i class="fa-solid fa-wallet"></i> Rent Status
			</a>
		</div>

		<div class="nav-group">
			<div class="nav-group-title">Services</div>
			<a class="nav-link" href="changePassword.jsp" onclick="closeSidebar()">
				<i class="fa-solid fa-lock"></i> Change Password
			</a>
			<a class="nav-link" href="addComplaint.jsp" onclick="closeSidebar()">
				<i class="fa-solid fa-pen-to-square"></i> Raise Complaint
			</a>
			<a class="nav-link" href="<%=ctx%>/tenant-complaints" onclick="closeSidebar()">
				<i class="fa-solid fa-list-check"></i> Complaint History
			</a>
			<a class="nav-link" href="<%=ctx%>/tenant-notices" onclick="closeSidebar()">
				<i class="fa-solid fa-bullhorn"></i> Notice Board
			</a>
			<a class="nav-link" href="<%=ctx%>/today-menu" onclick="closeSidebar()">
				<i class="fa-solid fa-utensils"></i> Today’s Menu
			</a>
			<a class="nav-link" href="<%=ctx%>/tenant-payment" onclick="closeSidebar()">
				<i class="fa-solid fa-indian-rupee-sign"></i> Pay Rent
			</a>
		</div>

		<div class="nav-group">
			<div class="nav-group-title">Support</div>
			<a class="nav-link" href="<%=ctx%>/contact-admin" onclick="closeSidebar()">
				<i class="fa-solid fa-phone"></i> Contact Admin
			</a>
			<a class="nav-link" href="<%=ctx%>/about-pg" onclick="closeSidebar()">
				<i class="fa-solid fa-circle-info"></i> About PG
			</a>
		</div>
	</div>

	<div class="sidebar-footer">
		<a class="logout-btn" href="<%=ctx%>/tenant-logout" onclick="return confirm('Are you sure you want to logout?')">
			<i class="fa-solid fa-right-from-bracket"></i>
			Logout
		</a>
	</div>
</aside>

<main class="main">
	<div class="topbar">
		<div class="topbar-left">
			<button class="menu-btn" type="button" onclick="openSidebar()">
				<i class="fa-solid fa-bars"></i>
			</button>

			<div class="page-title">
				<h2>Tenant Dashboard</h2>
				<span>Welcome back, <%=displayName%></span>
			</div>
		</div>

		<div class="topbar-right">
			<form class="search-form" action="<%=ctx%>/tenant-notices" method="get">
				<i class="fa-solid fa-magnifying-glass"></i>
				<input class="search-input" type="text" name="keyword" placeholder="Search notices or updates..." />
				<button class="search-btn" type="submit">Search</button>
			</form>

			<div class="top-icons">
				<a class="icon-chip" href="<%=ctx%>/tenant-notices" title="Notices">
					<i class="fa-regular fa-bell"></i>
					<span class="icon-badge">!</span>
				</a>

				<div class="profile-chip" title="Tenant profile">
					<div class="avatar"><%=avatar%></div>
					<div class="profile-text">
						<strong><%=displayName%></strong>
						<span>Room <%=roomNo > 0 ? roomNo : "-" %></span>
					</div>
				</div>
			</div>
		</div>
	</div>

	<section class="hero">
		<div class="hero-grid">
			<div class="hero-main">
				<div class="live-tag">
					<span class="live-dot"></span>
					Tenant Services
				</div>

				<h3>Manage your rent, complaints, notices and profile from one clean dashboard.</h3>

				<p>
					This tenant interface follows the same modern style as the admin dashboard,
					but keeps the experience simple and mobile-friendly so it feels like a real service app.
				</p>

				<div class="hero-meta">
					<div class="meta-pill"><i class="fa-regular fa-calendar"></i> <%=today%></div>
					<div class="meta-pill"><i class="fa-solid fa-door-open"></i> Room <%=roomNo > 0 ? roomNo : "-" %></div>
					<div class="meta-pill"><i class="fa-solid fa-phone"></i> <%=phone%></div>
					<div class="meta-pill"><i class="fa-solid fa-id-badge"></i> <%=occupation%></div>
				</div>

				<div class="hero-actions">
					<a class="btn btn-primary" href="<%=ctx%>/tenant-payment">
						<i class="fa-solid fa-indian-rupee-sign"></i>
						Pay Rent
					</a>
					<a class="btn btn-secondary" href="<%=ctx%>/tenant-payment-history">
						<i class="fa-solid fa-clock-rotate-left"></i>
						Payment History
					</a>
					<a class="btn btn-secondary" href="addComplaint.jsp">
						<i class="fa-solid fa-pen-to-square"></i>
						Raise Complaint
					</a>
				</div>
			</div>

			<div class="hero-side">
				<div class="side-card">
					<span class="small-label">Room Number</span>
					<div class="big-value"><%=roomNo > 0 ? roomNo : "-" %></div>
					<div class="subline">
						<span>Current stay</span>
						<span class="badge-up"><i class="fa-solid fa-house"></i> Active</span>
					</div>
				</div>

				<div class="side-card">
					<span class="small-label">Contact</span>
					<div class="big-value" style="font-size:20px; word-break:break-word;"><%=phone%></div>
					<div class="subline">
						<span>Primary phone</span>
						<span class="badge-up"><i class="fa-solid fa-phone"></i> Reachable</span>
					</div>
				</div>

				<div class="side-card">
					<span class="small-label">Account Status</span>
					<div class="big-value" style="font-size:20px;">Tenant Access</div>
					<div class="subline">
						<span>Logged in as</span>
						<span class="badge-up"><i class="fa-solid fa-shield-heart"></i> Secure</span>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="stats-grid">
		<a class="stat-card" href="<%=ctx%>/tenant-profile">
			<div class="stat-top">
				<div>
					<div class="stat-label">Tenant Name</div>
					<div class="stat-value" style="font-size:24px;"><%=displayName%></div>
				</div>
				<div class="stat-icon bg-blue"><i class="fa-solid fa-user"></i></div>
			</div>
			<div class="stat-note">View and update your profile</div>
		</a>

		<a class="stat-card" href="<%=ctx%>/tenant-rent-status">
			<div class="stat-top">
				<div>
					<div class="stat-label">Rent Status</div>
					<div class="stat-value" style="font-size:24px;">Open</div>
				</div>
				<div class="stat-icon bg-green"><i class="fa-solid fa-wallet"></i></div>
			</div>
			<div class="stat-note">Check your monthly rent details</div>
		</a>

		<a class="stat-card" href="<%=ctx%>/tenant-notices">
			<div class="stat-top">
				<div>
					<div class="stat-label">Notice Board</div>
					<div class="stat-value" style="font-size:24px;">Open</div>
				</div>
				<div class="stat-icon bg-amber"><i class="fa-solid fa-bullhorn"></i></div>
			</div>
			<div class="stat-note">Read latest PG announcements</div>
		</a>

		<a class="stat-card" href="<%=ctx%>/tenant-complaints">
			<div class="stat-top">
				<div>
					<div class="stat-label">Complaint History</div>
					<div class="stat-value" style="font-size:24px;">Track</div>
				</div>
				<div class="stat-icon bg-red"><i class="fa-solid fa-list-check"></i></div>
			</div>
			<div class="stat-note">See complaint progress and status</div>
		</a>
	</section>

	<div class="section-title">
		<h4>Quick Actions</h4>
		<span>Most used tenant services</span>
	</div>

	<section class="quick-actions">
		<div class="action-grid">
			<a class="action-card" href="<%=ctx%>/tenant-profile">
				<div class="icon bg-blue"><i class="fa-solid fa-user"></i></div>
				<h6>My Profile</h6>
				<p>View your complete personal details.</p>
			</a>

			<a class="action-card" href="changePassword.jsp">
				<div class="icon bg-violet"><i class="fa-solid fa-lock"></i></div>
				<h6>Change Password</h6>
				<p>Update your account password securely.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/tenant-payment">
				<div class="icon bg-green"><i class="fa-solid fa-indian-rupee-sign"></i></div>
				<h6>Pay Rent</h6>
				<p>Make monthly payment request with UTR.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/tenant-payment-history">
				<div class="icon bg-amber"><i class="fa-solid fa-clock-rotate-left"></i></div>
				<h6>Payment History</h6>
				<p>View all previous rent payments.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/tenant-rent-status">
				<div class="icon bg-cyan"><i class="fa-solid fa-wallet"></i></div>
				<h6>Rent Status</h6>
				<p>See your current month rent details.</p>
			</a>

			<a class="action-card" href="addComplaint.jsp">
				<div class="icon bg-red"><i class="fa-solid fa-pen-to-square"></i></div>
				<h6>Raise Complaint</h6>
				<p>Submit a new complaint to admin.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/tenant-complaints">
				<div class="icon bg-slate"><i class="fa-solid fa-list-check"></i></div>
				<h6>Complaint History</h6>
				<p>Track your complaint statuses.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/tenant-notices">
				<div class="icon bg-amber"><i class="fa-solid fa-bullhorn"></i></div>
				<h6>Notice Board</h6>
				<p>Read PG notices and updates.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/today-menu">
				<div class="icon bg-violet"><i class="fa-solid fa-utensils"></i></div>
				<h6>Today’s Menu</h6>
				<p>Check breakfast, lunch, snacks, dinner.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/contact-admin">
				<div class="icon bg-cyan"><i class="fa-solid fa-phone"></i></div>
				<h6>Contact Admin</h6>
				<p>Get help from PG management anytime.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/about-pg">
				<div class="icon bg-slate"><i class="fa-solid fa-circle-info"></i></div>
				<h6>About PG</h6>
				<p>View PG rules and facility details.</p>
			</a>

			<a class="action-card" href="<%=ctx%>/tenant-logout" onclick="return confirm('Are you sure you want to logout?')">
				<div class="icon bg-rose"><i class="fa-solid fa-right-from-bracket"></i></div>
				<h6>Logout</h6>
				<p>Securely logout from your account.</p>
			</a>
		</div>
	</section>

	<div class="footer">Smart PG Management System © 2026</div>
</main>

<nav class="bottom-nav">
	<div class="bottom-nav-inner">
		<a class="bottom-item" href="<%=ctx%>/tenant-dashboard">
			<i class="fa-solid fa-house"></i>
			<span>Home</span>
		</a>
		<a class="bottom-item" href="<%=ctx%>/tenant-payment">
			<i class="fa-solid fa-indian-rupee-sign"></i>
			<span>Pay</span>
		</a>
		<a class="bottom-item" href="<%=ctx%>/tenant-notices">
			<i class="fa-solid fa-bullhorn"></i>
			<span>Notices</span>
		</a>
		<a class="bottom-item" href="addComplaint.jsp">
			<i class="fa-solid fa-pen-to-square"></i>
			<span>Complaint</span>
		</a>
		<button class="bottom-item more" type="button" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
			<span>Menu</span>
		</button>
	</div>
</nav>

<script>
	const sidebar = document.getElementById('sidebar');
	const overlay = document.getElementById('overlay');

	function openSidebar() {
		sidebar.classList.add('open');
		overlay.classList.add('show');
		document.body.style.overflow = 'hidden';
	}

	function closeSidebar() {
		sidebar.classList.remove('open');
		overlay.classList.remove('show');
		document.body.style.overflow = '';
	}

	function toggleSidebar() {
		if (sidebar.classList.contains('open')) {
			closeSidebar();
		} else {
			openSidebar();
		}
	}

	document.querySelectorAll('.sidebar a').forEach(link => {
		link.addEventListener('click', () => {
			if (window.innerWidth <= 992) {
				closeSidebar();
			}
		});
	});

	window.addEventListener('resize', () => {
		if (window.innerWidth > 992) {
			closeSidebar();
		}
	});
</script>

</body>
</html>