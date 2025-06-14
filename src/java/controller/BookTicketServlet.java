/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import util.DBUtil;

@WebServlet("/bookTicket")
public class BookTicketServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            int scheduleId = Integer.parseInt(request.getParameter("schedule_id"));
            String seatClass = request.getParameter("seat_class");

            // Read 6 quantity types
            int qtyAdultMY = Integer.parseInt(request.getParameter("qty_adult_malaysian"));
            int qtyChildMY = Integer.parseInt(request.getParameter("qty_child_malaysian"));
            int qtySeniorMY = Integer.parseInt(request.getParameter("qty_senior_malaysian"));
            int qtyAdultFR = Integer.parseInt(request.getParameter("qty_adult_foreigner"));
            int qtyChildFR = Integer.parseInt(request.getParameter("qty_child_foreigner"));
            int qtySeniorFR = Integer.parseInt(request.getParameter("qty_senior_foreigner"));

            // Total quantity
            int totalQuantity = qtyAdultMY + qtyChildMY + qtySeniorMY + qtyAdultFR + qtyChildFR + qtySeniorFR;

            if (totalQuantity == 0) {
                response.sendRedirect("book_ticket.jsp?error=You+must+select+at+least+1+ticket");
                return;
            }

            try (Connection conn = DBUtil.getConnection()) {
                String sql = "INSERT INTO bookings (user_id, schedule_id, seat_class, quantity, "
                           + "qty_adult_malaysian, qty_child_malaysian, qty_senior_malaysian, "
                           + "qty_adult_foreigner, qty_child_foreigner, qty_senior_foreigner, status) "
                           + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";

                PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                stmt.setInt(1, userId);
                stmt.setInt(2, scheduleId);
                stmt.setString(3, seatClass);
                stmt.setInt(4, totalQuantity);
                stmt.setInt(5, qtyAdultMY);
                stmt.setInt(6, qtyChildMY);
                stmt.setInt(7, qtySeniorMY);
                stmt.setInt(8, qtyAdultFR);
                stmt.setInt(9, qtyChildFR);
                stmt.setInt(10, qtySeniorFR);

                int result = stmt.executeUpdate();
                if (result > 0) {
                    ResultSet rs = stmt.getGeneratedKeys();
                    if (rs.next()) {
                        int bookingId = rs.getInt(1);
                        response.sendRedirect("checkout.jsp?bookingId=" + bookingId);
                    } else {
                        response.sendRedirect("book_ticket.jsp?error=Booking+created+but+no+ID+returned");
                    }
                } else {
                    response.sendRedirect("book_ticket.jsp?error=Booking+failed");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("book_ticket.jsp?error=" + e.getMessage().replaceAll(" ", "+"));
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
