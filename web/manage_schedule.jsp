<%@ page import="java.sql.*" %>
<jsp:include page="includes/admin_header.jsp" />

<div class="container mt-5">
    <h2 class="mb-4 text-center">Manage Train Schedules</h2>

    <!-- Add New Schedule Form -->
    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white fw-bold">Add New Schedule</div>
        <div class="card-body">
            <form method="post" action="ManageEntityServlet">
                <input type="hidden" name="entity" value="schedule">
                <input type="hidden" name="action" value="add">
                <div class="row">
                    <div class="col-md-3 mb-2">
                        <select name="train_id" class="form-select" required>
                            <option value="">Select Train</option>
                            <%
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet trainRs = stmt.executeQuery("SELECT train_id, train_name FROM trains");
                                    while (trainRs.next()) {
                            %>
                            <option value="<%= trainRs.getInt("train_id") %>">
                                <%= trainRs.getInt("train_id") %> - <%= trainRs.getString("train_name") %>
                            </option>
                            <%
                                    }
                                    trainRs.close(); stmt.close(); conn.close();
                                } catch(Exception e) {
                            %>
                            <option disabled>Error loading trains</option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-md-3 mb-2">
                        <select name="route_id" class="form-select" required>
                            <option value="">Select Route</option>
                            <%
                                try {
                                    Class.forName("com.mysql.jdbc.Driver");
                                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                                    Statement stmt = conn.createStatement();
                                    ResultSet routeRs = stmt.executeQuery("SELECT route_id, start_point, end_point FROM routes");
                                    while (routeRs.next()) {
                            %>
                            <option value="<%= routeRs.getInt("route_id") %>">
                                <%= routeRs.getInt("route_id") %> - <%= routeRs.getString("start_point") %> ? <%= routeRs.getString("end_point") %>
                            </option>
                            <%
                                    }
                                    routeRs.close(); stmt.close(); conn.close();
                                } catch(Exception e) {
                            %>
                            <option disabled>Error loading routes</option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-md-3 mb-2">
                        <input type="time" name="departure_time" class="form-control" required>
                    </div>
                    <div class="col-md-3 mb-2">
                        <input type="time" name="arrival_time" class="form-control" required>
                    </div>
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-success w-100">+ Add Schedule</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Filter Inputs -->
    <div class="mb-3 d-flex justify-content-end gap-2">
        <input type="text" id="searchInput" onkeyup="filterTable()" class="form-control w-25" placeholder="Search">
        <select id="filterType" class="form-select w-25" onchange="filterTable()">
            <option value="0">Schedule ID</option>
            <option value="1">Train ID</option>
            <option value="2">Route ID</option>
        </select>
    </div>

    <!-- Schedule List Table -->
    <div class="card shadow">
        <div class="card-header bg-secondary text-white fw-bold">Schedule List</div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0" id="scheduleTable">
                <thead class="table-dark">
                    <tr>
                        <th>Schedule ID</th>
                        <th>Train ID</th>
                        <th>Route ID</th>
                        <th>Departure Time</th>
                        <th>Arrival Time</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM schedule");

                        while (rs.next()) {
                            int scheduleId = rs.getInt("schedule_id");
                            int trainId = rs.getInt("train_id");
                            int routeId = rs.getInt("route_id");
                            String dep = rs.getString("departure_time");
                            String arr = rs.getString("arrival_time");
                %>
                    <tr>
                        <form method="post" action="ManageEntityServlet">
                            <input type="hidden" name="entity" value="schedule">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="schedule_id" value="<%= scheduleId %>">
                            <td><%= scheduleId %></td>
                            <td><input type="number" name="train_id" value="<%= trainId %>" class="form-control" required></td>
                            <td><input type="number" name="route_id" value="<%= routeId %>" class="form-control" required></td>
                            <td><input type="time" name="departure_time" value="<%= dep %>" class="form-control" required></td>
                            <td><input type="time" name="arrival_time" value="<%= arr %>" class="form-control" required></td>
                            <td class="d-flex justify-content-center gap-1">
                                <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal<%= scheduleId %>">Delete</button>

                                <!-- Delete Modal -->
                                <div class="modal fade" id="confirmDeleteModal<%= scheduleId %>" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header bg-danger text-white">
                                                <h5 class="modal-title">Confirm Delete</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <div class="modal-body">Are you sure you want to delete this schedule?</div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                <a href="ManageEntityServlet?entity=schedule&action=delete&schedule_id=<%= scheduleId %>" class="btn btn-danger">Delete</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </form>
                    </tr>
                <%
                        }
                        rs.close(); stmt.close(); conn.close();
                    } catch(Exception e) {
                %>
                    <tr><td colspan="6" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Table Filtering Script -->
<script>
function filterTable() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    const filterIndex = parseInt(document.getElementById("filterType").value);
    const table = document.getElementById("scheduleTable");
    const rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        const cols = rows[i].getElementsByTagName("td");
        if (cols.length > filterIndex) {
            const content = cols[filterIndex].innerText.toLowerCase();
            rows[i].style.display = content.includes(input) ? "" : "none";
        }
    }
}
</script>

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="includes/footer.jsp"/>