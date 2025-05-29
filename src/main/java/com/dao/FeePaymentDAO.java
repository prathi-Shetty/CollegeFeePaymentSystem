package com.dao;

import com.model.FeePayment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeePaymentDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/fee_db";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String INSERT_PAYMENT_SQL = "INSERT INTO FeePayments (StudentID, StudentName, PaymentDate, Amount, Status) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_PAYMENT_BY_ID = "SELECT * FROM FeePayments WHERE PaymentID = ?";
    private static final String SELECT_ALL_PAYMENTS = "SELECT * FROM FeePayments";
    private static final String DELETE_PAYMENT_SQL = "DELETE FROM FeePayments WHERE PaymentID = ?";
    private static final String UPDATE_PAYMENT_SQL = "UPDATE FeePayments SET StudentID=?, StudentName=?, PaymentDate=?, Amount=?, Status=? WHERE PaymentID=?";
    private static final String SELECT_OVERDUE_PAYMENTS = "SELECT * FROM FeePayments WHERE Status = 'Overdue'";
    private static final String SELECT_UNPAID_STUDENTS = "SELECT * FROM FeePayments WHERE Status = 'Unpaid' AND PaymentDate BETWEEN ? AND ?";
    private static final String SELECT_TOTAL_COLLECTIONS = "SELECT SUM(Amount) as Total FROM FeePayments WHERE Status = 'Paid' AND PaymentDate BETWEEN ? AND ?";

    public FeePaymentDAO() {
        // Initialize driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    protected Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    // Improved error handling for all methods
    public void insertPayment(FeePayment payment) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_PAYMENT_SQL)) {
            ps.setInt(1, payment.getStudentId());
            ps.setString(2, payment.getStudentName());
            ps.setDate(3, new java.sql.Date(payment.getPaymentDate().getTime()));
            ps.setDouble(4, payment.getAmount());
            ps.setString(5, payment.getStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }

    public FeePayment selectPayment(int paymentId) throws SQLException {
        FeePayment payment = null;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_PAYMENT_BY_ID)) {
            ps.setInt(1, paymentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    payment = extractPaymentFromResultSet(rs);
                    payment.setPaymentId(paymentId);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return payment;
    }

    public List<FeePayment> selectAllPayments() throws SQLException {
        List<FeePayment> payments = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ALL_PAYMENTS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                FeePayment payment = extractPaymentFromResultSet(rs);
                payment.setPaymentId(rs.getInt("PaymentID"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return payments;
    }

    public boolean deletePayment(int paymentId) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(DELETE_PAYMENT_SQL)) {
            ps.setInt(1, paymentId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }

    public boolean updatePayment(FeePayment payment) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(UPDATE_PAYMENT_SQL)) {
            ps.setInt(1, payment.getStudentId());
            ps.setString(2, payment.getStudentName());
            ps.setDate(3, new java.sql.Date(payment.getPaymentDate().getTime()));
            ps.setDouble(4, payment.getAmount());
            ps.setString(5, payment.getStatus());
            ps.setInt(6, payment.getPaymentId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
    }

    public List<FeePayment> selectOverduePayments() throws SQLException {
        List<FeePayment> payments = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_OVERDUE_PAYMENTS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                FeePayment payment = extractPaymentFromResultSet(rs);
                payment.setPaymentId(rs.getInt("PaymentID"));
                payments.add(payment);
            }
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return payments;
    }

    public List<FeePayment> selectUnpaidStudents(java.util.Date startDate, java.util.Date endDate) throws SQLException {
        List<FeePayment> payments = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_UNPAID_STUDENTS)) {
            ps.setDate(1, new java.sql.Date(startDate.getTime()));
            ps.setDate(2, new java.sql.Date(endDate.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FeePayment payment = extractPaymentFromResultSet(rs);
                    payment.setPaymentId(rs.getInt("PaymentID"));
                    payments.add(payment);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return payments;
    }

    public double getTotalCollections(java.util.Date startDate, java.util.Date endDate) throws SQLException {
        double total = 0;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_TOTAL_COLLECTIONS)) {
            ps.setDate(1, new java.sql.Date(startDate.getTime()));
            ps.setDate(2, new java.sql.Date(endDate.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getDouble("Total");
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        return total;
    }

    // Helper method to extract payment from ResultSet
    private FeePayment extractPaymentFromResultSet(ResultSet rs) throws SQLException {
        int studentId = rs.getInt("StudentID");
        String studentName = rs.getString("StudentName");
        Date paymentDate = rs.getDate("PaymentDate");
        double amount = rs.getDouble("Amount");
        String status = rs.getString("Status");
        return new FeePayment(studentId, studentName, paymentDate, amount, status);
    }

    // Improved error logging
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}