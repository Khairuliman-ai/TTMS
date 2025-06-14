<%@ page import="java.sql.*, model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ include file="includes/header.jsp" %>

<div class="main-content">
    <div class="container-fluid">
        <h2 class="text-center text-primary mb-4">Book a Train Ticket</h2>

        <div class="card shadow-sm p-4 bg-white rounded mx-auto" style="max-width: 700px;">
            <form method="post" action="bookTicket" onsubmit="calculateTotalQuantity()">
                <input type="hidden" name="user_id" value="<%= user.getId() %>">
                <input type="hidden" id="total_quantity" name="quantity" value="0">

                <!-- Select Schedule -->
                <div class="mb-3">
                    <label for="schedule_id" class="form-label fw-bold">Select Schedule:</label>
                    <select name="schedule_id" class="form-select" required>
                        <%
                            try (
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                                PreparedStatement ps = conn.prepareStatement("SELECT schedule_id, departure_time, arrival_time FROM schedule");
                                ResultSet rs = ps.executeQuery();
                            ) {
                                while (rs.next()) {
                                    int sid = rs.getInt("schedule_id");
                                    String dep = rs.getString("departure_time");
                                    String arr = rs.getString("arrival_time");
                        %>
                            <option value="<%= sid %>">Schedule <%= sid %> (Dep: <%= dep %>, Arr: <%= arr %>)</option>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                            <option>Error loading schedule</option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <!-- Seat Class -->
                <div class="mb-3">
                    <label for="seat_class" class="form-label fw-bold">Class:</label>
                    <select name="seat_class" class="form-select" required>
                        <option value="Economy">Economy</option>
                        <option value="Business">Business</option>
                        <option value="Premium">Premium</option>
                    </select>
                </div>

                <!-- Ticket Quantities -->
                <div class="mb-3">
                    <label class="form-label fw-bold">Ticket Quantity (Fill 0 if not applicable):</label>

                    <div class="form-group mb-2">
                        <label>Dewasa (Warganegara):</label>
                        <input type="number" name="qty_adult_malaysian" class="form-control" value="0" min="0" required>
                    </div>
                    <div class="form-group mb-2">
                        <label>Kanak-kanak (Warganegara):</label>
                        <input type="number" name="qty_child_malaysian" class="form-control" value="0" min="0" required>
                    </div>
                    <div class="form-group mb-2">
                        <label>Warga Emas (Warganegara):</label>
                        <input type="number" name="qty_senior_malaysian" class="form-control" value="0" min="0" required>
                    </div>
                    <div class="form-group mb-2">
                        <label>Dewasa (Bukan Warganegara):</label>
                        <input type="number" name="qty_adult_foreigner" class="form-control" value="0" min="0" required>
                    </div>
                    <div class="form-group mb-2">
                        <label>Kanak-kanak (Bukan Warganegara):</label>
                        <input type="number" name="qty_child_foreigner" class="form-control" value="0" min="0" required>
                    </div>
                    <div class="form-group mb-2">
                        <label>Warga Emas (Bukan Warganegara):</label>
                        <input type="number" name="qty_senior_foreigner" class="form-control" value="0" min="0" required>
                    </div>
                </div>

                <!-- Submit -->
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">Book Ticket</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function calculateTotalQuantity() {
        const names = [
            "qty_adult_malaysian",
            "qty_child_malaysian",
            "qty_senior_malaysian",
            "qty_adult_foreigner",
            "qty_child_foreigner",
            "qty_senior_foreigner"
        ];
        let total = 0;
        names.forEach(name => {
            const value = parseInt(document.getElementsByName(name)[0].value) || 0;
            total += value;
        });
        document.getElementById("total_quantity").value = total;
    }
</script>

<%@ include file="includes/footer.jsp" %>
