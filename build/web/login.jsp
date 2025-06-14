<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - RailSync</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: #ece9f9;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            display: flex;
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            max-width: 1000px;
            width: 100%;
            transition: 0.3s;
        }

        .form-section {
            flex: 1;
            padding: 60px 50px;
        }

        .form-section h1 {
            font-size: 28px;
            font-weight: 700;
            text-align: center;
            margin-bottom: 10px;
        }

        .form-section p {
            font-size: 13px;
            color: #999;
            text-align: center;
            margin-bottom: 30px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        input, select {
            padding: 14px 16px;
            border-radius: 12px;
            border: none;
            background: #f3f3f3;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus, select:focus {
            outline: none;
            background: #ececec;
        }

        .login-btn {
            padding: 14px 0;
            border: none;
            border-radius: 12px;
            background: linear-gradient(135deg, #6b4ce6, #8854e0);
            color: white;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(139, 92, 246, 0.4);
        }

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(139, 92, 246, 0.6);
        }

        .divider {
            margin: 30px 0;
            position: relative;
            text-align: center;
        }


        .divider::before {
            content: "";
            position: absolute;
            top: 50%;
            width: 100%;
            height: 1px;
            background: #ddd;
            left: 0;
            z-index: 0;
        }

        .social-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            padding: 12px 0;
            border-radius: 12px;
            border: 1px solid #ddd;
            margin-bottom: 15px;
            cursor: pointer;
            background: white;
            transition: 0.3s;
            font-weight: 500;
            font-size: 15px;
        }

        .social-btn:hover {
            background: #f9f9f9;
            transform: translateY(-2px);
        }

        .social-btn img {
            width: 20px;
        }

        .error-message {
            color: #d32f2f;
            font-size: 14px;
            text-align: center;
            margin: 15px 0;
            padding: 10px;
            background-color: #fde8e8;
            border-radius: 8px;
        }

        .image-section {
            flex: 1;
            background: linear-gradient(135deg, #8854e0, #6b4ce6);
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            padding: 40px;
        }

        .image-wrapper {
            background: white;
            border-radius: 25px;
            padding: 20px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
            overflow: hidden;
        }

        .image-wrapper img {
            width: 100%;
            max-width: 300px;
            border-radius: 20px;
        }

        @media(max-width: 768px) {
            .container {
                flex-direction: column;
            }
            .form-section {
                padding: 40px 30px;
            }
            .image-section {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<div class="container">
    <!-- Left form section -->
    <div class="form-section">
        <h1>LOGIN</h1>
        <p>RAILWAY l Train Ticket Management System</p>

        <form id="login-form" action="login" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <select name="role" required>
                <option value="admin">Admin</option>
                <option value="user">Customer</option>
            </select>
            <button type="submit" class="login-btn">Login Now</button>
            
                <!-- Registration link -->
    <div style="text-align: center; margin-top: 15px;">
        <span style="font-size: 14px; color: #666;">Don't have an account?</span>
        <a href="register.jsp" style="color: #6b4ce6; font-weight: 500; text-decoration: none;">Register here</a>
    </div>
            
        </form>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <div class="divider"></div>

    </div>

    <!-- Right image section -->
    <div class="image-section">
        <div class="image-wrapper">
            <img src="img/trainLogo1.png" alt="Login Illustration">
        </div>
    </div>
</div>

</body>
</html>
