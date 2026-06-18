<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%!private int safeInt(Object value) { if (value==null) return 0; if (value instanceof Number) return ((Number)
		value).intValue(); try { return Integer.parseInt(String.valueOf(value)); } catch (Exception e) { return 0; } }
		private String fmt(int value) { return java.text.NumberFormat.getIntegerInstance().format(value); }%>

		<% // Protect dashboard if (session.getAttribute("adminUsername")==null) { response.sendRedirect("login.jsp");
			return; } String ctx=request.getContextPath(); String adminUsername=(String)
			session.getAttribute("adminUsername"); if (adminUsername==null || adminUsername.trim().isEmpty()) {
			adminUsername="Admin" ; } Integer totalTenantsAttr=(Integer) request.getAttribute("totalTenants"); Integer
			occupiedRoomsAttr=(Integer) request.getAttribute("occupiedRooms"); Integer totalRoomsAttr=(Integer)
			request.getAttribute("totalRooms"); Integer pendingFeesAttr=(Integer) request.getAttribute("pendingFees");
			Integer pendingComplaintsAttr=(Integer) request.getAttribute("pendingComplaints"); Integer
			totalCollectionAttr=(Integer) request.getAttribute("totalCollection"); Integer visitorsTodayAttr=(Integer)
			request.getAttribute("visitorsToday"); Integer totalEmployeesAttr=(Integer)
			request.getAttribute("totalEmployees"); Integer totalSalaryExpenseAttr=(Integer)
			request.getAttribute("totalSalaryExpense"); Integer paidTenantsAttr=(Integer)
			request.getAttribute("paidTenants"); Integer totalOccupiedAttr=(Integer)
			request.getAttribute("totalOccupied"); Integer totalAvailableAttr=(Integer)
			request.getAttribute("totalAvailable"); Integer totalExpenseAttr=(Integer)
			request.getAttribute("totalExpense"); Integer netProfitAttr=(Integer) request.getAttribute("netProfit"); int
			totalTenants=safeInt(totalTenantsAttr); int occupiedRooms=safeInt(occupiedRoomsAttr); int
			totalRooms=safeInt(totalRoomsAttr); int pendingFees=safeInt(pendingFeesAttr); int
			pendingComplaints=safeInt(pendingComplaintsAttr); int totalCollection=safeInt(totalCollectionAttr); int
			visitorsToday=safeInt(visitorsTodayAttr); int totalEmployees=safeInt(totalEmployeesAttr); int
			totalSalaryExpense=safeInt(totalSalaryExpenseAttr); int paidTenants=safeInt(paidTenantsAttr); int
			totalOccupied=safeInt(totalOccupiedAttr); int totalAvailable=safeInt(totalAvailableAttr); int
			totalExpense=safeInt(totalExpenseAttr); int netProfit=safeInt(netProfitAttr); String today=new
			java.text.SimpleDateFormat("dd MMMM yyyy").format(new java.util.Date()); System.out.println("home.jsp Loaded"); %>

			<!DOCTYPE html>
			<html lang="en">

			<head>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0">
				<title>Smart PG Management System</title>
				<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
				<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

				<style>
					:root {
						--bg: #f8fafc;
						--surface: #ffffff;
						--surface-2: #f1f5f9;
						--text: #0f172a;
						--muted: #64748b;
						--border: #e2e8f0;
						--primary: #4f46e5;
						--primary-2: #6366f1;
						--success: #22c55e;
						--warning: #f59e0b;
						--danger: #ef4444;
						--info: #06b6d4;
						--shadow: 0 14px 40px rgba(15, 23, 42, .08);
						--shadow-soft: 0 8px 24px rgba(15, 23, 42, .06);
						--radius: 22px;
						--radius-sm: 16px;
					}

					* {
						margin: 0;
						padding: 0;
						box-sizing: border-box;
						font-family: Segoe UI, Inter, system-ui, sans-serif;
					}

					body {
						background: var(--bg);
						color: var(--text);
						overflow-x: hidden;
					}

					a {
						color: inherit;
					}

					.overlay {
						position: fixed;
						inset: 0;
						background: rgba(15, 23, 42, .45);
						backdrop-filter: blur(2px);
						z-index: 900;
						opacity: 0;
						pointer-events: none;
						transition: .25s ease;
					}

					.overlay.show {
						opacity: 1;
						pointer-events: auto;
					}

					.sidebar {
						position: fixed;
						left: 0;
						top: 0;
						height: 100vh;
						width: 292px;
						background: linear-gradient(180deg, #0f172a 0%, #111827 100%);
						color: #fff;
						padding: 22px 18px;
						z-index: 1000;
						display: flex;
						flex-direction: column;
						border-right: 1px solid rgba(255, 255, 255, .08);
						box-shadow: 20px 0 50px rgba(2, 6, 23, .18);
						transition: transform .28s ease;
					}

					.brand {
						display: flex;
						align-items: center;
						gap: 12px;
						padding: 8px 8px 18px 8px;
						margin-bottom: 10px;
					}

					.brand-logo {
						width: 44px;
						height: 44px;
						border-radius: 14px;
						display: grid;
						place-items: center;
						background: linear-gradient(135deg, var(--primary), #22c55e);
						box-shadow: 0 10px 24px rgba(79, 70, 229, .35);
						flex: 0 0 auto;
					}

					.brand-title {
						display: flex;
						flex-direction: column;
						gap: 2px;
						min-width: 0;
					}

					.brand-title h1 {
						font-size: 16px;
						line-height: 1.2;
						font-weight: 800;
						letter-spacing: .3px;
					}

					.brand-title span {
						font-size: 12px;
						color: #94a3b8;
						white-space: nowrap;
						overflow: hidden;
						text-overflow: ellipsis;
					}

					.sidebar-scroll {
						flex: 1;
						overflow: auto;
						padding-right: 4px;
						margin-right: -4px;
					}

					.sidebar-scroll::-webkit-scrollbar {
						width: 8px;
					}

					.sidebar-scroll::-webkit-scrollbar-thumb {
						background: rgba(148, 163, 184, .25);
						border-radius: 999px;
					}

					.nav-group {
						margin-top: 18px;
					}

					.nav-group-title {
						font-size: 11px;
						text-transform: uppercase;
						letter-spacing: .14em;
						color: #94a3b8;
						padding: 0 10px 8px;
					}

					.nav-link {
						display: flex;
						align-items: center;
						gap: 12px;
						padding: 12px 14px;
						margin: 6px 4px;
						border-radius: 16px;
						text-decoration: none;
						color: #e2e8f0;
						font-weight: 600;
						transition: .22s ease;
						border: 1px solid transparent;
					}

					.nav-link i {
						width: 22px;
						text-align: center;
						font-size: 15px;
						color: #a5b4fc;
					}

					.nav-link:hover,
					.nav-link.active {
						background: rgba(79, 70, 229, .16);
						border-color: rgba(99, 102, 241, .22);
						transform: translateX(4px);
						color: #fff;
					}

					.sidebar-footer {
						padding: 16px 10px 6px;
						margin-top: 14px;
						border-top: 1px solid rgba(255, 255, 255, .08);
					}

					.logout-btn {
						display: flex;
						align-items: center;
						justify-content: center;
						gap: 10px;
						width: 100%;
						padding: 13px 16px;
						border-radius: 16px;
						background: linear-gradient(135deg, #ef4444, #dc2626);
						color: #fff;
						font-weight: 700;
						text-decoration: none;
						box-shadow: 0 12px 28px rgba(239, 68, 68, .24);
					}

					.main {
						margin-left: 292px;
						min-height: 100vh;
						padding: 24px 24px 92px;
					}

					.topbar {
						position: sticky;
						top: 16px;
						z-index: 300;
						display: flex;
						align-items: center;
						justify-content: space-between;
						gap: 16px;
						padding: 14px 16px;
						border: 1px solid rgba(226, 232, 240, .9);
						background: rgba(255, 255, 255, .78);
						backdrop-filter: blur(18px);
						border-radius: 24px;
						box-shadow: var(--shadow-soft);
					}

					.topbar-left {
						display: flex;
						align-items: center;
						gap: 14px;
						min-width: 0;
					}

					.menu-btn {
						display: none;
						align-items: center;
						justify-content: center;
						width: 46px;
						height: 46px;
						border: none;
						border-radius: 16px;
						background: var(--surface);
						box-shadow: 0 10px 24px rgba(15, 23, 42, .08);
						color: var(--text);
						cursor: pointer;
					}

					.page-title {
						display: flex;
						flex-direction: column;
						gap: 2px;
						min-width: 0;
					}

					.page-title h2 {
						font-size: 20px;
						line-height: 1.1;
						font-weight: 800;
					}

					.page-title span {
						font-size: 13px;
						color: var(--muted);
					}

					.topbar-right {
						display: flex;
						align-items: center;
						gap: 12px;
						flex: 1;
						justify-content: flex-end;
					}

					.search-form {
						flex: 1;
						max-width: 640px;
						display: flex;
						align-items: center;
						gap: 10px;
						padding: 8px;
						border: 1px solid var(--border);
						background: #fff;
						border-radius: 18px;
						box-shadow: 0 8px 18px rgba(15, 23, 42, .04);
					}

					.search-form i {
						color: #94a3b8;
						padding-left: 8px;
					}

					.search-input {
						flex: 1;
						border: none;
						outline: none;
						font-size: 15px;
						background: transparent;
						color: var(--text);
						min-width: 0;
					}

					.search-btn {
						border: none;
						outline: none;
						padding: 11px 16px;
						border-radius: 14px;
						background: linear-gradient(135deg, var(--primary), var(--primary-2));
						color: #fff;
						font-weight: 700;
						cursor: pointer;
					}

					.top-icons {
						display: flex;
						align-items: center;
						gap: 10px;
					}

					.icon-chip {
						width: 46px;
						height: 46px;
						border-radius: 16px;
						background: #fff;
						border: 1px solid var(--border);
						display: grid;
						place-items: center;
						box-shadow: 0 10px 18px rgba(15, 23, 42, .05);
						color: #334155;
						position: relative;
					}

					.icon-badge {
						position: absolute;
						top: -4px;
						right: -4px;
						min-width: 18px;
						height: 18px;
						padding: 0 5px;
						border-radius: 999px;
						background: var(--danger);
						color: #fff;
						font-size: 11px;
						font-weight: 800;
						display: grid;
						place-items: center;
						border: 2px solid #fff;
					}

					.profile-chip {
						display: flex;
						align-items: center;
						gap: 12px;
						padding: 8px 10px 8px 8px;
						background: #fff;
						border: 1px solid var(--border);
						border-radius: 18px;
						box-shadow: 0 10px 18px rgba(15, 23, 42, .05);
					}

					.avatar {
						width: 40px;
						height: 40px;
						border-radius: 14px;
						background: linear-gradient(135deg, #0ea5e9, #4f46e5);
						display: grid;
						place-items: center;
						color: #fff;
						font-weight: 800;
					}

					.profile-text {
						display: flex;
						flex-direction: column;
						line-height: 1.15;
						min-width: 0;
					}

					.profile-text strong {
						font-size: 14px;
						white-space: nowrap;
						overflow: hidden;
						text-overflow: ellipsis;
					}

					.profile-text span {
						font-size: 12px;
						color: var(--muted);
					}

					.hero {
						margin-top: 20px;
						padding: 22px;
						background: radial-gradient(circle at top left, rgba(79, 70, 229, .16),
								transparent 32%),
							radial-gradient(circle at top right, rgba(34, 197, 94, .14),
								transparent 30%), linear-gradient(180deg, #ffffff 0%, #fbfdff 100%);
						border: 1px solid var(--border);
						border-radius: 28px;
						box-shadow: var(--shadow);
					}

					.hero-grid {
						display: grid;
						grid-template-columns: 1.6fr .9fr;
						gap: 18px;
						align-items: stretch;
					}

					.hero-main,
					.hero-side {
						border-radius: 24px;
						background: rgba(255, 255, 255, .7);
						border: 1px solid rgba(226, 232, 240, .8);
						backdrop-filter: blur(10px);
						box-shadow: 0 12px 30px rgba(15, 23, 42, .04);
					}

					.hero-main {
						padding: 24px;
					}

					.live-tag {
						display: inline-flex;
						align-items: center;
						gap: 8px;
						padding: 8px 12px;
						border-radius: 999px;
						background: #ecfeff;
						color: #0f766e;
						font-size: 12px;
						font-weight: 800;
						letter-spacing: .03em;
					}

					.live-dot {
						width: 9px;
						height: 9px;
						border-radius: 50%;
						background: #22c55e;
						box-shadow: 0 0 0 6px rgba(34, 197, 94, .14);
					}

					.hero-main h3 {
						margin-top: 14px;
						font-size: 28px;
						line-height: 1.18;
						font-weight: 900;
					}

					.hero-main p {
						margin-top: 10px;
						color: var(--muted);
						font-size: 15px;
						line-height: 1.65;
						max-width: 760px;
					}

					.hero-meta {
						display: flex;
						flex-wrap: wrap;
						gap: 10px;
						margin-top: 18px;
					}

					.meta-pill {
						display: inline-flex;
						align-items: center;
						gap: 8px;
						padding: 10px 14px;
						border-radius: 999px;
						background: #f8fafc;
						border: 1px solid var(--border);
						color: #334155;
						font-size: 13px;
						font-weight: 700;
					}

					.hero-actions {
						display: flex;
						flex-wrap: wrap;
						gap: 12px;
						margin-top: 20px;
					}

					.btn {
						display: inline-flex;
						align-items: center;
						justify-content: center;
						gap: 10px;
						padding: 12px 16px;
						border-radius: 16px;
						text-decoration: none;
						font-weight: 800;
						transition: .22s ease;
						border: 1px solid transparent;
					}

					.btn-primary {
						background: linear-gradient(135deg, var(--primary), var(--primary-2));
						color: #fff;
						box-shadow: 0 16px 24px rgba(79, 70, 229, .22);
					}

					.btn-secondary {
						background: #fff;
						border-color: var(--border);
						color: var(--text);
					}

					.btn:hover {
						transform: translateY(-2px);
					}

					.hero-side {
						padding: 18px;
						display: flex;
						flex-direction: column;
						gap: 12px;
					}

					.side-card {
						padding: 16px;
						background: #fff;
						border: 1px solid var(--border);
						border-radius: 20px;
						box-shadow: 0 8px 18px rgba(15, 23, 42, .04);
					}

					.side-card .small-label {
						display: block;
						font-size: 12px;
						color: var(--muted);
						font-weight: 700;
						margin-bottom: 6px;
					}

					.side-card .big-value {
						font-size: 28px;
						font-weight: 900;
						line-height: 1.1;
					}

					.side-card .subline {
						display: flex;
						align-items: center;
						justify-content: space-between;
						margin-top: 8px;
						font-size: 13px;
						color: var(--muted);
					}

					.badge-up {
						color: var(--success);
						font-weight: 800;
					}

					.badge-down {
						color: var(--danger);
						font-weight: 800;
					}

					.stats-grid {
						display: grid;
						grid-template-columns: repeat(4, minmax(0, 1fr));
						gap: 16px;
						margin-top: 20px;
					}

					.stat-card {
						display: block;
						padding: 18px;
						background: var(--surface);
						border: 1px solid var(--border);
						border-radius: 24px;
						box-shadow: var(--shadow-soft);
						text-decoration: none;
						transition: .22s ease;
					}

					.stat-card:hover {
						transform: translateY(-4px);
						box-shadow: var(--shadow);
					}

					.stat-top {
						display: flex;
						align-items: flex-start;
						justify-content: space-between;
						gap: 12px;
					}

					.stat-icon {
						width: 46px;
						height: 46px;
						border-radius: 16px;
						display: grid;
						place-items: center;
						font-size: 18px;
						color: #fff;
						flex: 0 0 auto;
					}

					.bg-blue {
						background: linear-gradient(135deg, #2563eb, #4f46e5);
					}

					.bg-green {
						background: linear-gradient(135deg, #22c55e, #16a34a);
					}

					.bg-amber {
						background: linear-gradient(135deg, #f59e0b, #ea580c);
					}

					.bg-red {
						background: linear-gradient(135deg, #ef4444, #dc2626);
					}

					.bg-cyan {
						background: linear-gradient(135deg, #06b6d4, #0ea5e9);
					}

					.bg-violet {
						background: linear-gradient(135deg, #8b5cf6, #6366f1);
					}

					.bg-slate {
						background: linear-gradient(135deg, #334155, #0f172a);
					}

					.bg-rose {
						background: linear-gradient(135deg, #fb7185, #f43f5e);
					}

					.stat-label {
						margin-top: 12px;
						font-size: 14px;
						color: var(--muted);
						font-weight: 700;
					}

					.stat-value {
						margin-top: 6px;
						font-size: 28px;
						font-weight: 900;
						line-height: 1;
						letter-spacing: -.03em;
					}

					.stat-note {
						margin-top: 8px;
						font-size: 12px;
						color: #94a3b8;
					}

					.section-title {
						display: flex;
						align-items: flex-end;
						justify-content: space-between;
						gap: 12px;
						margin: 26px 4px 14px;
					}

					.section-title h4 {
						font-size: 20px;
						font-weight: 900;
					}

					.section-title span {
						color: var(--muted);
						font-size: 13px;
					}

					.analytics-grid {
						display: grid;
						grid-template-columns: 1.35fr .85fr;
						gap: 16px;
						margin-top: 6px;
					}

					.panel {
						background: var(--surface);
						border: 1px solid var(--border);
						border-radius: 28px;
						box-shadow: var(--shadow-soft);
						padding: 18px;
					}

					.chart-panel {
						min-height: 410px;
					}

					.panel-header {
						display: flex;
						align-items: flex-start;
						justify-content: space-between;
						gap: 12px;
						margin-bottom: 14px;
					}

					.panel-header h5 {
						font-size: 18px;
						font-weight: 900;
					}

					.panel-header p {
						color: var(--muted);
						font-size: 13px;
						margin-top: 4px;
					}

					.chart-wrap {
						position: relative;
						height: 330px;
					}

					.summary-grid {
						display: grid;
						grid-template-columns: 1fr;
						gap: 12px;
					}

					.summary-item {
						padding: 16px;
						border: 1px solid var(--border);
						border-radius: 20px;
						background: linear-gradient(180deg, #ffffff 0%, #fbfdff 100%);
					}

					.summary-item .row {
						display: flex;
						align-items: center;
						justify-content: space-between;
						gap: 10px;
					}

					.summary-item .row strong {
						font-size: 14px;
					}

					.summary-item .value {
						margin-top: 8px;
						font-size: 26px;
						font-weight: 900;
						line-height: 1;
					}

					.summary-item .desc {
						margin-top: 6px;
						font-size: 12px;
						color: var(--muted);
					}

					.summary-item.revenue {
						border-left: 5px solid var(--success);
					}

					.summary-item.expense {
						border-left: 5px solid var(--danger);
					}

					.summary-item.salary {
						border-left: 5px solid var(--warning);
					}

					.summary-item.profit {
						border-left: 5px solid var(--primary);
					}

					.chips {
						display: flex;
						flex-wrap: wrap;
						gap: 10px;
						margin-top: 12px;
					}

					.chip {
						padding: 10px 12px;
						border-radius: 999px;
						background: #f8fafc;
						border: 1px solid var(--border);
						font-size: 13px;
						font-weight: 700;
						color: #334155;
						text-decoration: none;
					}

					.quick-actions {
						margin-top: 20px;
					}

					.action-grid {
						display: grid;
						grid-template-columns: repeat(4, minmax(0, 1fr));
						gap: 16px;
					}

					.action-card {
						display: block;
						text-decoration: none;
						padding: 18px;
						background: var(--surface);
						border: 1px solid var(--border);
						border-radius: 24px;
						box-shadow: var(--shadow-soft);
						transition: .22s ease;
					}

					.action-card:hover {
						transform: translateY(-4px);
						box-shadow: var(--shadow);
					}

					.action-card .icon {
						width: 48px;
						height: 48px;
						border-radius: 16px;
						display: grid;
						place-items: center;
						color: #fff;
						font-size: 18px;
						margin-bottom: 14px;
					}

					.action-card h6 {
						font-size: 15px;
						font-weight: 900;
					}

					.action-card p {
						margin-top: 8px;
						font-size: 13px;
						color: var(--muted);
						line-height: 1.5;
					}

					.footer {
						margin-top: 24px;
						padding: 18px 6px 0;
						color: var(--muted);
						font-size: 13px;
						text-align: center;
					}

					.bottom-nav {
						display: none;
						position: fixed;
						left: 0;
						right: 0;
						bottom: 0;
						z-index: 1100;
						background: rgba(255, 255, 255, .92);
						backdrop-filter: blur(16px);
						border-top: 1px solid var(--border);
						padding: 10px 10px calc(10px + env(safe-area-inset-bottom));
						box-shadow: 0 -12px 30px rgba(15, 23, 42, .08);
					}

					.bottom-nav-inner {
						display: grid;
						grid-template-columns: repeat(5, 1fr);
						gap: 8px;
					}

					.bottom-item {
						display: flex;
						flex-direction: column;
						align-items: center;
						justify-content: center;
						gap: 6px;
						padding: 8px 4px;
						border-radius: 16px;
						text-decoration: none;
						color: #334155;
						font-size: 11px;
						font-weight: 800;
					}

					.bottom-item i {
						font-size: 17px;
					}

					.bottom-item.more {
						background: linear-gradient(135deg, var(--primary), var(--primary-2));
						color: #fff;
					}

					/* Responsive */
					@media (max-width : 1280px) {
						.stats-grid {
							grid-template-columns: repeat(2, minmax(0, 1fr));
						}

						.action-grid {
							grid-template-columns: repeat(2, minmax(0, 1fr));
						}

						.analytics-grid {
							grid-template-columns: 1fr;
						}
					}

					@media (max-width : 992px) {
						.sidebar {
							transform: translateX(-105%);
							width: min(90vw, 320px);
						}

						.sidebar.open {
							transform: translateX(0);
						}

						.main {
							margin-left: 0;
							padding: 16px 16px 100px;
						}

						.menu-btn {
							display: inline-flex;
						}

						.search-form {
							max-width: none;
						}

						.topbar {
							gap: 12px;
							padding: 12px;
							top: 10px;
						}

						.page-title h2 {
							font-size: 18px;
						}

						.hero-grid {
							grid-template-columns: 1fr;
						}

						.chart-panel {
							min-height: 360px;
						}
					}

					@media (max-width : 768px) {
						.topbar-right {
							display: none;
						}

						.topbar {
							align-items: center;
						}

						.hero {
							padding: 16px;
							border-radius: 22px;
						}

						.hero-main {
							padding: 18px;
						}

						.hero-main h3 {
							font-size: 22px;
						}

						.stats-grid {
							grid-template-columns: 1fr;
						}

						.action-grid {
							grid-template-columns: 1fr;
						}

						.section-title {
							flex-direction: column;
							align-items: flex-start;
						}

						.bottom-nav {
							display: block;
						}
					}

					@media (max-width : 480px) {
						.main {
							padding: 12px 12px 106px;
						}

						.topbar {
							border-radius: 20px;
						}

						.hero {
							border-radius: 20px;
						}

						.panel {
							border-radius: 22px;
						}

						.action-card,
						.stat-card {
							border-radius: 20px;
						}

						.chart-wrap {
							height: 280px;
						}
					}
				</style>
			</head>

			<body>

				<div class="overlay" id="overlay" onclick="closeSidebar()"></div>

				<aside class="sidebar" id="sidebar">
					<div class="brand">
						<div class="brand-logo">
							<i class="fa-solid fa-building-user"></i>
						</div>
						<div class="brand-title">
							<h1>Smart PG Admin</h1>
							<span>Business dashboard</span>
						</div>
					</div>

					<div class="sidebar-scroll">
						<div class="nav-group">
							<div class="nav-group-title">Overview</div>
							<a class="nav-link active" href="<%=ctx%>/dashboard" onclick="closeSidebar()"><i
									class="fa-solid fa-gauge-high"></i>
								Dashboard</a> <a class="nav-link" href="<%=ctx%>/revenue-chart"
								onclick="closeSidebar()"><i class="fa-solid fa-chart-line"></i>
								Revenue Analytics</a> <a class="nav-link" href="<%=ctx%>/monthly-rent-summary"
								onclick="closeSidebar()"><i class="fa-solid fa-chart-pie"></i> Monthly Collection</a> <a
								class="nav-link" href="<%=ctx%>/month-wise-rent-analysis" onclick="closeSidebar()"><i
									class="fa-solid fa-calendar-days"></i>
								Rent Analysis</a>
						</div>

						<div class="nav-group">
							<div class="nav-group-title">Management</div>
							<a class="nav-link" href="<%=ctx%>/fetch-tenants" onclick="closeSidebar()"><i
									class="fa-solid fa-users"></i>
								Tenants</a> <a class="nav-link" href="<%=ctx%>/fetch-rooms" onclick="closeSidebar()"><i
									class="fa-solid fa-bed"></i> Rooms</a>
							<a class="nav-link" href="<%=ctx%>/fetch-fees" onclick="closeSidebar()"><i
									class="fa-solid fa-money-bill-wave"></i>
								Fees</a> <a class="nav-link" href="<%=ctx%>/fetch-payment-requests"
								onclick="closeSidebar()"><i class="fa-solid fa-receipt"></i>
								Payment Requests</a> <a class="nav-link" href="<%=ctx%>/fetch-complaints"
								onclick="closeSidebar()"><i class="fa-solid fa-triangle-exclamation"></i> Complaints</a>
							<a class="nav-link" href="<%=ctx%>/fetch-visitors" onclick="closeSidebar()"><i
									class="fa-solid fa-user-group"></i>
								Visitors</a> <a class="nav-link" href="<%=ctx%>/fetch-employees"
								onclick="closeSidebar()"><i class="fa-solid fa-user-tie"></i>
								Employees</a> <a class="nav-link" href="<%=ctx%>/fetch-notices"
								onclick="closeSidebar()"><i class="fa-solid fa-bullhorn"></i>
								Notices</a> <a class="nav-link" href="<%=ctx%>/fetch-expenses"
								onclick="closeSidebar()"><i class="fa-solid fa-wallet"></i>
								Expenses</a> <a class="nav-link" href="<%=ctx%>/fetch-admin-weekly-menu"
								onclick="closeSidebar()"><i class="fa-solid fa-utensils"></i>
								Weekly Menu</a> <a class="nav-link" href="<%=ctx%>/fetch-pg-info"
								onclick="closeSidebar()"><i class="fa-solid fa-circle-info"></i>
								PG Info</a> <a class="nav-link" href="<%=ctx%>/fetch-payment-details"
								onclick="closeSidebar()"><i class="fa-solid fa-credit-card"></i>
								Payment Settings</a>
						</div>

						<div class="nav-group">
							<div class="nav-group-title">Utility</div>
							<a class="nav-link" href="<%=ctx%>/fetch-paid-tenants" onclick="closeSidebar()"><i
									class="fa-solid fa-circle-check"></i>
								Paid Tenants</a> <a class="nav-link" href="<%=ctx%>/fetch-pending-fees"
								onclick="closeSidebar()"><i class="fa-solid fa-clock"></i>
								Pending Fees</a> <a class="nav-link" href="<%=ctx%>/fetch-checkout-history"
								onclick="closeSidebar()"><i class="fa-solid fa-right-from-bracket"></i> Checkout
								History</a> <a class="nav-link" href="<%=ctx%>/fetch-activities"
								onclick="closeSidebar()"><i class="fa-solid fa-clock-rotate-left"></i> Activities</a> <a
								class="nav-link" href="<%=ctx%>/fetch-pending-reminders" onclick="closeSidebar()"><i
									class="fa-solid fa-bell"></i>
								Pending Reminders</a>
						</div>
					</div>

					<div class="sidebar-footer">
						<a class="logout-btn" href="<%=ctx%>/logout"
							onclick="return confirm('Are you sure you want to logout?')"> <i
								class="fa-solid fa-right-from-bracket"></i> Logout
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
								<h2>Smart PG Dashboard</h2>
								<span>Welcome back, <%=adminUsername%></span>
							</div>
						</div>

						<div class="topbar-right">
							<form class="search-form" action="<%=ctx%>/global-search" method="get">
								<i class="fa-solid fa-magnifying-glass"></i> <input class="search-input" type="text"
									name="keyword" placeholder="Search tenants, rooms, employees..." required>
								<button class="search-btn" type="submit">Search</button>
							</form>

							<div class="top-icons">
								<a class="icon-chip" href="<%=ctx%>/fetch-activities" title="Activities"> <i
										class="fa-regular fa-bell"></i> <span class="icon-badge">!</span>
								</a>
								<div class="profile-chip" title="Admin profile">
									<div class="avatar">
										<%=adminUsername.substring(0, 1).toUpperCase()%>
									</div>
									<div class="profile-text">
										<strong>
											<%=adminUsername%>
										</strong> <span>Administrator</span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<section class="hero">
						<div class="hero-grid">
							<div class="hero-main">
								<div class="live-tag">
									<span class="live-dot"></span> Live PG Operations
								</div>

								<h3>Manage tenants, rooms, payments, complaints, staff and
									revenue from one modern dashboard.</h3>

								<p>This interface is designed to feel responsive on mobile,
									tablet and laptop screens. The layout keeps your core business
									numbers visible first, with quick navigation for daily operations.
								</p>

								<div class="hero-meta">
									<div class="meta-pill">
										<i class="fa-regular fa-calendar"></i>
										<%=today%>
									</div>
									<div class="meta-pill">
										<i class="fa-solid fa-users"></i>
										<%=fmt(totalTenants)%>
											tenants
									</div>
									<div class="meta-pill">
										<i class="fa-solid fa-bed"></i>
										<%=fmt(totalRooms)%>
											rooms
									</div>
									<div class="meta-pill">
										<i class="fa-solid fa-indian-rupee-sign"></i>
										<%=fmt(totalCollection)%>
											revenue
									</div>
								</div>

								<div class="hero-actions">
									<a class="btn btn-primary" href="<%=ctx%>/revenue-chart"> <i
											class="fa-solid fa-chart-line"></i> View Revenue Chart
									</a> <a class="btn btn-secondary" href="<%=ctx%>/global-search"> <i
											class="fa-solid fa-magnifying-glass"></i> Global Search
									</a> <a class="btn btn-secondary" href="<%=ctx%>/fetch-payment-requests"> <i
											class="fa-solid fa-receipt"></i> Payment Requests
									</a>
								</div>
							</div>

							<div class="hero-side">
								<div class="side-card">
									<span class="small-label">Today’s Revenue</span>
									<div class="big-value">
										₹
										<%=fmt(totalCollection)%>
									</div>
									<div class="subline">
										<span>Collection status</span> <span class="badge-up"><i
												class="fa-solid fa-arrow-trend-up"></i> Stable</span>
									</div>
								</div>

								<div class="side-card">
									<span class="small-label">Pending Fees</span>
									<div class="big-value">
										<%=fmt(pendingFees)%>
									</div>
									<div class="subline">
										<span>Tenants waiting</span> <span class="badge-down"><i
												class="fa-solid fa-triangle-exclamation"></i> Attention</span>
									</div>
								</div>

								<div class="side-card">
									<span class="small-label">Net Profit</span>
									<div class="big-value">
										₹
										<%=fmt(netProfit)%>
									</div>
									<div class="subline">
										<span>After expenses</span> <span class="<%=netProfit >= 0 ? " badge-up"
											: "badge-down" %>">
											<%=netProfit>= 0 ? "Profit" : "Loss"%>
										</span>
									</div>
								</div>
							</div>
						</div>
					</section>

					<section class="stats-grid">
						<a class="stat-card" href="<%=ctx%>/fetch-tenants">
							<div class="stat-top">
								<div>
									<div class="stat-label">Total Tenants</div>
									<div class="stat-value">
										<%=fmt(totalTenants)%>
									</div>
								</div>
								<div class="stat-icon bg-blue">
									<i class="fa-solid fa-users"></i>
								</div>
							</div>
							<div class="stat-note">Registered and active tenants</div>
						</a> <a class="stat-card" href="<%=ctx%>/fetch-rooms">
							<div class="stat-top">
								<div>
									<div class="stat-label">Total Rooms</div>
									<div class="stat-value">
										<%=fmt(totalRooms)%>
									</div>
								</div>
								<div class="stat-icon bg-violet">
									<i class="fa-solid fa-building"></i>
								</div>
							</div>
							<div class="stat-note">Rooms available in the PG</div>
						</a> <a class="stat-card" href="<%=ctx%>/fetch-paid-tenants">
							<div class="stat-top">
								<div>
									<div class="stat-label">Paid Tenants</div>
									<div class="stat-value">
										<%=fmt(paidTenants)%>
									</div>
								</div>
								<div class="stat-icon bg-green">
									<i class="fa-solid fa-circle-check"></i>
								</div>
							</div>
							<div class="stat-note">Payments verified by admin</div>
						</a> <a class="stat-card" href="<%=ctx%>/fetch-pending-fees">
							<div class="stat-top">
								<div>
									<div class="stat-label">Pending Fees</div>
									<div class="stat-value">
										<%=fmt(pendingFees)%>
									</div>
								</div>
								<div class="stat-icon bg-amber">
									<i class="fa-solid fa-clock"></i>
								</div>
							</div>
							<div class="stat-note">Fees waiting for approval</div>
						</a> <a class="stat-card" href="<%=ctx%>/fetch-complaints">
							<div class="stat-top">
								<div>
									<div class="stat-label">Pending Complaints</div>
									<div class="stat-value">
										<%=fmt(pendingComplaints)%>
									</div>
								</div>
								<div class="stat-icon bg-red">
									<i class="fa-solid fa-triangle-exclamation"></i>
								</div>
							</div>
							<div class="stat-note">Issues that need attention</div>
						</a> <a class="stat-card" href="<%=ctx%>/fetch-visitors">
							<div class="stat-top">
								<div>
									<div class="stat-label">Visitors Today</div>
									<div class="stat-value">
										<%=fmt(visitorsToday)%>
									</div>
								</div>
								<div class="stat-icon bg-cyan">
									<i class="fa-solid fa-user-group"></i>
								</div>
							</div>
							<div class="stat-note">Entries recorded today</div>
						</a> <a class="stat-card" href="<%=ctx%>/fetch-employees">
							<div class="stat-top">
								<div>
									<div class="stat-label">Total Staff</div>
									<div class="stat-value">
										<%=fmt(totalEmployees)%>
									</div>
								</div>
								<div class="stat-icon bg-slate">
									<i class="fa-solid fa-user-tie"></i>
								</div>
							</div>
							<div class="stat-note">Employees and service staff</div>
						</a> <a class="stat-card" href="<%=ctx%>/fetch-expenses">
							<div class="stat-top">
								<div>
									<div class="stat-label">Total Expenses</div>
									<div class="stat-value">
										₹
										<%=fmt(totalExpense)%>
									</div>
								</div>
								<div class="stat-icon bg-rose">
									<i class="fa-solid fa-wallet"></i>
								</div>
							</div>
							<div class="stat-note">Operational and maintenance costs</div>
						</a>
					</section>

					<div class="section-title">
						<h4>Business Analytics</h4>
						<span>Current financial snapshot and trend summary</span>
					</div>

					<section class="analytics-grid">
						<div class="panel chart-panel">
							<div class="panel-header">
								<div>
									<h5>Revenue vs Expense vs Salary</h5>
									<p>Visual summary of your current business health</p>
								</div>
								<a class="chip" href="<%=ctx%>/revenue-chart"> <i
										class="fa-solid fa-arrow-up-right-from-square"></i> Open full
									chart
								</a>
							</div>
							<div class="chart-wrap">
								<canvas id="financeChart"></canvas>
							</div>
						</div>

						<div class="panel">
							<div class="panel-header">
								<div>
									<h5>Overview Snapshot</h5>
									<p>Quick financial status cards</p>
								</div>
							</div>

							<div class="summary-grid">
								<div class="summary-item revenue">
									<div class="row">
										<strong><i class="fa-solid fa-indian-rupee-sign"></i>
											Revenue</strong> <span class="badge-up">Collection</span>
									</div>
									<div class="value">
										₹
										<%=fmt(totalCollection)%>
									</div>
									<div class="desc">Collected from paid fee records</div>
								</div>

								<div class="summary-item expense">
									<div class="row">
										<strong><i class="fa-solid fa-file-invoice-dollar"></i>
											Expenses</strong> <span class="badge-down">Cost</span>
									</div>
									<div class="value">
										₹
										<%=fmt(totalExpense)%>
									</div>
									<div class="desc">All business expenses combined</div>
								</div>

								<div class="summary-item salary">
									<div class="row">
										<strong><i class="fa-solid fa-hand-holding-dollar"></i>
											Salary</strong> <span class="badge-down">Payroll</span>
									</div>
									<div class="value">
										₹
										<%=fmt(totalSalaryExpense)%>
									</div>
									<div class="desc">Monthly salary spending</div>
								</div>

								<div class="summary-item profit">
									<div class="row">
										<strong><i class="fa-solid fa-chart-simple"></i> Net
											Profit</strong> <span class="<%=netProfit >= 0 ? " badge-up" : "badge-down"
											%>"><%=netProfit>= 0 ? "Positive" : "Negative"%></span>
									</div>
									<div class="value">
										₹
										<%=fmt(netProfit)%>
									</div>
									<div class="desc">Revenue minus expense and salary</div>
								</div>
							</div>

							<div class="chips">
								<a class="chip" href="<%=ctx%>/monthly-rent-summary"><i
										class="fa-solid fa-chart-pie"></i> Monthly Collection</a> <a class="chip"
									href="<%=ctx%>/month-wise-rent-analysis"><i class="fa-regular fa-calendar"></i> Rent
									Analysis</a> <a class="chip" href="<%=ctx%>/fetch-pending-reminders"><i
										class="fa-solid fa-bell"></i> Send Reminders</a> <a class="chip"
									href="<%=ctx%>/fetch-reminder-history"><i class="fa-solid fa-clock-rotate-left"></i>
									Reminder History</a>
							</div>
						</div>
					</section>

					<div class="section-title">
						<h4>Quick Actions</h4>
						<span>One-tap access to the most used operations</span>
					</div>

					<section class="quick-actions">
						<div class="action-grid">
							<a class="action-card" href="addTenant.jsp">
								<div class="icon bg-blue">
									<i class="fa-solid fa-user-plus"></i>
								</div>
								<h6>Add Tenant</h6>
								<p>Create a fresh tenant record quickly.</p>
							</a> <a class="action-card" href="addRoom.jsp">
								<div class="icon bg-violet">
									<i class="fa-solid fa-door-open"></i>
								</div>
								<h6>Manage Rooms</h6>
								<p>Add or update room details.</p>
							</a> <a class="action-card" href="addFee.jsp">
								<div class="icon bg-green">
									<i class="fa-solid fa-money-check-dollar"></i>
								</div>
								<h6>Fee Management</h6>
								<p>Maintain monthly payment data.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-payment-requests">
								<div class="icon bg-amber">
									<i class="fa-solid fa-receipt"></i>
								</div>
								<h6>Payment Requests</h6>
								<p>Approve and verify tenant payments.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-complaints">
								<div class="icon bg-red">
									<i class="fa-solid fa-triangle-exclamation"></i>
								</div>
								<h6>Complaint Management</h6>
								<p>Review and resolve tenant complaints.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-visitors">
								<div class="icon bg-cyan">
									<i class="fa-solid fa-person-walking"></i>
								</div>
								<h6>Visitor Management</h6>
								<p>Register and track visitor entries.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-employees">
								<div class="icon bg-slate">
									<i class="fa-solid fa-people-group"></i>
								</div>
								<h6>Staff Management</h6>
								<p>Manage workers and salary details.</p>
							</a> <a class="action-card" href="<%=ctx%>/revenue-chart">
								<div class="icon bg-blue">
									<i class="fa-solid fa-chart-line"></i>
								</div>
								<h6>Revenue Analytics</h6>
								<p>Open the monthly revenue chart.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-notices">
								<div class="icon bg-amber">
									<i class="fa-solid fa-bullhorn"></i>
								</div>
								<h6>Notice Board</h6>
								<p>Publish important announcements.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-expenses">
								<div class="icon bg-rose">
									<i class="fa-solid fa-wallet"></i>
								</div>
								<h6>Expense Control</h6>
								<p>View and manage business expenses.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-pending-reminders">
								<div class="icon bg-green">
									<i class="fa-solid fa-bell"></i>
								</div>
								<h6>Rent Reminders</h6>
								<p>Email all tenants with pending rent.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-activities">
								<div class="icon bg-slate">
									<i class="fa-solid fa-clock-rotate-left"></i>
								</div>
								<h6>Activity Log</h6>
								<p>Track important system actions.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-admin-weekly-menu">
								<div class="icon bg-amber">
									<i class="fa-solid fa-utensils"></i>
								</div>
								<h6>Weekly Food Menu</h6>
								<p>Update and manage the weekly food menu.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-pg-info">
								<div class="icon bg-blue">
									<i class="fa-solid fa-circle-info"></i>
								</div>
								<h6>PG Information</h6>
								<p>Manage PG rules, ratings, maps, images and info.</p>
							</a> <a class="action-card" href="<%=ctx%>/fetch-payment-details">
								<div class="icon bg-green">
									<i class="fa-solid fa-credit-card"></i>
								</div>
								<h6>Payment Settings</h6>
								<p>Update Bank, UPI, and QR payment details.</p>
							</a> <a class="action-card" href="<%=ctx%>/reports">

								<div class="icon bg-blue">
									<i class="fa-solid fa-chart-line"></i>
								</div>

								<h6>Reports</h6>

								<p>View complete PG performance reports.</p>

							</a> <a class="action-card" href="<%=ctx%>/logout"
								onclick="return confirm('Are you sure you want to logout?')">

								<div class="icon bg-red">
									<i class="fa-solid fa-right-from-bracket"></i>
								</div>

								<h6>Logout</h6>

								<p>Sign out of your admin account securely.</p>

							</a>
						</div>
					</section>

					<div class="footer">Smart PG Management System © 2026</div>
				</main>

				<nav class="bottom-nav">
					<div class="bottom-nav-inner">
						<a class="bottom-item" href="<%=ctx%>/dashboard"> <i class="fa-solid fa-house"></i>
							<span>Home</span>
						</a> <a class="bottom-item" href="<%=ctx%>/fetch-tenants"> <i class="fa-solid fa-users"></i>
							<span>Tenants</span>
						</a> <a class="bottom-item" href="<%=ctx%>/fetch-fees"> <i
								class="fa-solid fa-money-bill-wave"></i> <span>Fees</span>
						</a> <a class="bottom-item" href="<%=ctx%>/fetch-complaints"> <i
								class="fa-solid fa-triangle-exclamation"></i> <span>Complaints</span>
						</a>
						<button class="bottom-item more" type="button" onclick="toggleSidebar()">
							<i class="fa-solid fa-bars"></i> <span>Menu</span>
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

					const financeCtx = document.getElementById('financeChart');
					if (financeCtx) {
						new Chart(financeCtx, {
							type: 'bar',
							data: {
								labels: ['Revenue', 'Expenses', 'Salary', 'Profit'],
								datasets: [{
									label: '₹ Amount',
									data: [<%=totalCollection %>, <%=totalExpense %>, <%=totalSalaryExpense %>, <%=netProfit %>],
									backgroundColor: [
										'rgba(34, 197, 94, 0.85)',
										'rgba(239, 68, 68, 0.85)',
										'rgba(245, 158, 11, 0.85)',
										'rgba(79, 70, 229, 0.85)'
									],
									borderColor: [
										'rgba(34, 197, 94, 1)',
										'rgba(239, 68, 68, 1)',
										'rgba(245, 158, 11, 1)',
										'rgba(79, 70, 229, 1)'
									],
									borderWidth: 1,
									borderRadius: 14,
									maxBarThickness: 64
								}]
							},
							options: {
								responsive: true,
								maintainAspectRatio: false,
								plugins: {
									legend: {
										display: false
									},
									tooltip: {
										callbacks: {
											label: function (context) {
												return '₹ ' + context.raw.toLocaleString();
											}
										}
									}
								},
								scales: {
									x: {
										grid: {
											display: false
										},
										ticks: {
											color: '#475569',
											font: {
												weight: '700'
											}
										}
									},
									y: {
										beginAtZero: true,
										grid: {
											color: 'rgba(148, 163, 184, 0.18)'
										},
										ticks: {
											color: '#64748b',
											callback: function (value) {
												return '₹ ' + value.toLocaleString();
											}
										}
									}
								}
							}
						});
					}
				</script>

			</body>

			</html>