package com.mvc.controller;

import com.mvc.dao.BlogDAO;
import com.mvc.dao.RoomDAO;
import com.mvc.dao.FeedbackDAO; 
import com.mvc.model.Blog;
import com.mvc.model.Room;
import com.mvc.model.Feedback;

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
    private RoomDAO roomDAO = new RoomDAO();
    private FeedbackDAO feedbackDAO = new FeedbackDAO(); 

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch latest 5 blogs
        List<Blog> latestBlogs = blogDAO.getLatestBlogs(5);
        request.setAttribute("latestBlogs", latestBlogs);

        // Fetch 4 rooms
        List<Room> latestRooms = roomDAO.getLatestRooms(4);
        request.setAttribute("latestRooms", latestRooms);

        // Fetch all feedback
        List<Feedback> allFeedback = feedbackDAO.getAllFeedback();
        request.setAttribute("allFeedback", allFeedback);

        // Forward to home.jsp
        request.getRequestDispatcher("/views/customer/index.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}