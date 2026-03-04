package com.mvc.dao;

import com.mvc.model.Feedback;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // Get feedback by room ID
    public List<Feedback> getFeedbackByRoomId(int roomId) {

        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM feedbacks WHERE room_id=? ORDER BY created_at DESC";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback fb = new Feedback();

                fb.setFeedbackId(rs.getInt("feedback_id"));
                fb.setName(rs.getString("name"));
                fb.setEmail(rs.getString("email"));
                fb.setFeedbackDate(rs.getDate("feedback_date"));
                fb.setRating(rs.getInt("rating"));
                fb.setReview(rs.getString("review"));
                fb.setRoomId(rs.getInt("room_id"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                fb.setUpdatedAt(rs.getTimestamp("updated_at"));

                list.add(fb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Insert feedback
    public void insertFeedback(Feedback fb) {

    	String sql = "INSERT INTO feedbacks "
    	           + "(name, email, feedback_date, rating, review, room_id, user_id, created_at, updated_at) "
    	           + "VALUES (?, ?, CURDATE(), ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, fb.getName());
            ps.setString(2, fb.getEmail());
            ps.setInt(3, fb.getRating());
            ps.setString(4, fb.getReview());
            ps.setInt(5, fb.getRoomId());
            ps.setInt(6, fb.getUserId());
            
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Feedback> getFeedbacksByUserId(int userId) {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM feedbacks WHERE user_id = ? ORDER BY feedback_date DESC";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("feedback_id"));
                fb.setName(rs.getString("name"));
                fb.setEmail(rs.getString("email"));
                fb.setFeedbackDate(rs.getDate("feedback_date"));
                fb.setRating(rs.getInt("rating"));
                fb.setReview(rs.getString("review"));
                fb.setRoomId(rs.getInt("room_id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                fb.setUpdatedAt(rs.getTimestamp("updated_at"));

                feedbacks.add(fb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbacks;
    }
    
    
 // ✅ Get all feedback
    public List<Feedback> getAllFeedback() {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM feedbacks ORDER BY created_at DESC";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("feedback_id"));
                fb.setName(rs.getString("name"));
                fb.setEmail(rs.getString("email"));
                fb.setFeedbackDate(rs.getDate("feedback_date"));
                fb.setRating(rs.getInt("rating"));
                fb.setReview(rs.getString("review"));
                fb.setRoomId(rs.getInt("room_id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                fb.setUpdatedAt(rs.getTimestamp("updated_at"));

                feedbacks.add(fb);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbacks;
    }
    
    public void deleteFeedback(int id) {

        String sql = "DELETE FROM feedbacks WHERE feedback_id = ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}