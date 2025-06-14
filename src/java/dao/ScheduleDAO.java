/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Schedule;
import java.sql.*;

public class ScheduleDAO {
    private Connection conn;

    public ScheduleDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addSchedule(Schedule s) throws SQLException {
        String sql = "INSERT INTO schedule (train_id, route_id, departure_time, arrival_time) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, s.getTrainId());
            stmt.setInt(2, s.getRouteId());
            stmt.setString(3, s.getDepartureTime());
            stmt.setString(4, s.getArrivalTime());
            return stmt.executeUpdate() > 0;
        }
    }
}
