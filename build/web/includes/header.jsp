<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>RailWay</title>

    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Bootstrap Icons CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- External CSS -->
    <link rel="stylesheet" href="css/custom.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .sidebar {
            height: 100vh;
            width: 220px;
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
            color: #fff;
            padding: 15px 20px;
            text-decoration: none;
            font-weight: 500;
            transition: 0.3s;
        }

        .sidebar a i {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #495057;
            border-left: 5px solid #0d6efd;
        }

        .main-content {
            margin-left: 220px;
            padding: 20px;
        }

        /* Responsive */
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
</head>

<body>

<div class="sidebar">
    <h2>RailWay</h2>

    <a href="dashboard.jsp" class="<%= request.getRequestURI().contains("dashboard.jsp") ? "active" : "" %>">
        <i class="bi bi-speedometer2"></i> Dashboard
    </a>
        
    <a href="profile.jsp" class="<%= request.getRequestURI().contains("profile.jsp") ? "active" : ""%>">
        <i class="bi bi-person-circle"></i> My Profile
    </a>

    <a href="schedule.jsp" class="<%= request.getRequestURI().contains("schedule.jsp") ? "active" : "" %>">
        <i class="bi bi-calendar3"></i> Schedule
    </a>

    <a href="book_ticket.jsp" class="<%= request.getRequestURI().contains("book_ticket.jsp") ? "active" : "" %>">
        <i class="bi bi-ticket-perforated-fill"></i> Tickets & Prices
    </a>

    <a href="promotion.jsp" class="<%= request.getRequestURI().contains("promotion.jsp") ? "active" : "" %>">
        <i class="bi bi-megaphone-fill"></i> Promotion
    </a>
        
    <a href="my_bookings.jsp" class="<%= request.getRequestURI().contains("my_bookings.jsp") ? "active" : ""%>">
        <i class="bi bi-folder2-open"></i> My Bookings
    </a>

    <a href="contact.jsp" class="<%= request.getRequestURI().contains("contact.jsp") ? "active" : "" %>">
        <i class="bi bi-envelope-fill"></i> Customer Support
    </a>

    <!-- Logout with modal -->
    <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal">
        <i class="bi bi-box-arrow-right"></i> Logout
    </a>
</div>

<div class="main-content">

<!-- Logout Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="logoutModalLabel">Confirm Logout</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to logout?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <a href="logout.jsp" class="btn btn-danger">Logout</a>
      </div>
    </div>
  </div>
</div>
