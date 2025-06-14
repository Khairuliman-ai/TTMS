<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<jsp:include page="includes/admin_header.jsp"/>

<div class="container mt-4">
    <div class="welcome-box shadow-sm p-4 mb-4 rounded bg-light">
        <h2 class="mb-3">Welcome, <%= user.getFullName() %> (Admin)!</h2>
        <p class="status mb-1">System Status: <strong class="text-success">Running Smoothly</strong></p>
        <span class="role badge bg-primary">Role: Admin</span>
    </div>

    <div class="row g-4">
        <!-- Manage Users -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm text-center">
                <div class="card-body">
                    <i class="bi bi-people-fill display-4 text-primary mb-3"></i>
                    <h5 class="card-title">Manage Users</h5>
                    <p>View, edit or delete user accounts.</p>
                    <a href="manage_users.jsp" class="btn btn-primary w-100">Manage</a>
                </div>
            </div>
        </div>

        <!-- Manage Trains -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm text-center">
                <div class="card-body">
                    <i class="bi bi-train-front display-4 text-success mb-3"></i>
                    <h5 class="card-title">Manage Trains</h5>
                    <p>Manage train records and availability.</p>
                    <a href="manage_trains.jsp" class="btn btn-success w-100">Manage</a>
                </div>
            </div>
        </div>

        <!-- Manage Routes -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm text-center">
                <div class="card-body">
                    <i class="bi bi-signpost-split display-4 text-warning mb-3"></i>
                    <h5 class="card-title">Manage Routes</h5>
                    <p>Update train routes and stations.</p>
                    <a href="manage_routes.jsp" class="btn btn-warning w-100">Manage</a>
                </div>
            </div>
        </div>

        <!-- Manage Schedule -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm text-center">
                <div class="card-body">
                    <i class="bi bi-calendar-event display-4 text-info mb-3"></i>
                    <h5 class="card-title">Manage Schedule</h5>
                    <p>Set train schedules and timings.</p>
                    <a href="manage_schedule.jsp" class="btn btn-info w-100">Manage</a>
                </div>
            </div>
        </div>

        <!-- View Reports -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm text-center">
                <div class="card-body">
                    <i class="bi bi-bar-chart-line display-4 text-dark mb-3"></i>
                    <h5 class="card-title">View Reports</h5>
                    <p>Analyze booking and performance reports.</p>
                    <a href="view_reports.jsp" class="btn btn-dark w-100">View</a>
                </div>
            </div>
        </div>

        <!-- Logout -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm text-center">
                <div class="card-body">
                    <i class="bi bi-box-arrow-right display-4 text-danger mb-3"></i>
                    <h5 class="card-title">Logout</h5>
                    <p>End your admin session safely.</p>
                    <a href="logout.jsp" class="btn btn-danger w-100">Logout</a>
                </div>
            </div>
        </div>
    </div>
</div>
<br><br><br><br><br><br><br>
<jsp:include page="includes/footer.jsp"/>
