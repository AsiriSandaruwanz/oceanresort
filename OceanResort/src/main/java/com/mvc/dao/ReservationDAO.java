package com.mvc.dao;

import com.mvc.model.Reservation;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // ================= INSERT RESERVATION =================
    public void insertReservation(Reservation reservation) {

        String sql = "INSERT INTO reservations "
                + "(guest_name, phone_number, address, members, check_in_date, check_out_date, "
                + "reservation_status, room_id, payment_id, user_id, created_at, updated_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, reservation.getGuestName());
            ps.setString(2, reservation.getPhoneNumber()); // NEW
            ps.setString(3, reservation.getAddress());     // NEW
            ps.setInt(4, reservation.getMembers());
            ps.setDate(5, Date.valueOf(reservation.getCheckInDate()));
            ps.setDate(6, Date.valueOf(reservation.getCheckOutDate()));
            ps.setString(7, reservation.getReservationStatus());
            ps.setInt(8, reservation.getRoomId());

            // Payment ID NULL initially
            ps.setNull(9, Types.INTEGER);

            ps.setInt(10, reservation.getUserId());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ================= GET RESERVATIONS BY USER ID =================
    public List<Reservation> getReservationsByUserId(int userId) {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE user_id = ? ORDER BY check_in_date DESC";

        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Reservation res = new Reservation();
                res.setReservationId(rs.getInt("reservation_id"));
                res.setGuestName(rs.getString("guest_name"));
                res.setPhoneNumber(rs.getString("phone_number"));
                res.setAddress(rs.getString("address"));
                res.setMembers(rs.getInt("members"));
                res.setCheckInDate(rs.getDate("check_in_date").toLocalDate());
                res.setCheckOutDate(rs.getDate("check_out_date").toLocalDate());
                res.setReservationStatus(rs.getString("reservation_status"));
                res.setRoomId(rs.getInt("room_id"));
                res.setPaymentId(rs.getObject("payment_id") != null ? rs.getInt("payment_id") : null);
                res.setUserId(rs.getInt("user_id"));
                res.setCreatedAt(rs.getTimestamp("created_at"));
                res.setUpdatedAt(rs.getTimestamp("updated_at"));

                reservations.add(res);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reservations;
    }
    
    
    public List<Reservation> getReservationsByRoomId(int roomId) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE room_id = ?";
        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setReservationId(rs.getInt("reservation_id"));
                reservation.setGuestName(rs.getString("guest_name"));
                reservation.setPhoneNumber(rs.getString("phone_number"));
                reservation.setAddress(rs.getString("address"));
                // Convert java.sql.Date to java.time.LocalDate
                reservation.setCheckInDate(rs.getDate("check_in_date").toLocalDate());
                reservation.setCheckOutDate(rs.getDate("check_out_date").toLocalDate());
                reservation.setMembers(rs.getInt("members"));
                reservation.setReservationStatus(rs.getString("reservation_status"));
                reservation.setRoomId(rs.getInt("room_id"));

                list.add(reservation);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Reservation> getAllReservations() {

        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY created_at DESC";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Reservation reservation = new Reservation();

                reservation.setReservationId(rs.getInt("reservation_id"));
                reservation.setGuestName(rs.getString("guest_name"));
                reservation.setPhoneNumber(rs.getString("phone_number"));
                reservation.setAddress(rs.getString("address"));
                reservation.setMembers(rs.getInt("members"));
                reservation.setCheckInDate(rs.getDate("check_in_date").toLocalDate());
                reservation.setCheckOutDate(rs.getDate("check_out_date").toLocalDate());
                reservation.setReservationStatus(rs.getString("reservation_status"));
                reservation.setRoomId(rs.getInt("room_id"));
                reservation.setPaymentId(rs.getObject("payment_id") != null ? rs.getInt("payment_id") : null);
                reservation.setUserId(rs.getInt("user_id"));
                reservation.setCreatedAt(rs.getTimestamp("created_at"));
                reservation.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(reservation);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    public void updateReservationStatus(int reservationId, String status) {

        String sql = "UPDATE reservations SET reservation_status = ?, updated_at = NOW() WHERE reservation_id = ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, reservationId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void updatePaymentId(int reservationId, int paymentId) throws SQLException {
        String sql = "UPDATE reservations SET payment_id = ? , updated_at = NOW() WHERE reservation_id = ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, paymentId);
            ps.setInt(2, reservationId);
            ps.executeUpdate();
        }
    }
    
    
}