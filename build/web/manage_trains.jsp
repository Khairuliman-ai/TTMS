<%@ page import="java.sql.*" %>
<jsp:include page="includes/admin_header.jsp" />

<div class="container mt-5">
    <h2 class="mb-4 text-center">Manage Trains</h2>

    <!-- Add New Train Form -->
    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white">
            Add New Train
        </div>
        <div class="card-body">
            <form method="post" action="ManageEntityServlet">
                <input type="hidden" name="entity" value="train">
                <input type="hidden" name="action" value="add">

                <div class="row">
                    <div class="col-md-10">
                        <input type="text" name="train_name" class="form-control" placeholder="Enter train name" required>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-success w-100">+ Add Train</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Search and Filter -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="input-group w-50">
            <span class="input-group-text">Search</span>
            <input type="text" id="searchInput" class="form-control" placeholder="Type to search..." onkeyup="filterTable()">
        </div>
        <div>
            <select id="filterType" class="form-select w-auto" onchange="filterTable()">
                <option value="0">By Train ID</option>
                <option value="1">By Train Name</option>
            </select>
        </div>
    </div>

    <!-- Train List Table -->
    <div class="card shadow">
        <div class="card-header bg-secondary text-white">
            Train List
        </div>
        <div class="card-body p-0">
            <table class="table table-striped mb-0" id="trainTable">
                <thead class="table-dark">
                    <tr>
                        <th>Train ID</th>
                        <th>Train Name</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM trains");

                        while (rs.next()) {
                            int trainId = rs.getInt("train_id");
                            String trainName = rs.getString("train_name");
                %>
                    <tr>
                        <form method="post" action="ManageEntityServlet">
                            <input type="hidden" name="entity" value="train">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="train_id" value="<%= trainId %>">
                            <td><%= trainId %></td>
                            <td><input type="text" name="train_name" value="<%= trainName %>" class="form-control" required></td>
                            <td class="d-flex justify-content-center gap-1">
                                <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                <button type="button" class="btn btn-danger btn-sm" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal<%= trainId %>">Delete</button>

                                <!-- Bootstrap Modal for Delete -->
                                <div class="modal fade" id="confirmDeleteModal<%= trainId %>" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
                                  <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                      <div class="modal-header bg-danger text-white">
                                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                      </div>
                                      <div class="modal-body">
                                        Are you sure you want to delete this train?
                                      </div>
                                      <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                        <a href="ManageEntityServlet?entity=train&action=delete&train_id=<%= trainId %>" class="btn btn-danger">Delete</a>
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
                    } catch (Exception e) {
                %>
                    <tr><td colspan="3" class="text-danger text-center">Error: <%= e.getMessage() %></td></tr>
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

<!-- Search Filter Script -->
<script>
function filterTable() {
    var input = document.getElementById("searchInput").value.toLowerCase();
    var filterIndex = parseInt(document.getElementById("filterType").value);
    var table = document.getElementById("trainTable");
    var trs = table.getElementsByTagName("tr");

    for (var i = 1; i < trs.length; i++) {
        var cells = trs[i].getElementsByTagName("td");
        if (cells.length > filterIndex) {
            let cellContent = cells[filterIndex].querySelector('input') 
                            ? cells[filterIndex].querySelector('input').value.toLowerCase()
                            : cells[filterIndex].innerText.toLowerCase();
            trs[i].style.display = cellContent.includes(input) ? "" : "none";
        }
    }
}
</script>
<jsp:include page="includes/footer.jsp"/>
