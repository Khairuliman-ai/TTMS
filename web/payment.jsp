<%-- 
    Document   : payment
    Created on : 6 May 2025, 7:44:16?am
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
    String trainName = "", departure = "", arrival = "", seatClass = "", amount = "--";
    int scheduleId = -1;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");

        String query = "SELECT s.schedule_id, s.departure_time, s.arrival_time, t.train_name, b.seat_class " +
                       "FROM bookings b " +
                       "JOIN schedule s ON b.schedule_id = s.schedule_id " +
                       "JOIN trains t ON s.train_id = t.train_id " +
                       "WHERE b.booking_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(bookingId));
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            scheduleId = rs.getInt("schedule_id");
            departure = rs.getString("departure_time");
            arrival = rs.getString("arrival_time");
            trainName = rs.getString("train_name");
            seatClass = rs.getString("seat_class");

            if ("Economy".equalsIgnoreCase(seatClass)) amount = "20.00";
            else if ("Business".equalsIgnoreCase(seatClass)) amount = "35.00";
            else if ("Premium".equalsIgnoreCase(seatClass)) amount = "50.00";
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading booking info: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Make Payment</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #eaf4fb;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            display: flex;
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            gap: 40px;
        }

        .form-section, .summary-section {
            flex: 1;
        }

        h2 {
            color: #004080;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 20px;
        }

        input, select, button {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        button {
            background-color: #007bff;
            color: white;
            border: none;
            font-weight: bold;
            margin-top: 25px;
        }

        .summary-box {
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            background-color: #f9f9f9;
        }

        .summary-box p {
            margin: 10px 0;
        }

        .summary-box h3 {
            border-top: 1px solid #ccc;
            margin-top: 20px;
            padding-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="form-section">
        <h2>Make a Payment</h2>
        <form method="post" action="makePayment.jsp">
            <input type="hidden" name="bookingId" value="<%= bookingId %>">
            <input type="hidden" name="scheduleId" value="<%= scheduleId %>">
            <input type="hidden" name="seatClass" value="<%= seatClass %>">

            <label for="amount">Amount (RM):</label>
            <input type="text" name="amount" placeholder="Enter amount" required>

            <label for="method">Payment Method:</label>
            <select name="method" required>
                <option value="">Select method</option>
                <option value="Credit Card">Credit Card</option>
                <option value="Online Banking">Online Banking</option>
                <option value="eWallet">eWallet</option>
            </select>

            <button type="submit">Pay Now</button>
        </form>
    </div>

    <div class="summary-section">
        <div class="summary-box">
            <p><strong>Train Name:</strong> <%= trainName %></p>
            <p><strong>Ticket ID:</strong> <%= bookingId %></p>
            <p><strong>Departure:</strong> <%= departure %></p>
            <p><strong>Arrival:</strong> <%= arrival %></p>
            <p><strong>Seat Class:</strong> <%= seatClass %></p>
            <h3>Total: RM <%= amount %></h3>
        </div>
    </div>
</div>

</body>
</html>
<jsp:include page="includes/footer.jsp"/>