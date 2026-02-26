package com.mvc.controller;

import com.mvc.dao.BlogDAO;
import com.mvc.model.Blog;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/blog")   // cleaner URL than /CustomerBlogServlet
public class CustomerBlogServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BlogDAO blogDAO;

    public void init() {
        blogDAO = new BlogDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch blogs from database
        List<Blog> blogs = blogDAO.getAllBlogs();
 
        System.out.println("Number of blogs fetched: " + blogs.size());
        
        // Send to JSP
        request.setAttribute("blogList", blogs);

        // Forward to customer blog page
        request.getRequestDispatcher("/views/customer/blog.jsp")
               .forward(request, response);
    }
}