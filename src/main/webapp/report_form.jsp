<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Report | AIET</title>
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

        .back-link {
            position: fixed;
            top: 2rem;
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
            z-index: 1000;
        }

        .back-link:hover {
            color: var(--text-primary);
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .container {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 32px;
            padding: 3rem;
            max-width: 800px;
            margin: 6rem auto 0;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
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

        .report-header {
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeInDown 0.8s ease-out 0.2s both;
        }

        .report-icon {
            width: 120px;
            height: 120px;
            border-radius: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            font-size: 3rem;
            color: white;
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
            animation: pulse 2s infinite;
        }

        .report-icon.overdue {
            background: var(--danger-gradient);
        }

        .report-icon.unpaid {
            background: var(--warning-gradient);
        }

        .report-icon.collections {
            background: var(--success-gradient);
        }

        .report-icon::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.3), transparent);
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }

        .report-title {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .report-description {
            color: var(--text-secondary);
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .form-section {
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-label {
            display: block;
            color: var(--text-primary);
            font-weight: 600;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-input {
            width: 100%;
            padding: 1rem 1.25rem;
            background: var(--input-bg);
            border: 2px solid var(--input-border);
            border-radius: 16px;
            color: var(--text-primary);
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            position: relative;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px var(--input-focus);
            transform: translateY(-2px);
        }

        .form-input:hover {
            border-color: rgba(102, 126, 234, 0.5);
        }

        .date-input-wrapper {
            position: relative;
        }

        .date-input-wrapper .form-input {
            padding-right: 3.5rem;
        }

        .date-input-wrapper::after {
            content: '\f073';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            pointer-events: none;
            font-size: 1.1rem;
        }

        .form-select {
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 1rem center;
            background-repeat: no-repeat;
            background-size: 1.5em 1.5em;
            padding-right: 3rem;
        }

        .button-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            align-items: center;
            margin-top: 3rem;
            animation: fadeInUp 0.8s ease-out 0.6s both;
        }

        .btn {
            padding: 1rem 2rem;
            border-radius: 16px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            border: none;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            box-shadow: var(--shadow);
        }

        .btn-primary:hover {
            transform: translateY(-4px) scale(1.02);
            box-shadow: var(--shadow-hover);
            color: white;
        }

        .btn-secondary {
            background: var(--input-bg);
            color: var(--text-secondary);
            border: 2px solid var(--border-color);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            color: var(--text-primary);
            border-color: #667eea;
            transform: translateY(-2px);
            background: var(--input-bg);
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .error-message {
            color: #ff6b6b;
            font-size: 0.85rem;
            margin-top: 0.5rem;
            display: none;
            animation: slideInDown 0.3s ease;
        }

        .form-input.error {
            border-color: #ff6b6b;
            box-shadow: 0 0 0 4px rgba(255, 107, 107, 0.2);
        }

        .form-input.error ~ .error-message {
            display: block;
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

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }

            .container {
                padding: 2rem;
                margin-top: 5rem;
                border-radius: 24px;
            }

            .theme-toggle,
            .back-link {
                top: 1rem;
                padding: 0.75rem;
            }

            .theme-toggle {
                right: 1rem;
                width: 50px;
                height: 50px;
            }

            .back-link {
                left: 1rem;
                font-size: 0.9rem;
                padding: 0.75rem 1rem;
            }

            .report-title {
                font-size: 1.8rem;
            }

            .report-icon {
                width: 100px;
                height: 100px;
                font-size: 2.5rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .button-group {
                flex-direction: column;
                gap: 1rem;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        /* Loading state */
        .loading {
            position: relative;
            pointer-events: none;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid currentColor;
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

    <a href="reports.jsp" class="back-link" title="Return to reports">
        <i class="fas fa-arrow-left"></i>Back
    </a>

    <div class="container">
        <div class="report-header">
            <% 
                String reportType = request.getParameter("reportType");
                String reportTitle = "";
                String iconClass = "";
                String description = "";
                String iconType = "";
                
                if ("overdue".equals(reportType)) {
                    reportTitle = "Overdue Payments Report";
                    iconClass = "fas fa-exclamation-triangle";
                    description = "Generate a comprehensive list of students with overdue fee payments including due amounts and deadlines";
                    iconType = "overdue";
                } else if ("unpaid".equals(reportType)) {
                    reportTitle = "Pending Payments Report";
                    iconClass = "fas fa-clock";
                    description = "Generate a detailed list of students with pending or uninitiated payments with filtering options";
                    iconType = "unpaid";
                } else if ("collections".equals(reportType)) {
                    reportTitle = "Fee Collections Report";
                    iconClass = "fas fa-chart-line";
                    description = "Analyze collected payments by department, collection method, or time period for comprehensive review";
                    iconType = "collections";
                }
            %>
            
            <div class="report-icon <%= iconType %>">
                <i class="<%= iconClass %>"></i>
            </div>
            
            <h1 class="report-title"><%= reportTitle %></h1>
            <p class="report-description"><%= description %></p>
        </div>

        <div class="form-section">
            <form action="report" method="get" id="reportForm">
                <input type="hidden" name="reportType" value="<%= reportType %>">
                
                <% if (!"overdue".equals(reportType)) { %>
                <div class="form-row">
                    <div class="form-group">
                        <label for="startDate" class="form-label">
                            <i class="fas fa-calendar-alt me-2"></i>Start Date
                        </label>
                        <div class="date-input-wrapper">
                            <input type="date" class="form-input" id="startDate" name="startDate" required>
                        </div>
                        <div class="error-message">Please select a valid start date</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="endDate" class="form-label">
                            <i class="fas fa-calendar-alt me-2"></i>End Date
                        </label>
                        <div class="date-input-wrapper">
                            <input type="date" class="form-input" id="endDate" name="endDate" required>
                        </div>
                        <div class="error-message">Please select a valid end date</div>
                    </div>
                </div>
                <% } %>
                
                <div class="button-group">
                    <a href="reports.jsp" class="btn btn-secondary">
                        <i class="fas fa-times"></i>Cancel
                    </a>
                    <button type="submit" class="btn btn-primary" id="generateBtn">
                        <i class="fas fa-file-download"></i>Generate Report
                    </button>
                </div>
            </form>
        </div>
    </div>

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

        // Form validation and handling
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('reportForm');
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            const generateBtn = document.getElementById('generateBtn');
            
            // Set default dates
            if (startDate && endDate) {
                const today = new Date();
                const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                
                function formatDate(date) {
                    const d = new Date(date);
                    let month = '' + (d.getMonth() + 1);
                    let day = '' + d.getDate();
                    const year = d.getFullYear();
                    
                    if (month.length < 2) month = '0' + month;
                    if (day.length < 2) day = '0' + day;
                    
                    return [year, month, day].join('-');
                }
                
                startDate.value = formatDate(firstDay);
                endDate.value = formatDate(today);
                
                // Date validation
                startDate.addEventListener('change', function() {
                    if (endDate.value && startDate.value > endDate.value) {
                        endDate.value = startDate.value;
                    }
                    validateInput(startDate);
                });
                
                endDate.addEventListener('change', function() {
                    validateInput(endDate);
                    if (startDate.value && endDate.value < startDate.value) {
                        showError(endDate, 'End date must be after start date');
                    }
                });
            }
            
            // Input validation
            function validateInput(input) {
                if (input.checkValidity()) {
                    input.classList.remove('error');
                } else {
                    input.classList.add('error');
                }
            }
            
            function showError(input, message) {
                input.classList.add('error');
                const errorDiv = input.parentNode.nextElementSibling;
                if (errorDiv && errorDiv.classList.contains('error-message')) {
                    errorDiv.textContent = message;
                }
            }
            
            // Form submission
            form.addEventListener('submit', function(e) {
                let isValid = true;
                const inputs = form.querySelectorAll('.form-input[required]');
                
                inputs.forEach(input => {
                    if (!input.checkValidity()) {
                        isValid = false;
                        input.classList.add('error');
                    } else {
                        input.classList.remove('error');
                    }
                });
                
                if (startDate && endDate && startDate.value && endDate.value) {
                    if (startDate.value > endDate.value) {
                        isValid = false;
                        showError(endDate, 'End date must be after start date');
                    }
                }
                
                if (!isValid) {
                    e.preventDefault();
                    return;
                }
                
                // Add loading state
                generateBtn.classList.add('loading');
                generateBtn.disabled = true;
                generateBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>Generating...';
            });
            
            // Input focus animations
            const inputs = document.querySelectorAll('.form-input');
            inputs.forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentNode.style.transform = 'scale(1.02)';
                });
                
                input.addEventListener('blur', function() {
                    this.parentNode.style.transform = 'scale(1)';
                    validateInput(this);
                });
            });
            
            // Animate form elements on load
            const formElements = document.querySelectorAll('.form-group');
            formElements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                setTimeout(() => {
                    element.style.transition = 'all 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, 600 + (100 * index));
            });
        });
        
        // Add ripple effect to buttons
        document.querySelectorAll('.btn').forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('div');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(255, 255, 255, 0.3);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s ease-out;
                    pointer-events: none;
                `;
                
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
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
    </script>
</body>
</html>