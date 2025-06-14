/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import util.DBUtil;

@WebServlet("/makePayment")
public class MakePaymentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String bookingId = request.getParameter("bookingId");
        String amountStr = request.getParameter("amount");
        String method = request.getParameter("method");

        try (Connection conn = DBUtil.getConnection()) {
            // Insert payment record and set status to 'paid'
            String sql = "INSERT INTO payments (booking_id, amount, method, status) VALUES (?, ?, ?, 'paid')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(bookingId));
            stmt.setDouble(2, Double.parseDouble(amountStr));
            stmt.setString(3, method);

            int result = stmt.executeUpdate();

            if (result > 0) {
                // ✅ Optionally update the bookings table to mark this booking as paid too
                String updateBooking = "UPDATE bookings SET status = 'Paid' WHERE booking_id = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateBooking);
                updateStmt.setInt(1, Integer.parseInt(bookingId));
                updateStmt.executeUpdate();

                response.sendRedirect("view_booking.jsp?bookingId=" + bookingId + "&paymentSuccess=1");
            } else {
                response.sendRedirect("payment.jsp?error=Payment+failed");
            }

        } catch (Exception e) {
            response.sendRedirect("payment.jsp?error=" + e.getMessage().replaceAll(" ", "+"));
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
