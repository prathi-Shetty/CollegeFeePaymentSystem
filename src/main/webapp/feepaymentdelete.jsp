<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Fee Payment | AIET</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        }

        .light-mode {
            --bg-primary: #f8fafc;
            --bg-secondary: #ffffff;
            --bg-card: rgba(255, 255, 255, 0.8);
            --text-primary: #1a202c;
            --text-secondary: #718096;
            --border-color: rgba(0, 0, 0, 0.1);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 16px 48px rgba(0, 0, 0, 0.15);
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
            transition: all 0.3s ease;
            overflow-x: hidden;
            opacity: 0;
        }

        .background-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            opacity: 0.1;
            background-image: 
                radial-gradient(circle at 25% 25%, #667eea 0%, transparent 50%),
                radial-gradient(circle at 75% 75%, #764ba2 0%, transparent 50%);
            animation: backgroundShift 20s ease-in-out infinite;
        }

        @keyframes backgroundShift {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(-20px, -20px) rotate(120deg); }
            66% { transform: translate(20px, -20px) rotate(240deg); }
        }

        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: var(--bg-secondary);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            padding: 2rem 0;
            transform: translateX(0);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 1000;
        }

        .sidebar.collapsed {
            transform: translateX(-100%);
        }

        .sidebar h2 {
            text-align: center;
            font-size: 1.8rem;
            font-weight: 800;
            margin-bottom: 3rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: logoGlow 3s ease-in-out infinite;
        }

        @keyframes logoGlow {
            0%, 100% { filter: brightness(1); }
            50% { filter: brightness(1.2); }
        }

        .sidebar ul {
            list-style: none;
            padding: 0 1rem;
        }

        .sidebar li {
            margin-bottom: 0.5rem;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            padding: 1rem 1.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            border-radius: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .sidebar a:before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: var(--primary-gradient);
            transition: left 0.3s ease;
            z-index: -1;
        }

        .sidebar a:hover:before {
            left: 0;
        }

        .sidebar a:hover {
            color: white;
            transform: translateX(8px);
            box-shadow: var(--shadow);
        }

        .sidebar a i {
            margin-right: 1rem;
            font-size: 1.1rem;
            width: 20px;
        }

        .sidebar a.active {
            background: var(--primary-gradient);
            color: white;
        }

        .main-content {
            margin-left: 280px;
            min-height: 100vh;
            transition: margin-left 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .main-content.expanded {
            margin-left: 0;
        }

        .header {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color);
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: var(--text-primary);
            font-size: 1.5rem;
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .menu-toggle:hover {
            background: var(--bg-card);
            transform: scale(1.1);
        }

        .theme-toggle {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow);
        }

        .theme-toggle:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .container {
            padding: 3rem 2rem;
            max-width: 800px;
            margin: 0 auto;
        }

        .container h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 2rem;
            background: var(--danger-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-align: center;
            animation: fadeInUp 0.8s ease-out;
        }

        .container h1 i {
            margin-right: 1rem;
            color: #fa709a;
        }

        .error {
            background: rgba(255, 107, 107, 0.1);
            border: 1px solid rgba(255, 107, 107, 0.3);
            color: #ff6b6b;
            padding: 1rem 1.5rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            backdrop-filter: blur(10px);
            font-weight: 500;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .form-container {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 3rem;
            margin-bottom: 2rem;
            animation: fadeInUp 0.8s ease-out 0.2s both;
            box-shadow: var(--shadow);
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: var(--text-primary);
            font-size: 1.1rem;
        }

        .form-group input {
            width: 100%;
            padding: 1rem 1.5rem;
            border: 1px solid var(--border-color);
            border-radius: 16px;
            background: var(--bg-card);
            color: var(--text-primary);
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
        }

        .form-group input:focus {
            outline: none;
            border-color: #fa709a;
            box-shadow: 0 0 0 3px rgba(250, 112, 154, 0.1), var(--shadow);
            transform: translateY(-2px);
        }

        .form-group input::placeholder {
            color: var(--text-secondary);
        }

        .btn-delete {
            background: var(--danger-gradient);
            color: white;
            border: none;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin: 0 auto;
            position: relative;
            overflow: hidden;
        }

        .btn-delete:before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            transition: all 0.5s ease;
            transform: translate(-50%, -50%);
        }

        .btn-delete:hover:before {
            width: 300px;
            height: 300px;
        }

        .btn-delete:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            padding: 1rem 1.5rem;
            border-radius: 16px;
            transition: all 0.3s ease;
            background: var(--bg-card);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .back-link:hover {
            color: var(--text-primary);
            transform: translateX(-4px);
            box-shadow: var(--shadow);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease;
        }

        .modal-content {
            background: var(--bg-secondary);
            backdrop-filter: blur(20px);
            padding: 3rem;
            border-radius: 24px;
            text-align: center;
            max-width: 500px;
            margin: 2rem;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-hover);
            animation: scaleIn 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .modal-content p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            color: var(--text-primary);
            font-weight: 500;
            line-height: 1.6;
        }

        .modal-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .modal-buttons button {
            padding: 1rem 2rem;
            border: none;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 1rem;
            box-shadow: var(--shadow);
        }

        .modal-buttons .confirm {
            background: var(--danger-gradient);
            color: white;
        }

        .modal-buttons .confirm:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .modal-buttons .cancel {
            background: var(--bg-card);
            color: var(--text-primary);
            border: 1px solid var(--border-color);
        }

        .modal-buttons .cancel:hover {
            background: var(--primary-gradient);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
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

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .menu-toggle {
                display: block;
            }

            .container {
                padding: 2rem 1rem;
            }

            .container h1 {
                font-size: 2rem;
            }

            .form-container {
                padding: 2rem;
            }

            .modal-content {
                margin: 1rem;
                padding: 2rem;
            }

            .modal-buttons {
                flex-direction: column;
            }
        }

        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            z-index: 999;
        }

        .overlay.active {
            opacity: 1;
            visibility: visible;
        }
    </style>
