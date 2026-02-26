package com.mvc.controller;

import com.mvc.dao.BlogDAO;
import com.mvc.dao.BlogCategoryDAO;
import com.mvc.model.Blog;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/blogs")
@MultipartConfig(fileSizeThreshold = 1024*1024*2,    // 2MB
                 maxFileSize = 1024*1024*10,        // 10MB
                 maxRequestSize = 1024*1024*50)     // 50MB
public class BlogServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private BlogDAO blogDAO;
    private BlogCategoryDAO categoryDAO;

    public void init() {
        blogDAO = new BlogDAO();
        categoryDAO = new BlogCategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                showForm(request, response);
                break;

            case "edit":
                editBlog(request, response);
                break;

            case "delete":
                deleteBlog(request, response);
                break;

            default: // list
                listBlogs(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertBlog(request, response);
        } else if ("update".equals(action)) {
            updateBlog(request, response);
        }
    }

    // --------------------- ACTION METHODS ---------------------

    private void listBlogs(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Blog> blogs = blogDAO.getAllBlogs();

        request.setAttribute("blogList", blogs);
        request.setAttribute("pageTitle", "All Blogs");
        request.setAttribute("contentPage", "/views/admin/blog-content.jsp");
        request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("pageTitle", "Add Blog");
        request.setAttribute("contentPage", "/views/admin/BlogCategory/blog-form.jsp");
        request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
    }

    private void editBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.getBlogById(id);
        request.setAttribute("blog", blog);
        request.setAttribute("categories", categoryDAO.getAllCategories());
        request.setAttribute("pageTitle", "Edit Blog");
        request.setAttribute("contentPage", "/views/admin/BlogCategory/blog-form.jsp");
        request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
    }

    private void insertBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        Part filePart = request.getPart("image_path");
        String fileName = extractFileName(filePart);
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        filePart.write(uploadPath + File.separator + fileName);

        Blog blog = new Blog();
        blog.setTitle(request.getParameter("title"));
        blog.setContent(request.getParameter("content"));
        blog.setBlogDate(Date.valueOf(request.getParameter("blog_date")));
        blog.setBlogCategoryId(Integer.parseInt(request.getParameter("blog_category_id")));
        blog.setImagePath("uploads/" + fileName);

        blogDAO.insertBlog(blog);
        response.sendRedirect("blogs");
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        int id = Integer.parseInt(request.getParameter("id"));
        Blog blog = blogDAO.getBlogById(id);

        blog.setTitle(request.getParameter("title"));
        blog.setContent(request.getParameter("content"));
        blog.setBlogDate(Date.valueOf(request.getParameter("blog_date")));
        blog.setBlogCategoryId(Integer.parseInt(request.getParameter("blog_category_id")));

        Part filePart = request.getPart("image_path");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            filePart.write(uploadPath + File.separator + fileName);
            blog.setImagePath("uploads/" + fileName);
        }

        blogDAO.updateBlog(blog);
        response.sendRedirect("blogs");
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        blogDAO.deleteBlog(id);
        response.sendRedirect("blogs");
    }

    // --------------------- HELPER ---------------------
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String s : contentDisp.split(";")) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}