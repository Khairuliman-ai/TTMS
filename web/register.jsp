<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Account</title>

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

        .register-btn {
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

        .register-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(139, 92, 246, 0.6);
        }

        .message {
            margin-top: 20px;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            font-weight: 500;
            font-size: 14px;
        }

        .error {
            background-color: #fde8e8;
            color: #d32f2f;
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
        <h1>Create Account</h1>
        <p>Fill in your details below to register.</p>

        <form method="post" action="register">
            <input type="text" name="username" placeholder="Username" required />
            <input type="password" name="password" placeholder="Password" required />
            <select name="role" required>
                <option value="">Select Role</option>
                <option value="user">User</option>
                
            </select>
            <input type="text" name="fullName" placeholder="Full Name" required />
            <input type="email" name="email" placeholder="Email" required />
            <input type="text" name="phone" placeholder="Phone Number" required />
            <button type="submit" class="register-btn">Register</button>
        </form>

        <!-- Feedback from servlet -->
        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>
    </div>

    <!-- Right image section -->
    <div class="image-section">
        <div class="image-wrapper">
            <img src="img/trainLogo1.png"  alt="Register Illustration">
        </div>
    </div>
</div>

</body>
</html>
