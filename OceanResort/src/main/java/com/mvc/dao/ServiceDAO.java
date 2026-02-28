package com.mvc.dao;

import com.mvc.model.Service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // ---------------- GET ALL SERVICES ----------------
    public List<Service> getAllServices() {
        List<Service> list = new ArrayList<>();
        String sql = "SELECT * FROM services ORDER BY created_at DESC";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("service_id"));
                service.setName(rs.getString("service_name"));
                service.setPrice(rs.getDouble("service_price"));
                service.setRoomId(rs.getInt("room_id"));
                service.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                service.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());

                list.add(service);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------- GET SERVICE BY ID ----------------
    public Service getServiceById(int id) {
        Service service = null;
        String sql = "SELECT * FROM services WHERE service_id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                service = new Service();
                service.setServiceId(rs.getInt("service_id"));
                service.setName(rs.getString("service_name"));
                service.setPrice(rs.getDouble("service_price"));
                service.setRoomId(rs.getInt("room_id"));
                service.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                service.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return service;
    }

    // ---------------- INSERT SERVICE ----------------
    public void insertService(Service service) {
        String sql = "INSERT INTO services (service_name, service_price, room_id, created_at, updated_at) VALUES (?, ?, ?, NOW(), NOW())";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, service.getName());
            ps.setDouble(2, service.getPrice());
            ps.setInt(3, service.getRoomId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ---------------- UPDATE SERVICE ----------------
    public void updateService(Service service) {
        String sql = "UPDATE services SET service_name=?, service_price=?, room_id=?, updated_at=NOW() WHERE service_id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, service.getName());
            ps.setDouble(2, service.getPrice());
            ps.setInt(3, service.getRoomId());
            ps.setInt(4, service.getServiceId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ---------------- DELETE SERVICE ----------------
    public void deleteService(int id) {
        String sql = "DELETE FROM services WHERE service_id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}