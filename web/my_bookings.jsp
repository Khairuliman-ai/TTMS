<%-- 
    Document   : my_booking
    Created on : 13 Jun 2025, 11:04:43?pm
    Author     : wanmu
--%>

<%@ page import="java.sql.*, model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<jsp:include page="includes/header.jsp" />

<div class="container my-5">
    <h2 class="mb-4 text-primary fw-bold text-center">My Bookings</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Train</th>
                <th>Route</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Class</th>
                <th>Tickets</th>
                <th>Status</th>
                <th>Booked At</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                String sql = "SELECT b.booking_id, b.seat_class, b.quantity, b.status, b.booking_time, " +
                             "t.train_name, r.start_point, r.end_point, s.departure_time, s.arrival_time " +
                             "FROM bookings b " +
                             "JOIN schedule s ON b.schedule_id = s.schedule_id " +
                             "JOIN trains t ON s.train_id = t.train_id " +
                             "JOIN routes r ON s.route_id = r.route_id " +
                             "WHERE b.user_id = ? " +
                             "ORDER BY b.booking_time DESC";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, user.getId());
                ResultSet rs = ps.executeQuery();
                int count = 1;
                while (rs.next()) {
        %>
            <tr>
                <td><%= count++ %></td>
                <td><%= rs.getString("train_name") %></td>
                <td><%= rs.getString("start_point") %> ? <%= rs.getString("end_point") %></td>
                <td><%= rs.getString("departure_time") %></td>
                <td><%= rs.getString("arrival_time") %></td>
                <td><%= rs.getString("seat_class") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><span class="badge bg-info text-dark"><%= rs.getString("status") %></span></td>
                <td><%= rs.getString("booking_time") %></td>
            </tr>
        <%
                }
                rs.close();
                ps.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='9' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="includes/footer.jsp"/>