<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.model.FeePayment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Fee Payments | AIET</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            overflow-x: auto;
            position: relative;
            padding: 2rem;
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

        .container {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 32px;
            padding: 3rem;
            max-width: 1400px;
            margin: 0 auto;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 6rem;
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
            border-radius: 32px 32px 0 0;
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeInDown 0.8s ease-out 0.2s both;
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .header h1 i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
            animation: fadeInUp 0.8s ease-out 0.3s both;
        }

        .stat-card {
            background: var(--input-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 1.5rem;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow);
        }

        .stat-card .icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            opacity: 0.8;
        }

        .stat-card .number {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stat-card .label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .table-container {
            background: var(--input-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: var(--shadow);
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: var(--primary-gradient);
        }

        thead th {
            color: white;
            padding: 1.5rem 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        tbody tr {
            border-bottom: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: rgba(102, 126, 234, 0.1);
            transform: scale(1.01);
        }

        tbody tr:last-child {
            border-bottom: none;
        }

        tbody td {
            padding: 1.25rem 1rem;
            color: var(--text-primary);
            font-weight: 500;
        }

        .amount {
            font-family: 'Courier New', monospace;
            font-weight: 700;
            font-size: 1.1rem;
            color: #4bb543;
        }

        .status {
            padding: 0.5rem 1rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .status-paid {
            background: linear-gradient(135deg, rgba(75, 181, 67, 0.2), rgba(56, 249, 215, 0.2));
            color: #4bb543;
            border: 1px solid rgba(75, 181, 67, 0.3);
        }

        .status-paid::before {
            content: '✅';
        }

        .status-unpaid {
            background: linear-gradient(135deg, rgba(255, 193, 7, 0.2), rgba(255, 235, 59, 0.2));
            color: #ffc107;
            border: 1px solid rgba(255, 193, 7, 0.3);
        }

        .status-unpaid::before {
            content: '⏳';
        }

        .status-overdue {
            background: linear-gradient(135deg, rgba(250, 112, 154, 0.2), rgba(254, 225, 64, 0.2));
            color: #fa709a;
            border: 1px solid rgba(250, 112, 154, 0.3);
        }

        .status-overdue::before {
            content: '⚠️';
        }

        .no-data {
            text-align: center;
            color: var(--text-secondary);
            font-style: italic;
            padding: 3rem !important;
            font-size: 1.1rem;
        }

        .back-link {
            position: fixed;
            bottom: 2rem;
            left: 2rem;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            padding: 1rem 1.5rem;
            border: 2px solid var(--border-color);
            border-radius: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: var(--input-bg);
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow);
        }

        .back-link:hover {
            color: var(--text-primary);
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(60px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
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

        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .container {
                padding: 2rem;
                margin-top: 4rem;
                border-radius: 24px;
            }

            .header h1 {
                font-size: 2rem;
                flex-direction: column;
                gap: 0.5rem;
            }

            .theme-toggle {
                top: 1rem;
                right: 1rem;
                width: 50px;
                height: 50px;
            }

            .stats-container {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.9rem;
            }

            thead th,
            tbody td {
                padding: 1rem 0.5rem;
            }

            .back-link {
                position: relative;
                bottom: auto;
                left: auto;
                margin: 2rem auto 0;
                display: flex;
                justify-content: center;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 600px;
            }
        }

        /* Loading animation */
        .loading {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 3rem;
        }

        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid var(--border-color);
            border-top: 4px solid #667eea;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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

    <div class="container">
        <div class="header">
            <h1><i class="fas fa-receipt"></i>Fee Payment Records</h1>
        </div>

        <%
        List<FeePayment> payments = (List<FeePayment>) request.getAttribute("payments");
        int totalPayments = 0;
        int paidCount = 0;
        int unpaidCount = 0;
        int overdueCount = 0;
        double totalAmount = 0.0;
        
        if (payments != null && !payments.isEmpty()) {
            totalPayments = payments.size();
            for (FeePayment payment : payments) {
                totalAmount += payment.getAmount();
                String status = payment.getStatus();
                if ("Paid".equalsIgnoreCase(status)) paidCount++;
                else if ("Unpaid".equalsIgnoreCase(status)) unpaidCount++;
                else if ("Overdue".equalsIgnoreCase(status)) overdueCount++;
            }
        }
        %>

        <div class="stats-container">
            <div class="stat-card">
                <div class="icon">📊</div>
                <div class="number"><%= totalPayments %></div>
                <div class="label">Total Records</div>
            </div>
            <div class="stat-card">
                <div class="icon">✅</div>
                <div class="number"><%= paidCount %></div>
                <div class="label">Paid</div>
            </div>
            <div class="stat-card">
                <div class="icon">⏳</div>
                <div class="number"><%= unpaidCount %></div>
                <div class="label">Unpaid</div>
            </div>
            <div class="stat-card">
                <div class="icon">⚠️</div>
                <div class="number"><%= overdueCount %></div>
                <div class="label">Overdue</div>
            </div>
            <div class="stat-card">
                <div class="icon">💰</div>
                <div class="number">₹<%= String.format("%.2f", totalAmount) %></div>
                <div class="label">Total Amount</div>
            </div>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Payment Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="payments-tbody">
                    <%
                    if (payments != null && !payments.isEmpty()) {
                        for (FeePayment payment : payments) {
                            String statusClass = "";
                            String status = payment.getStatus();
                            if ("Paid".equalsIgnoreCase(status)) statusClass = "status-paid";
                            else if ("Unpaid".equalsIgnoreCase(status)) statusClass = "status-unpaid";
                            else if ("Overdue".equalsIgnoreCase(status)) statusClass = "status-overdue";
                    %>
                    <tr>
                        <td><%= payment.getPaymentId() %></td>
                        <td><%= payment.getStudentId() %></td>
                        <td><%= payment.getStudentName() %></td>
                        <td><%= payment.getPaymentDate() %></td>
                        <td class="amount">₹<%= String.format("%.2f", payment.getAmount()) %></td>
                        <td><span class="status <%= statusClass %>"><%= status %></span></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr><td colspan="6" class="no-data">
                        <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 1rem; display: block; opacity: 0.5;"></i>
                        No fee payments found.
                    </td></tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <a href="index.jsp" class="back-link">
        <i class="fas fa-arrow-left"></i>
        Return to Dashboard
    </a>

    <script>
        function toggleTheme() {
            document.body.classList.toggle('light-mode');
            const themeToggle = document.querySelector('.theme-toggle i');
            
            if (document.body.classList.contains('light-mode')) {
                themeToggle.className = 'fas fa-sun';
            } else {
                themeToggle.className = 'fas fa-moon';
            }
        }

        // Animate table rows on load
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('tbody tr');
            rows.forEach((row, index) => {
                row.style.opacity = '0';
                row.style.transform = 'translateX(-20px)';
                setTimeout(() => {
                    row.style.transition = 'all 0.5s ease';
                    row.style.opacity = '1';
                    row.style.transform = 'translateX(0)';
                }, 100 * index);
            });

            // Animate stat cards
            const statCards = document.querySelectorAll('.stat-card');
            statCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.5s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 200 + (100 * index));
            });
        });

        // Add search functionality (if needed in future)
        function searchTable() {
            // Implementation for table search
        }

        // Add export functionality (if needed in future)
        function exportData() {
            // Implementation for data export
        }
    </script>
</body>
</html>