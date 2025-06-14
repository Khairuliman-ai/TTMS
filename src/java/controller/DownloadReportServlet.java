/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class DownloadReportServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=booking_report.pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            Font titleFont = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
            document.add(new Paragraph("Ticket Booking Report", titleFont));
            document.add(new Paragraph(" ")); // spacer

            PdfPTable table = new PdfPTable(8);
            table.setWidthPercentage(100);
            table.setWidths(new int[]{2, 3, 3, 3, 3, 3, 2, 3});

            String[] headers = {"Booking ID", "User", "Train", "From", "To", "Seat Class", "Amount", "Payment"};
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header));
                cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                table.addCell(cell);
            }

            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/ttms", "root", "");
            String sql = "SELECT b.booking_id, u.full_name, t.train_name, r.start_point, r.end_point, " +
                         "b.seat_class, p.amount, p.payment_method " +
                         "FROM bookings b " +
                         "JOIN users u ON b.user_id = u.id " +
                         "JOIN schedule s ON b.schedule_id = s.schedule_id " +
                         "JOIN trains t ON s.train_id = t.train_id " +
                         "JOIN routes r ON s.route_id = r.route_id " +
                         "JOIN payments p ON b.booking_id = p.booking_id " +
                         "ORDER BY b.booking_id DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                table.addCell(rs.getString("booking_id"));
                table.addCell(rs.getString("full_name"));
                table.addCell(rs.getString("train_name"));
                table.addCell(rs.getString("start_point"));
                table.addCell(rs.getString("end_point"));
                table.addCell(rs.getString("seat_class"));
                table.addCell("RM " + rs.getDouble("amount"));
                table.addCell(rs.getString("payment_method"));
            }

            document.add(table);
            document.close();

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            throw new ServletException("PDF generation error: " + e.getMessage());
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
