<%@ page import="java.sql.*" %>
<jsp:include page="includes/admin_header.jsp" />

<div class="container mt-5">
    <h2 class="mb-4 text-center">Manage Users</h2>

    <!-- Add New User Form -->
    <div class="card shadow mb-4 rounded-3">
        <div class="card-header bg-primary text-white fw-bold">
            Add New User
        </div>
        <div class="card-body">
            <form method="post" action="ManageEntityServlet">
                <input type="hidden" name="action" value="insert">
                <input type="hidden" name="entity" value="user">

                <div class="row mb-3">
                    <div class="col-md-2">
                        <input type="text" name="username" class="form-control" placeholder="Username" required>
                    </div>
                    <div class="col-md-2">
                        <input type="password" name="password" class="form-control" placeholder="Password" required>
                    </div>
                    <div class="col-md-2">
                        <input type="email" name="email" class="form-control" placeholder="Email" required>
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="full_name" class="form-control" placeholder="Full Name">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="phone" class="form-control" placeholder="Phone" required>
                    </div>
                    <div class="col-md-1">
                        <select name="role" class="form-select" required>
                            <option value="user">User</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="col-md-1">
                        <button type="submit" class="btn btn-success w-100">Add</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Search & Filter -->
    <div class="row mb-3">
        <div class="col-md-3">
            <select id="filterType" class="form-select">
                <option value="id">Search by ID</option>
                <option value="username">Search by Username</option>
            </select>
        </div>
        <div class="col-md-9">
            <input type="text" id="userSearch" class="form-control" placeholder="Type to search..." onkeyup="filterUsers()">
        </div>
    </div>

    <!-- User Table -->
    <div class="card shadow">
        <div class="card-header bg-secondary text-white fw-bold">
            User List
        </div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0" id="userTable">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Full Name</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM users");
                        while(rs.next()) {
                %>
                    <tr>
                        <form method="post" action="ManageEntityServlet">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="entity" value="user">
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                            <td><%= rs.getInt("id") %></td>
                            <td><input type="text" name="username" value="<%= rs.getString("username") %>" class="form-control" required></td>
                            <td><input type="email" name="email" value="<%= rs.getString("email") %>" class="form-control"></td>
                            <td><input type="text" name="full_name" value="<%= rs.getString("full_name") %>" class="form-control"></td>
                            <td><input type="text" name="phone" value="<%= rs.getString("phone") %>" class="form-control" required></td>
                            <td>
                                <select name="role" class="form-select" required>
                                    <option value="user" <%= rs.getString("role").equals("user") ? "selected" : "" %>>User</option>
                                    <option value="admin" <%= rs.getString("role").equals("admin") ? "selected" : "" %>>Admin</option>
                                </select>
                            </td>
                            <td class="d-flex justify-content-center gap-1">
                                <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                <a href="ManageEntityServlet?action=delete&entity=user&id=<%= rs.getInt("id") %>"
                                   onclick="return confirm('Are you sure you want to delete this user?');"
                                   class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </form>
                    </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch(Exception e) {
                %>
                    <tr><td colspan='7' class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Filter Script -->
<script>
function filterUsers() {
    const filterType = document.getElementById("filterType").value;
    const filterText = document.getElementById("userSearch").value.toLowerCase();
    const table = document.getElementById("userTable");
    const rows = table.getElementsByTagName("tr");

    for (let i = 1; i < rows.length; i++) {
        const row = rows[i];
        const cells = row.getElementsByTagName("td");

        if (cells.length > 1) {
            let match = false;

            if (filterType === "id") {
                const id = cells[0].innerText.toLowerCase();
                match = id.includes(filterText);
            } else if (filterType === "username") {
                const usernameInput = cells[1].querySelector("input");
                const username = usernameInput ? usernameInput.value.toLowerCase() : "";
                match = username.includes(filterText);
            }

            row.style.display = match ? "" : "none";
        }
    }
}
</script>
<jsp:include page="includes/footer.jsp"/>