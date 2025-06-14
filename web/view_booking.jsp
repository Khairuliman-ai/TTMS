<%@ page import="java.sql.*, model.User" %>
<%@ include file="includes/header.jsp" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String bookingId = request.getParameter("bookingId");
    if (bookingId == null || bookingId.isEmpty()) {
        out.println("<p style='color:red;'>Missing booking ID.</p>");
        return;
    }

    String trainName = "", departure = "", arrival = "", seatClass = "", paymentMethod = "";
    double amount = 0.0;
    int userId = 0;
    String fullName = "";
    boolean found = false;

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
         PreparedStatement ps = conn.prepareStatement(
            "SELECT b.user_id, u.full_name, b.seat_class, " +
            "       s.departure_time, s.arrival_time, t.train_name, " +
            "       p.amount, p.method " +
            "FROM bookings b " +
            "JOIN users u ON b.user_id = u.id " +
            "JOIN schedule s ON b.schedule_id = s.schedule_id " +
            "JOIN trains t ON s.train_id = t.train_id " +
            "LEFT JOIN payments p ON b.booking_id = p.booking_id " +
            "WHERE b.booking_id = ? AND b.user_id = ?"
        )
    ) {
        ps.setInt(1, Integer.parseInt(bookingId));
        ps.setInt(2, user.getId());

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                found = true;
                userId = rs.getInt("user_id");
                fullName = rs.getString("full_name");
                seatClass = rs.getString("seat_class");
                departure = rs.getString("departure_time");
                arrival = rs.getString("arrival_time");
                trainName = rs.getString("train_name");
                amount = rs.getDouble("amount");
                paymentMethod = rs.getString("method");
            }
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<div class="main-content">
    <div class="container mt-4">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white text-center">
                <h4>Booking Summary</h4>
            </div>
            <div class="card-body">
                <% if (found) { %>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">User ID:</div>
                        <div class="col-sm-8"><%= userId %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Full Name:</div>
                        <div class="col-sm-8"><%= fullName %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Train Name:</div>
                        <div class="col-sm-8"><%= trainName %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Booking ID:</div>
                        <div class="col-sm-8"><%= bookingId %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Seat Class:</div>
                        <div class="col-sm-8"><%= seatClass %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Departure:</div>
                        <div class="col-sm-8"><%= departure %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Arrival:</div>
                        <div class="col-sm-8"><%= arrival %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Payment Method:</div>
                        <div class="col-sm-8"><%= paymentMethod != null ? paymentMethod : "Unpaid" %></div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-sm-4 fw-bold">Total Paid:</div>
                        <div class="col-sm-8">RM <%= String.format("%.2f", amount) %></div>
                    </div>
                <% } else { %>
                    <div class="alert alert-danger text-center">Booking not found.</div>
                <% } %>
            </div>
        </div>
    </div>
</div>
<jsp:include page="includes/footer.jsp"/>