<%-- 
    Document   : makePayment
    Created on : 8 May 2025, 10:49:15?am
    Author     : wanmu
--%>

<%@ page import="java.sql.*" %>
<%
    String bookingIdStr = request.getParameter("bookingId");
    String amountStr = request.getParameter("amount");
    String method = request.getParameter("method");

    if (bookingIdStr == null || amountStr == null || method == null) {
        out.println("<p style='color:red;'>Missing payment info.</p>");
        return;
    }

    try {
        int bookingId = Integer.parseInt(bookingIdStr);
        double amount = Double.parseDouble(amountStr);

        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
        PreparedStatement ps = conn.prepareStatement("INSERT INTO payments (booking_id, amount, payment_method) VALUES (?, ?, ?)");
        ps.setInt(1, bookingId);
        ps.setDouble(2, amount);
        ps.setString(3, method);

        int result = ps.executeUpdate();
        if (result > 0) {
            response.sendRedirect("payment_status.jsp?bookingId=" + bookingId);
        } else {
            out.println("<p style='color:red;'>Payment failed.</p>");
        }

        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
<jsp:include page="includes/footer.jsp"/>