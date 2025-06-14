/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/manageEntity")
public class ManageEntityServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String entity = request.getParameter("entity");
        String action = request.getParameter("action");

        if (entity == null || action == null) {
            response.sendRedirect("error.jsp?msg=" + URLEncoder.encode("Missing entity or action", "UTF-8"));
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "")) {

                switch (entity) {
                    case "train":
                        handleTrain(action, request, conn);
                        response.sendRedirect("manage_trains.jsp");
                        break;

                    case "route":
                        handleRoute(action, request, conn);
                        response.sendRedirect("manage_routes.jsp");
                        break;

                    case "schedule":
                        handleSchedule(action, request, conn);
                        response.sendRedirect("manage_schedule.jsp");
                        break;

                    case "user":
                        handleUser(action, request, conn);
                        response.sendRedirect("manage_users.jsp");
                        break;

                    default:
                        response.sendRedirect("error.jsp?msg=" + URLEncoder.encode("Unknown entity", "UTF-8"));
                        break;
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
            String msg;
            if (e.getMessage().toLowerCase().contains("foreign key constraint fails")) {
                msg = "Cannot delete this record because it is linked to other data (e.g. bookings).";
            } else {
                msg = e.getMessage();
            }
            String safeMessage = URLEncoder.encode(msg, "UTF-8");
            response.sendRedirect("error.jsp?msg=" + safeMessage);
        }
    }

    private void handleTrain(String action, HttpServletRequest request, Connection conn) throws SQLException {
        if ("add".equals(action)) {
            String name = request.getParameter("train_name");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO trains (train_name) VALUES (?)");
            ps.setString(1, name);
            ps.executeUpdate();

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("train_id"));
            String name = request.getParameter("train_name");
            PreparedStatement ps = conn.prepareStatement("UPDATE trains SET train_name=? WHERE train_id=?");
            ps.setString(1, name);
            ps.setInt(2, id);
            ps.executeUpdate();

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("train_id"));
            PreparedStatement ps = conn.prepareStatement("DELETE FROM trains WHERE train_id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private void handleRoute(String action, HttpServletRequest request, Connection conn) throws SQLException {
        if ("add".equals(action)) {
            String start = request.getParameter("start_point");
            String end = request.getParameter("end_point");

            double priceAdultMY = Double.parseDouble(request.getParameter("price_adult_malaysian"));
            double priceChildMY = Double.parseDouble(request.getParameter("price_child_malaysian"));
            double priceSeniorMY = Double.parseDouble(request.getParameter("price_senior_malaysian"));
            double priceAdultFR = Double.parseDouble(request.getParameter("price_adult_foreigner"));
            double priceChildFR = Double.parseDouble(request.getParameter("price_child_foreigner"));
            double priceSeniorFR = Double.parseDouble(request.getParameter("price_senior_foreigner"));

            String sql = "INSERT INTO routes (start_point, end_point, price_adult_malaysian, price_child_malaysian, price_senior_malaysian, price_adult_foreigner, price_child_foreigner, price_senior_foreigner) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, start);
            ps.setString(2, end);
            ps.setDouble(3, priceAdultMY);
            ps.setDouble(4, priceChildMY);
            ps.setDouble(5, priceSeniorMY);
            ps.setDouble(6, priceAdultFR);
            ps.setDouble(7, priceChildFR);
            ps.setDouble(8, priceSeniorFR);
            ps.executeUpdate();

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("route_id"));
            String start = request.getParameter("start_point");
            String end = request.getParameter("end_point");

            double priceAdultMY = Double.parseDouble(request.getParameter("price_adult_malaysian"));
            double priceChildMY = Double.parseDouble(request.getParameter("price_child_malaysian"));
            double priceSeniorMY = Double.parseDouble(request.getParameter("price_senior_malaysian"));
            double priceAdultFR = Double.parseDouble(request.getParameter("price_adult_foreigner"));
            double priceChildFR = Double.parseDouble(request.getParameter("price_child_foreigner"));
            double priceSeniorFR = Double.parseDouble(request.getParameter("price_senior_foreigner"));

            String sql = "UPDATE routes SET start_point=?, end_point=?, price_adult_malaysian=?, price_child_malaysian=?, price_senior_malaysian=?, price_adult_foreigner=?, price_child_foreigner=?, price_senior_foreigner=? WHERE route_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, start);
            ps.setString(2, end);
            ps.setDouble(3, priceAdultMY);
            ps.setDouble(4, priceChildMY);
            ps.setDouble(5, priceSeniorMY);
            ps.setDouble(6, priceAdultFR);
            ps.setDouble(7, priceChildFR);
            ps.setDouble(8, priceSeniorFR);
            ps.setInt(9, id);
            ps.executeUpdate();

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("route_id"));
            PreparedStatement ps = conn.prepareStatement("DELETE FROM routes WHERE route_id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }


    private void handleSchedule(String action, HttpServletRequest request, Connection conn) throws SQLException {
        if ("add".equals(action)) {
            int trainId = Integer.parseInt(request.getParameter("train_id"));
            int routeId = Integer.parseInt(request.getParameter("route_id"));
            String dep = request.getParameter("departure_time");
            String arr = request.getParameter("arrival_time");
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO schedule (train_id, route_id, departure_time, arrival_time) VALUES (?, ?, ?, ?)"
            );
            ps.setInt(1, trainId);
            ps.setInt(2, routeId);
            ps.setString(3, dep);
            ps.setString(4, arr);
            ps.executeUpdate();

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("schedule_id"));
            int trainId = Integer.parseInt(request.getParameter("train_id"));
            int routeId = Integer.parseInt(request.getParameter("route_id"));
            String dep = request.getParameter("departure_time");
            String arr = request.getParameter("arrival_time");
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE schedule SET train_id=?, route_id=?, departure_time=?, arrival_time=? WHERE schedule_id=?"
            );
            ps.setInt(1, trainId);
            ps.setInt(2, routeId);
            ps.setString(3, dep);
            ps.setString(4, arr);
            ps.setInt(5, id);
            ps.executeUpdate();

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("schedule_id"));
            PreparedStatement ps = conn.prepareStatement("DELETE FROM schedule WHERE schedule_id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    private void handleUser(String action, HttpServletRequest request, Connection conn) throws SQLException {
        if ("insert".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullname = request.getParameter("full_name");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role") != null ? request.getParameter("role") : "user";

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users (username, password, email, full_name, role, phone) VALUES (?, ?, ?, ?, ?, ?)"
            );
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, email);
            ps.setString(4, fullname);
            ps.setString(5, role);
            ps.setString(6, phone);
            ps.executeUpdate();

        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String username = request.getParameter("username");
            String fullname = request.getParameter("full_name");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");

            PreparedStatement ps = conn.prepareStatement(
                "UPDATE users SET username=?, full_name=?, phone=?, role=? WHERE id=?"
            );
            ps.setString(1, username);
            ps.setString(2, fullname);
            ps.setString(3, phone);
            ps.setString(4, role);
            ps.setInt(5, id);
            ps.executeUpdate();

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }



   // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
