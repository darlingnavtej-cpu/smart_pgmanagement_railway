<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%
    Boolean loggedIn = (Boolean) session.getAttribute("superAdminLoggedIn");
    boolean isAuthenticated = (loggedIn != null && loggedIn);

    List<Map<String, String>> pgList = (List<Map<String, String>>) request.getAttribute("pgList");
    String errorMessage = (String) request.getAttribute("errorMessage");

    // Compute stats
    int totalPgs = 0;
    int activePgs = 0;
    int suspendedPgs = 0;

    if (pgList != null) {
        totalPgs = pgList.size();
        for (Map<String, String> pg : pgList) {
            if ("active".equalsIgnoreCase(pg.get("status"))) {
                activePgs++;
            } else {
                suspendedPgs++;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png" href="<%=request.getContextPath()%>/images/favicon.png">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Smart PG - Super Admin Console</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
    <style>
        :root {
            --bg: #0f172a;
            --surface: #1e293b;
            --surface-hover: #334155;
            --border: #475569;
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            --radius: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Inter, system-ui, sans-serif;
        }

        body {
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* --- LOGIN STYLES --- */
        .login-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: var(--shadow);
            text-align: center;
            animation: fadeIn 0.5s ease-out;
        }

        .login-card h1 {
            font-size: 26px;
            font-weight: 800;
            margin-bottom: 8px;
            background: linear-gradient(135deg, #a5b4fc, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .login-card p {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 25px;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-weight: 600;
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 8px;
        }

        .input-group input {
            width: 100%;
            background: var(--bg);
            border: 1px solid var(--border);
            padding: 12px 15px;
            border-radius: 10px;
            color: var(--text);
            font-size: 15px;
            outline: none;
            transition: 0.3s;
        }

        .input-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            background: var(--primary-hover);
        }

        /* --- DASHBOARD STYLES --- */
        header {
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            padding: 20px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .brand-sec h1 {
            font-size: 22px;
            font-weight: 800;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .brand-sec h1 i {
            color: var(--primary);
        }

        .brand-sec span {
            font-size: 12px;
            color: var(--text-muted);
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logout-link {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: 0.2s;
        }

        .logout-link:hover {
            color: var(--danger);
        }

        .dashboard-container {
            flex: 1;
            padding: 40px;
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .stat-info h3 {
            font-size: 13px;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
        }

        .stat-info p {
            font-size: 32px;
            font-weight: 800;
        }

        .stat-icon-wrapper {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
        }

        .bg-indigo { background: linear-gradient(135deg, #6366f1, #4f46e5); }
        .bg-emerald { background: linear-gradient(135deg, #10b981, #059669); }
        .bg-amber { background: linear-gradient(135deg, #f59e0b, #d97706); }

        /* Error/Alert Banners */
        .alert {
            background: rgba(239, 68, 68, 0.15);
            border: 1px solid var(--danger);
            color: #fca5a5;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 14px;
        }

        /* Registry Table */
        .panel {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .panel-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
        }

        .panel-header h2 {
            font-size: 18px;
            font-weight: 700;
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th {
            background: rgba(0,0,0,0.1);
            color: var(--text-muted);
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 15px 24px;
            border-bottom: 1px solid var(--border);
        }

        td {
            padding: 18px 24px;
            border-bottom: 1px solid rgba(71, 85, 105, 0.5);
            font-size: 14px;
            vertical-align: middle;
        }

        tr:last-child td {
            border-bottom: none;
        }

        /* Badges */
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .badge-active { background: rgba(16, 185, 129, 0.15); color: #34d399; border: 1px solid rgba(16, 185, 129, 0.3); }
        .badge-suspended { background: rgba(245, 158, 11, 0.15); color: #fbbf24; border: 1px solid rgba(245, 158, 11, 0.3); }
        .badge-offline { background: rgba(239, 68, 68, 0.15); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); }

        /* Action Buttons */
        .action-cell {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .act-btn {
            padding: 8px 12px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            transition: 0.2s;
        }

        .btn-access { background: rgba(99, 102, 241, 0.15); color: #a5b4fc; border: 1px solid rgba(99, 102, 241, 0.3); }
        .btn-access:hover { background: var(--primary); color: white; }

        .btn-suspend { background: rgba(245, 158, 11, 0.15); color: #fcd34d; border: 1px solid rgba(245, 158, 11, 0.3); }
        .btn-suspend:hover { background: var(--warning); color: black; }

        .btn-activate { background: rgba(16, 185, 129, 0.15); color: #6ee7b7; border: 1px solid rgba(16, 185, 129, 0.3); }
        .btn-activate:hover { background: var(--success); color: white; }

        .btn-delete { background: rgba(239, 68, 68, 0.15); color: #fca5a5; border: 1px solid rgba(239, 68, 68, 0.3); }
        .btn-delete:hover { background: var(--danger); color: white; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 768px) {
            header {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }
            .dashboard-container {
                padding: 20px;
            }
            td, th {
                padding: 12px 15px;
            }
        }
    </style>
</head>
<body>

<% if (!isAuthenticated) { %>
    <!-- LOGIN VIEW -->
    <div class="login-container">
        <div class="login-card">
            <h1>Super Admin Console</h1>
            <p>Smart PG SaaS Management Portal</p>

            <% if (errorMessage != null) { %>
                <div class="alert">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span><%= errorMessage %></span>
                </div>
            <% } %>

            <form action="super-admin?action=login" method="post">
                <div class="input-group">
                    <label for="password">Enter Master Passcode</label>
                    <input type="password" id="password" name="password" placeholder="••••••••" required autofocus>
                </div>
                <button type="submit" class="btn">Authenticate</button>
            </form>
        </div>
    </div>
<% } else { %>
    <!-- DASHBOARD VIEW -->
    <header>
        <div class="brand-sec">
            <h1><i class="fa-solid fa-screwdriver-wrench"></i> Super Admin Console</h1>
            <span>SaaS Registry & Database Manager</span>
        </div>
        <div class="header-actions">
            <a href="super-admin?action=logout" class="logout-link">
                <i class="fa-solid fa-right-from-bracket"></i> Logout
            </a>
        </div>
    </header>

    <div class="dashboard-container">
        <!-- Error Alerts -->
        <% if (errorMessage != null) { %>
            <div class="alert">
                <i class="fa-solid fa-circle-exclamation"></i>
                <span><%= errorMessage %></span>
            </div>
        <% } %>

        <!-- Stats grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Total Registered PGs</h3>
                    <p><%= totalPgs %></p>
                </div>
                <div class="stat-icon-wrapper bg-indigo">
                    <i class="fa-solid fa-building"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Active PGs</h3>
                    <p><%= activePgs %></p>
                </div>
                <div class="stat-icon-wrapper bg-emerald">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Suspended PGs</h3>
                    <p><%= suspendedPgs %></p>
                </div>
                <div class="stat-icon-wrapper bg-amber">
                    <i class="fa-solid fa-ban"></i>
                </div>
            </div>
        </div>

        <!-- Registry Panel -->
        <div class="panel">
            <div class="panel-header">
                <h2>Tenant Schema & Routing Registries</h2>
            </div>
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>PG Code (Subdomain)</th>
                            <th>PG Name</th>
                            <th>Owner Name</th>
                            <th>Admin Email</th>
                            <th>Database Name</th>
                            <th>Status</th>
                            <th style="text-align: center;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (pgList == null || pgList.isEmpty()) { %>
                            <tr>
                                <td colspan="7" style="text-align: center; color: var(--text-muted);">No tenants registered in the SaaS registry.</td>
                            </tr>
                        <% } else {
                            for (Map<String, String> pg : pgList) {
                                String sub = pg.get("subdomain");
                                String name = pg.get("pgName");
                                String owner = pg.get("ownerName");
                                String email = pg.get("email");
                                String db = pg.get("dbName");
                                String status = pg.get("status");
                                boolean online = Boolean.parseBoolean(pg.get("dbOnline"));
                        %>
                            <tr>
                                <td style="font-weight: 700; color: var(--primary);"><%= sub %></td>
                                <td><%= name %></td>
                                <td><%= owner %></td>
                                <td><%= email %></td>
                                <td style="font-family: monospace; color: var(--text-muted);"><%= db %></td>
                                <td>
                                    <% if (!online) { %>
                                        <span class="badge badge-offline"><i class="fa-solid fa-triangle-exclamation"></i> Offline</span>
                                    <% } else if ("active".equalsIgnoreCase(status)) { %>
                                        <span class="badge badge-active"><i class="fa-solid fa-circle-play"></i> Active</span>
                                    <% } else { %>
                                        <span class="badge badge-suspended"><i class="fa-solid fa-circle-pause"></i> Suspended</span>
                                    <% } %>
                                </td>
                                <td style="text-align: center;">
                                    <div class="action-cell">
                                        <!-- Bypass Access -->
                                        <a href="super-admin?action=impersonate&subdomain=<%= sub %>" target="_blank" class="act-btn btn-access">
                                            <i class="fa-solid fa-user-secret"></i> Impersonate
                                        </a>

                                        <!-- Toggle Status -->
                                        <% if ("active".equalsIgnoreCase(status)) { %>
                                            <a href="super-admin?action=toggle&subdomain=<%= sub %>" class="act-btn btn-suspend">
                                                <i class="fa-solid fa-ban"></i> Suspend
                                            </a>
                                        <% } else { %>
                                            <a href="super-admin?action=toggle&subdomain=<%= sub %>" class="act-btn btn-activate">
                                                <i class="fa-solid fa-check"></i> Activate
                                            </a>
                                        <% } %>

                                        <!-- Delete Schema (Restricted for default admin) -->
                                        <% if (!"admin".equalsIgnoreCase(sub)) { %>
                                            <a href="super-admin?action=delete&subdomain=<%= sub %>" 
                                               onclick="return confirm('WARNING: This will drop the database \'<%= db %>\' and delete all records for PG \'<%= name %>\'. This action CANNOT be undone!\n\nAre you sure you want to proceed?');" 
                                               class="act-btn btn-delete">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </a>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                        <% 
                            }
                        } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<% } %>

</body>
</html>
