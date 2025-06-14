<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/header.jsp"/>

<div class="main-content">
    <div class="container-fluid">
        <h2 class="text-center text-primary mb-4">Train Schedule</h2>

        <div class="table-responsive shadow-sm rounded bg-white p-3">
            <table class="table table-striped table-hover align-middle text-center">
                <thead class="table-primary">
                    <tr>
                        <th>Schedule ID</th>
                        <th>Train Name</th>
                        <th>Route</th>
                        <th>Departure</th>
                        <th>Arrival</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(
                                "SELECT s.schedule_id, t.train_name, r.start_point, r.end_point, " +
                                "s.departure_time, s.arrival_time " +
                                "FROM schedule s " +
                                "JOIN trains t ON s.train_id = t.train_id " +
                                "JOIN routes r ON s.route_id = r.route_id"
                            );

                            while (rs.next()) {
                    %>
                    <tr>
                        <td><%= rs.getInt("schedule_id") %></td>
                        <td><%= rs.getString("train_name") %></td>
                        <td><%= rs.getString("start_point") %> → <%= rs.getString("end_point") %></td>
                        <td><%= rs.getString("departure_time") %></td>
                        <td><%= rs.getString("arrival_time") %></td>
                    </tr>
                    <%
                            }
                        } catch(Exception e) {
                    %>
                    <tr>
                        <td colspan="5" class="text-danger fw-bold text-center">Error: <%= e.getMessage() %></td>
                    </tr>
                    <%
                        } finally {
                            try { if (rs != null) rs.close(); } catch (Exception e) {}
                            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                            try { if (conn != null) conn.close(); } catch (Exception e) {}
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
