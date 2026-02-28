package com.mvc.model;

import java.time.LocalDateTime;

public class Service {

    private int serviceId;
    private String name;
    private double price;
    private int roomId; // optional: if the service is tied to a room
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Service() {}

    public Service(String name, double price, int roomId) {
        this.name = name;
        this.price = price;
        this.roomId = roomId;
        this.createdAt = LocalDateTime.now();
    }

    // Getters and Setters
    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}