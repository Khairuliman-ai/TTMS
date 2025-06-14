<%-- 
    Document   : error
    Created on : 8 May 2025, 11:59:55?am
    Author     : wanmu
--%>

<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fff0f0;
            text-align: center;
            padding: 50px;
        }
        .error-box {
            background-color: #ffe6e6;
            padding: 30px;
            border: 1px solid #ff9999;
            border-radius: 10px;
            display: inline-block;
        }
        h1 {
            color: #cc0000;
        }
        p {
            color: #660000;
            font-size: 18px;
        }
        a {
            margin-top: 20px;
            display: inline-block;
            color: #0066cc;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="error-box">
        <h1>Something went wrong!</h1>
        <p><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "Unknown error." %></p>
        <a href="home.jsp">Return to Home</a>
    </div>
</body>
</html>