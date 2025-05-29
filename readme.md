# 🏫 College Fee Payment System

> A web-based system to manage student fee records efficiently using **Java Servlets**, **JSP**, and **MySQL**, developed as part of the Advanced Java curriculum.

---

## 👩‍💻 Student Info

- **Name:** Prathi U Shetty  
- **USN:** 4AL22CS107  
- **Semester:** VI  
- **Section:** B
- **Subject:** Advanced Java  
- **Subject Code:** BCS613D

---

## 🔍 Overview

This project is designed to simplify the process of managing college fee payments. It allows administrators to:

- Record and track student fee transactions
- View pending dues and payment history
- Generate custom reports
- Ensure data validation and structured architecture

---

## 📦 Core Modules

- **➕ Add Student Fee Info**  
- **🔄 Edit Existing Records**  
- **🗑️ Remove a Student Entry**  
- **📋 View Fee Status**  
- **📈 Generate Reports on Payments, Dues, and Defaulters**

---

## ⚙️ Tech Stack

| Technology     | Purpose                        |
|----------------|--------------------------------|
| Java (JSP, Servlets) | Backend logic & web interface |
| MySQL          | Database to store records      |
| HTML/CSS/JS    | Front-end presentation         |
| Bootstrap 5    | Responsive UI design           |
| Apache Tomcat  | Web server for deployment      |
| JDBC           | Database connectivity layer    |

---

Step 2: Set Up the Database
Open MySQL (or phpMyAdmin) and run:
CREATE DATABASE college_fee;
USE college_fee;

CREATE TABLE StudentFees (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Course VARCHAR(100),
    FeeAmount DECIMAL(10,2),
    PaidAmount DECIMAL(10,2),
    DueAmount DECIMAL(10,2),
    PaymentDate DATE
);

INSERT INTO StudentFees VALUES 
(101, 'Prathi U Shetty', 'Computer Science', 50000, 30000, 20000, '2025-04-10'),
(102, 'Rithika', 'Information Science', 55000, 55000, 0, '2025-04-08'),
(103, 'Sakshi', 'Mechanical', 40000, 15000, 25000, '2025-04-12');
Step 3: Configure JDBC
In FeeDAO.java, update your DB credentials:
DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/college_fee", 
    "your_username", 
    "your_password"
);
Step 4: Add JDBC Library
Download mysql-connector-java.jar

Step 5: Deploy to Server
Import as Dynamic Web Project in Eclipse/IntelliJ

Deploy to Apache Tomcat

Access via: http://localhost:8080/CollegeFeePaymentSystem
📊 Functionality Testing
Feature	Description
Add Fee	Fill form and submit new record
Update Fee	Modify existing student data
Delete Fee	Remove a student’s record
View Details	List all records with filters
Reports	View defaulters, total collection, paid/unpaid status
✅ Validation & Security
✅ Form validations on both client and server

🔐 Use of prepared statements (SQL Injection-safe)

🔁 Clean error handling and user notifications

🧪 Sample Screens : 


🎓 Learning Outcomes
Developed a complete Java web application from scratch

Learned MVC architecture and layered development

Built skills in form handling, CRUD operations, and JDBC integration

Gained hands-on experience in deploying apps with Tomcat

👤 Author
Developed by Prathi U Shetty
USN: 4AL22CS107
Alva’s Institute of Engineering & Technology
Subject: Advanced Java (BCS613D)
