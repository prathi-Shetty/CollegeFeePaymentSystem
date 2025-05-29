<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Fee Payment | AIET</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-bg: #f5f7fa;
            --dark-bg: #1e1e2f;
            --light-text: #212529;
            --dark-text: #f1f1f1;
            --card-bg: #ffffff;
            --card-bg-dark: #2c2c3e;
            --border-color: #e0e0e0;
            --danger-color: #f72585;
            --success-color: #4cc9f0;
        }

        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background-color: var(--light-bg);
            color: var(--light-text);
            transition: background-color 0.3s, color 0.3s;
        }

        body.dark-mode {
            background-color: var(--dark-bg);
            color: var(--dark-text);
        }

        .container {
            max-width: 600px;
            margin: 2rem auto;
            background-color: var(--card-bg);
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s;
        }

        body.dark-mode .container {
            background-color: var(--card-bg-dark);
        }

        h1 {
            text-align: center;
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
        }

        .theme-toggle {
            position: absolute;
            top: 20px;
            right: 20px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1.2rem;
            color: var(--primary-color);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 500;
            margin-bottom: 0.3rem;
        }

        input, select {
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-family: inherit;
            transition: all 0.3s;
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }

        button {
            padding: 0.9rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        button:hover {
            background-color: var(--secondary-color);
        }

        .back-link {
            text-align: center;
            margin-top: 1.2rem;
            display: inline-block;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .back-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }

        .message {
            padding: 0.8rem;
            text-align: center;
            border-radius: 5px;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .error {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--danger-color);
        }

        .success {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success-color);
        }

        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <button class="theme-toggle" onclick="toggleTheme()" title="Toggle Light/Dark Mode">
        <i class="fas fa-adjust"></i>
    </button>

    <div class="container">
        <h1><i class="fas fa-edit"></i> Update Fee Payment</h1>

        <% if (request.getParameter("error") != null) { %>
            <div class="message error">
                <i class="fas fa-exclamation-circle"></i> Failed to update payment. Please try again.
            </div>
        <% } %>

        <% if (request.getParameter("success") != null) { %>
            <div class="message success">
                <i class="fas fa-check-circle"></i> Payment updated successfully!
            </div>
        <% } %>

        <form action="updatePayment" method="post">
            <div class="form-group">
                <label for="paymentId">Payment ID</label>
                <input type="number" id="paymentId" name="paymentId" required placeholder="Enter payment ID">
            </div>
            <div class="form-group">
                <label for="studentId">Student ID</label>
                <input type="number" id="studentId" name="studentId" required placeholder="Enter student ID">
            </div>
            <div class="form-group">
                <label for="studentName">Student Name</label>
                <input type="text" id="studentName" name="studentName" required placeholder="Enter student name">
            </div>
            <div class="form-group">
                <label for="paymentDate">Payment Date</label>
                <input type="date" id="paymentDate" name="paymentDate" required>
            </div>
            <div class="form-group">
                <label for="amount">Amount</label>
                <input type="number" id="amount" name="amount" step="0.01" required placeholder="0.00">
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status" required>
                    <option value="" disabled selected>Select payment status</option>
                    <option value="Paid">Paid</option>
                    <option value="Unpaid">Unpaid</option>
                    <option value="Overdue">Overdue</option>
                </select>
            </div>
            <button type="submit"><i class="fas fa-save"></i> Update Payment</button>
        </form>

        <a class="back-link" href="index.jsp"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>

    <script>
        // Theme toggle logic with local storage
        function toggleTheme() {
            document.body.classList.toggle("dark-mode");
            localStorage.setItem("theme", document.body.classList.contains("dark-mode") ? "dark" : "light");
        }

        // Initialize theme on page load
        window.onload = () => {
            if (localStorage.getItem("theme") === "dark") {
                document.body.classList.add("dark-mode");
            }
        }
    </script>
</body>
</html>
