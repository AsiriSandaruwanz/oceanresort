package com.mvc.dao;

import java.sql.*;
import java.util.*;
import com.mvc.model.BlogCategory;

public class BlogCategoryDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    private static final String SELECT_ALL =
        "SELECT * FROM blog_categories ORDER BY id DESC";

    public List<BlogCategory> getAllCategories() {

        List<BlogCategory> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(
                    jdbcURL, jdbcUsername, jdbcPassword);

            PreparedStatement ps = connection.prepareStatement(SELECT_ALL);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BlogCategory category = new BlogCategory(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                list.add(category);
            }

            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    public void insertCategory(String name, String description) {

        String sql = "INSERT INTO blog_categories (name, description, created_at, updated_at) VALUES (?, ?, NOW(), NOW())";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, description);

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public BlogCategory getCategoryById(int id) {

        BlogCategory category = null;

        String sql = "SELECT * FROM blog_categories WHERE id=?";

        try {
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                category = new BlogCategory(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }
    
    
    public void updateCategory(int id, String name, String description) {

        String sql = "UPDATE blog_categories SET name=?, description=?, updated_at=NOW() WHERE id=?";

        try {
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, description);
            ps.setInt(3, id);

            ps.executeUpdate();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public void deleteCategory(int id) {

        String sql = "DELETE FROM blog_categories WHERE id=?";

        try {
            Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, id);
            ps.executeUpdate();

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}