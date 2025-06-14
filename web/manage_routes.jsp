<%@ page import="java.sql.*" %>
<jsp:include page="includes/admin_header.jsp" />

<%
    String[] locationOptions = {
        "Kuala Lumpur", "Johor Bahru", "Butterworth", "Ipoh", "Melaka", "Alor Setar",
        "Seremban", "Kota Bharu", "Kuala Terengganu", "Kuantan", "Shah Alam", "Petaling Jaya",
        "Klang", "Georgetown", "Sungai Petani", "Kangar", "Muar", "Putrajaya", "Cyberjaya", "Taiping"
    };
%>

<div class="container mt-5">
    <h2 class="mb-4 text-center">Manage Routes</h2>

    <!-- Add New Route Form -->
    <div class="card shadow mb-5">
        <div class="card-header bg-primary text-white">Add New Route</div>
        <div class="card-body">
            <form method="post" action="manageEntity">
                <input type="hidden" name="entity" value="route">
                <input type="hidden" name="action" value="add">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <select name="start_point" class="form-select" required>
                            <option value="">From</option>
                            <% for (String loc : locationOptions) { %>
                                <option value="<%= loc %>"><%= loc %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <select name="end_point" class="form-select" required>
                            <option value="">To</option>
                            <% for (String loc : locationOptions) { %>
                                <option value="<%= loc %>"><%= loc %></option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <div class="row g-2">
                    <div class="col-md-2"><input type="number" step="0.01" name="price_adult_malaysian" class="form-control" placeholder="Adult MY" required></div>
                    <div class="col-md-2"><input type="number" step="0.01" name="price_child_malaysian" class="form-control" placeholder="Child MY" required></div>
                    <div class="col-md-2"><input type="number" step="0.01" name="price_senior_malaysian" class="form-control" placeholder="Senior MY" required></div>
                    <div class="col-md-2"><input type="number" step="0.01" name="price_adult_foreigner" class="form-control" placeholder="Adult FR" required></div>
                    <div class="col-md-2"><input type="number" step="0.01" name="price_child_foreigner" class="form-control" placeholder="Child FR" required></div>
                    <div class="col-md-2"><input type="number" step="0.01" name="price_senior_foreigner" class="form-control" placeholder="Senior FR" required></div>
                </div>

                <div class="mt-3 text-end">
                    <button type="submit" class="btn btn-success">+ Add Route</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Route List Table -->
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">Route List</div>
        <div class="card-body p-0">
            <table class="table table-bordered table-striped mb-0">
                <thead class="table-dark text-center">
                    <tr>
                        <th rowspan="2">ID</th>
                        <th rowspan="2">From</th>
                        <th rowspan="2">To</th>
                        <th colspan="3">Malaysian (RM)</th>
                        <th colspan="3">Foreigner (RM)</th>
                        <th rowspan="2">Actions</th>
                    </tr>
                    <tr>
                        <th>Adult</th><th>Child</th><th>Senior</th>
                        <th>Adult</th><th>Child</th><th>Senior</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM routes");

                            while (rs.next()) {
                                int id = rs.getInt("route_id");
                    %>
                    <tr>
                        <form method="post" action="manageEntity">
                            <input type="hidden" name="entity" value="route">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="route_id" value="<%= id %>">
                            <td><%= id %></td>
                            <td>
                                <select name="start_point" class="form-select form-select-sm" required>
                                    <% for (String loc : locationOptions) { %>
                                        <option value="<%= loc %>" <%= loc.equals(rs.getString("start_point")) ? "selected" : "" %>><%= loc %></option>
                                    <% } %>
                                </select>
                            </td>
                            <td>
                                <select name="end_point" class="form-select form-select-sm" required>
                                    <% for (String loc : locationOptions) { %>
                                        <option value="<%= loc %>" <%= loc.equals(rs.getString("end_point")) ? "selected" : "" %>><%= loc %></option>
                                    <% } %>
                                </select>
                            </td>
                            <td><input type="number" step="0.01" name="price_adult_malaysian" value="<%= rs.getDouble("price_adult_malaysian") %>" class="form-control form-control-sm"></td>
                            <td><input type="number" step="0.01" name="price_child_malaysian" value="<%= rs.getDouble("price_child_malaysian") %>" class="form-control form-control-sm"></td>
                            <td><input type="number" step="0.01" name="price_senior_malaysian" value="<%= rs.getDouble("price_senior_malaysian") %>" class="form-control form-control-sm"></td>
                            <td><input type="number" step="0.01" name="price_adult_foreigner" value="<%= rs.getDouble("price_adult_foreigner") %>" class="form-control form-control-sm"></td>
                            <td><input type="number" step="0.01" name="price_child_foreigner" value="<%= rs.getDouble("price_child_foreigner") %>" class="form-control form-control-sm"></td>
                            <td><input type="number" step="0.01" name="price_senior_foreigner" value="<%= rs.getDouble("price_senior_foreigner") %>" class="form-control form-control-sm"></td>
                            <td class="text-center">
                                <button type="submit" class="btn btn-sm btn-primary mb-1">Update</button>
                                <a href="manageEntity?entity=route&action=delete&route_id=<%= id %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure to delete?');">Delete</a>
                            </td>
                        </form>
                    </tr>
                    <%
                            }
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                    %>
                    <tr><td colspan="10" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="includes/footer.jsp"/>