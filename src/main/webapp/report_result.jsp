<%@ page import="java.util.List, com.model.FeePayment" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Results | AIET</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.bootstrap5.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --warning-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            
            --bg-primary: #0f0f23;
            --bg-secondary: #1a1a2e;
            --bg-card: rgba(255, 255, 255, 0.05);
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.7);
            --border-color: rgba(255, 255, 255, 0.1);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            --shadow-hover: 0 16px 48px rgba(0, 0, 0, 0.4);
            --input-bg: rgba(255, 255, 255, 0.05);
            --input-border: rgba(255, 255, 255, 0.1);
            --input-focus: rgba(102, 126, 234, 0.3);
        }

        .light-mode {
            --bg-primary: #f8fafc;
            --bg-secondary: #ffffff;
            --bg-card: rgba(255, 255, 255, 0.9);
            --text-primary: #1a202c;
            --text-secondary: #718096;
            --border-color: rgba(0, 0, 0, 0.1);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 16px 48px rgba(0, 0, 0, 0.15);
            --input-bg: rgba(255, 255, 255, 0.8);
            --input-border: rgba(0, 0, 0, 0.1);
            --input-focus: rgba(102, 126, 234, 0.2);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            min-height: 100vh;
            transition: all 0.3s ease;
            position: relative;
        }

        .background-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2;
            opacity: 0.1;
            background-image: 
                radial-gradient(circle at 25% 25%, #667eea 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, #764ba2 0%, transparent 50%);
            animation: backgroundShift 20s ease-in-out infinite;
        }

        .floating-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }

        .shape {
            position: absolute;
            border-radius: 50%;
            background: var(--primary-gradient);
            opacity: 0.1;
            animation: float 15s infinite ease-in-out;
        }

        .shape:nth-child(1) {
            width: 100px;
            height: 100px;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 150px;
            height: 150px;
            top: 60%;
            right: 10%;
            animation-delay: -5s;
        }

        .shape:nth-child(3) {
            width: 80px;
            height: 80px;
            bottom: 20%;
            left: 20%;
            animation-delay: -10s;
        }

        @keyframes backgroundShift {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(-20px, -20px) rotate(120deg); }
            66% { transform: translate(20px, -20px) rotate(240deg); }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-30px) rotate(120deg); }
            66% { transform: translateY(30px) rotate(240deg); }
        }

        .theme-toggle {
            position: fixed;
            top: 2rem;
            right: 2rem;
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 50%;
            cursor: pointer;
            font-size: 1.2rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow);
            z-index: 1000;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .theme-toggle:hover {
            transform: translateY(-4px) scale(1.1);
            box-shadow: var(--shadow-hover);
        }

        .sidebar {
            width: 280px;
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            position: fixed;
            height: 100vh;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            z-index: 999;
            overflow-y: auto;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            padding: 2rem 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            text-decoration: none;
            font-size: 1.25rem;
            border-bottom: 1px solid var(--border-color);
        }

        .sidebar-brand i {
            font-size: 1.8rem;
            margin-right: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav {
            padding: 1.5rem 1rem;
            list-style: none;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 1rem 1.25rem;
            border-radius: 16px;
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
            border-radius: 16px;
        }

        .nav-link i {
            margin-right: 1rem;
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
            position: relative;
            z-index: 1;
        }

        .nav-link span {
            position: relative;
            z-index: 1;
        }

        .nav-link:hover {
            color: var(--text-primary);
            transform: translateX(4px);
        }

        .nav-link:hover::before {
            opacity: 0.1;
        }

        .nav-link.active {
            background: var(--primary-gradient);
            color: white;
            font-weight: 600;
            box-shadow: 0 4px 16px rgba(102, 126, 234, 0.3);
        }

        .nav-link.active::before {
            opacity: 1;
        }

        .main-content {
            margin-left: 280px;
            padding: 2rem;
            min-height: 100vh;
            animation: slideInRight 0.6s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
            padding: 2rem;
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: var(--shadow);
            animation: fadeInDown 0.8s ease-out;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .page-title i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-description {
            color: var(--text-secondary);
            font-size: 1rem;
            margin: 0;
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: 0 4px 16px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
        }

        .btn-outline-primary {
            background: transparent;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn-outline-primary:hover {
            background: var(--primary-gradient);
            color: white;
            transform: translateY(-2px);
        }

        .btn-outline-secondary {
            background: transparent;
            color: var(--text-secondary);
            border: 2px solid var(--border-color);
        }

        .btn-outline-secondary:hover {
            background: var(--input-bg);
            color: var(--text-primary);
            transform: translateY(-2px);
        }

        .card {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: var(--shadow);
            margin-bottom: 2rem;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .card-body {
            padding: 3rem;
        }

        .report-summary {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 3rem;
            margin-bottom: 3rem;
            border-left: 6px solid transparent;
            border-image: var(--primary-gradient) 1;
            box-shadow: var(--shadow);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .report-summary::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: var(--primary-gradient);
        }

        .total-amount {
            font-size: 3rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 1.5rem 0;
        }

        .report-period {
            color: var(--text-secondary);
            font-size: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .summary-card {
            background: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .summary-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow);
        }

        .summary-card h6 {
            color: var(--text-secondary);
            font-size: 0.9rem;
            margin-bottom: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }

        .summary-card h4 {
            color: var(--text-primary);
            font-size: 1.8rem;
            font-weight: 700;
        }

        .table-container {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

        .table {
            margin: 0;
            background: transparent;
            color: var(--text-primary);
        }

        .table thead th {
            background: var(--input-bg);
            border: none;
            color: var(--text-primary);
            font-weight: 600;
            padding: 1.5rem 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }

        .table tbody td {
            border-color: var(--border-color);
            padding: 1.25rem 1rem;
            color: var(--text-primary);
            vertical-align: middle;
        }

        .table tbody tr:hover {
            background: var(--input-bg);
        }

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .badge-paid {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .badge-unpaid {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .badge-overdue {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
        }

        .btn-sm {
            padding: 0.5rem 0.75rem;
            font-size: 0.8rem;
            border-radius: 8px;
        }

        .btn-outline-primary.btn-sm {
            color: #667eea;
            border-color: #667eea;
        }

        .btn-outline-danger.btn-sm {
            color: #fa709a;
            border-color: #fa709a;
        }

        .btn-outline-primary.btn-sm:hover {
            background: #667eea;
            color: white;
        }

        .btn-outline-danger.btn-sm:hover {
            background: #fa709a;
            color: white;
        }

        .alert {
            background: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 2rem;
            color: var(--text-primary);
            margin: 2rem 0;
        }

        .alert-info {
            border-left: 4px solid #4facfe;
        }

        .report-footer {
            margin-top: 3rem;
            padding: 2rem;
            background: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            text-align: center;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        /* DataTables Styling */
        .dataTables_wrapper {
            color: var(--text-primary);
        }

        .dataTables_length select,
        .dataTables_filter input {
            background: var(--input-bg);
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            border-radius: 8px;
            padding: 0.5rem;
        }

        .dataTables_info,
        .dataTables_length label,
        .dataTables_filter label {
            color: var(--text-secondary);
        }

        .paginate_button {
            background: var(--input-bg) !important;
            border: 1px solid var(--border-color) !important;
            color: var(--text-primary) !important;
            border-radius: 8px !important;
            margin: 0 2px !important;
        }

        .paginate_button:hover {
            background: var(--primary-gradient) !important;
            color: white !important;
        }

        .paginate_button.current {
            background: var(--primary-gradient) !important;
            color: white !important;
        }

        .dt-buttons .btn {
            margin: 0 0.25rem !important;
            border-radius: 8px !important;
        }

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(60px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 1200px) {
            .sidebar {
                width: 80px;
                overflow: hidden;
            }
            
            .sidebar-brand span, 
            .nav-link span {
                display: none;
            }
            
            .main-content {
                margin-left: 80px;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                width: 280px;
            }
            
            .sidebar.active {
                transform: translateX(0);
            }
            
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
                padding: 1.5rem;
            }
            
            .btn-group {
                width: 100%;
                justify-content: flex-end;
            }
            
            .theme-toggle {
                top: 1rem;
                right: 1rem;
                width: 50px;
                height: 50px;
            }
            
            .card-body {
                padding: 1.5rem;
            }
            
            .total-amount {
                font-size: 2rem;
            }
        }

        .mobile-menu-toggle {
            display: none;
            position: fixed;
            top: 2rem;
            left: 2rem;
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 50%;
            cursor: pointer;
            font-size: 1.2rem;
            z-index: 1001;
            width: 60px;
            height: 60px;
            align-items: center;
            justify-content: center;
        }

        @media (max-width: 768px) {
            .mobile-menu-toggle {
                display: flex;
            }
        }
    </style>
</head>
<body>
    <div class="background-pattern"></div>
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>
    
    <button class="theme-toggle" onclick="toggleTheme()" title="Toggle Theme">
        <i class="fas fa-moon"></i>
    </button>

    <button class="mobile-menu-toggle" onclick="toggleSidebar()" title="Toggle Menu">
        <i class="fas fa-bars"></i>
    </button>

    <div class="sidebar" id="sidebar">
        <a href="index.jsp" class="sidebar-brand">
            <i class="fas fa-university"></i>
            <span>College Fees</span>
        </a>
        <ul class="nav">
            <li class="nav-item">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="feepaymentadd.jsp">
                    <i class="fas fa-plus-circle"></i>
                    <span>Add Payment</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="feepaymentupdate.jsp">
                    <i class="fas fa-edit"></i>
                    <span>Update Payment</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="feepaymentdelete.jsp">
                    <i class="fas fa-trash-alt"></i>
                    <span>Delete Payment</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="displayPayments">
                    <i class="fas fa-list"></i>
                    <span>View Payments</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="reports.jsp">
                    <i class="fas fa-chart-bar"></i>
                    <span>Reports</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="main-content">
        <div class="page-header">
            <div>
                <h1 class="page-title">
                    <i class="fas fa-file-alt"></i> Report Results
                </h1>
                <p class="page-description"><%= request.getAttribute("reportTitle") %></p>
            </div>
            <div class="btn-group">
                <button class="btn btn-outline-secondary" onclick="window.print()">
                    <i class="fas fa-print"></i> Print
                </button>
                <a href="reports.jsp" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
                <button class="btn btn-primary" id="exportPdf">
                    <i class="fas fa-file-pdf"></i> PDF
                </button>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <% if ("collections".equals(request.getAttribute("reportType"))) { %>
                    <div class="report-summary">
                        <h4>Total Collections Summary</h4>
                        <div class="total-amount">
                            ₹<%= String.format("%.2f", request.getAttribute("totalCollections")) %>
                        </div>
                        <p class="report-period">
                            <i class="fas fa-calendar-alt"></i> 
                            <%= request.getAttribute("startDate") %> to <%= request.getAttribute("endDate") %>
                        </p>
                        <div class="summary-grid">
                            <div class="summary-card">
                                <h6>Total Payments</h6>
                                <h4><%= request.getAttribute("totalPayments") %></h4>
                            </div>
                            <div class="summary-card">
                                <h6>Paid Students</h6>
                                <h4><%= request.getAttribute("paidStudents") %></h4>
                            </div>
                            <div class="summary-card">
                                <h6>Average Payment</h6>
                                <h4>₹<%= String.format("%.2f", request.getAttribute("averagePayment")) %></h4>
                            </div>
                        </div>
                    </div>
                <% } else { 
                    List<FeePayment> reportData = (List<FeePayment>) request.getAttribute("reportData");
                    if (reportData != null && !reportData.isEmpty()) { 
                %>
                    <div class="table-container">
                        <div style="padding: 1.5rem;">
                            <table id="reportTable" class="table table-striped table-hover" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>Payment ID</th>
                                        <th>Student ID</th>
                                        <th>Student Name</th>
                                        <th>Payment Date</th>
                                        <th>Amount</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (FeePayment payment : reportData) { 
                                        String badgeClass = "";
                                        if ("Paid".equals(payment.getStatus())) {
                                            badgeClass = "badge-paid";
                                        } else if ("Unpaid".equals(payment.getStatus())) {
                                            badgeClass = "badge-unpaid";
                                        } else if ("Overdue".equals(payment.getStatus())) {
                                            badgeClass = "badge-overdue";
                                        }
                                    %>
                                        <tr>
                                            <td><%= payment.getPaymentId() %></td>
                                            <td><%= payment.getStudentId() %></td>
                                            <td><%= payment.getStudentName() %></td>
                                            <td><%= payment.getPaymentDate() %></td>
                                            <td>₹<%= String.format("%.2f", payment.getAmount()) %></td>
                                            <td><span class="badge <%= badgeClass %>"><%= payment.getStatus() %></span></td>
                                            <td>
                                                <div class="btn-group btn-group-sm">
                                                    <a href="feepaymentupdate.jsp?id=<%= payment.getPaymentId() %>" class="btn btn-sm btn-outline-primary" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="feepaymentdelete.jsp?id=<%= payment.getPaymentId() %>" class="btn btn-sm btn-outline-danger" title="Delete">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                <% } else { %>
                    <div class="alert alert-info text-center">
                        <i class="fas fa-info-circle"></i> No records found matching your criteria.
                    </div>
                <% } 
                   } %>
                
                <div class="mt-4 text-muted text-center">
                    <small>
                        <i class="fas fa-clock"></i> Report generated on: <%= new java.util.Date() %> | 
                        <i class="fas fa-user"></i> Generated by: <%= request.getRemoteUser() != null ? request.getRemoteUser() : "System" %>
                    </small>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.bootstrap5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <script>
        $(document).ready(function() {
            var table = $('#reportTable').DataTable({
                responsive: true,
                dom: '<"top"Bf>rt<"bottom"lip><"clear">',
                buttons: [
                    {
                        extend: 'copy',
                        className: 'btn btn-sm btn-outline-secondary',
                        text: '<i class="fas fa-copy"></i> Copy'
                    },
                    {
                        extend: 'excel',
                        className: 'btn btn-sm btn-outline-success',
                        text: '<i class="fas fa-file-excel"></i> Excel',
                        title: '<%= request.getAttribute("reportTitle") %>',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'csv',
                        className: 'btn btn-sm btn-outline-primary',
                        text: '<i class="fas fa-file-csv"></i> CSV',
                        title: '<%= request.getAttribute("reportTitle") %>',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    },
                    {
                        extend: 'pdf',
                        className: 'btn btn-sm btn-outline-danger',
                        text: '<i class="fas fa-file-pdf"></i> PDF',
                        title: '<%= request.getAttribute("reportTitle") %>',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        },
                        customize: function(doc) {
                            doc.content[1].table.widths = 
                                Array(doc.content[1].table.body[0].length + 1).join('*').split('');
                            doc.styles.tableHeader.alignment = 'center';
                        }
                    },
                    {
                        extend: 'print',
                        className: 'btn btn-sm btn-outline-info',
                        text: '<i class="fas fa-print"></i> Print',
                        title: '<%= request.getAttribute("reportTitle") %>',
                        exportOptions: {
                            columns: ':not(:last-child)'
                        }
                    }
                ],
                order: [[0, 'desc']],
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search records...",
                    lengthMenu: "Show _MENU_ entries",
                    info: "Showing _START_ to _END_ of _TOTAL_ entries",
                    infoEmpty: "Showing 0 to 0 of 0 entries",
                    infoFiltered: "(filtered from _MAX_ total entries)",
                    paginate: {
                        first: "First",
                        last: "Last",
                        next: "Next",
                        previous: "Previous"
                    }
                };

                }
            });
            
            // Custom PDF export button
            $('#exportPdf').click(function() {
                table.button('.buttons-pdf').trigger();
            });
        });
    </script>
</body>
</html>