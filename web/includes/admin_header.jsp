<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            height: 100vh;
            width: 240px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #343a40;
            padding-top: 20px;
            z-index: 1000;
        }

        .sidebar h2 {
            color: #fff;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #fff;
            padding: 15px 20px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #495057;
            border-left: 5px solid #0d6efd;
        }

        .main-content {
            margin-left: 240px;
            padding: 20px;
        }

        @media (max-width: 768px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }
            .main-content {
                margin-left: 0;
            }
        }
    </style>

    <!-- Bootstrap JS for modal -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>

<body>

<div class="sidebar">
    <h2>RailWay</h2>

    <a href="admin_dashboard.jsp" class="<%= request.getRequestURI().contains("admin_dashboard.jsp") ? "active" : ""%>">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>

    <a href="admin_profile.jsp" class="<%= request.getRequestURI().contains("admin_profile.jsp") ? "active" : ""%>">
        <i class="bi bi-person"></i> My Profile
    </a>

    <a href="manage_users.jsp" class="<%= request.getRequestURI().contains("manage_users.jsp") ? "active" : ""%>">
        <i class="bi bi-people-fill"></i> Manage Users
    </a>

    <a href="manage_trains.jsp" class="<%= request.getRequestURI().contains("manage_trains.jsp") ? "active" : ""%>">
        <i class="bi bi-train-front"></i> Manage Trains
    </a>

    <a href="manage_routes.jsp" class="<%= request.getRequestURI().contains("manage_routes.jsp") ? "active" : "" %>">
        <i class="bi bi-signpost-split"></i> Manage Routes
    </a>

    <a href="manage_schedule.jsp" class="<%= request.getRequestURI().contains("manage_schedule.jsp") ? "active" : "" %>">
        <i class="bi bi-calendar-event"></i> Manage Schedule
    </a>

    <a href="view_reports.jsp" class="<%= request.getRequestURI().contains("view_reports.jsp") ? "active" : "" %>">
        <i class="bi bi-bar-chart-line"></i> View Reports
    </a>

    <!-- Logout with modal confirmation -->
    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>

<div class="main-content">

<!-- Logout Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to logout from the system?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <a href="logout.jsp" class="btn btn-danger">Logout</a>
      </div>
    </div>
  </div>
</div>

