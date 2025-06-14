<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/admin_header.jsp" />

<%
    String keyword = request.getParameter("keyword");
    String filter = request.getParameter("filter");

    if (keyword == null) keyword = "";
    if (filter == null) filter = "booking_id";

    keyword = keyword.trim().toLowerCase();
    String whereClause = "WHERE 1=1";

    if (!keyword.isEmpty()) {
        switch (filter) {
            case "user":
                whereClause += " AND LOWER(u.full_name) LIKE ?";
                break;
            case "train":
                whereClause += " AND LOWER(t.train_name) LIKE ?";
                break;
            case "from":
                whereClause += " AND LOWER(r.start_point) LIKE ?";
                break;
            case "to":
                whereClause += " AND LOWER(r.end_point) LIKE ?";
                break;
            case "seat_class":
                whereClause += " AND LOWER(b.seat_class) LIKE ?";
                break;
            default:
                whereClause += " AND CAST(b.booking_id AS CHAR) LIKE ?";
        }
    }
%>

<div class="container mt-5">
    <h2 class="mb-4 text-center">Ticket Booking Report</h2>

    <!-- Filter Form -->
    <form method="get" class="row mb-3">
        <div class="col-md-4">
            <input type="text" name="keyword" value="<%= keyword %>" class="form-control" placeholder="Search...">
        </div>
        <div class="col-md-3">
            <select name="filter" class="form-select">
                <option value="booking_id" <%= filter.equals("booking_id") ? "selected" : "" %>>Booking ID</option>
                <option value="user" <%= filter.equals("user") ? "selected" : "" %>>User</option>
                <option value="train" <%= filter.equals("train") ? "selected" : "" %>>Train</option>
                <option value="from" <%= filter.equals("from") ? "selected" : "" %>>From</option>
                <option value="to" <%= filter.equals("to") ? "selected" : "" %>>To</option>
                <option value="seat_class" <%= filter.equals("seat_class") ? "selected" : "" %>>Seat Class</option>
            </select>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Filter</button>
        </div>
        <div class="col-md-3 text-end">
            <a href="DownloadReportServlet" class="btn btn-danger w-100">Download PDF</a>
        </div>
    </form>

    <!-- Booking Report Table -->
    <div class="card shadow">
        <div class="card-header bg-primary text-white fw-bold">Booking Report</div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0">
                <thead class="table-dark text-center">
                    <tr>
                        <th>Booking ID</th>
                        <th>User</th>
                        <th>Train</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Seat Class</th>
                        <th>Quantity</th>
                        <th>Payment Status</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");

                        String sql = "SELECT b.booking_id, u.full_name, t.train_name, r.start_point, r.end_point, " +
                                     "b.seat_class, b.quantity " +
                                     "FROM bookings b " +
                                     "JOIN users u ON b.user_id = u.id " +
                                     "JOIN schedule s ON b.schedule_id = s.schedule_id " +
                                     "JOIN trains t ON s.train_id = t.train_id " +
                                     "JOIN routes r ON s.route_id = r.route_id " +
                                     whereClause + " ORDER BY b.booking_id DESC";

                        ps = conn.prepareStatement(sql);
                        if (!keyword.isEmpty()) {
                            ps.setString(1, "%" + keyword + "%");
                        }

                        rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                    <tr class="text-center">
                        <td><%= rs.getInt("booking_id") %></td>
                        <td><%= rs.getString("full_name") %></td>
                        <td><%= rs.getString("train_name") %></td>
                        <td><%= rs.getString("start_point") %></td>
                        <td><%= rs.getString("end_point") %></td>
                        <td><%= rs.getString("seat_class") %></td>
                        <td><%= rs.getInt("quantity") %></td>
                        <td><span class="badge bg-success">Paid</span></td>
                    </tr>
                <%
                        }
                    } catch (Exception e) {
                %>
                    <tr><td colspan="8" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
                <%
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<br><br><br><br><br><br><br><br><br><br><br><br>
<jsp:include page="includes/footer.jsp"/>