<%-- 
    Document   : home
    Created on : 6 May 2025, 7:43:20?am
    Author     : wanmu
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Train Ticketing System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body {
            background: linear-gradient(to right, #1e3c72, #2a5298);
            color: #fff;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .hero {
            text-align: center;
            padding: 50px;
            background: rgba(0, 0, 0, 0.4);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
        }
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 20px;
            font-weight: 700;
        }
        .hero p {
            font-size: 1.2rem;
            margin-bottom: 40px;
        }
        .btn-custom {
            margin: 10px;
            padding: 12px 30px;
            font-size: 1rem;
            border-radius: 50px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            transform: scale(1.1);
        }
    </style>
</head>
<body>

    <div class="hero">
        <h1>Train Ticketing System</h1>
        <p>Fast. Simple. Efficient. Book and manage your tickets anytime.</p>
        <div class="d-flex flex-wrap justify-content-center">
            <a href="login.jsp" class="btn btn-light btn-custom">Login</a>
            <a href="register.jsp" class="btn btn-light btn-custom">Register</a>
            <a href="schedule.jsp" class="btn btn-light btn-custom">View Schedule</a>
            <a href="contact.jsp" class="btn btn-light btn-custom">Contact Us</a>
            <a href="about.jsp" class="btn btn-light btn-custom">About</a>
        </div>
    </div>

    <!-- Bootstrap JS (optional, only if you need dynamic components) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