</head>
<body>
    <div class="background-pattern"></div>
    <div class="overlay" onclick="toggleSidebar()"></div>

    <div class="sidebar" id="sidebar">
        <h2><i class="fas fa-university"></i> CFMS</h2>
        <ul>
            <li><a href="index.jsp"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="feepaymentadd.jsp"><i class="fas fa-plus-circle"></i> Add Payment</a></li>
            <li><a href="feepaymentupdate.jsp"><i class="fas fa-edit"></i> Update Payment</a></li>
            <li><a href="feepaymentdelete.jsp" class="active"><i class="fas fa-trash-alt"></i> Delete Payment</a></li>
            <li><a href="displayPayments"><i class="fas fa-list"></i> View Payments</a></li>
            <li><a href="reports.jsp"><i class="fas fa-chart-pie"></i> Reports</a></li>
        </ul>
    </div>

    <div class="main-content">
        <div class="header">
            <button class="menu-toggle" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
            <button class="theme-toggle" onclick="toggleTheme()"><i class="fas fa-palette"></i> Toggle Theme</button>
        </div>

        <div class="container">
            <h1><i class="fas fa-trash-alt"></i> Delete Fee Payment</h1>

            <% if (request.getParameter("error") != null) { %>
                <div class="error">
                    <i class="fas fa-exclamation-triangle"></i>
                    Failed to delete payment. Please try again.
                </div>
            <% } %>

            <div class="form-container">
                <form id="deleteForm">
                    <div class="form-group">
                        <label for="paymentId">
                            <i class="fas fa-hashtag"></i>
                            Payment ID
                        </label>
                        <input type="number" id="paymentId" name="paymentId" required 
                               placeholder="Enter payment ID to delete">
                    </div>
                    <button type="button" class="btn-delete" onclick="openModal()">
                        <i class="fas fa-trash-alt"></i>
                        Delete Payment Record
                    </button>
                </form>
            </div>

            <a href="index.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i> 
                Return to Dashboard
            </a>
        </div>

        <div id="confirmModal" class="modal">
            <div class="modal-content">
                <div style="font-size: 3rem; color: #fa709a; margin-bottom: 1rem;">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <p>Are you sure you want to delete this payment record? This action cannot be undone and will permanently remove all associated data.</p>
                <div class="modal-buttons">
                    <button class="confirm" onclick="submitForm()">
                        <i class="fas fa-trash"></i> Yes, Delete
                    </button>
                    <button class="cancel" onclick="closeModal()">
                        <i class="fas fa-times"></i> Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const form = document.getElementById('deleteForm');
        const modal = document.getElementById('confirmModal');

        function toggleTheme() {
            document.body.classList.toggle('light-mode');
            const themeToggle = document.querySelector('.theme-toggle');
            const icon = themeToggle.querySelector('i');
            
            if (document.body.classList.contains('light-mode')) {
                icon.className = 'fas fa-moon';
                themeToggle.innerHTML = '<i class="fas fa-moon"></i> Dark Mode';
            } else {
                icon.className = 'fas fa-sun';
                themeToggle.innerHTML = '<i class="fas fa-sun"></i> Light Mode';
            }
        }

        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.querySelector('.overlay');
            
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
        }

        function openModal() {
            const paymentId = document.getElementById('paymentId').value;
            if (!paymentId) {
                document.getElementById('paymentId').focus();
                document.getElementById('paymentId').style.borderColor = '#fa709a';
                setTimeout(() => {
                    document.getElementById('paymentId').style.borderColor = '';
                }, 2000);
                return;
            }
            modal.style.display = "flex";
        }

        function closeModal() {
            modal.style.display = "none";
        }

        function submitForm() {
            form.setAttribute("method", "get");
            form.setAttribute("action", "deletePayment");
            form.submit();
        }

        // Close modal on escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
            }
        });

        // Close modal on background click
        modal.addEventListener('click', function(e) {
            if (e.target === modal) {
                closeModal();
            }
        });

        // Add loading animation
        window.addEventListener('load', function() {
            document.body.style.opacity = '1';
            document.getElementById("paymentId").focus();
        });

        document.body.style.transition = 'opacity 0.5s ease-in-out';

        // Add input validation animation
        document.getElementById('paymentId').addEventListener('input', function() {
            this.style.borderColor = '';
        });
    </script>
</body>
</html>