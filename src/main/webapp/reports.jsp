<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Reports | AIET</title>
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

        .page-header {
            text-align: center;
            margin-bottom: 4rem;
            animation: fadeInDown 0.8s ease-out 0.2s both;
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: flex;
            align-items: center;
            justify-content: center;
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
            font-size: 1.1rem;
            line-height: 1.6;
            max-width: 600px;
            margin: 0 auto;
        }

        .report-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .report-card {
            background: var(--input-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 2rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            text-decoration: none;
            color: inherit;
        }

        .report-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--primary-gradient);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .report-card:hover::before {
            transform: scaleX(1);
        }

        .report-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-hover);
            border-color: rgba(102, 126, 234, 0.3);
        }

        .report-card:nth-child(1) .report-icon {
            background: var(--danger-gradient);
        }

        .report-card:nth-child(2) .report-icon {
            background: var(--warning-gradient);
        }

        .report-card:nth-child(3) .report-icon {
            background: var(--success-gradient);
        }

        .report-icon {
            width: 70px;
            height: 70px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            color: white;
            box-shadow: var(--shadow);
        }

        .report-card h3 {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
        }

        .report-card p {
            color: var(--text-secondary);
            line-height: 1.6;
            margin-bottom: 1.5rem;
            font-size: 0.95rem;
        }

        .report-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .report-link:hover {
            gap: 0.75rem;
            color: #5a67d8;
        }

        .report-link i {
            transition: transform 0.3s ease;
        }

        .report-card:hover .report-link i {
            transform: translateX(4px);
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

            .page-title {
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

            .report-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .report-card {
                padding: 1.5rem;
            }

            .back-link {
                position: relative;
                bottom: auto;
                left: auto;
                margin: 2rem auto 0;
                display: flex;
                justify-content: center;
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

        /* Pulse animation for cards */
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        .report-card:active {
            animation: pulse 0.2s ease-in-out;
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
        <div class="page-header">
            <h1 class="page-title">
                <i class="fas fa-chart-pie"></i>Report Center
            </h1>
            <p class="page-description">
                Choose a report category below to generate detailed fee records, payment analytics, and outstanding dues.
            </p>
        </div>

        <div class="report-grid">
            <!-- Overdue Payments Report -->
            <div class="report-card" onclick="location.href='reportCriteria?reportType=overdue'" 
                 title="View overdue payment report">
                <div class="report-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3>Overdue Payments</h3>
                <p>Generate a report of students with overdue fee payments, including the due amount and deadlines.</p>
                <a href="reportCriteria?reportType=overdue" class="report-link">
                    View Report <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <!-- Pending Payments Report -->
            <div class="report-card" onclick="location.href='reportCriteria?reportType=unpaid'" 
                 title="View pending payment report">
                <div class="report-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <h3>Pending Payments</h3>
                <p>List all students with pending or uninitiated payments. Filter results by department or fee range.</p>
                <a href="reportCriteria?reportType=unpaid" class="report-link">
                    View Report <i class="fas fa-arrow-right"></i>
                </a>
            </div>

            <!-- Fee Collection Report -->
            <div class="report-card" onclick="location.href='reportCriteria?reportType=collections'" 
                 title="View fee collection summary">
                <div class="report-icon">
                    <i class="fas fa-chart-line"></i>
                </div>
                <h3>Fee Collections</h3>
                <p>Analyze collected payments by department, collection method, or time period for performance review.</p>
                <a href="reportCriteria?reportType=collections" class="report-link">
                    View Report <i class="fas fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>

    <a href="index.jsp" class="back-link" title="Return to dashboard">
        <i class="fas fa-arrow-left"></i>Return to Dashboard
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

        // Animate cards on load
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.report-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                setTimeout(() => {
                    card.style.transition = 'all 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, 300 + (150 * index));
            });

            // Add click animation
            cards.forEach(card => {
                card.addEventListener('click', function(e) {
                    // Create ripple effect
                    const ripple = document.createElement('div');
                    const rect = card.getBoundingClientRect();
                    const size = Math.max(rect.width, rect.height);
                    const x = e.clientX - rect.left - size / 2;
                    const y = e.clientY - rect.top - size / 2;
                    
                    ripple.style.cssText = `
                        position: absolute;
                        width: ${size}px;
                        height: ${size}px;
                        left: ${x}px;
                        top: ${y}px;
                        background: rgba(102, 126, 234, 0.3);
                        border-radius: 50%;
                        transform: scale(0);
                        animation: ripple 0.6s ease-out;
                        pointer-events: none;
                    `;
                    
                    card.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        });

        // Add ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(2);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);

        // Add hover sound effect (optional)
        function playHoverSound() {
            // Uncomment if you want sound effects
            // const audio = new Audio('data:audio/wav;base64,UklGRnoGAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQoGAACBhYqFbF1fdJivrJBhNjVgodDbq2EcBj+a2/LDciUFLIHO8tiJNwgZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmMcAzuC0PLUdjEGJYHO89eLOgcZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmMcAzuC0PLUdjEGJYHO89eLOgcZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmMcAzuC0PLUdjEGJYHO89eLOgcZaLvt559NEAxQp+PwtmMcBjiR1/LMeSwFJHfH8N2QQAoUXrTp66hVFApGn+DyvmMcAzuC0PLUdjEGJYHO89eLOgcZaLzu559NFApGn+PwtWEcAjiR1/LNeSsFJHfH8N+RQgkUXrTp66hVFAlGnt');
            // audio.play().catch(() => {});
        }
    </script>
</body>
</html>