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
<title>Smart PG Management System - Complete SaaS Solution for PG Owners & Residents</title>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">

<!-- Fonts and Icon libraries -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=Outfit:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<style>
	:root {
		--bg-primary: #f8fafc;
		--bg-secondary: #0f172a;
		--surface-white: rgba(255, 255, 255, 0.75);
		--surface-card: #ffffff;
		--surface-card-dark: #1e293b;
		--text-main: #1e293b;
		--text-muted: #64748b;
		--text-light: #94a3b8;
		--text-white: #ffffff;
		
		/* Strictly Blue & White Theme Color Palette */
		--primary: #2563eb; /* Royal Blue */
		--primary-hover: #1d4ed8;
		--primary-light: #eff6ff; /* Soft Blue */
		--secondary: #0ea5e9; /* Sky Blue */
		--secondary-light: #e0f2fe;
		--accent: #1e40af; /* Deep Cobalt Blue */
		--accent-light: #dbeafe;

		--border-light: rgba(226, 232, 240, 0.8);
		--border-glass: rgba(255, 255, 255, 0.6);
		
		--shadow-sm: 0 2px 8px rgba(15, 23, 42, 0.04);
		--shadow-md: 0 10px 25px -5px rgba(15, 23, 42, 0.05), 0 8px 10px -6px rgba(15, 23, 42, 0.05);
		--shadow-lg: 0 20px 40px -15px rgba(15, 23, 42, 0.1), 0 10px 15px -10px rgba(15, 23, 42, 0.1);
		--shadow-indigo: 0 15px 30px -5px rgba(37, 99, 235, 0.2);
		
		--radius-sm: 8px;
		--radius-md: 16px;
		--radius-lg: 24px;
		--radius-xl: 32px;
		
		--transition-fast: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
		--transition-normal: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	}

	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}

	html {
		scroll-behavior: smooth;
	}

	body {
		background-color: var(--bg-primary);
		color: var(--text-main);
		font-family: 'Inter', system-ui, -apple-system, sans-serif;
		line-height: 1.6;
		overflow-x: hidden;
	}

	h1, h2, h3, h4, h5, h6 {
		font-family: 'Outfit', sans-serif;
		color: var(--bg-secondary);
		font-weight: 700;
	}

	a {
		text-decoration: none;
		color: inherit;
		transition: var(--transition-fast);
	}

	img {
		max-width: 100%;
		height: auto;
	}

	.container {
		width: min(1280px, calc(100% - 40px));
		margin: 0 auto;
	}

	.gradient-text {
		background: linear-gradient(135deg, #2563eb 0%, #0ea5e9 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}

	.badge {
		display: inline-flex;
		align-items: center;
		gap: 6px;
		padding: 6px 16px;
		border-radius: 9999px;
		font-size: 13px;
		font-weight: 600;
		letter-spacing: 0.03em;
		text-transform: uppercase;
	}

	.badge-primary {
		background-color: var(--primary-light);
		color: var(--primary);
		border: 1px solid rgba(37, 99, 235, 0.15);
	}

	.badge-success {
		background-color: var(--accent-light);
		color: var(--primary);
		border: 1px solid rgba(30, 64, 175, 0.15);
	}

	.badge-warning {
		background-color: var(--primary-light);
		color: var(--accent);
		border: 1px solid rgba(37, 99, 235, 0.15);
	}

	.pulse-dot {
		width: 8px;
		height: 8px;
		border-radius: 50%;
		background-color: var(--primary);
		animation: pulse 1.5s infinite;
	}

	@keyframes pulse {
		0% {
			transform: scale(0.95);
			box-shadow: 0 0 0 0 rgba(37, 99, 235, 0.7);
		}
		70% {
			transform: scale(1);
			box-shadow: 0 0 0 8px rgba(37, 99, 235, 0);
		}
		100% {
			transform: scale(0.95);
			box-shadow: 0 0 0 0 rgba(37, 99, 235, 0);
		}
	}

	/* Header & Unified Navigation */
	.header {
		position: sticky;
		top: 0;
		z-index: 1000;
		background: rgba(248, 250, 252, 0.85);
		backdrop-filter: blur(20px);
		-webkit-backdrop-filter: blur(20px);
		border-bottom: 1px solid var(--border-light);
		transition: var(--transition-fast);
	}

	.header.scrolled {
		background: rgba(255, 255, 255, 0.95);
		box-shadow: var(--shadow-sm);
	}

	.navbar {
		height: 80px;
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 20px;
	}

	.logo-container {
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.logo-img {
		width: 44px;
		height: 44px;
		border-radius: 12px;
		object-fit: cover;
		border: 2px solid var(--primary-light);
		box-shadow: 0 4px 10px rgba(37, 99, 235, 0.15);
	}

	.logo-text h1 {
		font-size: 20px;
		font-weight: 800;
		line-height: 1.1;
		letter-spacing: -0.02em;
	}

	.logo-text span {
		font-size: 11px;
		font-weight: 500;
		color: var(--text-muted);
		text-transform: uppercase;
		letter-spacing: 0.05em;
	}

	.nav-links {
		display: flex;
		align-items: center;
		gap: 4px;
	}

	.nav-link {
		padding: 8px 14px;
		border-radius: 10px;
		font-weight: 600;
		font-size: 15px;
		color: var(--text-muted);
	}

	.nav-link:hover {
		color: var(--primary);
		background-color: rgba(37, 99, 235, 0.05);
	}

	.cta-buttons {
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.btn {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		gap: 8px;
		padding: 12px 24px;
		border-radius: var(--radius-md);
		font-size: 15px;
		font-weight: 700;
		border: none;
		cursor: pointer;
		transition: var(--transition-normal);
	}

	.btn-primary {
		background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
		color: var(--text-white);
		box-shadow: var(--shadow-indigo);
	}

	.btn-primary:hover {
		transform: translateY(-2px);
		box-shadow: 0 20px 35px -5px rgba(37, 99, 235, 0.35);
	}

	.btn-secondary {
		background-color: var(--surface-card);
		color: var(--bg-secondary);
		border: 1px solid var(--border-light);
		box-shadow: var(--shadow-sm);
	}

	.btn-secondary:hover {
		background-color: var(--primary-light);
		color: var(--primary);
		border-color: rgba(37, 99, 235, 0.2);
		transform: translateY(-2px);
	}

	.menu-btn {
		display: none;
		width: 44px;
		height: 44px;
		border: 1px solid var(--border-light);
		border-radius: 12px;
		background: var(--surface-card);
		cursor: pointer;
		color: var(--bg-secondary);
		font-size: 18px;
	}

	/* Mobile Navigation Drawer */
	.mobile-drawer {
		position: fixed;
		top: 80px;
		left: 0;
		width: 100%;
		background: rgba(255, 255, 255, 0.98);
		backdrop-filter: blur(20px);
		border-bottom: 1px solid var(--border-light);
		padding: 24px;
		box-shadow: var(--shadow-lg);
		z-index: 999;
		display: flex;
		flex-direction: column;
		gap: 12px;
		opacity: 0;
		visibility: hidden;
		transform: translateY(-10px);
		transition: all 0.3s ease;
	}

	.mobile-drawer.active {
		opacity: 1;
		visibility: visible;
		transform: translateY(0);
	}

	.mobile-drawer .nav-link {
		padding: 12px 16px;
		border-radius: 12px;
		background-color: rgba(15, 23, 42, 0.02);
		border: 1px solid rgba(15, 23, 42, 0.03);
	}

	/* Hero Section */
	.hero-section {
		padding: 60px 0 100px;
		background: radial-gradient(circle at top left, rgba(37, 99, 235, 0.1), transparent 45%),
		            radial-gradient(circle at bottom right, rgba(14, 165, 233, 0.08), transparent 45%);
		position: relative;
	}

	.hero-grid {
		display: grid;
		grid-template-columns: 1.15fr 0.85fr;
		gap: 40px;
		align-items: center;
	}

	.hero-content h2 {
		font-size: clamp(34px, 4.5vw, 56px);
		line-height: 1.15;
		letter-spacing: -0.03em;
		margin: 20px 0;
	}

	.hero-content p {
		font-size: clamp(16px, 1.8vw, 19px);
		color: var(--text-muted);
		margin-bottom: 36px;
		max-width: 620px;
	}

	.hero-btns {
		display: flex;
		flex-wrap: wrap;
		gap: 16px;
	}

	.hero-graphics {
		position: relative;
		width: 100%;
		height: 480px;
		display: grid;
		place-items: center;
	}

	/* Modern Glassmorphic UI Dashboard Simulation */
	.dashboard-mockup {
		width: 100%;
		max-width: 480px;
		background: rgba(255, 255, 255, 0.65);
		backdrop-filter: blur(16px);
		-webkit-backdrop-filter: blur(16px);
		border: 1px solid var(--border-glass);
		border-radius: var(--radius-lg);
		padding: 24px;
		box-shadow: var(--shadow-lg);
		position: relative;
		z-index: 2;
	}

	.mockup-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20px;
		padding-bottom: 12px;
		border-bottom: 1px solid rgba(15, 23, 42, 0.08);
	}

	.mockup-actions {
		display: flex;
		gap: 6px;
	}

	.dot {
		width: 10px;
		height: 10px;
		border-radius: 50%;
		background-color: var(--text-light);
	}

	.dot-blue-1 { background-color: var(--accent); }
	.dot-blue-2 { background-color: var(--primary); }
	.dot-blue-3 { background-color: var(--secondary); }

	.mockup-title {
		font-size: 14px;
		font-weight: 700;
		color: var(--text-muted);
		text-transform: uppercase;
		letter-spacing: 0.05em;
	}

	.mockup-stats {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 12px;
		margin-bottom: 16px;
	}

	.mockup-stat-card {
		background: #ffffff;
		padding: 14px;
		border-radius: var(--radius-md);
		border: 1px solid var(--border-light);
		box-shadow: var(--shadow-sm);
	}

	.mockup-stat-card span {
		font-size: 11px;
		font-weight: 600;
		color: var(--text-muted);
		display: block;
	}

	.mockup-stat-card h5 {
		font-size: 18px;
		margin-top: 4px;
	}

	.mockup-chart {
		background: #ffffff;
		padding: 16px;
		border-radius: var(--radius-md);
		border: 1px solid var(--border-light);
		margin-bottom: 16px;
	}

	.mockup-chart-header {
		display: flex;
		justify-content: space-between;
		font-size: 11px;
		font-weight: 600;
		color: var(--text-muted);
		margin-bottom: 10px;
	}

	/* Floating interactive elements */
	.floating-card {
		position: absolute;
		background: var(--surface-card);
		border-radius: var(--radius-md);
		padding: 16px;
		box-shadow: var(--shadow-md);
		border: 1px solid var(--border-light);
		display: flex;
		align-items: center;
		gap: 12px;
		z-index: 3;
		animation: float 6s ease-in-out infinite;
	}

	.floating-card-1 {
		top: 10%;
		right: -5%;
		animation-delay: 0s;
	}

	.floating-card-2 {
		bottom: 8%;
		left: -5%;
		animation-delay: 2s;
	}

	.floating-card-3 {
		bottom: 30%;
		right: -10%;
		animation-delay: 4s;
	}

	@keyframes float {
		0% { transform: translateY(0px); }
		50% { transform: translateY(-10px); }
		100% { transform: translateY(0px); }
	}

	.floating-icon {
		width: 40px;
		height: 40px;
		border-radius: 10px;
		display: grid;
		place-items: center;
		color: #ffffff;
		font-size: 16px;
	}

	/* Why Smart PG Section (Manual Struggles vs Smart PG Solutions) */
	.why-section {
		background-color: var(--surface-card);
		border-top: 1px solid var(--border-light);
		border-bottom: 1px solid var(--border-light);
	}

	.why-grid {
		display: grid;
		grid-template-columns: 1.1fr 0.9fr;
		gap: 40px;
		align-items: center;
	}

	.why-content h3 {
		font-size: clamp(28px, 3.5vw, 42px);
		margin-bottom: 16px;
		line-height: 1.2;
	}

	.why-content p {
		color: var(--text-muted);
		font-size: 16px;
		margin-bottom: 28px;
	}

	.why-comparison-table {
		display: flex;
		flex-direction: column;
		gap: 16px;
	}

	.comparison-row {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 16px;
	}

	.comp-card {
		padding: 18px;
		border-radius: var(--radius-md);
		border: 1px solid var(--border-light);
		font-size: 14px;
	}

	.comp-card.suffering {
		background-color: rgba(30, 64, 175, 0.01);
		border-left: 4px solid var(--text-light);
	}

	.comp-card.resolving {
		background-color: rgba(37, 99, 235, 0.02);
		border-left: 4px solid var(--primary);
	}

	.comp-card h5 {
		font-size: 15px;
		font-weight: 700;
		margin-bottom: 6px;
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.comp-card.suffering h5 { color: var(--text-muted); }
	.comp-card.resolving h5 { color: var(--primary); }

	.comp-card p {
		color: var(--text-muted);
		margin-bottom: 0;
		line-height: 1.5;
	}

	.why-visual-wrapper {
		background: #ffffff;
		border: 1px solid var(--border-light);
		border-radius: var(--radius-xl);
		padding: 24px;
		box-shadow: var(--shadow-lg);
		text-align: center;
	}

	.why-img {
		width: 100%;
		border-radius: var(--radius-lg);
		margin-bottom: 20px;
		box-shadow: var(--shadow-sm);
		border: 1px solid var(--border-light);
	}

	.why-visual-summary {
		text-align: left;
		padding: 0 10px;
	}

	.why-visual-summary h4 {
		font-size: 20px;
		margin-bottom: 8px;
	}

	.why-visual-summary p {
		font-size: 13px;
		color: var(--text-muted);
		margin-bottom: 0;
	}

	/* Workflow / PG Pipeline Section */
	.workflow-section {
		background-color: var(--bg-primary);
	}

	.workflow-timeline {
		display: grid;
		grid-template-columns: repeat(5, 1fr);
		gap: 20px;
		margin-top: 50px;
		position: relative;
	}

	.workflow-timeline::before {
		content: '';
		position: absolute;
		top: 36px;
		left: 10%;
		right: 10%;
		height: 3px;
		background: linear-gradient(90deg, var(--primary-light) 0%, var(--primary) 50%, var(--secondary) 100%);
		z-index: 1;
	}

	.workflow-step {
		text-align: center;
		position: relative;
		z-index: 2;
	}

	.step-circle {
		width: 72px;
		height: 72px;
		border-radius: 50%;
		background: var(--surface-card);
		border: 4px solid var(--border-light);
		color: var(--text-muted);
		display: grid;
		place-items: center;
		font-size: 22px;
		font-weight: 800;
		margin: 0 auto 20px;
		box-shadow: var(--shadow-md);
		transition: all 0.3s ease;
	}

	.workflow-step:hover .step-circle {
		border-color: var(--primary);
		background-color: var(--primary);
		color: var(--text-white);
		transform: scale(1.1);
		box-shadow: var(--shadow-indigo);
	}

	.step-info h4 {
		font-size: 16px;
		font-weight: 700;
		margin-bottom: 8px;
	}

	.step-info p {
		font-size: 13px;
		color: var(--text-muted);
		line-height: 1.5;
	}

	/* Section Commons */
	.section-padding {
		padding: 100px 0;
	}

	.section-header {
		text-align: center;
		max-width: 700px;
		margin: 0 auto 60px;
	}

	.section-header h3 {
		font-size: clamp(28px, 3.5vw, 42px);
		margin-top: 12px;
		letter-spacing: -0.02em;
	}

	.section-header p {
		color: var(--text-muted);
		margin-top: 14px;
		font-size: 16px;
	}

	/* 12 Core Features Section */
	.features-section {
		background-color: #ffffff;
	}

	.features-grid {
		display: grid;
		grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
		gap: 24px;
	}

	.feature-card {
		background-color: var(--bg-primary);
		border-radius: var(--radius-lg);
		padding: 28px;
		border: 1px solid var(--border-light);
		transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
		display: flex;
		flex-direction: column;
		height: 100%;
	}

	.feature-card:hover {
		background-color: #ffffff;
		transform: translateY(-8px);
		box-shadow: var(--shadow-lg);
		border-color: rgba(37, 99, 235, 0.15);
	}

	.feature-icon-wrapper {
		width: 52px;
		height: 52px;
		border-radius: 14px;
		display: grid;
		place-items: center;
		margin-bottom: 22px;
		color: #ffffff;
		font-size: 20px;
	}

	.feature-card h4 {
		font-size: 18px;
		font-weight: 700;
		margin-bottom: 12px;
		line-height: 1.3;
	}

	.feature-card p {
		font-size: 14px;
		color: var(--text-muted);
		line-height: 1.6;
		flex-grow: 1;
	}

	/* Software Tour Interface Gallery Section [NEW] */
	.screens-section {
		background-color: var(--bg-primary);
	}

	.screens-grid {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 36px;
	}

	.screen-card {
		background: var(--surface-card);
		border-radius: var(--radius-lg);
		border: 1px solid var(--border-light);
		padding: 30px;
		box-shadow: var(--shadow-md);
		transition: var(--transition-normal);
		display: flex;
		flex-direction: column;
		gap: 20px;
	}

	.screen-card:hover {
		transform: translateY(-6px);
		box-shadow: var(--shadow-lg);
		border-color: rgba(37, 99, 235, 0.15);
	}

	.screen-img-container {
		border-radius: var(--radius-md);
		overflow: hidden;
		border: 1px solid var(--border-light);
		box-shadow: var(--shadow-sm);
	}

	.screen-img {
		width: 100%;
		display: block;
	}

	.screen-info h4 {
		font-size: 20px;
		margin-bottom: 8px;
		display: flex;
		align-items: center;
		gap: 10px;
	}

	.screen-info h4 i {
		color: var(--primary);
	}

	.screen-info p {
		font-size: 14px;
		color: var(--text-muted);
		line-height: 1.6;
	}

	/* Interactive Savings Calculator Widget [NEW] */
	.calculator-section {
		background-color: #ffffff;
		border-top: 1px solid var(--border-light);
		border-bottom: 1px solid var(--border-light);
	}

	.calc-container {
		max-width: 900px;
		margin: 0 auto;
		background: linear-gradient(135deg, rgba(37, 99, 235, 0.03) 0%, rgba(14, 165, 233, 0.01) 100%);
		border: 1px solid var(--border-light);
		border-radius: var(--radius-xl);
		padding: 40px;
		display: grid;
		grid-template-columns: 1.1fr 0.9fr;
		gap: 40px;
		box-shadow: var(--shadow-md);
	}

	.calc-inputs {
		display: flex;
		flex-direction: column;
		gap: 28px;
	}

	.slider-group {
		display: flex;
		flex-direction: column;
		gap: 10px;
	}

	.slider-label-row {
		display: flex;
		justify-content: space-between;
		align-items: center;
		font-weight: 700;
		font-size: 15px;
	}

	.slider-label-row span.val {
		color: var(--primary);
		font-size: 18px;
		font-family: 'Outfit', sans-serif;
	}

	.calc-slider {
		-webkit-appearance: none;
		width: 100%;
		height: 8px;
		border-radius: 999px;
		background: var(--border-light);
		outline: none;
	}

	.calc-slider::-webkit-slider-thumb {
		-webkit-appearance: none;
		appearance: none;
		width: 22px;
		height: 22px;
		border-radius: 50%;
		background: var(--primary);
		cursor: pointer;
		box-shadow: var(--shadow-sm);
		transition: transform 0.1s;
	}

	.calc-slider::-webkit-slider-thumb:hover {
		transform: scale(1.15);
	}

	.calc-outputs {
		background: #ffffff;
		border: 1px solid var(--border-light);
		border-radius: var(--radius-lg);
		padding: 30px;
		display: flex;
		flex-direction: column;
		justify-content: center;
		gap: 20px;
		box-shadow: var(--shadow-sm);
	}

	.calc-output-item {
		border-bottom: 1px solid rgba(15, 23, 42, 0.05);
		padding-bottom: 16px;
	}

	.calc-output-item:last-child {
		border-bottom: none;
		padding-bottom: 0;
	}

	.calc-output-item span {
		font-size: 12px;
		font-weight: 600;
		color: var(--text-muted);
		text-transform: uppercase;
		letter-spacing: 0.05em;
		display: block;
	}

	.calc-output-item strong {
		font-family: 'Outfit', sans-serif;
		font-size: 28px;
		font-weight: 800;
		color: var(--bg-secondary);
		display: block;
		margin-top: 4px;
	}

	.calc-output-item.highlight strong {
		color: var(--primary);
		font-size: 34px;
	}

	/* Interactive Testimonials Carousel Section [NEW] */
	.feedback-section {
		background-color: var(--bg-primary);
	}

	.feedback-carousel-wrapper {
		max-width: 800px;
		margin: 0 auto;
		position: relative;
		overflow: hidden;
		padding: 20px 10px;
	}

	.feedback-track {
		display: flex;
		transition: transform 0.5s ease-in-out;
		width: 100%;
	}

	.feedback-slide {
		min-width: 100%;
		flex-shrink: 0;
		background: #ffffff;
		border: 1px solid var(--border-light);
		border-radius: var(--radius-lg);
		padding: 40px;
		box-shadow: var(--shadow-md);
		text-align: center;
	}

	.feedback-stars {
		color: var(--primary);
		font-size: 18px;
		margin-bottom: 20px;
	}

	.feedback-quote {
		font-size: 18px;
		font-style: italic;
		color: var(--text-main);
		line-height: 1.6;
		margin-bottom: 24px;
		font-family: 'Inter', sans-serif;
	}

	.feedback-profile h5 {
		font-size: 16px;
		font-weight: 800;
		color: var(--bg-secondary);
	}

	.feedback-profile span {
		font-size: 13px;
		color: var(--text-muted);
	}

	.carousel-nav-btn {
		position: absolute;
		top: 50%;
		transform: translateY(-50%);
		width: 44px;
		height: 44px;
		border-radius: 50%;
		background: #ffffff;
		border: 1px solid var(--border-light);
		color: var(--text-main);
		cursor: pointer;
		display: grid;
		place-items: center;
		z-index: 10;
		box-shadow: var(--shadow-sm);
		transition: var(--transition-fast);
	}

	.carousel-nav-btn:hover {
		background-color: var(--primary-light);
		color: var(--primary);
		border-color: rgba(37, 99, 235, 0.2);
	}

	.carousel-nav-btn.prev { left: -10px; }
	.carousel-nav-btn.next { right: -10px; }

	.carousel-dots {
		display: flex;
		justify-content: center;
		gap: 8px;
		margin-top: 24px;
	}

	.carousel-dot {
		width: 10px;
		height: 10px;
		border-radius: 50%;
		background-color: var(--text-light);
		border: none;
		cursor: pointer;
		transition: var(--transition-fast);
	}

	.carousel-dot.active {
		background-color: var(--primary);
		width: 24px;
		border-radius: 999px;
	}

	/* Compare Portals Section */
	.compare-section {
		background-color: #ffffff;
	}

	.tabs-container {
		max-width: 800px;
		margin: 0 auto;
	}

	.tabs-nav {
		display: flex;
		justify-content: center;
		gap: 12px;
		background-color: var(--bg-primary);
		padding: 8px;
		border-radius: var(--radius-md);
		border: 1px solid var(--border-light);
		margin-bottom: 40px;
	}

	.tab-btn {
		flex: 1;
		padding: 14px 24px;
		border-radius: 12px;
		font-weight: 700;
		font-size: 16px;
		cursor: pointer;
		background: transparent;
		border: none;
		color: var(--text-muted);
		transition: var(--transition-fast);
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 8px;
	}

	.tab-btn.active {
		background-color: var(--surface-card);
		color: var(--primary);
		box-shadow: var(--shadow-sm);
	}

	.tab-content {
		display: none;
		grid-template-columns: 1fr 1fr;
		gap: 40px;
		align-items: center;
		animation: fadeIn 0.4s ease;
	}

	.tab-content.active {
		display: grid;
	}

	@keyframes fadeIn {
		from { opacity: 0; transform: translateY(10px); }
		to { opacity: 1; transform: translateY(0); }
	}

	.tab-text h4 {
		font-size: 26px;
		margin-bottom: 16px;
	}

	.tab-text p {
		color: var(--text-muted);
		margin-bottom: 24px;
	}

	.tab-features-list {
		list-style: none;
	}

	.tab-features-list li {
		display: flex;
		align-items: center;
		gap: 12px;
		margin-bottom: 12px;
		font-weight: 600;
		font-size: 15px;
	}

	.tab-features-list i {
		font-size: 16px;
	}

	.tab-img {
		background-color: var(--bg-primary);
		padding: 20px;
		border-radius: var(--radius-lg);
		border: 1px solid var(--border-light);
		box-shadow: var(--shadow-md);
	}

	.matrix-box {
		background-color: #ffffff;
		border-radius: var(--radius-md);
		padding: 16px;
		border-left: 4px solid var(--primary);
		margin-bottom: 12px;
		box-shadow: var(--shadow-sm);
	}

	.matrix-title {
		font-weight: 700;
		font-size: 14px;
		color: var(--bg-secondary);
	}

	.matrix-desc {
		font-size: 13px;
		color: var(--text-muted);
		margin-top: 4px;
	}

	/* Interactive Pricing Cards */
	.pricing-section {
		background-color: var(--bg-primary);
		position: relative;
	}

	.pricing-toggle {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 16px;
		margin-bottom: 48px;
	}

	.toggle-label {
		font-size: 15px;
		font-weight: 700;
		color: var(--text-muted);
	}

	.toggle-label.active {
		color: var(--bg-secondary);
	}

	.toggle-switch {
		width: 60px;
		height: 32px;
		background-color: var(--primary);
		border-radius: 999px;
		position: relative;
		cursor: pointer;
		padding: 4px;
		transition: background-color 0.3s;
	}

	.toggle-ball {
		width: 24px;
		height: 24px;
		background-color: #ffffff;
		border-radius: 50%;
		position: absolute;
		top: 4px;
		left: 4px;
		transition: left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
		box-shadow: var(--shadow-sm);
	}

	.toggle-switch.yearly .toggle-ball {
		left: 32px;
	}

	.pricing-grid {
		display: grid;
		grid-template-columns: repeat(3, 1fr);
		gap: 24px;
	}

	.pricing-card {
		background-color: #ffffff;
		border-radius: var(--radius-lg);
		padding: 36px;
		border: 1px solid var(--border-light);
		box-shadow: var(--shadow-md);
		position: relative;
		display: flex;
		flex-direction: column;
		height: 100%;
		transition: var(--transition-normal);
	}

	.pricing-card:hover {
		transform: translateY(-8px);
		box-shadow: var(--shadow-lg);
	}

	.pricing-card.popular {
		border: 2px solid var(--primary);
		box-shadow: var(--shadow-lg);
	}

	.pricing-ribbon {
		position: absolute;
		top: -14px;
		left: 50%;
		transform: translateX(-50%);
		background: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
		color: var(--text-white);
		padding: 4px 16px;
		border-radius: 9999px;
		font-size: 11px;
		font-weight: 800;
		text-transform: uppercase;
		letter-spacing: 0.05em;
		box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
	}

	.pricing-header h4 {
		font-size: 20px;
		text-transform: uppercase;
		color: var(--text-muted);
		letter-spacing: 0.05em;
		margin-bottom: 12px;
	}

	.pricing-card.popular .pricing-header h4 {
		color: var(--primary);
	}

	.price-display {
		margin: 20px 0;
	}

	.price-display .currency {
		font-size: 24px;
		font-weight: 700;
		vertical-align: top;
		position: relative;
		top: 6px;
	}

	.price-display .amount {
		font-size: 48px;
		font-weight: 900;
		letter-spacing: -0.03em;
		line-height: 1;
	}

	.price-display .period {
		font-size: 14px;
		color: var(--text-muted);
		font-weight: 500;
	}

	.pricing-features {
		list-style: none;
		margin: 24px 0;
		flex-grow: 1;
	}

	.pricing-features li {
		display: flex;
		align-items: center;
		gap: 12px;
		margin-bottom: 12px;
		font-size: 14px;
		color: var(--text-main);
	}

	.pricing-features li i {
		font-size: 14px;
	}

	.pricing-features li i.fa-circle-check { color: var(--primary); }
	.pricing-features li i.fa-circle-xmark { color: var(--text-light); }

	.pricing-card .btn {
		width: 100%;
		border-radius: 12px;
	}

	/* Interactive FAQs Accordion */
	.faq-section {
		background-color: #ffffff;
	}

	.faq-container {
		max-width: 760px;
		margin: 0 auto;
	}

	.faq-item {
		border-bottom: 1px solid var(--border-light);
		padding: 20px 0;
	}

	.faq-question {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;
		background: transparent;
		border: none;
		text-align: left;
		cursor: pointer;
		font-size: 18px;
		font-weight: 700;
		color: var(--bg-secondary);
		gap: 20px;
	}

	.faq-answer {
		max-height: 0;
		overflow: hidden;
		transition: max-height 0.3s cubic-bezier(0, 1, 0, 1);
		color: var(--text-muted);
		font-size: 15px;
		margin-top: 0;
	}

	.faq-item.active .faq-answer {
		max-height: 1000px;
		margin-top: 12px;
		transition: max-height 0.4s cubic-bezier(1, 0, 1, 0);
	}

	.faq-icon {
		width: 24px;
		height: 24px;
		border-radius: 50%;
		background-color: var(--bg-primary);
		display: grid;
		place-items: center;
		font-size: 12px;
		transition: transform 0.3s ease;
		color: var(--text-muted);
	}

	.faq-item.active .faq-icon {
		transform: rotate(180deg);
		background-color: var(--primary-light);
		color: var(--primary);
	}

	/* Support Callout Banner */
	.support-banner {
		padding: 60px 0;
		background: linear-gradient(135deg, rgba(37, 99, 235, 0.05) 0%, rgba(14, 165, 233, 0.02) 100%);
		border-top: 1px solid var(--border-light);
		border-bottom: 1px solid var(--border-light);
	}

	.support-panel {
		background: #ffffff;
		border: 1px solid var(--border-light);
		border-radius: var(--radius-lg);
		padding: 40px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		gap: 30px;
		box-shadow: var(--shadow-md);
		flex-wrap: wrap;
	}

	.support-text {
		flex: 1;
		min-width: 300px;
	}

	.support-text h4 {
		font-size: 24px;
		margin-bottom: 8px;
	}

	.support-text p {
		color: var(--text-muted);
		font-size: 15px;
	}

	/* Professional Footer */
	.footer {
		background-color: var(--bg-secondary);
		color: var(--text-light);
		padding: 80px 0 30px;
		border-top: 1px solid rgba(255, 255, 255, 0.06);
	}

	.footer-grid {
		display: grid;
		grid-template-columns: 1.5fr 1fr 1fr 1fr;
		gap: 40px;
		margin-bottom: 60px;
	}

	.footer-logo {
		margin-bottom: 20px;
	}

	.footer-logo h4 {
		color: var(--text-white);
		font-size: 22px;
		font-weight: 800;
	}

	.footer-logo span {
		color: var(--text-light);
		font-size: 12px;
		text-transform: uppercase;
		letter-spacing: 0.05em;
	}

	.footer-desc {
		font-size: 14px;
		line-height: 1.65;
		margin-bottom: 24px;
		max-width: 320px;
	}

	.social-links {
		display: flex;
		gap: 12px;
	}

	.social-icon {
		width: 36px;
		height: 36px;
		border-radius: 50%;
		background-color: rgba(255, 255, 255, 0.05);
		color: var(--text-white);
		display: grid;
		place-items: center;
		font-size: 14px;
		transition: var(--transition-fast);
	}

	.social-icon:hover {
		background-color: var(--primary);
		transform: translateY(-2px);
	}

	.footer-col h5 {
		color: var(--text-white);
		font-size: 16px;
		margin-bottom: 24px;
		position: relative;
		padding-bottom: 8px;
	}

	.footer-col h5::after {
		content: '';
		position: absolute;
		left: 0;
		bottom: 0;
		width: 30px;
		height: 2px;
		background-color: var(--primary);
	}

	.footer-links {
		list-style: none;
	}

	.footer-links li {
		margin-bottom: 12px;
	}

	.footer-links a {
		font-size: 14px;
		font-weight: 500;
	}

	.footer-links a:hover {
		color: var(--text-white);
		padding-left: 4px;
	}

	.footer-contact li {
		display: flex;
		align-items: flex-start;
		gap: 12px;
		margin-bottom: 16px;
		font-size: 14px;
	}

	.footer-contact i {
		margin-top: 4px;
		color: var(--primary);
	}

	.footer-bottom {
		border-top: 1px solid rgba(255, 255, 255, 0.05);
		padding-top: 30px;
		display: flex;
		justify-content: space-between;
		align-items: center;
		flex-wrap: wrap;
		gap: 20px;
	}

	.footer-copy {
		font-size: 13px;
	}

	.footer-bottom-links {
		display: flex;
		gap: 20px;
		font-size: 13px;
	}

	/* Responsive Breakpoints */
	@media (max-width: 1024px) {
		.hero-grid {
			grid-template-columns: 1fr;
			gap: 60px;
			text-align: center;
		}

		.hero-content p {
			margin-left: auto;
			margin-right: auto;
		}

		.hero-btns {
			justify-content: center;
		}

		.why-grid {
			grid-template-columns: 1fr;
			gap: 40px;
		}

		.why-visual-wrapper {
			max-width: 540px;
			margin: 0 auto;
		}

		.workflow-timeline {
			grid-template-columns: repeat(3, 1fr);
		}

		.workflow-timeline::before {
			display: none;
		}

		.screens-grid {
			grid-template-columns: 1fr;
			max-width: 600px;
			margin: 0 auto;
		}

		.calc-container {
			grid-template-columns: 1fr;
			max-width: 600px;
		}

		.pricing-grid {
			grid-template-columns: repeat(2, 1fr);
			gap: 20px;
		}
		
		.pricing-card.popular {
			grid-row: span 1;
		}

		.footer-grid {
			grid-template-columns: repeat(2, 1fr);
		}
	}

	@media (max-width: 768px) {
		.nav-links, .header .cta-buttons {
			display: none;
		}

		.menu-btn {
			display: grid;
			place-items: center;
		}

		.section-padding {
			padding: 60px 0;
		}

		.why-comparison-table {
			gap: 12px;
		}

		.comparison-row {
			grid-template-columns: 1fr;
			gap: 12px;
		}

		.workflow-timeline {
			grid-template-columns: 1fr;
			gap: 30px;
		}

		.tab-content {
			grid-template-columns: 1fr;
			gap: 30px;
		}

		.tab-img {
			order: -1;
		}

		.pricing-grid {
			grid-template-columns: 1fr;
			max-width: 440px;
			margin: 0 auto;
		}

		.support-panel {
			flex-direction: column;
			text-align: center;
		}

		.support-panel .btn {
			width: 100%;
		}
	}

	@media (max-width: 520px) {
		.footer-grid {
			grid-template-columns: 1fr;
		}

		.footer-bottom {
			flex-direction: column;
			text-align: center;
		}
	}
</style>
</head>

<body>

<!-- Header / Unified Navigation -->
<header class="header" id="header">
	<div class="container navbar">
		<a href="#" class="logo-container">
			<img src="<%=request.getContextPath()%>/images/logo.jpg" alt="Smart PG Logo" class="logo-img">
			<div class="logo-text">
				<h1>Smart PG</h1>
				<span>Management Suite</span>
			</div>
		</a>

		<nav class="nav-links">
			<a href="#why" class="nav-link">Why Us</a>
			<a href="#workflow" class="nav-link">Workflow</a>
			<a href="#features" class="nav-link">Features</a>
			<a href="#interface" class="nav-link">Software Tour</a>
			<a href="#calculator" class="nav-link">Calculator</a>
			<a href="#feedback" class="nav-link">Feedback</a>
			<a href="#pricing" class="nav-link">Pricing</a>
			<a href="#faq" class="nav-link">FAQs</a>
		</nav>

		<div class="cta-buttons">
			<a href="<%=ctx%>/tenantLogin.jsp" class="btn btn-secondary">
				<i class="fa-solid fa-user"></i> Tenant Login
			</a>
			<a href="<%=ctx%>/login.jsp" class="btn btn-primary">
				<i class="fa-solid fa-user-shield"></i> Admin Portal
			</a>
		</div>

		<button class="menu-btn" id="menuBtn" type="button" aria-label="Toggle Navigation menu">
			<i class="fa-solid fa-bars"></i>
		</button>
	</div>
</header>

<!-- Mobile Navigation Drawer -->
<div class="mobile-drawer" id="mobileDrawer">
	<a href="#why" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-circle-question" style="margin-right: 8px;"></i> Why Us</a>
	<a href="#workflow" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-gears" style="margin-right: 8px;"></i> Workflow</a>
	<a href="#features" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-star" style="margin-right: 8px;"></i> Features</a>
	<a href="#interface" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-desktop" style="margin-right: 8px;"></i> Software Tour</a>
	<a href="#calculator" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-calculator" style="margin-right: 8px;"></i> Savings Calculator</a>
	<a href="#feedback" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-comments" style="margin-right: 8px;"></i> Feedback</a>
	<a href="#pricing" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-tag" style="margin-right: 8px;"></i> Pricing</a>
	<a href="#faq" class="nav-link" onclick="toggleMenu()"><i class="fa-solid fa-circle-question" style="margin-right: 8px;"></i> FAQs</a>
	<div style="display: flex; flex-direction: column; gap: 10px; margin-top: 10px;">
		<a href="<%=ctx%>/tenantLogin.jsp" class="btn btn-secondary" style="width: 100%;">
			<i class="fa-solid fa-user"></i> Tenant Login
		</a>
		<a href="<%=ctx%>/login.jsp" class="btn btn-primary" style="width: 100%;">
			<i class="fa-solid fa-user-shield"></i> Admin Portal
		</a>
	</div>
</div>

<!-- Hero Section -->
<section class="hero-section">
	<div class="container hero-grid">
		<div class="hero-content">
			<div class="badge badge-primary">
				<span class="pulse-dot"></span> Smart PG Hostels Platform
			</div>
			<h2>Redefining Paying Guest & Hostel Operations</h2>
			<p>
				Say goodbye to messy paper registers and manual rent chase-ups. Manage room bookings, collect rent payments, print digital receipts, track complaints, and organize weekly menus from one premium, fully responsive system.
			</p>
			<div class="hero-btns">
				<a href="<%=ctx%>/login.jsp" class="btn btn-primary">
					<i class="fa-solid fa-user-shield"></i> Admin/Owner Login
				</a>
				<a href="<%=ctx%>/tenantLogin.jsp" class="btn btn-secondary">
					<i class="fa-solid fa-user"></i> Resident Tenant Login
				</a>
			</div>
		</div>

		<div class="hero-graphics">
			<!-- Glassmorphic Mockup simulating PG Admin Dashboard -->
			<div class="dashboard-mockup">
				<div class="mockup-header">
					<div class="mockup-actions">
						<span class="dot dot-blue-1"></span>
						<span class="dot dot-blue-2"></span>
						<span class="dot dot-blue-3"></span>
					</div>
					<span class="mockup-title">PG Command Center</span>
				</div>
				<div class="mockup-stats">
					<div class="mockup-stat-card">
						<span>Occupancy Rate</span>
						<h5 style="color: var(--primary);">94.2%</h5>
					</div>
					<div class="mockup-stat-card">
						<span>Rent Collected</span>
						<h5 style="color: var(--accent);">₹3,84,000</h5>
					</div>
				</div>
				<div class="mockup-chart">
					<div class="mockup-chart-header">
						<span>Monthly Profit & Loss</span>
						<span style="color: var(--primary);"><i class="fa-solid fa-caret-up"></i> +12%</span>
					</div>
					<!-- Miniature Pure CSS SVG Graph -->
					<svg viewBox="0 0 400 120" style="width: 100%; height: auto;">
						<defs>
							<linearGradient id="chartGrad" x1="0" y1="0" x2="0" y2="1">
								<stop offset="0%" stop-color="#2563eb" stop-opacity="0.2"/>
								<stop offset="100%" stop-color="#2563eb" stop-opacity="0"/>
							</linearGradient>
						</defs>
						<path d="M 0 100 Q 50 40 100 80 T 200 30 T 300 60 T 400 20 L 400 120 L 0 120 Z" fill="url(#chartGrad)"/>
						<path d="M 0 100 Q 50 40 100 80 T 200 30 T 300 60 T 400 20" fill="none" stroke="#2563eb" stroke-width="3" stroke-linecap="round"/>
						<circle cx="200" cy="30" r="5" fill="#2563eb"/>
						<circle cx="400" cy="20" r="5" fill="#0ea5e9"/>
					</svg>
				</div>
				<div style="font-size: 11px; font-weight: 600; color: var(--text-muted); display: flex; align-items: center; justify-content: space-between;">
					<span>Live Operations Monitor</span>
					<span style="color: var(--primary);"><i class="fa-solid fa-circle" style="font-size: 7px; margin-right: 4px;"></i> Connected</span>
				</div>
			</div>

			<!-- Floating Card 1: Bed Allocation -->
			<div class="floating-card floating-card-1">
				<div class="floating-icon" style="background: linear-gradient(135deg, #2563eb, #1d4ed8);">
					<i class="fa-solid fa-bed"></i>
				</div>
				<div>
					<span style="font-size: 11px; color: var(--text-muted); font-weight: 600; display: block;">Bed Allocated</span>
					<strong style="font-size: 14px; color: var(--bg-secondary);">Room 204B · Bed A</strong>
				</div>
			</div>

			<!-- Floating Card 2: Payment Confirmed -->
			<div class="floating-card floating-card-2">
				<div class="floating-icon" style="background: linear-gradient(135deg, #2563eb, #0ea5e9);">
					<i class="fa-solid fa-circle-check"></i>
				</div>
				<div>
					<span style="font-size: 11px; color: var(--text-muted); font-weight: 600; display: block;">Rent Received</span>
					<strong style="font-size: 14px; color: var(--bg-secondary);">₹6,500 · Verified</strong>
				</div>
			</div>

			<!-- Floating Card 3: Support Ticket -->
			<div class="floating-card floating-card-3">
				<div class="floating-icon" style="background: linear-gradient(135deg, #1e40af, #2563eb);">
					<i class="fa-solid fa-wrench"></i>
				</div>
				<div>
					<span style="font-size: 11px; color: var(--text-muted); font-weight: 600; display: block;">Complaint Resolved</span>
					<strong style="font-size: 14px; color: var(--bg-secondary);">WiFi Fixed · Room 301</strong>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Why Smart PG Section (Manual Struggles vs Smart PG Solutions) -->
<section class="section-padding why-section" id="why">
	<div class="container why-grid">
		<div class="why-content">
			<div class="badge badge-warning">Why Traditional PGs Suffer</div>
			<h3>Eliminate the Mess of Manual PG Administration</h3>
			<p>
				Running a paying guest accommodation is stressful when you rely on notebooks and text messages. Here is how manual operations drag PG operators down, and how our digital suite brings absolute peace of mind.
			</p>
			
			<div class="why-comparison-table">
				<!-- Pain & Resolution 1: Rent Collections -->
				<div class="comparison-row">
					<div class="comp-card suffering">
						<h5><i class="fa-solid fa-circle-xmark"></i> Traditional Suffering</h5>
						<p>Chasing rent dues manually, keeping record of payments in paper ledgers, and dealing with math leakages.</p>
					</div>
					<div class="comp-card resolving">
						<h5><i class="fa-solid fa-circle-check"></i> Smart PG Solution</h5>
						<p>Auto rent bill calculations, digital payment transaction confirmations, and instant PDF receipt downloads.</p>
					</div>
				</div>

				<!-- Pain & Resolution 2: Complaints -->
				<div class="comparison-row">
					<div class="comp-card suffering">
						<h5><i class="fa-solid fa-circle-xmark"></i> Traditional Suffering</h5>
						<p>Tenants complain about broken geysers, cleaning, or WiFi verbally, resulting in forgotten chores and disputes.</p>
					</div>
					<div class="comp-card resolving">
						<h5><i class="fa-solid fa-circle-check"></i> Smart PG Solution</h5>
						<p>A digital support ticket console for tenants to report maintenance issues, tracked in real-time by admins.</p>
					</div>
				</div>

				<!-- Pain & Resolution 3: Food & Notices -->
				<div class="comparison-row">
					<div class="comp-card suffering">
						<h5><i class="fa-solid fa-circle-xmark"></i> Traditional Suffering</h5>
						<p>Scribbling breakfast plans on chalkboards or pasting paper rules that tenants ignore or miss.</p>
					</div>
					<div class="comp-card resolving">
						<h5><i class="fa-solid fa-circle-check"></i> Smart PG Solution</h5>
						<p>Weekly food menu schedules and official notice banners accessible directly on tenant dashboard screens.</p>
					</div>
				</div>
			</div>
		</div>

		<!-- Visual Split Screen Illustration -->
		<div class="why-visual-wrapper">
			<img src="<%=request.getContextPath()%>/images/manual_vs_digital_pg.png" alt="Traditional Manual Desk vs Modern Smart PG Management Suite" class="why-img">
			<div class="why-visual-summary">
				<h4>Modernize Your PG Business</h4>
				<p>Transition from a chaotic stack of paper receipt logs to a structured SaaS operational panel. Track profits, payments, gate visitors, room vacancy charts, and employee payroll checks instantly.</p>
			</div>
		</div>
	</div>
</section>

<!-- Operational Workflow Section -->
<section class="section-padding workflow-section" id="workflow">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-primary">Smooth Operations</div>
			<h3>How the PG System Works</h3>
			<p>A step-by-step pipeline designed to streamline administration, tracking from bed registration to month-end reports.</p>
		</div>

		<div class="workflow-timeline">
			<!-- Step 1 -->
			<div class="workflow-step">
				<div class="step-circle">1</div>
				<div class="step-info">
					<h4>Setup PG Rooms</h4>
					<p>Add PG branches, allocate floors, configure beds, and set sharing and AC rates.</p>
				</div>
			</div>

			<!-- Step 2 -->
			<div class="workflow-step">
				<div class="step-circle">2</div>
				<div class="step-info">
					<h4>Check-In Tenants</h4>
					<p>Upload tenant profiles, log emergency contacts, and allot beds digitally.</p>
				</div>
			</div>

			<!-- Step 3 -->
			<div class="workflow-step">
				<div class="step-circle">3</div>
				<div class="step-info">
					<h4>Auto Rent Alerts</h4>
					<p>System generates invoices monthly and broadcasts automated email/SMS reminders.</p>
				</div>
			</div>

			<!-- Step 4 -->
			<div class="workflow-step">
				<div class="step-circle">4</div>
				<div class="step-info">
					<h4>Tenant Self-Pay</h4>
					<p>Tenants submit payments online, check daily menus, and lodge repair complaints.</p>
				</div>
			</div>

			<!-- Step 5 -->
			<div class="workflow-step">
				<div class="step-circle">5</div>
				<div class="step-info">
					<h4>Track Revenue</h4>
					<p>Download expense sheets, check salary logs, and monitor clean profit graphs.</p>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- 12 Core Features Section -->
<section class="section-padding features-section" id="features">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-primary">Comprehensive Features</div>
			<h3>All-in-One PG & Hostel Management Cockpit</h3>
			<p>Everything you need to successfully launch, run, scale, and market your paying guest accommodations without the administration overhead.</p>
		</div>

		<div class="features-grid">
			<!-- Feature 1: Room Bed Management -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #2563eb, #1d4ed8);">
					<i class="fa-solid fa-hotel"></i>
				</div>
				<h4>Room & Bed Allocation</h4>
				<p>Track single, double, or triple sharing setups. Manage vacancies, check occupied beds, and assign rooms smoothly during tenant onboarding.</p>
			</div>

			<!-- Feature 2: Tenant Profiles -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #0ea5e9, #2563eb);">
					<i class="fa-solid fa-users"></i>
				</div>
				<h4>Tenant Registries</h4>
				<p>Maintain detailed profile logs for each tenant, including emergency contacts, check-in dates, and histories of past room occupancies.</p>
			</div>

			<!-- Feature 3: Smart Rent Invoices -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #1e40af, #2563eb);">
					<i class="fa-solid fa-file-invoice-dollar"></i>
				</div>
				<h4>Invoicing & PDF Receipts</h4>
				<p>Auto-generate rent invoices. Allow tenants to view paid histories, request invoice copies, and print formal payment receipts instantly.</p>
			</div>

			<!-- Feature 4: Automatic Reminders -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #2563eb, #0ea5e9);">
					<i class="fa-solid fa-bell"></i>
				</div>
				<h4>SMS & Email Reminders</h4>
				<p>Broadcast outstanding dues reminders automatically. Alert tenants on upcoming rent checks, local policies, or food menu modifications.</p>
			</div>

			<!-- Feature 5: Multi-Role Dashboard -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #1e40af, #1d4ed8);">
					<i class="fa-solid fa-laptop-code"></i>
				</div>
				<h4>Dual Access Portals</h4>
				<p>Distinct portals optimized for PG Admins (full operational control) and PG Tenants (quick receipts, food menu schedules, and complaint logs).</p>
			</div>

			<!-- Feature 6: Complaint Ticketing -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #2563eb, #1e40af);">
					<i class="fa-solid fa-circle-exclamation"></i>
				</div>
				<h4>Complaint Resolution</h4>
				<p>Enable tenants to lodge cleaning, electricity, or WiFi issues online. Admins track status levels and mark resolved tickets instantly.</p>
			</div>

			<!-- Feature 7: Food Menu Scheduler -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #0ea5e9, #1e40af);">
					<i class="fa-solid fa-utensils"></i>
				</div>
				<h4>Food Menu Planner</h4>
				<p>Schedule breakfast, lunch, and dinner menus weekly. Tenants can instantly view "Today's Special" on their mobile dashboards.</p>
			</div>

			<!-- Feature 8: Expense Logging -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #1d4ed8, #0ea5e9);">
					<i class="fa-solid fa-receipt"></i>
				</div>
				<h4>Operational Expenses</h4>
				<p>Track PG maintenance expenses, grocery costs, utility invoices, and electricity bills to analyze monthly spending figures.</p>
			</div>

			<!-- Feature 9: Employee Salaries -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #2563eb, #1e40af);">
					<i class="fa-solid fa-money-check-dollar"></i>
				</div>
				<h4>Employee Payroll</h4>
				<p>Log employees, cooks, cleaners, and security staff. Maintain salary logs, track pending payments, and check payment history.</p>
			</div>

			<!-- Feature 10: Security Visitor Logs -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #1e293b, #0f172a);">
					<i class="fa-solid fa-user-lock"></i>
				</div>
				<h4>Visitor Registers</h4>
				<p>Monitor security parameters at your gates. Log visitor names, check-in timestamps, phone entries, and host room mappings.</p>
			</div>

			<!-- Feature 11: Revenue Reporting -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #0ea5e9, #2563eb);">
					<i class="fa-solid fa-chart-pie"></i>
				</div>
				<h4>Revenue Charts</h4>
				<p>Visualize cash flow logs, outstanding tenant dues, monthly earnings statistics, and analyze PG growth patterns dynamically.</p>
			</div>

			<!-- Feature 12: SaaS Multi-Branch -->
			<div class="feature-card">
				<div class="feature-icon-wrapper" style="background: linear-gradient(135deg, #2563eb, #1d4ed8);">
					<i class="fa-solid fa-diagram-project"></i>
				</div>
				<h4>Multi-Hostel Networks</h4>
				<p>Scale operations seamlessly. Control multiple PG branches, hostels, or buildings from a single Super Admin SaaS cockpit.</p>
			</div>
		</div>
	</div>
</section>

<!-- Software tour Gallery Section (Real Interface screenshots) [NEW] -->
<section class="section-padding screens-section" id="interface">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-success"><i class="fa-solid fa-desktop"></i> Real-time software screenshots</div>
			<h3>Explore the User Interfaces</h3>
			<p>Visual previews of the actual dashboards and modules built to automate management routines for both administrators and tenants.</p>
		</div>

		<div class="screens-grid">
			<!-- Screen 1: Admin Dashboard -->
			<div class="screen-card">
				<div class="screen-img-container">
					<img src="<%=request.getContextPath()%>/images/admin_dashboard.png" alt="Smart PG Owner Admin Control Panel Mockup" class="screen-img">
				</div>
				<div class="screen-info">
					<h4><i class="fa-solid fa-chart-line"></i> Centralized Admin Dashboard</h4>
					<p>Provides PG operators complete business control. Access critical KPI trackers (occupancy counts, check-ins), view revenue line-graphs, download expense lists, track active complaints, and review staff salary ledgers.</p>
				</div>
			</div>

			<!-- Screen 2: Tenant Mobile View -->
			<div class="screen-card">
				<div class="screen-img-container">
					<img src="<%=request.getContextPath()%>/images/tenant_dashboard.png" alt="Smart PG Resident Tenant Mobile Panel Mockup" class="screen-img">
				</div>
				<div class="screen-info">
					<h4><i class="fa-solid fa-mobile-screen-button"></i> Mobile-Friendly Tenant Portal</h4>
					<p>Empowers resident tenants with a self-service workspace. Residents verify their bed allocation, retrieve monthly rent bills, pay balances, download PDF transaction receipts, check weekly food menu boards, and report helpdesk complaints.</p>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Savings Calculator Widget Section [NEW] -->
<section class="section-padding calculator-section" id="calculator">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-primary">Savings Estimator</div>
			<h3>Calculate Your Return on Investment</h3>
			<p>Drag the sliders to input your PG details and see how much administrative work and revenue leakage you can recover with Smart PG.</p>
		</div>

		<div class="calc-container">
			<div class="calc-inputs">
				<!-- Input 1: Beds -->
				<div class="slider-group">
					<div class="slider-label-row">
						<span>Total Capacity (Beds)</span>
						<span class="val" id="bedsVal">80 Beds</span>
					</div>
					<input type="range" min="10" max="500" value="80" class="calc-slider" id="bedsSlider" oninput="calculateSavings()" aria-label="Adjust total capacity in beds">
				</div>

				<!-- Input 2: Rent -->
				<div class="slider-group">
					<div class="slider-label-row">
						<span>Avg Monthly Rent per Bed</span>
						<span class="val" id="rentVal">₹7,500</span>
					</div>
					<input type="range" min="2000" max="25000" step="500" value="7500" class="calc-slider" id="rentSlider" oninput="calculateSavings()" aria-label="Adjust average monthly rent per bed">
				</div>
			</div>

			<div class="calc-outputs">
				<div class="calc-output-item">
					<span>Expected Monthly Revenue</span>
					<strong id="revenueOutput">₹6,00,000</strong>
				</div>
				<div class="calc-output-item">
					<span>Avg. Revenue Loss (Without System - 8%)</span>
					<strong style="color: var(--danger);" id="leakageOutput">₹48,000</strong>
				</div>
				<div class="calc-output-item highlight">
					<span>Estimated Monthly Recovery (With Smart PG)</span>
					<strong id="savingsOutput">₹48,000</strong>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Compare Portals Section -->
<section class="section-padding compare-section" id="compare">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-primary">Dual Access Matrix</div>
			<h3>Two Portals. One Integrated Backend.</h3>
			<p>Explore how the system accommodates both the operational demands of PG administrators and the self-service needs of residents.</p>
		</div>

		<div class="tabs-container">
			<div class="tabs-nav">
				<button class="tab-btn active" onclick="switchTab('adminTab', this)">
					<i class="fa-solid fa-user-shield"></i> PG Admins & Owners
				</button>
				<button class="tab-btn" onclick="switchTab('tenantTab', this)">
					<i class="fa-solid fa-user"></i> Resident Tenants
				</button>
			</div>

			<!-- Admin Tab Content -->
			<div class="tab-content active" id="adminTab">
				<div class="tab-text">
					<h4>Complete PG Business Oversight</h4>
					<p>As a PG owner or branch manager, you receive a full-scale administration console designed to maximize yields and simplify tasks.</p>
					<ul class="tab-features-list">
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> Track rooms, vacant beds, and booking reservations</li>
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> Review detailed monthly profit, loss, and expense sheets</li>
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> Track complaints, assign work, and log weekly menu schedules</li>
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> Manage security visitor gates and review staff salaries</li>
					</ul>
				</div>
				<div class="tab-img">
					<div class="matrix-box">
						<span class="matrix-title">Room Allotment System</span>
						<p class="matrix-desc">Filter available rooms instantly by floor, sharing type, or air conditioning features.</p>
					</div>
					<div class="matrix-box" style="border-left-color: var(--accent);">
						<span class="matrix-title">Rent Billing Engine</span>
						<p class="matrix-desc">Auto-compute monthly rents, incorporate utility costs, and push reminders to late tenants.</p>
					</div>
					<div class="matrix-box" style="border-left-color: var(--secondary);">
						<span class="matrix-title">Helpdesk Console</span>
						<p class="matrix-desc">Receive tickets in real-time, view uploaded images, and mark tasks as resolved.</p>
					</div>
				</div>
			</div>

			<!-- Tenant Tab Content -->
			<div class="tab-content" id="tenantTab">
				<div class="tab-text">
					<h4>Resident Comfort & Self-Service</h4>
					<p>Empower your tenants with a private mobile-friendly panel. Minimize manual queries and improve tenant satisfaction rates.</p>
					<ul class="tab-features-list">
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> View invoice details and track paid history records</li>
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> Lodge complaint tickets and check resolution progress</li>
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> Check weekly food menu schedules and daily specials</li>
						<li><i class="fa-solid fa-circle-check" style="color: var(--primary);"></i> Read notice board updates and download payment receipts</li>
					</ul>
				</div>
				<div class="tab-img">
					<div class="matrix-box" style="border-left-color: var(--primary);">
						<span class="matrix-title">Tenant Payment Lobby</span>
						<p class="matrix-desc">Access bills instantly, confirm transaction IDs, and download payment receipts PDF.</p>
					</div>
					<div class="matrix-box" style="border-left-color: var(--accent);">
						<span class="matrix-title">Food Menu Checker</span>
						<p class="matrix-desc">View breakfast, lunch, and dinner plans to arrange food outside if necessary.</p>
					</div>
					<div class="matrix-box" style="border-left-color: var(--secondary);">
						<span class="matrix-title">Resident Ticket Lodge</span>
						<p class="matrix-desc">Write complaint notes, report repair issues, and receive instant status updates.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Feedback Testimonial Carousel Section [NEW] -->
<section class="section-padding feedback-section" id="feedback">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-primary">Client Reviews</div>
			<h3>Loved by Leading PG Owners</h3>
			<p>Read experiences from hostel operators and PG managers who modernized their business with Smart PG.</p>
		</div>

		<div class="feedback-carousel-wrapper">
			<button class="carousel-nav-btn prev" onclick="moveSlide(-1)" aria-label="Previous testimonial"><i class="fa-solid fa-chevron-left"></i></button>
			<button class="carousel-nav-btn next" onclick="moveSlide(1)" aria-label="Next testimonial"><i class="fa-solid fa-chevron-right"></i></button>
			
			<div class="feedback-track" id="carouselTrack">
				<!-- Slide 1 -->
				<div class="feedback-slide">
					<div class="feedback-stars">
						<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
					</div>
					<p class="feedback-quote">
						"Before using Smart PG, I spent hours calling tenants to follow up on late rent. Now, the system sends automated reminders, and payments are verified instantly. My rent leakage dropped to zero!"
					</p>
					<div class="feedback-profile">
						<h5>Ramesh Gowda</h5>
						<span>Owner, Sri Lakshmi Luxury PG (Bangalore)</span>
					</div>
				</div>

				<!-- Slide 2 -->
				<div class="feedback-slide">
					<div class="feedback-stars">
						<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
					</div>
					<p class="feedback-quote">
						"The complaint tracking feature is a lifesaver. My tenants register geyser or WiFi tickets directly. It gets solved in hours, and they don't have to keep calling my personal phone anymore."
					</p>
					<div class="feedback-profile">
						<h5>Adithya Verma</h5>
						<span>Manager, Elite Student Hostels (BTM Layout)</span>
					</div>
				</div>

				<!-- Slide 3 -->
				<div class="feedback-slide">
					<div class="feedback-stars">
						<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
					</div>
					<p class="feedback-quote">
						"Managing three branches used to require a mountain of notebooks. Smart PG consolidated all branches into one dashboard. I can check profit statements from my home easily."
					</p>
					<div class="feedback-profile">
						<h5>Priya Krishnan</h5>
						<span>Director, Royal Comfort PG Chain</span>
					</div>
				</div>
			</div>

			<div class="carousel-dots">
				<button class="carousel-dot active" onclick="gotoSlide(0)" aria-label="Go to testimonial slide 1"></button>
				<button class="carousel-dot" onclick="gotoSlide(1)" aria-label="Go to testimonial slide 2"></button>
				<button class="carousel-dot" onclick="gotoSlide(2)" aria-label="Go to testimonial slide 3"></button>
			</div>
		</div>
	</div>
</section>

<!-- Pricing Section -->
<section class="section-padding pricing-section" id="pricing">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-primary">SaaS Plans</div>
			<h3>Flexible SaaS Pricing Models</h3>
			<p>No high investments. Start with our small tier and scale pricing plans dynamically as your hostel locations expand.</p>
		</div>

		<div class="pricing-toggle">
			<span class="toggle-label active" id="labelMonthly">Billed Monthly</span>
			<div class="toggle-switch" id="billingToggle" onclick="toggleBilling()" aria-label="Toggle billing duration mode">
				<span class="toggle-ball"></span>
			</div>
			<span class="toggle-label" id="labelYearly">Billed Annually <span style="color: var(--primary); font-weight: 800; font-size: 12px;">(Save 20%)</span></span>
		</div>

		<div class="pricing-grid">
			<!-- Basic Plan -->
			<div class="pricing-card">
				<div class="pricing-header">
					<h4>Basic Tier</h4>
					<p>For independent single landlords</p>
				</div>
				<div class="price-display">
					<span class="currency">₹</span>
					<span class="amount" id="basicPrice">499</span>
					<span class="period" id="basicPeriod">/ month</span>
				</div>
				<ul class="pricing-features">
					<li><i class="fa-solid fa-circle-check"></i> Up to 1 PG Branch</li>
					<li><i class="fa-solid fa-circle-check"></i> Max 20 Resident Tenants</li>
					<li><i class="fa-solid fa-circle-check"></i> Room Vacancy Monitoring</li>
					<li><i class="fa-solid fa-circle-check"></i> Manual Rent Reminders</li>
					<li><i class="fa-solid fa-circle-check"></i> Standard Email Support</li>
					<li><i class="fa-solid fa-circle-xmark"></i> Multi-branch SaaS Login</li>
					<li><i class="fa-solid fa-circle-xmark"></i> Excel Revenue Reports</li>
				</ul>
				<a href="<%=ctx%>/registerSaaS.jsp" class="btn btn-secondary">Get Started</a>
			</div>

			<!-- Standard Plan -->
			<div class="pricing-card popular">
				<div class="pricing-ribbon">Most Popular</div>
				<div class="pricing-header">
					<h4>Standard Tier</h4>
					<p>For growing PG business teams</p>
				</div>
				<div class="price-display">
					<span class="currency">₹</span>
					<span class="amount" id="standardPrice">999</span>
					<span class="period" id="standardPeriod">/ month</span>
				</div>
				<ul class="pricing-features">
					<li><i class="fa-solid fa-circle-check"></i> Up to 3 PG Branches</li>
					<li><i class="fa-solid fa-circle-check"></i> Max 100 Resident Tenants</li>
					<li><i class="fa-solid fa-circle-check"></i> Auto Invoice Generates</li>
					<li><i class="fa-solid fa-circle-check"></i> Automated Email Reminders</li>
					<li><i class="fa-solid fa-circle-check"></i> WiFi / Complaint Ticketing</li>
					<li><i class="fa-solid fa-circle-check"></i> Revenue Profit Graphs</li>
					<li><i class="fa-solid fa-circle-xmark"></i> Priority 24/7 Phone Help</li>
				</ul>
				<a href="<%=ctx%>/registerSaaS.jsp" class="btn btn-primary">Start Free Trial</a>
			</div>

			<!-- Premium Plan -->
			<div class="pricing-card">
				<div class="pricing-header">
					<h4>Premium Tier</h4>
					<p>For large multi-city PG networks</p>
				</div>
				<div class="price-display">
					<span class="currency">₹</span>
					<span class="amount" id="premiumPrice">1,499</span>
					<span class="period" id="premiumPeriod">/ month</span>
				</div>
				<ul class="pricing-features">
					<li><i class="fa-solid fa-circle-check"></i> Unlimited PG Branches</li>
					<li><i class="fa-solid fa-circle-check"></i> Unlimited Tenants</li>
					<li><i class="fa-solid fa-circle-check"></i> Full Expense & Salary Ledgers</li>
					<li><i class="fa-solid fa-circle-check"></i> Auto SMS & Email Reminders</li>
					<li><i class="fa-solid fa-circle-check"></i> Security Guard Gate Logs</li>
					<li><i class="fa-solid fa-circle-check"></i> Excel & PDF Download Reports</li>
					<li><i class="fa-solid fa-circle-check"></i> 24/7 Dedicated Account Manager</li>
				</ul>
				<a href="<%=ctx%>/registerSaaS.jsp" class="btn btn-secondary">Contact Sales</a>
			</div>
		</div>
	</div>
</section>

<!-- FAQs Section -->
<section class="section-padding faq-section" id="faq">
	<div class="container">
		<div class="section-header">
			<div class="badge badge-primary">FAQ Portal</div>
			<h3>Frequently Answered Questions</h3>
			<p>Have questions about launching our Smart PG system? Find key answers below.</p>
		</div>

		<div class="faq-container">
			<!-- FAQ 1 -->
			<div class="faq-item">
				<button class="faq-question" type="button">
					Can tenants pay rent online and download receipts?
					<span class="faq-icon"><i class="fa-solid fa-chevron-down"></i></span>
				</button>
				<div class="faq-answer">
					<p>Yes. Tenants can log into their private dashboard, confirm payment details, verify transaction logs, and instantly download a professional billing receipt in PDF format.</p>
				</div>
			</div>

			<!-- FAQ 2 -->
			<div class="faq-item">
				<button class="faq-question" type="button">
					How does the Complaint Ticketing system help owners?
					<span class="faq-icon"><i class="fa-solid fa-chevron-down"></i></span>
				</button>
				<div class="faq-answer">
					<p>Whenever a room maintenance problem emerges (e.g. plumbing or WiFi outages), the tenant registers a ticket online. Admins see the ticket instantly, coordinate resolving it, and update the tenant on progress updates directly via the portal.</p>
				</div>
			</div>

			<!-- FAQ 3 -->
			<div class="faq-item">
				<button class="faq-question" type="button">
					Can I manage multiple PG hostels from one profile?
					<span class="faq-icon"><i class="fa-solid fa-chevron-down"></i></span>
				</button>
				<div class="faq-answer">
					<p>Absolutely. The Standard and Premium tiers support multi-branch features. Under a single account profile, you can map multiple PG locations, run separate accounts for local managers, and monitor consolidated revenue dashboards.</p>
				</div>
			</div>

			<!-- FAQ 4 -->
			<div class="faq-item">
				<button class="faq-question" type="button">
					How secure is tenant and owner database records?
					<span class="faq-icon"><i class="fa-solid fa-chevron-down"></i></span>
				</button>
				<div class="faq-answer">
					<p>We leverage industry-grade security protocols. Role-based login constraints guarantee that data is isolated, ensuring that tenants only access their personal profiles, and branch managers only access their designated branch data.</p>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- Support Panel Callout banner -->
<section class="support-banner">
	<div class="container">
		<div class="support-panel">
			<div class="support-text">
				<h4>Looking for Commercial Setup Support?</h4>
				<p>We help large scale PG hostels set up automated email triggers, configure custom billing profiles, and deploy to personal servers.</p>
			</div>
			<a href="mailto:smartpgmanage@gmail.com" class="btn btn-primary">
				<i class="fa-solid fa-envelope"></i> Contact: smartpgmanage@gmail.com
			</a>
		</div>
	</div>
</section>

<!-- Footer Section -->
<footer class="footer">
	<div class="container footer-grid">
		<div class="footer-col">
			<div class="footer-logo">
				<h4>Smart PG</h4>
				<span>Management Suite</span>
			</div>
			<p class="footer-desc">
				Empowering hostel administrators and resident tenants with a unified operational workspace to simplify payments, bookings, security, and food menus.
			</p>
			<div class="social-links">
				<a href="#" aria-label="Facebook link" class="social-icon"><i class="fa-brands fa-facebook-f"></i></a>
				<a href="#" aria-label="Twitter link" class="social-icon"><i class="fa-brands fa-x-twitter"></i></a>
				<a href="#" aria-label="LinkedIn link" class="social-icon"><i class="fa-brands fa-linkedin-in"></i></a>
				<a href="https://www.instagram.com/_smartpg_?igsh=MXZvNDEwbHpvbG5mMw==" target="_blank" aria-label="Instagram link" class="social-icon"><i class="fa-brands fa-instagram"></i></a>
			</div>
		</div>

		<div class="footer-col">
			<h5>Quick Navigation</h5>
			<ul class="footer-links">
				<li><a href="#why">Why Us</a></li>
				<li><a href="#workflow">Workflow</a></li>
				<li><a href="#features">Key Features</a></li>
				<li><a href="#interface">Software Tour</a></li>
				<li><a href="#calculator">Calculator</a></li>
				<li><a href="#feedback">Feedback</a></li>
			</ul>
		</div>

		<div class="footer-col">
			<h5>Product Features</h5>
			<ul class="footer-links">
				<li><a href="#features">Rent Invoicing</a></li>
				<li><a href="#features">Complaint Tracker</a></li>
				<li><a href="#features">Food Menu Scheduler</a></li>
				<li><a href="#features">Gate Security Logs</a></li>
				<li><a href="#features">Expense Ledgers</a></li>
			</ul>
		</div>

		<div class="footer-col">
			<h5>Contact Support</h5>
			<ul class="footer-contact">
				<li>
					<i class="fa-solid fa-envelope"></i>
					<span>smartpgmanage@gmail.com</span>
				</li>
				<li>
					<i class="fa-solid fa-location-dot"></i>
					<span>BTM Stage 1, Bangalore, India</span>
				</li>
				<li>
					<i class="fa-solid fa-calendar-day"></i>
					<span>Support Hours: Mon - Sat (9am - 6pm)</span>
				</li>
			</ul>
		</div>
	</div>

	<div class="container footer-bottom">
		<p class="footer-copy">
			Smart PG Management System © 2026. All rights reserved. Designed for elite paying guest accommodations.
		</p>
		<div class="footer-bottom-links">
			<a href="#">Privacy Policy</a>
			<a href="#">Terms of Use</a>
			<a href="#">SLA Agreement</a>
		</div>
	</div>
</footer>

<script>
	// Sticky Header Shadow Control
	const header = document.getElementById('header');
	window.addEventListener('scroll', () => {
		if (window.scrollY > 20) {
			header.classList.add('scrolled');
		} else {
			header.classList.remove('scrolled');
		}
	});

	// Mobile Navigation Menu Drawer toggle
	const menuBtn = document.getElementById('menuBtn');
	const mobileDrawer = document.getElementById('mobileDrawer');

	menuBtn.addEventListener('click', (e) => {
		e.stopPropagation();
		mobileDrawer.classList.toggle('active');
		const icon = menuBtn.querySelector('i');
		if (mobileDrawer.classList.contains('active')) {
			icon.className = 'fa-solid fa-xmark';
		} else {
			icon.className = 'fa-solid fa-bars';
		}
	});

	// Helper to auto-close menu when a link is clicked
	function toggleMenu() {
		mobileDrawer.classList.remove('active');
		menuBtn.querySelector('i').className = 'fa-solid fa-bars';
	}

	// Close menu upon outside clicks
	document.addEventListener('click', (e) => {
		if (!menuBtn.contains(e.target) && !mobileDrawer.contains(e.target)) {
			mobileDrawer.classList.remove('active');
			menuBtn.querySelector('i').className = 'fa-solid fa-bars';
		}
	});

	// Close menu upon window resize
	window.addEventListener('resize', () => {
		if (window.innerWidth > 768) {
			mobileDrawer.classList.remove('active');
			menuBtn.querySelector('i').className = 'fa-solid fa-bars';
		}
	});

	// Tabs Switcher (Admin vs Tenant Matrix)
	function switchTab(tabId, btnElement) {
		const contents = document.querySelectorAll('.tab-content');
		contents.forEach(content => content.classList.remove('active'));
		
		const buttons = document.querySelectorAll('.tab-btn');
		buttons.forEach(btn => btn.classList.remove('active'));
		
		document.getElementById(tabId).classList.add('active');
		btnElement.classList.add('active');
	}

	// Interactive Pricing Toggle Monthly/Yearly
	function toggleBilling() {
		const switchElem = document.getElementById('billingToggle');
		switchElem.classList.toggle('yearly');
		
		const isYearly = switchElem.classList.contains('yearly');
		
		const labelMonthly = document.getElementById('labelMonthly');
		const labelYearly = document.getElementById('labelYearly');
		
		if (isYearly) {
			labelMonthly.classList.remove('active');
			labelYearly.classList.add('active');
			
			// Set Annually prices (20% off)
			animatePrice('basicPrice', 399);
			document.getElementById('basicPeriod').innerText = '/ month (billed annually)';
			
			animatePrice('standardPrice', 799);
			document.getElementById('standardPeriod').innerText = '/ month (billed annually)';
			
			animatePrice('premiumPrice', 1199);
			document.getElementById('premiumPeriod').innerText = '/ month (billed annually)';
		} else {
			labelMonthly.classList.add('active');
			labelYearly.classList.remove('active');
			
			// Set Monthly prices
			animatePrice('basicPrice', 499);
			document.getElementById('basicPeriod').innerText = '/ month';
			
			animatePrice('standardPrice', 999);
			document.getElementById('standardPeriod').innerText = '/ month';
			
			animatePrice('premiumPrice', 1499);
			document.getElementById('premiumPeriod').innerText = '/ month';
		}
	}

	// Micro-animation for price transitions
	function animatePrice(elementId, endValue) {
		const element = document.getElementById(elementId);
		let startValue = parseInt(element.innerText.replace(/,/g, ''));
		let duration = 250;
		let startTime = null;

		function step(currentTime) {
			if (!startTime) startTime = currentTime;
			const progress = Math.min((currentTime - startTime) / duration, 1);
			const currentValue = Math.floor(progress * (endValue - startValue) + startValue);
			element.innerText = currentValue.toLocaleString('en-IN');
			if (progress < 1) {
				window.requestAnimationFrame(step);
			}
		}
		window.requestAnimationFrame(step);
	}

	// FAQs Accordion collapsible logic
	const faqQuestions = document.querySelectorAll('.faq-question');
	faqQuestions.forEach(question => {
		question.addEventListener('click', () => {
			const faqItem = question.parentElement;
			const isActive = faqItem.classList.contains('active');
			
			document.querySelectorAll('.faq-item').forEach(item => {
				item.classList.remove('active');
			});
			
			if (!isActive) {
				faqItem.classList.add('active');
			}
		});
	});

	// Interactive Savings Calculator logic [NEW]
	function calculateSavings() {
		const beds = parseInt(document.getElementById('bedsSlider').value);
		const rent = parseInt(document.getElementById('rentSlider').value);
		
		document.getElementById('bedsVal').innerText = beds + " Beds";
		document.getElementById('rentVal').innerText = "₹" + rent.toLocaleString('en-IN');
		
		const expectedRevenue = beds * rent;
		const leakageLoss = Math.round(expectedRevenue * 0.08); // 8% leakage
		const recoverySavings = leakageLoss;
		
		document.getElementById('revenueOutput').innerText = "₹" + expectedRevenue.toLocaleString('en-IN');
		document.getElementById('leakageOutput').innerText = "₹" + leakageLoss.toLocaleString('en-IN');
		document.getElementById('savingsOutput').innerText = "₹" + recoverySavings.toLocaleString('en-IN');
	}
	
	// Initialize Savings Calculator on load
	calculateSavings();

	// Testimonials Carousel Logic [NEW]
	let currentSlide = 0;
	const slides = document.querySelectorAll('.feedback-slide');
	const dots = document.querySelectorAll('.carousel-dot');
	const totalSlides = slides.length;

	function moveSlide(step) {
		currentSlide = (currentSlide + step + totalSlides) % totalSlides;
		updateCarousel();
	}

	function gotoSlide(slideIndex) {
		currentSlide = slideIndex;
		updateCarousel();
	}

	function updateCarousel() {
		const track = document.getElementById('carouselTrack');
		track.style.transform = `translateX(-${currentSlide * 100}%)`;
		
		// Update dots
		dots.forEach((dot, index) => {
			if (index === currentSlide) {
				dot.classList.add('active');
			} else {
				dot.classList.remove('active');
			}
		});
	}
</script>

</body>
</html>