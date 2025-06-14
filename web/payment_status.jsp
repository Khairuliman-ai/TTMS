<%-- 
    Document   : payment_status
    Created on : 6 May 2025, 7:44:34?am
    Author     : wanmu
--%>

<%@ page import="java.sql.*, model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String bookingId = request.getParameter("bookingId");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String trainName = "", departure = "", arrival = "", seatClass = "", paymentMethod = "";
    double amount = 0;
    int userId = 0;
    String fullName = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");

        String query = "SELECT b.user_id, u.full_name, b.seat_class, s.departure_time, s.arrival_time, " +
                       "t.train_name, p.amount, p.payment_method " +
                       "FROM bookings b " +
                       "JOIN users u ON b.user_id = u.id " +  // Adjust 'u.id' if different in your DB
                       "JOIN schedule s ON b.schedule_id = s.schedule_id " +
                       "JOIN trains t ON s.train_id = t.train_id " +
                       "JOIN payments p ON b.booking_id = p.booking_id " +
                       "WHERE b.booking_id = ?";

        ps = conn.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(bookingId));
        rs = ps.executeQuery();

        if (rs.next()) {
            userId = rs.getInt("user_id");
            fullName = rs.getString("full_name");
            seatClass = rs.getString("seat_class");
            departure = rs.getString("departure_time");
            arrival = rs.getString("arrival_time");
            trainName = rs.getString("train_name");
            amount = rs.getDouble("amount");
            paymentMethod = rs.getString("payment_method");
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Status</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #eef6fa;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
        }
        .summary-container {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            width: 600px;
        }
        h2 {
            text-align: center;
            color: #003366;
            margin-bottom: 20px;
        }
        .summary-item {
            margin: 10px 0;
        }
        .summary-item strong {
            display: inline-block;
            width: 150px;
        }
    </style>
</head>
<body>
<div class="summary-container">
    <h2>Payment Confirmation</h2>
    <div class="summary-item"><strong>User ID:</strong> <%= userId %></div>
    <div class="summary-item"><strong>Full Name:</strong> <%= fullName %></div>
    <div class="summary-item"><strong>Train Name:</strong> <%= trainName %></div>
    <div class="summary-item"><strong>Ticket ID:</strong> <%= bookingId %></div>
    <div class="summary-item"><strong>Seat Class:</strong> <%= seatClass %></div>
    <div class="summary-item"><strong>Departure:</strong> <%= departure %></div>
    <div class="summary-item"><strong>Arrival:</strong> <%= arrival %></div>
    <div class="summary-item"><strong>Payment Method:</strong> <%= paymentMethod %></div>
    <div class="summary-item"><strong>Total Paid:</strong> RM<%= amount %></div>
</div>
</body>
</html>
<jsp:include page="includes/footer.jsp"/>