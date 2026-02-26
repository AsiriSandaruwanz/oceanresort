package com.mvc.dao;

import com.mvc.model.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO {

    private String jdbcURL = "jdbc:mysql://localhost:3306/ocean_resort";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";

    // --------------------- GET ALL BLOGS ---------------------
    public List<Blog> getAllBlogs() {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT b.*, c.name AS category_name " +
                     "FROM blogs b LEFT JOIN blog_categories c ON b.blog_category_id = c.id " +
                     "ORDER BY b.blog_date DESC";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setBlogDate(rs.getDate("blog_date"));
                b.setImagePath(rs.getString("image_path"));
                b.setContent(rs.getString("content"));
                b.setCategoryName(rs.getString("category_name"));
                b.setBlogCategoryId(rs.getInt("blog_category_id"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --------------------- GET BLOG BY ID ---------------------
    public Blog getBlogById(int id) {
        Blog blog = null;
        String sql = "SELECT * FROM blogs WHERE id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                blog = new Blog();
                blog.setId(rs.getInt("id"));
                blog.setTitle(rs.getString("title"));
                blog.setContent(rs.getString("content"));
                blog.setBlogDate(rs.getDate("blog_date"));
                blog.setImagePath(rs.getString("image_path"));
                blog.setBlogCategoryId(rs.getInt("blog_category_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return blog;
    }

    // --------------------- INSERT BLOG ---------------------
    public void insertBlog(Blog blog) {
        String sql = "INSERT INTO blogs (blog_category_id, title, blog_date, image_path, content, created_at, updated_at) " +
                     "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, blog.getBlogCategoryId());
            ps.setString(2, blog.getTitle());
            ps.setDate(3, blog.getBlogDate());
            ps.setString(4, blog.getImagePath());
            ps.setString(5, blog.getContent());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --------------------- UPDATE BLOG ---------------------
    public void updateBlog(Blog blog) {
        String sql = "UPDATE blogs SET blog_category_id=?, title=?, blog_date=?, content=?, updated_at=NOW()";

        // Only update image if path exists
        if (blog.getImagePath() != null && !blog.getImagePath().isEmpty()) {
            sql += ", image_path=?";
        }

        sql += " WHERE id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, blog.getBlogCategoryId());
            ps.setString(2, blog.getTitle());
            ps.setDate(3, blog.getBlogDate());
            ps.setString(4, blog.getContent());

            int index = 5;
            if (blog.getImagePath() != null && !blog.getImagePath().isEmpty()) {
                ps.setString(5, blog.getImagePath());
                index = 6;
            }

            ps.setInt(index, blog.getId());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --------------------- DELETE BLOG ---------------------
    public void deleteBlog(int id) {
        String sql = "DELETE FROM blogs WHERE id=?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
 // --------------------- Get the latest 5 blogs ---------------------
    public List<Blog> getLatestBlogs(int limit) {
        List<Blog> list = new ArrayList<>();
        String sql = "SELECT b.*, c.name AS category_name " +
                     "FROM blogs b LEFT JOIN blog_categories c ON b.blog_category_id = c.id " +
                     "ORDER BY b.blog_date DESC LIMIT ?";

        try (Connection conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setBlogDate(rs.getDate("blog_date"));
                b.setImagePath(rs.getString("image_path"));
                b.setContent(rs.getString("content"));
                b.setCategoryName(rs.getString("category_name"));
                b.setBlogCategoryId(rs.getInt("blog_category_id"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}