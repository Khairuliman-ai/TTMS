/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Booking;
import java.sql.*;
import java.util.*;

public class BookingDAO {
    private Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean createBooking(Booking b) throws SQLException {
        String sql = "INSERT INTO bookings (user_id, schedule_id, seat_class, status) VALUES (?, ?, ?, 'booked')";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, b.getUserId());
            stmt.setInt(2, b.getScheduleId());
            stmt.setString(3, b.getSeatClass());
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Booking> getBookingsByUser(int userId) throws SQLException {
        String sql = "SELECT * FROM bookings WHERE user_id=?";
        List<Booking> list = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking b = new Booking();
                b.setBookingId(rs.getInt("booking_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setScheduleId(rs.getInt("schedule_id"));
                b.setSeatClass(rs.getString("seat_class"));
                b.setStatus(rs.getString("status"));
                list.add(b);
            }
        }
        return list;
    }

    public boolean cancelBooking(int bookingId) throws SQLException {
        String sql = "UPDATE bookings SET status='cancelled' WHERE booking_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;
        }
    }
}
