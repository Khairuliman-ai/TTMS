<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="util.DBUtil" %>
<%@ page session="true" %>

<jsp:include page="includes/header.jsp" />

<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String fullName = "", email = "", phone = "", password = "";
    Boolean success = (Boolean) request.getAttribute("success");
    String message = (String) request.getAttribute("message");

    try (Connection con = DBUtil.getConnection()) {
        String sql = "SELECT * FROM users WHERE username = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            fullName = rs.getString("full_name");
            email = rs.getString("email");
            phone = rs.getString("phone");
            password = rs.getString("password");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="main-content">
    <div class="container my-4">
        <h2 class="text-center text-primary mb-4">My Profile</h2>

        <% if (success != null && success) { %>
            <div class="alert alert-success text-center" role="alert">
                 Profile updated successfully! Redirecting to dashboard...
            </div>
            <meta http-equiv="refresh" content="3; URL=dashboard.jsp">
        <% } else if (message != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                <%= message %>
            </div>
        <% } %>

        <div class="card shadow-sm rounded p-4">
            <form action="UpdateProfileServlet" method="post">
                <input type="hidden" name="username" value="<%= username %>">
                <input type="hidden" name="origin" value="user">

                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" class="form-control" name="fullname" value="<%= fullName %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" value="<%= email %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Phone</label>
                    <input type="text" class="form-control" name="phone" value="<%= phone %>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" class="form-control" name="password" value="<%= password %>" required>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg">Update Profile</button>
                </div>
            </form>
        </div>
    </div>
</div>
<br><br><br><br><br><br><br><br>
<jsp:include page="includes/footer.jsp"/>
