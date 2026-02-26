package com.mvc.model;

import java.sql.Date;

public class Blog {
    
    private int id;
    private int blogCategoryId;
    private String categoryName; // for display in table
    private String title;
    private Date blogDate;
    private String imagePath;
    private String content;
    private Date createdAt;
    private Date updatedAt;

    // --------------------- GETTERS & SETTERS ---------------------

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getBlogCategoryId() {
        return blogCategoryId;
    }
    public void setBlogCategoryId(int blogCategoryId) {
        this.blogCategoryId = blogCategoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public Date getBlogDate() {
        return blogDate;
    }
    public void setBlogDate(Date blogDate) {
        this.blogDate = blogDate;
    }

    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    // --------------------- TO STRING ---------------------
    @Override
    public String toString() {
        return "Blog [id=" + id + ", title=" + title + ", category=" + categoryName +
               ", blogDate=" + blogDate + ", imagePath=" + imagePath + "]";
    }
}