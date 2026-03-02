package com.mvc.model;

import java.sql.Timestamp;
import java.sql.Date;

public class Feedback {

    private int feedbackId;
    private String name;
    private String email;
    private Date feedbackDate;
    private int rating;
    private String review;
    private int roomId;
    private int userId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    

    // Getters and Setters

    public int getFeedbackId() { return feedbackId; }
    public void setFeedbackId(int feedbackId) { this.feedbackId = feedbackId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Date getFeedbackDate() { return feedbackDate; }
    public void setFeedbackDate(Date feedbackDate) { this.feedbackDate = feedbackDate; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}