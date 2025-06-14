<%@ page import="java.sql.*" %>
<%@ include file="includes/header.jsp" %>

<div class="main-content">
    <div class="container py-5">
        <h2 class="text-center text-primary mb-4">Contact Us</h2>

        <div class="card shadow p-4 mx-auto" style="max-width: 600px;">
            <form method="post" action="contact.jsp">

                <div class="mb-3">
                    <label class="form-label">Name:</label>
                    <input type="text" name="name" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email:</label>
                    <input type="email" name="email" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Subject:</label>
                    <input type="text" name="subject" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">Message:</label>
                    <textarea name="message" rows="5" class="form-control" required></textarea>
                </div>

                <button type="submit" class="btn btn-primary w-100">Send Message</button>
            </form>

            <%
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String subject = request.getParameter("subject");
                String message = request.getParameter("message");

                if (name != null && email != null && message != null) {
                    Connection conn = null;
                    PreparedStatement ps = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                        String sql = "INSERT INTO contact_us (name, email, subject, message) VALUES (?, ?, ?, ?)";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, name);
                        ps.setString(2, email);
                        ps.setString(3, subject);
                        ps.setString(4, message);
                        int result = ps.executeUpdate();
                        if (result > 0) {
            %>
                            <div class="alert alert-success mt-3 text-center">Message sent successfully!</div>
            <%
                        } else {
            %>
                            <div class="alert alert-danger mt-3 text-center">Message failed to send.</div>
            <%
                        }
                    } catch (Exception e) {
            %>
                        <div class="alert alert-danger mt-3 text-center">Error: <%= e.getMessage() %></div>
            <%
                    } finally {
                        try { if (ps != null) ps.close(); } catch (Exception e) {}
                        try { if (conn != null) conn.close(); } catch (Exception e) {}
                    }
                }
            %>
        </div>
    </div>
</div>
<br><br>
<%@ include file="includes/footer.jsp" %>
