<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>College Fee Management System | AIET</title>
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
            max-width: 1400px;
            margin: 0 auto;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 4rem;
            animation: fadeInUp 0.8s ease-out;
        }

        .welcome-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .welcome-subtitle {
            font-size: 1.3rem;
            color: var(--text-secondary);
            font-weight: 400;
            max-width: 600px;
            margin: 0 auto;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 4rem;
        }

        .menu-item {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 2.5rem;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.8s ease-out;
        }

        .menu-item:nth-child(1) { animation-delay: 0.1s; }
        .menu-item:nth-child(2) { animation-delay: 0.2s; }
        .menu-item:nth-child(3) { animation-delay: 0.3s; }
        .menu-item:nth-child(4) { animation-delay: 0.4s; }
        .menu-item:nth-child(5) { animation-delay: 0.5s; }

        .menu-item::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: var(--primary-gradient);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: -1;
        }

        .menu-item:hover::before {
            opacity: 0.1;
        }

        .menu-item:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: var(--shadow-hover);
            border-color: rgba(102, 126, 234, 0.3);
        }

        .menu-icon {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .menu-item:nth-child(1) .menu-icon {
            background: var(--primary-gradient);
            color: white;
        }

        .menu-item:nth-child(2) .menu-icon {
            background: var(--secondary-gradient);
            color: white;
        }

        .menu-item:nth-child(3) .menu-icon {
            background: var(--danger-gradient);
            color: white;
        }

        .menu-item:nth-child(4) .menu-icon {
            background: var(--success-gradient);
            color: white;
        }

        .menu-item:nth-child(5) .menu-icon {
            background: var(--warning-gradient);
            color: white;
        }

        .menu-item:hover .menu-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .menu-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
        }

        .menu-desc {
            color: var(--text-secondary);
            margin-bottom: 2rem;
            line-height: 1.6;
            font-weight: 400;
        }

        .menu-link {
            display: inline-flex;
            align-items: center;
            background: var(--primary-gradient);
            color: white;
            text-decoration: none;
            padding: 0.875rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow);
        }

        .menu-link:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .menu-link::after {
            content: '→';
            margin-left: 0.5rem;
            transition: transform 0.3s ease;
        }

        .menu-link:hover::after {
            transform: translateX(4px);
        }

        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 4rem;
        }

        .stat-card {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            animation: fadeInUp 0.8s ease-out;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .footer {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-top: 1px solid var(--border-color);
            text-align: center;
            padding: 2rem;
            color: var(--text-secondary);
            font-weight: 400;
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

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .pulse {
            animation: pulse 2s infinite;
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

            .welcome-title {
                font-size: 2.5rem;
            }

            .menu-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .container {
                padding: 2rem 1rem;
            }

            .header {
                padding: 1rem;
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
        <h2><i class="fas fa-university"></i> AIET</h2>
        <ul>
            <li><a href="#"><i class="fas fa-home"></i> Dashboard</a></li>
            <li><a href="feepaymentadd.jsp"><i class="fas fa-plus-circle"></i> Add Payment</a></li>
            <li><a href="feepaymentupdate.jsp"><i class="fas fa-edit"></i> Update Payment</a></li>
            <li><a href="feepaymentdelete.jsp"><i class="fas fa-trash-alt"></i> Delete Payment</a></li>
            <li><a href="displayPayments"><i class="fas fa-list"></i> View Payments</a></li>
            <li><a href="reports.jsp"><i class="fas fa-chart-pie"></i> Reports</a></li>
        </ul>
    </div>

    <div class="main-content" id="mainContent">
        <div class="header">
            <button class="menu-toggle" onclick="toggleSidebar()">
                <i class="fas fa-bars"></i>
            </button>
            <button class="theme-toggle" onclick="toggleTheme()">
                <i class="fas fa-palette"></i> Toggle Theme
            </button>
        </div>

        <div class="container">
            <div class="welcome-section">
                <h1 class="welcome-title">College Fee Management</h1>
                <p class="welcome-subtitle">Streamlined fee management with modern technology and intuitive design</p>
            </div>

            <div class="stats-section">
                <div class="stat-card">
                    <div class="stat-number">1,247</div>
                    <div class="stat-label">Total Students</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">₹2.8M</div>
                    <div class="stat-label">Fees Collected</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">94%</div>
                    <div class="stat-label">Collection Rate</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">156</div>
                    <div class="stat-label">Pending Payments</div>
                </div>
            </div>

            <div class="menu-grid">
                <div class="menu-item">
                    <div class="menu-icon"><i class="fas fa-user-plus"></i></div>
                    <div class="menu-title">Add Fee Payment</div>
                    <div class="menu-desc">Enter a new student fee payment record with comprehensive details and automated validation.</div>
                    <a href="feepaymentadd.jsp" class="menu-link">Get Started</a>
                </div>

                <div class="menu-item">
                    <div class="menu-icon"><i class="fas fa-pen-nib"></i></div>
                    <div class="menu-title">Update Payment</div>
                    <div class="menu-desc">Modify or correct existing payment data with secure authentication and audit trails.</div>
                    <a href="feepaymentupdate.jsp" class="menu-link">Modify Records</a>
                </div>

                <div class="menu-item">
                    <div class="menu-icon"><i class="fas fa-trash-can"></i></div>
                    <div class="menu-title">Delete Payment</div>
                    <div class="menu-desc">Remove incorrect or duplicate entries with comprehensive backup and recovery options.</div>
                    <a href="feepaymentdelete.jsp" class="menu-link">Manage Deletions</a>
                </div>

                <div class="menu-item">
                    <div class="menu-icon"><i class="fas fa-folder-open"></i></div>
                    <div class="menu-title">View Payments</div>
                    <div class="menu-desc">Search, filter, and view all fee payment records with advanced analytics and insights.</div>
                    <a href="displayPayments" class="menu-link">Browse Records</a>
                </div>

                <div class="menu-item">
                    <div class="menu-icon"><i class="fas fa-chart-line"></i></div>
                    <div class="menu-title">Generate Reports</div>
                    <div class="menu-desc">Analyze fee collections with comprehensive reports, charts, and exportable data formats.</div>
                    <a href="reports.jsp" class="menu-link">View Analytics</a>
                </div>
            </div>
        </div>

        <div class="footer">
            &copy; <%= java.time.Year.now().getValue() %> College Fee Management System | All rights reserved. | Powered by Modern Technology
        </div>
    </div>

    <script>
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
            const mainContent = document.getElementById('mainContent');
            const overlay = document.querySelector('.overlay');
            
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
        }

        // Add smooth scrolling and entrance animations
        document.addEventListener('DOMContentLoaded', function() {
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            document.querySelectorAll('.menu-item, .stat-card').forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(30px)';
                el.style.transition = 'all 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
                observer.observe(el);
            });

            // Add particle effect on hover
            document.querySelectorAll('.menu-item').forEach(item => {
                item.addEventListener('mouseenter', function() {
                    this.style.boxShadow = '0 20px 60px rgba(102, 126, 234, 0.3)';
                });
                
                item.addEventListener('mouseleave', function() {
                    this.style.boxShadow = '';
                });
            });
        });

        // Add loading animation
        window.addEventListener('load', function() {
            document.body.style.opacity = '1';
        });

        document.body.style.opacity = '0';
        document.body.style.transition = 'opacity 0.5s ease-in-out';
    </script>
</body>
</html>