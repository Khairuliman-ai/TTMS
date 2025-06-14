<%-- 
    Document   : bookTicket
    Created on : 8 May 2025, 10:48:53 am
    Author     : wanmu
--%>


<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userId = request.getParameter("userId");
    String scheduleId = request.getParameter("scheduleId");
    String seatClass = request.getParameter("seatClass");

    if (userId != null && scheduleId != null && seatClass != null) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");

            String sql = "INSERT INTO bookings (user_id, schedule_id, seat_class, status) VALUES (?, ?, ?, 'Pending')";
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, Integer.parseInt(userId));
            ps.setInt(2, Integer.parseInt(scheduleId));
            ps.setString(3, seatClass);

            int result = ps.executeUpdate();

            if (result > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int bookingId = generatedKeys.getInt(1);
                    response.sendRedirect("payment.jsp?bookingId=" + bookingId);
                } else {
                    out.println("<p style='color:red;'>Booking successful but no ID returned.</p>");
                }
            } else {
                out.println("<p style='color:red;'>Booking failed.</p>");
            }

        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    } else {
        out.println("<p style='color:red;'>Missing form data.</p>");
    }
%>
<jsp:include page="includes/footer.jsp"/>
