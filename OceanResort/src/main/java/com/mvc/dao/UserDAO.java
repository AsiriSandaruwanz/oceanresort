package com.mvc.dao;

import com.mvc.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // ---------------- REGISTER ----------------
    public boolean registerUser(User user) {
        boolean rowInserted = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "INSERT INTO users (name, email, phone, password, role, created_at) VALUES (?, ?, ?, ?, ?, NOW())";

            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPhone());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getRole());

            rowInserted = pst.executeUpdate() > 0;

            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rowInserted;
    }

    // ---------------- LOGIN ----------------
    public User login(String email, String password) {
        User user = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User(
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("password"),
                        rs.getString("role")
                );
                user.setUserId(rs.getInt("user_id"));
                user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // ---------------- GET ALL USERS ----------------
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY created_at DESC";

        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());

                list.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ---------------- GET USER BY ID ----------------
    public User getUserById(int id) {
        User user = null;
        String sql = "SELECT * FROM users WHERE user_id=?";

        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // ---------------- UPDATE USER ----------------
    public boolean updateUser(User user) {
        boolean rowUpdated = false;
        String sql = "UPDATE users SET name=?, email=?, phone=?, password=?, role=? WHERE user_id=?";

        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPhone());
            pst.setString(4, user.getPassword());
            pst.setString(5, user.getRole());
            pst.setInt(6, user.getUserId());

            rowUpdated = pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rowUpdated;
    }

    // ---------------- DELETE USER ----------------
    public boolean deleteUser(int id) {
        boolean rowDeleted = false;
        String sql = "DELETE FROM users WHERE user_id=?";

        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, id);
            rowDeleted = pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rowDeleted;
    }
    
    // ---------------- UPDATE USER PROFILE (ONLY NAME, EMAIL, PHONE) ----------------
    public boolean updateUserProfile(User user) {
        boolean rowUpdated = false;
        String sql = "UPDATE users SET name=?, email=?, phone=? WHERE user_id=?";

        try (Connection con = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPhone());
            pst.setInt(4, user.getUserId());

            rowUpdated = pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rowUpdated;
    }
    
    
}