<%@ page import="java.sql.*, model.User" %>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

String bookingId = request.getParameter("bookingId");
if (bookingId == null || bookingId.isEmpty()) {
    out.println("<p style='color:red;'>Booking ID is missing!</p>");
    return;
}

String trainName = "", seatClass = "", depTime = "", arrTime = "", start = "", end = "";
int qtyAdultMY = 0, qtyChildMY = 0, qtySeniorMY = 0;
int qtyAdultFR = 0, qtyChildFR = 0, qtySeniorFR = 0;
double multiplier = 1.0;
double fareAdultMY = 0, fareChildMY = 0, fareSeniorMY = 0;
double fareAdultFR = 0, fareChildFR = 0, fareSeniorFR = 0;

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
    String query = "SELECT t.train_name, s.departure_time, s.arrival_time, r.start_point, r.end_point, b.seat_class, " +
                   "b.qty_adult_malaysian, b.qty_child_malaysian, b.qty_senior_malaysian, " +
                   "b.qty_adult_foreigner, b.qty_child_foreigner, b.qty_senior_foreigner, " +
                   "r.price_adult_malaysian, r.price_child_malaysian, r.price_senior_malaysian, " +
                   "r.price_adult_foreigner, r.price_child_foreigner, r.price_senior_foreigner " +
                   "FROM bookings b " +
                   "JOIN schedule s ON b.schedule_id = s.schedule_id " +
                   "JOIN trains t ON s.train_id = t.train_id " +
                   "JOIN routes r ON s.route_id = r.route_id " +
                   "WHERE b.booking_id = ?";
    PreparedStatement ps = conn.prepareStatement(query);
    ps.setInt(1, Integer.parseInt(bookingId));
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        trainName = rs.getString("train_name");
        depTime = rs.getString("departure_time");
        arrTime = rs.getString("arrival_time");
        start = rs.getString("start_point");
        end = rs.getString("end_point");
        seatClass = rs.getString("seat_class");

        qtyAdultMY = rs.getInt("qty_adult_malaysian");
        qtyChildMY = rs.getInt("qty_child_malaysian");
        qtySeniorMY = rs.getInt("qty_senior_malaysian");
        qtyAdultFR = rs.getInt("qty_adult_foreigner");
        qtyChildFR = rs.getInt("qty_child_foreigner");
        qtySeniorFR = rs.getInt("qty_senior_foreigner");

        fareAdultMY = rs.getDouble("price_adult_malaysian");
        fareChildMY = rs.getDouble("price_child_malaysian");
        fareSeniorMY = rs.getDouble("price_senior_malaysian");
        fareAdultFR = rs.getDouble("price_adult_foreigner");
        fareChildFR = rs.getDouble("price_child_foreigner");
        fareSeniorFR = rs.getDouble("price_senior_foreigner");

        // Multiplier based on seat class
        if ("Business".equalsIgnoreCase(seatClass)) multiplier = 1.5;
        else if ("Premium".equalsIgnoreCase(seatClass)) multiplier = 2.0;
    }

    rs.close();
    ps.close();
    conn.close();
} catch (Exception e) {
    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    return;
}

// Final calculation
double totalAdultMY = qtyAdultMY * fareAdultMY * multiplier;
double totalChildMY = qtyChildMY * fareChildMY * multiplier;
double totalSeniorMY = qtySeniorMY * fareSeniorMY * multiplier;
double totalAdultFR = qtyAdultFR * fareAdultFR * multiplier;
double totalChildFR = qtyChildFR * fareChildFR * multiplier;
double totalSeniorFR = qtySeniorFR * fareSeniorFR * multiplier;

double total = totalAdultMY + totalChildMY + totalSeniorMY + totalAdultFR + totalChildFR + totalSeniorFR;
%>

<jsp:include page="includes/header.jsp" />

<div class="main-content">
    <div class="container my-5">
        <h2 class="mb-4 text-primary fw-bold text-center">Checkout</h2>

        <div class="row g-5">
            <!-- Contact & Payment Section -->
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h4 class="text-secondary mb-3">Contact Details</h4>
                        <p><strong>Name:</strong> <%= user.getFullName() %></p>
                        <p><strong>Username:</strong> <%= user.getUsername() %></p>

                        <hr>

                        <h4 class="text-secondary mb-3">Payment Method</h4>
                        <form method="post" action="makePayment">
                            <input type="hidden" name="bookingId" value="<%= bookingId %>">
                            <input type="hidden" name="amount" value="<%= total %>">

                            <div class="mb-3">
                                <label for="method" class="form-label fw-semibold">Select Payment Method:</label>
                                <select class="form-select" id="method" name="method" required>
                                    <option value="">-- Select --</option>
                                    <option value="Credit Card">Credit / Debit Card</option>
                                    <option value="Online Banking">Online Banking</option>
                                    <option value="Digital Wallet">Digital Wallet</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Pay Now</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Ticket Summary Section -->
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h4 class="text-secondary mb-3">Ticket Summary</h4>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>Train:</strong> <%= trainName %></li>
                            <li class="list-group-item"><strong>Route:</strong> <%= start %> ---> <%= end %></li>
                            <li class="list-group-item"><strong>Departure:</strong> <%= depTime %></li>
                            <li class="list-group-item"><strong>Arrival:</strong> <%= arrTime %></li>
                            <li class="list-group-item"><strong>Class:</strong> <%= seatClass %> (x<%= multiplier %>)</li>

                            <li class="list-group-item"><strong>Dewasa (MY):</strong> <%= qtyAdultMY %> x RM<%= fareAdultMY %></li>
                            <li class="list-group-item"><strong>Kanak-kanak (MY):</strong> <%= qtyChildMY %> x RM<%= fareChildMY %></li>
                            <li class="list-group-item"><strong>Warga Emas (MY):</strong> <%= qtySeniorMY %> x RM<%= fareSeniorMY %></li>

                            <li class="list-group-item"><strong>Dewasa (Non-MY):</strong> <%= qtyAdultFR %> x RM<%= fareAdultFR %></li>
                            <li class="list-group-item"><strong>Kanak-kanak (Non-MY):</strong> <%= qtyChildFR %> x RM<%= fareChildFR %></li>
                            <li class="list-group-item"><strong>Warga Emas (Non-MY):</strong> <%= qtySeniorFR %> x RM<%= fareSeniorFR %></li>

                            <li class="list-group-item fw-bold text-primary"><strong>Total (after class multiplier):</strong> RM<%= String.format("%.2f", total) %></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-4 text-center">
            <a href="book_ticket.jsp" class="btn btn-outline-secondary"><i class="bi bi-arrow-left"></i> Back to Booking</a>
        </div>
    </div>
</div>
<jsp:include page="includes/footer.jsp"/>
