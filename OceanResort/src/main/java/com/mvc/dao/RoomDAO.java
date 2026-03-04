package com.mvc.dao;

import com.mvc.model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // --------------------- GET ALL ROOMS ---------------------
    public List<Room> getAllRooms() {

        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM rooms ORDER BY created_at DESC";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {

                Room room = new Room();

                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setBedType(rs.getString("bed_type"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setTitle(rs.getString("title"));
                room.setAmenities(rs.getString("amenities"));
                room.setSize(rs.getString("size"));
                room.setCapacity(rs.getInt("capacity"));
                room.setImagePath(rs.getString("image_path"));
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // --------------------- GET ROOM BY ID ---------------------
    public Room getRoomById(int id) {

        Room room = null;
        String sql = "SELECT * FROM rooms WHERE room_id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                room = new Room();

                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setBedType(rs.getString("bed_type"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setTitle(rs.getString("title"));
                room.setAmenities(rs.getString("amenities"));
                room.setSize(rs.getString("size"));
                room.setCapacity(rs.getInt("capacity"));
                room.setImagePath(rs.getString("image_path"));
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return room;
    }

    // --------------------- INSERT ROOM ---------------------
    public void insertRoom(Room room) {

        String sql = "INSERT INTO rooms (room_number, bed_type, price_per_night, title, amenities, size, capacity, image_path, created_at, updated_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getBedType());
            ps.setDouble(3, room.getPricePerNight());
            ps.setString(4, room.getTitle());
            ps.setString(5, room.getAmenities());
            ps.setString(6, room.getSize());
            ps.setInt(7, room.getCapacity());
            ps.setString(8, room.getImagePath());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --------------------- UPDATE ROOM ---------------------
    public void updateRoom(Room room) {

        String sql = "UPDATE rooms SET room_number=?, bed_type=?, price_per_night=?, title=?, amenities=?, size=?, capacity=?, updated_at=NOW()";

        // update image only if provided
        if (room.getImagePath() != null && !room.getImagePath().isEmpty()) {
            sql += ", image_path=?";
        }

        sql += " WHERE room_id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getBedType());
            ps.setDouble(3, room.getPricePerNight());
            ps.setString(4, room.getTitle());
            ps.setString(5, room.getAmenities());
            ps.setString(6, room.getSize());
            ps.setInt(7, room.getCapacity());

            int index = 8;

            if (room.getImagePath() != null && !room.getImagePath().isEmpty()) {
                ps.setString(8, room.getImagePath());
                index = 9;
            }

            ps.setInt(index, room.getRoomId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --------------------- DELETE ROOM ---------------------
    public void deleteRoom(int id) {

        String sql = "DELETE FROM rooms WHERE room_id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Room> getLatestRooms(int limit) {
        List<Room> rooms = new ArrayList<>();

        String sql = "SELECT * FROM rooms ORDER BY created_at DESC LIMIT ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setBedType(rs.getString("bed_type"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setTitle(rs.getString("title"));
                room.setAmenities(rs.getString("amenities"));
                room.setSize(rs.getString("size"));
                room.setCapacity(rs.getInt("capacity"));
                room.setImagePath(rs.getString("image_path"));
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));

                rooms.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }
    
    
    public List<Room> getRoomsByCapacity(int guests) {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM rooms WHERE capacity >= ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, guests);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Room room = new Room();
                room.setRoomId(rs.getInt("room_id"));
                room.setTitle(rs.getString("title"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setBedType(rs.getString("bed_type"));
                room.setPricePerNight(rs.getDouble("price_per_night"));
                room.setCapacity(rs.getInt("capacity"));
                room.setSize(rs.getString("size"));
                room.setAmenities(rs.getString("amenities"));
                room.setImagePath(rs.getString("image_path"));
                room.setCreatedAt(rs.getTimestamp("created_at"));
                room.setUpdatedAt(rs.getTimestamp("updated_at"));

                rooms.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }
}