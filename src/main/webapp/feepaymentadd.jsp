<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Fee Payment - AIET</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            overflow-x: hidden;
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

        .container {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 32px;
            padding: 3rem;
            width: 100%;
            max-width: 600px;
            margin: 2rem;
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

        h1 {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: fadeInDown 0.8s ease-out 0.2s both;
        }

        .subtitle {
            text-align: center;
            color: var(--text-secondary);
            margin-bottom: 2.5rem;
            font-weight: 400;
            animation: fadeInDown 0.8s ease-out 0.3s both;
        }

        .alert {
            padding: 1rem 1.5rem;
            border-radius: 16px;
            margin-bottom: 2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            animation: slideInRight 0.6s ease-out;
        }

        .alert.success {
            background: linear-gradient(135deg, rgba(75, 181, 67, 0.2), rgba(56, 249, 215, 0.2));
            border: 1px solid rgba(75, 181, 67, 0.3);
            color: #4bb543;
        }

        .alert.error {
            background: linear-gradient(135deg, rgba(250, 112, 154, 0.2), rgba(254, 225, 64, 0.2));
            border: 1px solid rgba(250, 112, 154, 0.3);
            color: #fa709a;
        }

        form {
            animation: fadeInUp 0.8s ease-out 0.4s both;
        }

        .form-group {
            margin-bottom: 2rem;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            color: var(--text-primary);
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 1.25rem 1.5rem;
            background: var(--input-bg);
            border: 2px solid var(--input-border);
            border-radius: 16px;
            color: var(--text-primary);
            font-size: 1rem;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px var(--input-focus);
            transform: translateY(-2px);
        }

        .form-group input::placeholder {
            color: var(--text-secondary);
            font-weight: 400;
        }

        .form-group select {
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%236b7280' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='m6 8 4 4 4-4'/%3e%3c/svg%3e");
            background-position: right 1rem center;
            background-repeat: no-repeat;
            background-size: 1.5em 1.5em;
            padding-right: 3rem;
        }

        .form-group select option {
            background: var(--bg-secondary);
            color: var(--text-primary);
            padding: 0.5rem;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 3rem;
            flex-direction: column;
        }

        .btn-primary {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1.25rem 2rem;
            border-radius: 16px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow);
            position: relative;
            overflow: hidden;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-hover);
        }

        .btn-primary:active {
            transform: translateY(-1px);
        }

        .back-link {
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
            justify-content: center;
            background: var(--input-bg);
            backdrop-filter: blur(10px);
        }

        .back-link:hover {
            color: var(--text-primary);
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: var(--shadow);
        }

        .input-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            pointer-events: none;
            font-size: 1.1rem;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }

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

        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .form-progress {
            position: absolute;
            top: 0;
            left: 0;
            height: 4px;
            background: var(--success-gradient);
            border-radius: 32px 32px 0 0;
            width: 0%;
            transition: width 0.3s ease;
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem;
                align-items: flex-start;
                padding-top: 6rem;
            }

            .container {
                padding: 2rem;
                margin: 0;
                border-radius: 24px;
            }

            h1 {
                font-size: 2rem;
            }

            .theme-toggle {
                top: 1rem;
                right: 1rem;
                width: 50px;
                height: 50px;
                padding: 0.75rem;
            }

            .form-actions {
                flex-direction: column;
            }
        }

        /* Loading animation */
        .btn-primary.loading {
            pointer-events: none;
            position: relative;
        }

        .btn-primary.loading::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            margin: auto;
            border: 2px solid transparent;
            border-top-color: #ffffff;
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
        <div class="form-progress" id="formProgress"></div>
        
        <h1><i class="fas fa-plus-circle" style="margin-right: 0.5rem;"></i>Add Fee Payment</h1>
        <p class="subtitle">Enter student payment details with precision and care</p>

        <% if (request.getParameter("error") != null) { %>
            <div class="alert error">
                <i class="fas fa-exclamation-triangle"></i>
                Failed to add payment. Please verify your information and try again.
            </div>
        <% } %>

        <% if (request.getParameter("success") != null) { %>
            <div class="alert success">
                <i class="fas fa-check-circle"></i>
                Payment record added successfully! The system has been updated.
            </div>
        <% } %>

        <form action="addPayment" method="post" id="paymentForm">
            <div class="form-group">
                <label for="studentId"><i class="fas fa-id-card" style="margin-right: 0.5rem;"></i>Student ID</label>
                <input type="number" id="studentId" name="studentId" required 
                       placeholder="Enter unique student identifier" min="1">
            </div>

            <div class="form-group">
                <label for="studentName"><i class="fas fa-user" style="margin-right: 0.5rem;"></i>Student Name</label>
                <input type="text" id="studentName" name="studentName" required 
                       placeholder="Enter full student name" maxlength="100">
            </div>

            <div class="form-group">
                <label for="paymentDate"><i class="fas fa-calendar-alt" style="margin-right: 0.5rem;"></i>Payment Date</label>
                <input type="date" id="paymentDate" name="paymentDate" required>
            </div>

            <div class="form-group">
                <label for="amount"><i class="fas fa-rupee-sign" style="margin-right: 0.5rem;"></i>Amount</label>
                <input type="number" id="amount" name="amount" step="0.01" required 
                       placeholder="0.00" min="0.01" max="999999.99">
            </div>

            <div class="form-group">
                <label for="status"><i class="fas fa-check-circle" style="margin-right: 0.5rem;"></i>Payment Status</label>
                <select id="status" name="status" required>
                    <option value="" disabled selected>Select payment status</option>
                    <option value="Paid">✅ Paid</option>
                    <option value="Unpaid">⏳ Unpaid</option>
                    <option value="Overdue">⚠️ Overdue</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-primary" id="submitBtn">
                    <i class="fas fa-save" style="margin-right: 0.5rem;"></i>
                    Add Payment Record
                </button>
                
                <a href="index.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i>
                    Return to Dashboard
                </a>
            </div>
        </form>
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

        // Form validation and progress tracking
        const form = document.getElementById('paymentForm');
        const formProgress = document.getElementById('formProgress');
        const inputs = form.querySelectorAll('input[required], select[required]');
        
        function updateProgress() {
            let filledInputs = 0;
            inputs.forEach(input => {
                if (input.value.trim() !== '') {
                    filledInputs++;
                }
            });
            
            const progress = (filledInputs / inputs.length) * 100;
            formProgress.style.width = progress + '%';
        }

        inputs.forEach(input => {
            input.addEventListener('input', updateProgress);
            input.addEventListener('change', updateProgress);
        });

        // Form submission with loading state
        form.addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('loading');
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin" style="margin-right: 0.5rem;"></i>Processing...';
        });

        // Set today's date as default
        document.getElementById('paymentDate').valueAsDate = new Date();

        // Input animations and validations
        inputs.forEach((input, index) => {
            input.style.animationDelay = `${0.1 + (index * 0.1)}s`;
            
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('label').style.color = '#667eea';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.querySelector('label').style.color = 'var(--text-primary)';
            });
        });

        // Amount formatting
        document.getElementById('amount').addEventListener('input', function() {
            let value = this.value;
            if (value && !isNaN(value)) {
                this.style.color = '#4bb543';
            } else {
                this.style.color = 'var(--text-primary)';
            }
        });

        // Student ID validation
        document.getElementById('studentId').addEventListener('input', function() {
            if (this.value.length > 0) {
                this.style.borderColor = '#4bb543';
            } else {
                this.style.borderColor = 'var(--input-border)';
            }
        });

        // Initialize progress
        updateProgress();

        // Entrance animation for form elements
        document.addEventListener('DOMContentLoaded', function() {
            const formGroups = document.querySelectorAll('.form-group');
            formGroups.forEach((group, index) => {
                group.style.opacity = '0';
                group.style.transform = 'translateY(30px)';
                group.style.animation = `fadeInUp 0.6s ease-out ${0.4 + (index * 0.1)}s forwards`;
            });
        });
    </script>
</body>
</html>