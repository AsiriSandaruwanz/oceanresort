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

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BlogDAO blogDAO = new BlogDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch latest 5 blogs
        List<Blog> latestBlogs = blogDAO.getLatestBlogs(5);
        System.out.println("Latest blogs fetched: " + latestBlogs.size()); // debug

        // Set as request attribute
        request.setAttribute("latestBlogs", latestBlogs);

        // Forward to home.jsp
        request.getRequestDispatcher("/views/customer/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}