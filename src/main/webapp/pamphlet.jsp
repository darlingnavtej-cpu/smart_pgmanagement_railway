<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Smart PG Management System - Owner & Tenant Brochure</title>
<link rel="icon" type="image/png" href="<%=ctx%>/images/favicon.png">

<!-- Fonts & Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

<style>
	:root {
		--bg: #f8fafc;
		--surface: #ffffff;
		--surface-2: #f1f5f9;
		--text: #0f172a;
		--muted: #64748b;
		--border: #e2e8f0;
		--primary: #4f46e5;
		--primary-gradient: linear-gradient(135deg, #4f46e5, #6366f1);
		--success: #22c55e;
		--success-gradient: linear-gradient(135deg, #22c55e, #10b981);
		--warning: #f59e0b;
		--danger: #ef4444;
		--info: #06b6d4;
		--purple: #8b5cf6;
		--dark-blue: #0f172a;
		
		--shadow-soft: 0 8px 30px rgba(15, 23, 42, 0.04);
		--shadow-medium: 0 16px 40px rgba(15, 23, 42, 0.08);
		--shadow-strong: 0 24px 60px rgba(79, 70, 229, 0.12);
		--radius: 24px;
		--radius-sm: 16px;
	}

	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}

	body {
		font-family: 'Inter', system-ui, -apple-system, sans-serif;
		background-color: var(--bg);
		color: var(--text);
		line-height: 1.6;
		transition: background-color 0.3s;
	}

	h1, h2, h3, h4, h5, h6 {
		font-family: 'Outfit', sans-serif;
		font-weight: 800;
	}

	a {
		text-decoration: none;
		color: inherit;
	}

	/* Dual-Mode Action Bar */
	.mode-selector {
		position: fixed;
		bottom: 24px;
		left: 50%;
		transform: translateX(-50%);
		background: rgba(15, 23, 42, 0.85);
		backdrop-filter: blur(20px);
		border: 1px solid rgba(255, 255, 255, 0.1);
		padding: 8px;
		border-radius: 999px;
		display: flex;
		align-items: center;
		gap: 8px;
		z-index: 10000;
		box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
	}

	.mode-btn {
		background: transparent;
		border: none;
		color: #94a3b8;
		font-weight: 700;
		padding: 10px 20px;
		border-radius: 999px;
		cursor: pointer;
		font-size: 14px;
		display: flex;
		align-items: center;
		gap: 8px;
		transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	}

	.mode-btn.active {
		background: var(--primary);
		color: #ffffff;
		box-shadow: 0 4px 14px rgba(79, 70, 229, 0.4);
	}

	.mode-btn:hover:not(.active) {
		color: #ffffff;
		background: rgba(255, 255, 255, 0.05);
	}

	.print-btn {
		background: #22c55e;
		color: #ffffff;
		border: none;
		font-weight: 700;
		padding: 10px 20px;
		border-radius: 999px;
		cursor: pointer;
		font-size: 14px;
		display: flex;
		align-items: center;
		gap: 8px;
		box-shadow: 0 4px 14px rgba(34, 197, 94, 0.4);
		transition: all 0.3s;
	}

	.print-btn:hover {
		background: #16a34a;
		transform: translateY(-1px);
	}

	/* INTERACTIVE PRESENTATION VIEW STYLES */
	.digital-view {
		display: block;
		min-height: 100vh;
	}

	.hero-section {
		position: relative;
		padding: 140px 24px 80px;
		background: 
			radial-gradient(circle at top left, rgba(79, 70, 229, 0.15), transparent 45%),
			radial-gradient(circle at bottom right, rgba(34, 197, 94, 0.12), transparent 45%),
			linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
		border-bottom: 1px solid var(--border);
		text-align: center;
		overflow: hidden;
	}

	.hero-badge {
		display: inline-flex;
		align-items: center;
		gap: 8px;
		padding: 10px 20px;
		background: #eef2ff;
		color: var(--primary);
		border-radius: 999px;
		font-size: 14px;
		font-weight: 800;
		letter-spacing: 0.5px;
		margin-bottom: 24px;
		border: 1px solid rgba(79, 70, 229, 0.15);
		animation: pulse 2s infinite;
	}

	@keyframes pulse {
		0%, 100% { transform: scale(1); }
		50% { transform: scale(1.02); }
	}

	.hero-section h1 {
		font-size: clamp(36px, 5vw, 64px);
		line-height: 1.1;
		color: var(--text);
		max-width: 900px;
		margin: 0 auto 20px;
		letter-spacing: -1.5px;
	}

	.hero-section h1 span {
		background: var(--primary-gradient);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}

	.hero-section p {
		font-size: clamp(16px, 2vw, 20px);
		color: var(--muted);
		max-width: 700px;
		margin: 0 auto 35px;
		font-weight: 500;
	}

	.cta-group {
		display: flex;
		justify-content: center;
		gap: 16px;
		flex-wrap: wrap;
	}

	.btn {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		gap: 10px;
		padding: 16px 32px;
		font-size: 16px;
		font-weight: 800;
		border-radius: 18px;
		transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
		cursor: pointer;
	}

	.btn-primary {
		background: var(--primary-gradient);
		color: #ffffff;
		box-shadow: var(--shadow-strong);
	}

	.btn-primary:hover {
		transform: translateY(-3px);
		box-shadow: 0 20px 40px rgba(79, 70, 229, 0.25);
	}

	.btn-secondary {
		background: #ffffff;
		color: var(--text);
		border: 1px solid var(--border);
		box-shadow: var(--shadow-soft);
	}

	.btn-secondary:hover {
		background: var(--surface-2);
		transform: translateY(-3px);
	}

	/* Highlights Section */
	.highlights-container {
		max-width: 1200px;
		margin: -50px auto 80px;
		padding: 0 24px;
		position: relative;
		z-index: 10;
	}

	.highlights-grid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
		gap: 24px;
	}

	.highlight-card {
		background: rgba(255, 255, 255, 0.9);
		backdrop-filter: blur(10px);
		border: 1px solid var(--border);
		border-radius: var(--radius);
		padding: 32px;
		box-shadow: var(--shadow-medium);
		transition: all 0.3s;
	}

	.highlight-card:hover {
		transform: translateY(-5px);
		border-color: var(--primary);
	}

	.highlight-icon {
		width: 60px;
		height: 60px;
		border-radius: 20px;
		display: grid;
		place-items: center;
		color: #ffffff;
		font-size: 24px;
		margin-bottom: 24px;
		box-shadow: 0 10px 20px rgba(0,0,0,0.05);
	}

	.icon-indigo { background: var(--primary-gradient); }
	.icon-emerald { background: var(--success-gradient); }
	.icon-violet { background: linear-gradient(135deg, var(--purple), #a855f7); }

	.highlight-card h3 {
		font-size: 22px;
		margin-bottom: 12px;
		color: var(--text);
	}

	.highlight-card p {
		color: var(--muted);
		font-size: 15px;
	}

	/* Section Styling */
	.section-container {
		max-width: 1200px;
		margin: 80px auto;
		padding: 0 24px;
	}

	.section-header {
		text-align: center;
		margin-bottom: 60px;
	}

	.section-header h2 {
		font-size: 38px;
		color: var(--text);
		margin-bottom: 16px;
		letter-spacing: -1px;
	}

	.section-header p {
		color: var(--muted);
		font-size: 16px;
		max-width: 600px;
		margin: 0 auto;
	}

	/* Features Tabs & Details */
	.features-interactive {
		display: grid;
		grid-template-columns: 320px 1fr;
		gap: 40px;
		background: #ffffff;
		border-radius: var(--radius);
		border: 1px solid var(--border);
		padding: 24px;
		box-shadow: var(--shadow-medium);
	}

	.tab-menu {
		display: flex;
		flex-direction: column;
		gap: 8px;
	}

	.tab-link {
		padding: 16px 20px;
		border-radius: 16px;
		background: transparent;
		border: none;
		text-align: left;
		font-weight: 700;
		color: var(--muted);
		cursor: pointer;
		display: flex;
		align-items: center;
		gap: 12px;
		font-size: 15px;
		transition: all 0.25s;
	}

	.tab-link:hover {
		background: var(--surface-2);
		color: var(--text);
	}

	.tab-link.active {
		background: #eef2ff;
		color: var(--primary);
	}

	.tab-link.active i {
		color: var(--primary);
	}

	.tab-content {
		padding: 20px 10px;
	}

	.tab-pane {
		display: none;
	}

	.tab-pane.active {
		display: block;
		animation: fadeIn 0.4s ease;
	}

	@keyframes fadeIn {
		from { opacity: 0; transform: translateY(8px); }
		to { opacity: 1; transform: translateY(0); }
	}

	.tab-pane h3 {
		font-size: 28px;
		color: var(--text);
		margin-bottom: 18px;
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.tab-pane h3 i {
		color: var(--primary);
	}

	.tab-pane p {
		color: var(--muted);
		font-size: 16px;
		margin-bottom: 30px;
		max-width: 800px;
	}

	.feature-subgrid {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
		gap: 20px;
	}

	.subfeature-card {
		background: var(--bg);
		border: 1px solid var(--border);
		border-radius: var(--radius-sm);
		padding: 20px;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.subfeature-card i {
		font-size: 20px;
		color: var(--primary);
	}

	.subfeature-card strong {
		font-size: 16px;
		color: var(--text);
	}

	.subfeature-card span {
		font-size: 13.5px;
		color: var(--muted);
	}

	/* Dual Dashboard Previews */
	.dashboards-layout {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 32px;
	}

	.dash-preview-card {
		background: #ffffff;
		border: 1px solid var(--border);
		border-radius: var(--radius);
		padding: 32px;
		box-shadow: var(--shadow-medium);
		overflow: hidden;
		position: relative;
	}

	.dash-preview-card.admin-theme {
		border-top: 5px solid var(--primary);
	}

	.dash-preview-card.tenant-theme {
		border-top: 5px solid var(--success);
	}

	.dash-preview-card h3 {
		font-size: 24px;
		margin-bottom: 8px;
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.dash-preview-card .badge {
		font-size: 12px;
		padding: 4px 10px;
		border-radius: 99px;
		font-weight: 800;
	}

	.dash-preview-card.admin-theme .badge { background: #eef2ff; color: var(--primary); }
	.dash-preview-card.tenant-theme .badge { background: #ecfeff; color: var(--success); }

	.dash-preview-card p.intro {
		color: var(--muted);
		font-size: 14px;
		margin-bottom: 24px;
	}

	.simulated-screen {
		background: #0f172a;
		border-radius: var(--radius-sm);
		padding: 16px;
		font-family: 'Inter', sans-serif;
		color: #f1f5f9;
		font-size: 12px;
		box-shadow: inset 0 2px 8px rgba(0,0,0,0.5);
	}

	.sim-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding-bottom: 12px;
		border-bottom: 1px solid rgba(255,255,255,0.1);
		margin-bottom: 12px;
	}

	.sim-dot-group {
		display: flex;
		gap: 4px;
	}

	.sim-dot {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background: #ff5f56;
	}
	.sim-dot:nth-child(2) { background: #ffbd2e; }
	.sim-dot:nth-child(3) { background: #27c93f; }

	.sim-title {
		font-weight: 700;
		color: #94a3b8;
		font-size: 11px;
	}

	.sim-grid {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 8px;
		margin-bottom: 12px;
	}

	.sim-stat {
		background: rgba(255,255,255,0.05);
		border-radius: 8px;
		padding: 10px;
		border: 1px solid rgba(255,255,255,0.03);
	}

	.sim-stat .lbl { color: #94a3b8; font-size: 10px; }
	.sim-stat .val { font-size: 14px; font-weight: 800; margin-top: 2px; }
	.sim-stat.primary-val .val { color: #818cf8; }
	.sim-stat.success-val .val { color: #34d399; }
	.sim-stat.warning-val .val { color: #fbbf24; }

	.sim-activity-list {
		display: flex;
		flex-direction: column;
		gap: 6px;
	}

	.sim-act {
		background: rgba(255,255,255,0.03);
		padding: 8px;
		border-radius: 6px;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.sim-act .act-txt { display: flex; align-items: center; gap: 8px; font-weight: 500; }
	.sim-act .act-time { color: #64748b; font-size: 10px; }
	.sim-act.green-glow { border-left: 3px solid #10b981; }
	.sim-act.indigo-glow { border-left: 3px solid #6366f1; }
	.sim-act.red-glow { border-left: 3px solid #ef4444; }

	/* Actions List */
	.dash-actions-list {
		margin-top: 24px;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.dash-action-item {
		display: flex;
		align-items: center;
		gap: 12px;
		font-size: 14.5px;
		color: var(--text);
		font-weight: 600;
	}

	.dash-action-item i {
		width: 28px;
		height: 28px;
		border-radius: 50%;
		display: grid;
		place-items: center;
		font-size: 12px;
	}

	.admin-theme .dash-action-item i { background: #eef2ff; color: var(--primary); }
	.tenant-theme .dash-action-item i { background: #ecfeff; color: var(--success); }

	/* Time-Savings Section */
	.stats-banner {
		background: var(--dark-blue);
		color: #ffffff;
		border-radius: var(--radius);
		padding: 60px 40px;
		margin: 80px auto;
		text-align: center;
		position: relative;
		overflow: hidden;
		box-shadow: var(--shadow-strong);
	}

	.stats-banner::before {
		content: '';
		position: absolute;
		inset: 0;
		background: radial-gradient(circle at 10% 20%, rgba(79, 70, 229, 0.2) 0%, transparent 40%),
		            radial-gradient(circle at 90% 80%, rgba(34, 197, 94, 0.15) 0%, transparent 40%);
	}

	.stats-banner h2 {
		font-size: 36px;
		margin-bottom: 16px;
		position: relative;
		z-index: 2;
	}

	.stats-banner p {
		color: #94a3b8;
		font-size: 17px;
		max-width: 700px;
		margin: 0 auto 40px;
		position: relative;
		z-index: 2;
	}

	.metrics-row {
		display: grid;
		grid-template-columns: repeat(4, 1fr);
		gap: 24px;
		position: relative;
		z-index: 2;
	}

	.metric-item {
		background: rgba(255, 255, 255, 0.04);
		border: 1px solid rgba(255, 255, 255, 0.08);
		border-radius: var(--radius-sm);
		padding: 24px 16px;
	}

	.metric-num {
		font-family: 'Outfit', sans-serif;
		font-size: 42px;
		font-weight: 900;
		background: linear-gradient(135deg, #ffffff, #94a3b8);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		margin-bottom: 6px;
	}

	.metric-num.highlighted {
		background: linear-gradient(135deg, #818cf8, #34d399);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}

	.metric-lbl {
		font-size: 14px;
		color: #cbd5e1;
		font-weight: 700;
		margin-bottom: 4px;
	}

	.metric-desc {
		font-size: 12px;
		color: #64748b;
	}

	/* SaaS banner */
	.saas-banner {
		background: linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(6, 182, 212, 0.05) 100%);
		border: 1px dashed var(--primary);
		border-radius: var(--radius);
		padding: 40px;
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 40px;
		margin-top: 80px;
	}

	.saas-content h3 {
		font-size: 26px;
		color: var(--text);
		margin-bottom: 10px;
	}

	.saas-content p {
		color: var(--muted);
		font-size: 15px;
	}

	/* Footer styling for presentation */
	.presentation-footer {
		text-align: center;
		padding: 60px 24px;
		border-top: 1px solid var(--border);
		background: #ffffff;
		color: var(--muted);
		font-size: 14px;
	}

	/* PRINTABLE A4 PAMPHLET STYLES */
	.a4-view {
		display: none;
		background: #525659;
		padding: 40px 0 80px;
		min-height: 100vh;
	}

	.a4-page {
		width: 210mm;
		height: 297mm;
		background: #ffffff;
		margin: 0 auto 30px;
		box-shadow: 0 10px 30px rgba(0,0,0,0.3);
		position: relative;
		box-sizing: border-box;
		overflow: hidden;
		color: #0f172a;
	}

	/* Inner spacing matching standard print margins */
	.a4-inner {
		padding: 15mm;
		height: 100%;
		display: flex;
		flex-direction: column;
		justify-content: space-between;
		position: relative;
		z-index: 10;
	}

	/* Decorative backgrounds for A4 */
	.a4-page::before {
		content: '';
		position: absolute;
		width: 150mm;
		height: 150mm;
		border-radius: 50%;
		filter: blur(80mm);
		opacity: 0.1;
		pointer-events: none;
		z-index: 1;
	}

	.a4-page.page-1::before {
		background: var(--primary);
		top: -50mm;
		left: -50mm;
	}

	.a4-page.page-2::before {
		background: var(--success);
		bottom: -50mm;
		right: -50mm;
	}

	.a4-page.page-3::before {
		background: var(--purple);
		top: -50mm;
		right: -50mm;
	}

	/* A4 Header / Footer */
	.a4-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border-bottom: 2px solid var(--border);
		padding-bottom: 5mm;
		margin-bottom: 8mm;
	}

	.a4-logo {
		display: flex;
		align-items: center;
		gap: 8px;
		color: var(--text);
	}

	.a4-logo i {
		font-size: 20px;
		color: var(--primary);
	}

	.a4-logo span {
		font-family: 'Outfit', sans-serif;
		font-weight: 800;
		font-size: 16px;
	}

	.a4-header-right {
		font-size: 10px;
		font-weight: 700;
		color: var(--muted);
		text-transform: uppercase;
		letter-spacing: 1px;
	}

	.a4-footer {
		border-top: 1px solid var(--border);
		padding-top: 4mm;
		margin-top: auto;
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-size: 10px;
		font-weight: 600;
		color: var(--muted);
	}

	/* Cover Page (Page 1) Elements */
	.a4-cover-content {
		flex: 1;
		display: flex;
		flex-direction: column;
		justify-content: center;
		padding: 10mm 5mm;
	}

	.a4-cover-badge {
		align-self: flex-start;
		font-family: 'Outfit', sans-serif;
		background: #eef2ff;
		color: var(--primary);
		font-size: 11px;
		font-weight: 800;
		padding: 6px 14px;
		border-radius: 99px;
		text-transform: uppercase;
		letter-spacing: 1px;
		margin-bottom: 8mm;
		border: 1px solid rgba(79, 70, 229, 0.1);
	}

	.a4-cover-title {
		font-size: 38px;
		line-height: 1.15;
		margin-bottom: 6mm;
		color: var(--text);
		font-weight: 900;
	}

	.a4-cover-title span {
		color: var(--primary);
	}

	.a4-cover-desc {
		font-size: 14px;
		color: var(--muted);
		margin-bottom: 10mm;
		max-width: 90%;
		line-height: 1.6;
	}

	/* Owner statistics grid on A4 */
	.a4-stats-bar {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 6mm;
		background: var(--surface-2);
		border-radius: var(--radius-sm);
		padding: 6mm;
		margin-bottom: 12mm;
		border: 1px solid var(--border);
	}

	.a4-stat-item {
		text-align: center;
	}

	.a4-stat-num {
		font-family: 'Outfit', sans-serif;
		font-size: 26px;
		font-weight: 900;
		color: var(--primary);
	}

	.a4-stat-lbl {
		font-size: 10px;
		color: var(--text);
		font-weight: 800;
		margin-top: 2px;
		text-transform: uppercase;
		letter-spacing: 0.5px;
	}

	.a4-stat-desc {
		font-size: 9px;
		color: var(--muted);
		margin-top: 1px;
	}

	/* Highlights box */
	.a4-cover-highlights {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 6mm;
	}

	.a4-highlight-box {
		border: 1px solid var(--border);
		border-radius: var(--radius-sm);
		padding: 5mm;
		display: flex;
		gap: 4mm;
	}

	.a4-highlight-box i {
		font-size: 18px;
		color: var(--primary);
		margin-top: 2px;
	}

	.a4-highlight-box div h4 {
		font-size: 13px;
		color: var(--text);
		margin-bottom: 1mm;
	}

	.a4-highlight-box div p {
		font-size: 10.5px;
		color: var(--muted);
		line-height: 1.4;
	}

	/* Core Content layouts for Page 2 & 3 */
	.a4-section-title {
		font-size: 20px;
		color: var(--text);
		margin-bottom: 5mm;
		display: flex;
		align-items: center;
		gap: 10px;
		position: relative;
	}

	.a4-section-title::after {
		content: '';
		flex: 1;
		height: 1px;
		background: var(--border);
	}

	.a4-section-title i {
		color: var(--primary);
	}

	.a4-grid-2 {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 8mm;
		flex: 1;
	}

	.a4-feature-column h3 {
		font-size: 14px;
		color: var(--text);
		margin-bottom: 4mm;
		padding-bottom: 2mm;
		border-bottom: 2px solid var(--primary);
		display: inline-block;
	}

	.a4-feature-list {
		display: flex;
		flex-direction: column;
		gap: 4.5mm;
	}

	.a4-feature-item {
		display: flex;
		gap: 3.5mm;
	}

	.a4-feature-item i {
		font-size: 14px;
		color: var(--primary);
		margin-top: 1mm;
		width: 14px;
		text-align: center;
	}

	.a4-feature-item div h4 {
		font-size: 12.5px;
		color: var(--text);
		margin-bottom: 0.5mm;
	}

	.a4-feature-item div p {
		font-size: 10.5px;
		color: var(--muted);
		line-height: 1.4;
	}

	.a4-workflow-box {
		background: var(--bg);
		border: 1px solid var(--border);
		border-radius: var(--radius-sm);
		padding: 5mm;
	}

	.a4-step {
		position: relative;
		padding-left: 8mm;
		margin-bottom: 4.5mm;
	}

	.a4-step:last-child {
		margin-bottom: 0;
	}

	.a4-step::before {
		content: attr(data-step);
		position: absolute;
		left: 0;
		top: 0;
		width: 5.5mm;
		height: 5.5mm;
		border-radius: 50%;
		background: var(--success);
		color: #ffffff;
		display: grid;
		place-items: center;
		font-size: 10px;
		font-weight: 800;
	}

	.a4-step h4 {
		font-size: 12.5px;
		color: var(--text);
		margin-bottom: 0.5mm;
	}

	.a4-step p {
		font-size: 10.5px;
		color: var(--muted);
		line-height: 1.4;
	}

	/* Dashboard layouts on A4 Page 3 */
	.a4-dashboards {
		display: flex;
		flex-direction: column;
		gap: 6mm;
		flex: 1;
	}

	.a4-dash-card {
		border: 1px solid var(--border);
		border-radius: var(--radius-sm);
		padding: 5mm;
		display: flex;
		flex-direction: column;
		gap: 4mm;
	}

	.a4-dash-card.admin { border-left: 4px solid var(--primary); }
	.a4-dash-card.tenant { border-left: 4px solid var(--success); }

	.a4-dash-head {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.a4-dash-head h3 {
		font-size: 14px;
		color: var(--text);
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.a4-dash-head span {
		font-size: 9px;
		padding: 2px 8px;
		border-radius: 99px;
		font-weight: 800;
		text-transform: uppercase;
	}

	.a4-dash-card.admin span { background: #eef2ff; color: var(--primary); }
	.a4-dash-card.tenant span { background: #ecfeff; color: var(--success); }

	.a4-dash-body {
		display: grid;
		grid-template-columns: 1.2fr 0.8fr;
		gap: 6mm;
	}

	.a4-dash-desc {
		font-size: 11px;
		color: var(--muted);
		line-height: 1.5;
	}

	.a4-dash-desc ul {
		margin-top: 2mm;
		padding-left: 4mm;
		display: flex;
		flex-direction: column;
		gap: 1.5mm;
	}

	.a4-dash-desc li {
		font-size: 10.5px;
	}

	/* Simulated graphic */
	.a4-graphic-container {
		background: #0f172a;
		border-radius: 12px;
		padding: 4mm;
		color: #ffffff;
		font-family: monospace;
		font-size: 8px;
		box-shadow: 0 4px 10px rgba(0,0,0,0.15);
	}

	.a4-graphic-line {
		margin-bottom: 2px;
		display: flex;
		justify-content: space-between;
	}
	.a4-graphic-line.header {
		font-weight: bold;
		border-bottom: 1px solid rgba(255,255,255,0.1);
		padding-bottom: 2px;
		margin-bottom: 4px;
		color: #818cf8;
	}

	/* CTA Page (Page 4) */
	.a4-cta-content {
		flex: 1;
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		text-align: center;
		padding: 15mm 10mm;
	}

	.a4-cta-icon {
		width: 20mm;
		height: 20mm;
		border-radius: 50%;
		background: var(--primary-gradient);
		color: #ffffff;
		display: grid;
		place-items: center;
		font-size: 32px;
		margin-bottom: 8mm;
		box-shadow: 0 10px 20px rgba(79, 70, 229, 0.2);
	}

	.a4-cta-content h2 {
		font-size: 28px;
		margin-bottom: 4mm;
		color: var(--text);
	}

	.a4-cta-content p {
		font-size: 13.5px;
		color: var(--muted);
		max-width: 85%;
		margin-bottom: 10mm;
		line-height: 1.6;
	}

	.a4-cta-features {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 6mm;
		margin-bottom: 12mm;
		width: 100%;
	}

	.a4-cta-feat-box {
		border: 1px solid var(--border);
		border-radius: var(--radius-sm);
		padding: 4mm;
		background: var(--surface-2);
	}

	.a4-cta-feat-box i {
		font-size: 16px;
		color: var(--primary);
		margin-bottom: 2mm;
	}

	.a4-cta-feat-box h4 {
		font-size: 11.5px;
		margin-bottom: 1px;
	}

	.a4-cta-feat-box p {
		font-size: 9px;
		color: var(--muted);
		margin-bottom: 0;
	}

	.a4-footer-details {
		background: var(--dark-blue);
		color: #ffffff;
		border-radius: var(--radius-sm);
		padding: 8mm;
		width: 100%;
		display: flex;
		justify-content: space-between;
		align-items: center;
		text-align: left;
	}

	.a4-footer-details h3 {
		font-size: 16px;
		margin-bottom: 1.5mm;
	}

	.a4-footer-details p {
		font-size: 11px;
		color: #94a3b8;
		margin-bottom: 0;
	}

	.a4-footer-right {
		display: flex;
		gap: 8mm;
	}

	.a4-footer-item {
		display: flex;
		align-items: center;
		gap: 3mm;
		font-size: 11px;
	}

	.a4-footer-item i {
		font-size: 16px;
		color: var(--success);
	}

	/* RESPONSIVE DESIGN FOR Presentation Mode */
	@media (max-width: 992px) {
		.features-interactive {
			grid-template-columns: 1fr;
		}

		.tab-menu {
			flex-direction: row;
			overflow-x: auto;
			padding-bottom: 8px;
		}

		.tab-link {
			white-space: nowrap;
		}

		.dashboards-layout {
			grid-template-columns: 1fr;
		}

		.metrics-row {
			grid-template-columns: 1fr 1fr;
		}

		.saas-banner {
			flex-direction: column;
			text-align: center;
		}
	}

	@media (max-width: 600px) {
		.hero-section {
			padding: 100px 16px 50px;
		}

		.hero-section h1 {
			font-size: 36px;
		}

		.btn {
			width: 100%;
		}

		.metrics-row {
			grid-template-columns: 1fr;
		}
	}

	/* PRINT MEDIA QUERY - Overrides browser presentation when printing */
	@media print {
		/* Hide UI elements */
		.mode-selector, .presentation-footer, .digital-view {
			display: none !important;
		}

		body {
			background: #ffffff !important;
		}

		.a4-view {
			display: block !important;
			padding: 0 !important;
			background: transparent !important;
		}

		.a4-page {
			margin: 0 !important;
			box-shadow: none !important;
			page-break-after: always !important;
			page-break-inside: avoid !important;
		}

		/* Standard A4 margins in printing */
		@page {
			size: A4 portrait;
			margin: 0;
		}
	}
</style>
</head>
<body>

	<!-- Floating Dual-Mode Controller -->
	<div class="mode-selector">
		<button class="mode-btn active" id="btn-digital" onclick="switchMode('digital')">
			<i class="fa-solid fa-laptop"></i> Digital Showcase
		</button>
		<button class="mode-btn" id="btn-a4" onclick="switchMode('a4')">
			<i class="fa-solid fa-file-pdf"></i> Printable A4 Layout
		</button>
		<button class="print-btn" onclick="triggerPrint()">
			<i class="fa-solid fa-print"></i> Export to PDF / Print
		</button>
	</div>

	<!-- ========================================== -->
	<!-- DIGITAL PRESENTATION SHOWCASE               -->
	<!-- ========================================== -->
	<div class="digital-view" id="digital-view">
		<!-- Hero Section -->
		<section class="hero-section">
			<div class="hero-badge">
				<i class="fa-solid fa-circle-check"></i> Enterprise PG Management Suite
			</div>
			<h1>Simplifying PG Management.<br><span>Maximizing Occupancy & Profits.</span></h1>
			<p>A beautiful, SaaS-ready web platform that automates rent collections, maps rooms, delegates employee salary tasks, and logs tenant complaints in one unified space.</p>
			
			<div class="cta-group">
				<a href="<%=ctx%>/registerSaaS.jsp" class="btn btn-primary">
					<i class="fa-solid fa-rocket"></i> Register PG SaaS Portal
				</a>
				<a href="<%=ctx%>/index.jsp" class="btn btn-secondary">
					<i class="fa-solid fa-circle-arrow-right"></i> Open Active Demo
				</a>
			</div>
		</section>

		<!-- Highlight cards -->
		<div class="highlights-container">
			<div class="highlights-grid">
				<div class="highlight-card">
					<div class="highlight-icon icon-indigo">
						<i class="fa-solid fa-clock-rotate-left"></i>
					</div>
					<h3>Save 15+ Hours Weekly</h3>
					<p>Eliminate manual paper logs and spreadsheets. Room allocations, fee calculation, and monthly expenses are computed automatically.</p>
				</div>
				<div class="highlight-card">
					<div class="highlight-icon icon-emerald">
						<i class="fa-solid fa-money-bill-trend-up"></i>
					</div>
					<h3>Reduce Rent Late Fees</h3>
					<p>Automate payment status reports, show active notifications to tenants, and approve uploaded billing receipts instantly.</p>
				</div>
				<div class="highlight-card">
					<div class="highlight-icon icon-violet">
						<i class="fa-solid fa-users-viewfinder"></i>
					</div>
					<h3>Multi-Tenant SaaS Ready</h3>
					<p>Are you running multiple PG branches? Instantiate a clean sub-domain/PG Code database instance immediately through SaaS onboarding.</p>
				</div>
			</div>
		</div>

		<!-- Interactive Features Section -->
		<section class="section-container" id="features">
			<div class="section-header">
				<h2>All the Features You Need to Run Your PG</h2>
				<p>A comprehensive list of fully implemented systems built inside this application to optimize daily logistics.</p>
			</div>

			<div class="features-interactive">
				<div class="tab-menu">
					<button class="tab-link active" onclick="openFeature(event, 'room-mgmt')">
						<i class="fa-solid fa-bed"></i> Room & Bed Manager
					</button>
					<button class="tab-link" onclick="openFeature(event, 'finance-mgmt')">
						<i class="fa-solid fa-wallet"></i> Rent & Expenses
					</button>
					<button class="tab-link" onclick="openFeature(event, 'tenant-portal')">
						<i class="fa-solid fa-circle-user"></i> Tenant Self-Service
					</button>
					<button class="tab-link" onclick="openFeature(event, 'staff-logistics')">
						<i class="fa-solid fa-users-gear"></i> Staff & Security Logs
					</button>
				</div>

				<div class="tab-content">
					<!-- Room Mgmt Pane -->
					<div class="tab-pane active" id="room-mgmt">
						<h3><i class="fa-solid fa-bed"></i> Room & Sharing Allocations</h3>
						<p>Real-time rooms manager allows you to list occupancy, edit roommates lists, and manage rent variables per occupant capacity.</p>
						<div class="feature-subgrid">
							<div class="subfeature-card">
								<i class="fa-solid fa-eye"></i>
								<strong>Dynamic Room Status</strong>
								<span>Inspect available beds vs occupied beds instantly.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-layer-group"></i>
								<strong>Sharing Tiers</strong>
								<span>Establish custom room shares (1-share, 2-share, 3-share) with variable base prices.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-users"></i>
								<strong>Roommate Mappings</strong>
								<span>Instantly display roommates sharing a room, preventing booking conflicts.</span>
							</div>
						</div>
					</div>

					<!-- Finance Mgmt Pane -->
					<div class="tab-pane" id="finance-mgmt">
						<h3><i class="fa-solid fa-wallet"></i> Rent Automation & Expense Tracking</h3>
						<p>Track cash flow, log salaries, compute utility expenditures, and maintain monthly financial charts in one place.</p>
						<div class="feature-subgrid">
							<div class="subfeature-card">
								<i class="fa-solid fa-calendar-days"></i>
								<strong>Rent Schedulers</strong>
								<span>Schedule recurring rent invoices. Shows clear lists of paid vs pending tenants.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-calculator"></i>
								<strong>Interactive Analytics</strong>
								<span>Beautiful Revenue charts displaying Net Profits, Overall Collections, and operational expenses.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-receipt"></i>
								<strong>Invoice Receipts</strong>
								<span>Generate formal PDF/JSP printed receipts directly for completed rent payments.</span>
							</div>
						</div>
					</div>

					<!-- Tenant Portal Pane -->
					<div class="tab-pane" id="tenant-portal">
						<h3><i class="fa-solid fa-circle-user"></i> Tenant Self-Service Experience</h3>
						<p>Give your residents the power to make payments, raise maintenance requests, check menus, and read notices online.</p>
						<div class="feature-subgrid">
							<div class="subfeature-card">
								<i class="fa-solid fa-credit-card"></i>
								<strong>Rent Payments & Logs</strong>
								<span>Tenants check outstanding bills and upload transaction IDs/receipt screenshots for verification.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-triangle-exclamation"></i>
								<strong>Support Ticketing</strong>
								<span>Quickly report infrastructure problems (WiFi, food, cleaning) and track status updates from the admin.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-utensils"></i>
								<strong>Weekly Food Menus</strong>
								<span>Access the live daily menu board detailing breakfast, lunch, and dinner plans.</span>
							</div>
						</div>
					</div>

					<!-- Staff & Security Pane -->
					<div class="tab-pane" id="staff-logistics">
						<h3><i class="fa-solid fa-users-gear"></i> Staff payroll & Security logbook</h3>
						<p>Govern external resources, dispatch salaries, view historical payment notes, and log daily security checks.</p>
						<div class="feature-subgrid">
							<div class="subfeature-card">
								<i class="fa-solid fa-user-tie"></i>
								<strong>Employee Directories</strong>
								<span>Create profiles for wardens, chefs, and maintenance staff with role descriptors.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-money-check-dollar"></i>
								<strong>Salary Pay-out Logs</strong>
								<span>Dispense salaries and archive transactions to maintain correct PG profit statements.</span>
							</div>
							<div class="subfeature-card">
								<i class="fa-solid fa-address-book"></i>
								<strong>Visitor Register</strong>
								<span>Log visitor entries, contact details, reason for visit, and entry times.</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Visual Dashboard Showcase -->
		<section class="section-container">
			<div class="section-header">
				<h2>Inside the Dashboards</h2>
				<p>Dual interface built for clear administration and transparent resident relationships.</p>
			</div>

			<div class="dashboards-layout">
				<!-- Admin Dashboard Preview -->
				<div class="dash-preview-card admin-theme">
					<h3><i class="fa-solid fa-user-shield"></i> Admin Command Center <span class="badge">Core Hub</span></h3>
					<p class="intro">Enables complete operational control, showcasing live business telemetry and administrative controls.</p>
					
					<div class="simulated-screen">
						<div class="sim-header">
							<div class="sim-dot-group">
								<span class="sim-dot"></span>
								<span class="sim-dot"></span>
								<span class="sim-dot"></span>
							</div>
							<div class="sim-title">ADMINISTRATOR CORE PORTAL</div>
							<div><i class="fa-solid fa-bell"></i></div>
						</div>
						<div class="sim-grid">
							<div class="sim-stat primary-val">
								<div class="lbl">Total Occupants</div>
								<div class="val">48 Tenants</div>
							</div>
							<div class="sim-stat success-val">
								<div class="lbl">Collection Rate</div>
								<div class="val">94.8%</div>
							</div>
							<div class="sim-stat warning-val">
								<div class="lbl">Active Complaints</div>
								<div class="val">3 Pending</div>
							</div>
						</div>
						<div class="sim-activity-list">
							<div class="sim-act green-glow">
								<div class="act-txt"><i class="fa-solid fa-circle-check"></i> Rent Paid: Room 204 (Rahul)</div>
								<div class="act-time">Just Now</div>
							</div>
							<div class="sim-act indigo-glow">
								<div class="act-txt"><i class="fa-solid fa-user-plus"></i> New Tenant: Room 102</div>
								<div class="act-time">10m ago</div>
							</div>
							<div class="sim-act red-glow">
								<div class="act-txt"><i class="fa-solid fa-triangle-exclamation"></i> Complaint: WiFi Issues</div>
								<div class="act-time">1h ago</div>
							</div>
						</div>
					</div>

					<div class="dash-actions-list">
						<div class="dash-action-item"><i class="fa-solid fa-check"></i> Oversee Room Inventory, check-ins & check-outs.</div>
						<div class="dash-action-item"><i class="fa-solid fa-check"></i> Track expenses and process staff salaries.</div>
						<div class="dash-action-item"><i class="fa-solid fa-check"></i> Resolve complaints, broadcast notices, and update food menus.</div>
					</div>
				</div>

				<!-- Tenant Dashboard Preview -->
				<div class="dash-preview-card tenant-theme">
					<h3><i class="fa-solid fa-user"></i> Tenant Self-Service Portal <span class="badge">Resident Hub</span></h3>
					<p class="intro">Simplifies tenant daily life, making billing transparent and communication instant.</p>
					
					<div class="simulated-screen">
						<div class="sim-header">
							<div class="sim-dot-group">
								<span class="sim-dot"></span>
								<span class="sim-dot"></span>
								<span class="sim-dot"></span>
							</div>
							<div class="sim-title">TENANT PERSONAL PORTAL</div>
							<div><i class="fa-solid fa-envelope"></i></div>
						</div>
						<div class="sim-grid">
							<div class="sim-stat success-val">
								<div class="lbl">Rent Status</div>
								<div class="val">Paid (June)</div>
							</div>
							<div class="sim-stat primary-val">
								<div class="lbl">Room Assigned</div>
								<div class="val">Room 204-B</div>
							</div>
							<div class="sim-stat warning-val">
								<div class="lbl">Today's Menu</div>
								<div class="val">Paneer Butter</div>
							</div>
						</div>
						<div class="sim-activity-list">
							<div class="sim-act indigo-glow">
								<div class="act-txt"><i class="fa-solid fa-bullhorn"></i> Notice: Water Maintenance tomorrow</div>
								<div class="act-time">2h ago</div>
							</div>
							<div class="sim-act green-glow">
								<div class="act-txt"><i class="fa-solid fa-wrench"></i> Complaint Resolved: Lightbulb fixed</div>
								<div class="act-time">Yesterday</div>
							</div>
						</div>
					</div>

					<div class="dash-actions-list">
						<div class="dash-action-item"><i class="fa-solid fa-check"></i> Upload transaction screenshots for quick payments.</div>
						<div class="dash-action-item"><i class="fa-solid fa-check"></i> Log issues instantly with automated categorization.</div>
						<div class="dash-action-item"><i class="fa-solid fa-check"></i> Check the menu board and upcoming official notices.</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Statistics & Performance Banner -->
		<section class="stats-banner">
			<h2>Performance Analytics & Time Saved</h2>
			<p>We designed our software with a simple philosophy: spend less time typing on grids and more time expanding your assets.</p>
			
			<div class="metrics-row">
				<div class="metric-item">
					<div class="metric-num highlighted">15 hrs</div>
					<div class="metric-lbl">Time Saved Weekly</div>
					<div class="metric-desc">No more manual billing calculations.</div>
				</div>
				<div class="metric-item">
					<div class="metric-num">90%</div>
					<div class="metric-lbl">Fewer Delays</div>
					<div class="metric-desc">Due to rapid reminders and payment logs.</div>
				</div>
				<div class="metric-item">
					<div class="metric-num highlighted">Zero</div>
					<div class="metric-lbl">Paperwork</div>
					<div class="metric-desc">Complaints, receipt PDFs, menu digital logs.</div>
				</div>
				<div class="metric-item">
					<div class="metric-num">40%</div>
					<div class="metric-lbl">Faster Resolution</div>
					<div class="metric-desc">On plumbing, wifi, and food complaints.</div>
				</div>
			</div>
		</section>

		<!-- SaaS Registration Pitch -->
		<section class="section-container">
			<div class="saas-banner">
				<div class="saas-content">
					<h3>Do you own multiple branches?</h3>
					<p>Onboard your hostels via our SaaS platform. Instantly provision custom databases for distinct branches, securing data isolation and dedicated dashboards.</p>
				</div>
				<a href="<%=ctx%>/registerSaaS.jsp" class="btn btn-primary" style="white-space: nowrap;">
					<i class="fa-solid fa-circle-plus"></i> Onboard My PG Now
				</a>
			</div>
		</section>

		<!-- Showcase Footer -->
		<footer class="presentation-footer">
			<p>&copy; 2026 Smart PG Management System. Made for Modern PG Owners & Hostel Operators.</p>
		</footer>
	</div>


	<!-- ========================================== -->
	<!-- PRINTABLE A4 MULTI-PAGE PAMPHLET VIEW      -->
	<!-- ========================================== -->
	<div class="a4-view" id="a4-view">
		
		<!-- PAGE 1: COVER PAGE -->
		<div class="a4-page page-1">
			<div class="a4-inner">
				<div class="a4-header">
					<div class="a4-logo">
						<i class="fa-solid fa-house-chimney-user"></i>
						<span>SMART PG</span>
					</div>
					<div class="a4-header-right">System Overview</div>
				</div>

				<div class="a4-cover-content">
					<div class="a4-cover-badge">All-In-One PG Operating Suite</div>
					<h1 class="a4-cover-title">Simplifying management.<br><span>Maximizing cash flow.</span></h1>
					<p class="a4-cover-desc">Automate your rent collections, allocate rooms and beds in real time, oversee staff payroll, track utility expenses, and process resident complaints through one unified, beautiful system.</p>
					
					<!-- Key Statistics -->
					<div class="a4-stats-bar">
						<div class="a4-stat-item">
							<div class="a4-stat-num">15+ hrs</div>
							<div class="a4-stat-lbl">Time Saved</div>
							<div class="a4-stat-desc">Per week on admin</div>
						</div>
						<div class="a4-stat-item">
							<div class="a4-stat-num">90%</div>
							<div class="a4-stat-lbl">Late Rent Cut</div>
							<div class="a4-stat-desc">With swift reminders</div>
						</div>
						<div class="a4-stat-item">
							<div class="a4-stat-num">100%</div>
							<div class="a4-stat-lbl">Digital Log</div>
							<div class="a4-stat-desc">No messy registers</div>
						</div>
					</div>

					<div class="a4-cover-highlights">
						<div class="a4-highlight-box">
							<i class="fa-solid fa-shield-halved"></i>
							<div>
								<h4>SaaS Subdomain Ready</h4>
								<p>Deploy distinct PG branches on dedicated database setups through rapid onboarding.</p>
							</div>
						</div>
						<div class="a4-highlight-box">
							<i class="fa-solid fa-qrcode"></i>
							<div>
								<h4>Transparent Billings</h4>
								<p>Tenants upload payment screenshot proofs and track rent status histories online.</p>
							</div>
						</div>
					</div>
				</div>

				<div class="a4-footer">
					<span>Brochure: Section 1</span>
					<span>Smart PG Management System</span>
					<span>Page 1</span>
				</div>
			</div>
		</div>

		<!-- PAGE 2: DETAILED FEATURES & WORKFLOW -->
		<div class="a4-page page-2">
			<div class="a4-inner">
				<div class="a4-header">
					<div class="a4-logo">
						<i class="fa-solid fa-house-chimney-user"></i>
						<span>SMART PG</span>
					</div>
					<div class="a4-header-right">Features & Workflows</div>
				</div>

				<h2 class="a4-section-title"><i class="fa-solid fa-list-check"></i> System Features Checklist</h2>
				
				<div class="a4-grid-2">
					<div class="a4-feature-column">
						<h3>Owner & Operator Features</h3>
						<div class="a4-feature-list">
							<div class="a4-feature-item">
								<i class="fa-solid fa-bed"></i>
								<div>
									<h4>Room & Bed Allocator</h4>
									<p>Log rooms and bed sharing numbers. View occupancy rates in real-time.</p>
								</div>
							</div>
							<div class="a4-feature-item">
								<i class="fa-solid fa-wallet"></i>
								<div>
									<h4>Rent & Fee Automator</h4>
									<p>Schedule room rates, extra utilities, and log payment receipts.</p>
								</div>
							</div>
							<div class="a4-feature-item">
								<i class="fa-solid fa-chart-line"></i>
								<div>
									<h4>Expense & Income Logs</h4>
									<p>Track food costs, maintenance, and staff salaries dynamically.</p>
								</div>
							</div>
							<div class="a4-feature-item">
								<i class="fa-solid fa-users-gear"></i>
								<div>
									<h4>Staff & Payroll logs</h4>
									<p>Manage warden and chef salaries. Track disbursement histories.</p>
								</div>
							</div>
						</div>
					</div>

					<div class="a4-feature-column">
						<h3>Tenant Self-Service Actions</h3>
						<div class="a4-workflow-box">
							<div class="a4-step" data-step="1">
								<h4>Verify Security Logins</h4>
								<p>Access the portal securely using email/phone OTP verification parameters.</p>
							</div>
							<div class="a4-step" data-step="2">
								<h4>Verify Outstanding Bills</h4>
								<p>View rent details and pay online. Upload receipt pictures for instant approvals.</p>
							</div>
							<div class="a4-step" data-step="3">
								<h4>Raise Maintenance Tickets</h4>
								<p>File infrastructure complaints (WiFi, food, water) and view live repair logs.</p>
							</div>
							<div class="a4-step" data-step="4">
								<h4>Check Food & Notices</h4>
								<p>Stay up to date with the weekly menu plans and urgent building announcements.</p>
							</div>
						</div>
					</div>
				</div>

				<div class="a4-footer">
					<span>Brochure: Section 2</span>
					<span>Smart PG Management System</span>
					<span>Page 2</span>
				</div>
			</div>
		</div>

		<!-- PAGE 3: DASHBOARDS SUMMARY -->
		<div class="a4-page page-3">
			<div class="a4-inner">
				<div class="a4-header">
					<div class="a4-logo">
						<i class="fa-solid fa-house-chimney-user"></i>
						<span>SMART PG</span>
					</div>
					<div class="a4-header-right">Dashboards & Controls</div>
				</div>

				<h2 class="a4-section-title"><i class="fa-solid fa-chart-pie"></i> Visual Portal Dashboards</h2>
				
				<div class="a4-dashboards">
					<!-- Admin Card -->
					<div class="a4-dash-card admin">
						<div class="a4-dash-head">
							<h3><i class="fa-solid fa-user-shield"></i> Admin Command Hub</h3>
							<span>Operations</span>
						</div>
						<div class="a4-dash-body">
							<div class="a4-dash-desc">
								<p>Displays critical business telemetry to hostlers, giving them a unified overview of the PG status:</p>
								<ul>
									<li><strong>Key Telemetry:</strong> Total occupants, active occupancy rate, and pending maintenance orders.</li>
									<li><strong>Financial Health:</strong> Revenue charts, operational utility expenses, and paid employee details.</li>
									<li><strong>Activity Feeds:</strong> Live visitor logs, check-in histories, and new complaint alerts.</li>
								</ul>
							</div>
							<div class="a4-graphic-container">
								<div class="a4-graphic-line header"><span>ADMIN CORE STATUS</span><span>LIVE</span></div>
								<div class="a4-graphic-line"><span>Total Occupants</span><span>48/50 Beds</span></div>
								<div class="a4-graphic-line"><span>Net Collection</span><span>$12,450 (94%)</span></div>
								<div class="a4-graphic-line"><span>Active Issues</span><span>3 Tickets</span></div>
								<div class="a4-graphic-line"><span>Paid Wages</span><span>4 Employees</span></div>
							</div>
						</div>
					</div>

					<!-- Tenant Card -->
					<div class="a4-dash-card tenant">
						<div class="a4-dash-head">
							<h3><i class="fa-solid fa-user"></i> Tenant Self-Service portal</h3>
							<span>Resident</span>
						</div>
						<div class="a4-dash-body">
							<div class="a4-dash-desc">
								<p>Empowers the tenants to manage basic chores without requiring manual interactions with wardens:</p>
								<ul>
									<li><strong>Bills Directory:</strong> View base room charges, pay fees, and download receipt history.</li>
									<li><strong>Helpdesk Hub:</strong> File complaints under categories (plumbing, wifi, electricity) with description forms.</li>
									<li><strong>Notice and Meals:</strong> View warden instructions and check daily breakfast, lunch, and dinner menus.</li>
								</ul>
							</div>
							<div class="a4-graphic-container">
								<div class="a4-graphic-line header" style="color:#10b981"><span>TENANT PORTAL</span><span>ACTIVE</span></div>
								<div class="a4-graphic-line"><span>Assigned Room</span><span>Room 204 (B-Bed)</span></div>
								<div class="a4-graphic-line"><span>Bill Status</span><span>Paid (June)</span></div>
								<div class="a4-graphic-line"><span>Open Tickets</span><span>0 Issues</span></div>
								<div class="a4-graphic-line"><span>Menu Today</span><span>Paneer & Butter Roti</span></div>
							</div>
						</div>
					</div>
				</div>

				<div class="a4-footer">
					<span>Brochure: Section 3</span>
					<span>Smart PG Management System</span>
					<span>Page 3</span>
				</div>
			</div>
		</div>

		<!-- PAGE 4: CALL TO ACTION -->
		<div class="a4-page page-4">
			<div class="a4-inner">
				<div class="a4-header">
					<div class="a4-logo">
						<i class="fa-solid fa-house-chimney-user"></i>
						<span>SMART PG</span>
					</div>
					<div class="a4-header-right">Get Started</div>
				</div>

				<div class="a4-cta-content">
					<div class="a4-cta-icon">
						<i class="fa-solid fa-rocket"></i>
					</div>
					<h2>Boost Your PG Operations Today</h2>
					<p>Smart PG Management provides the complete framework to modernise hostel logistics. Save hours on calculations, improve fee visibility, and secure resident retention through quick support.</p>
					
					<div class="a4-cta-features">
						<div class="a4-cta-feat-box">
							<i class="fa-solid fa-bolt"></i>
							<h4>Instant Setup</h4>
							<p>Register via our SaaS portal in minutes.</p>
						</div>
						<div class="a4-cta-feat-box">
							<i class="fa-solid fa-users-rectangle"></i>
							<h4>Clean Data</h4>
							<p>Dedicated branch databases keep history safe.</p>
						</div>
						<div class="a4-cta-feat-box">
							<i class="fa-solid fa-arrows-to-eye"></i>
							<h4>Visual Dashboards</h4>
							<p>Overview of bills and operations on any phone.</p>
						</div>
					</div>

					<div class="a4-footer-details">
						<div>
							<h3>Ready to onboard?</h3>
							<p>Contact your SaaS administrator or register details.</p>
						</div>
						<div class="a4-footer-right">
							<div class="a4-footer-item">
								<i class="fa-solid fa-globe"></i>
								<div>
									<strong>Web Portal URL</strong>
									<span style="color:#cbd5e1; font-size:10px;">smartpg.com/register</span>
								</div>
							</div>
							<div class="a4-footer-item">
								<i class="fa-solid fa-circle-nodes"></i>
								<div>
									<strong>PG Code Instance</strong>
									<span style="color:#cbd5e1; font-size:10px;">SaaS-Ready Architecture</span>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="a4-footer">
					<span>Brochure: Section 4</span>
					<span>Smart PG Management System</span>
					<span>Page 4</span>
				</div>
			</div>
		</div>

	</div>

	<!-- Custom Scripts -->
	<script>
		// Open particular feature inside tabs
		function openFeature(evt, featureName) {
			// Get all elements with class="tab-pane" and hide them
			const tabPanes = document.querySelectorAll(".tab-pane");
			tabPanes.forEach(pane => pane.classList.remove("active"));

			// Get all elements with class="tab-link" and remove the class "active"
			const tabLinks = document.querySelectorAll(".tab-link");
			tabLinks.forEach(link => link.classList.remove("active"));

			// Show the current tab, and add an "active" class to the button that opened the tab
			document.getElementById(featureName).classList.add("active");
			evt.currentTarget.classList.add("active");
		}

		// Toggle view between Digital Showcase and A4 printable page
		function switchMode(mode) {
			const digitalView = document.getElementById("digital-view");
			const a4View = document.getElementById("a4-view");
			const btnDigital = document.getElementById("btn-digital");
			const btnA4 = document.getElementById("btn-a4");

			if (mode === 'a4') {
				digitalView.style.display = 'none';
				a4View.style.display = 'block';
				btnDigital.classList.remove('active');
				btnA4.classList.add('active');
				document.body.style.backgroundColor = '#525659';
			} else {
				digitalView.style.display = 'block';
				a4View.style.display = 'none';
				btnDigital.classList.add('active');
				btnA4.classList.remove('active');
				document.body.style.backgroundColor = '#f8fafc';
			}
		}

		// Print layout trigger
		function triggerPrint() {
			// Check if we are currently in A4 mode. If not, temporarily switch or print directly.
			const currentModeIsA4 = document.getElementById("btn-a4").classList.contains("active");
			
			if (!currentModeIsA4) {
				// Switch to A4 layout, wait brief moment, print, then allow restoration if needed
				switchMode('a4');
				setTimeout(function() {
					window.print();
				}, 250);
			} else {
				window.print();
			}
		}
	</script>
</body>
</html>
