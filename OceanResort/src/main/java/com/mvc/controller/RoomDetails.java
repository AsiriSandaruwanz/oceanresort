package com.mvc.controller;

import com.mvc.dao.FeedbackDAO;
import com.mvc.dao.RoomDAO;
import com.mvc.model.Feedback;
import com.mvc.model.Room;
import com.mvc.model.User;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/room-details")
public class RoomDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RoomDAO roomDAO = new RoomDAO();
    private FeedbackDAO feedbackDAO = new FeedbackDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roomIdParam = request.getParameter("roomId");
        Room room = null;

        if (roomIdParam != null && !roomIdParam.isEmpty()) {
            try {
                int roomId = Integer.parseInt(roomIdParam);

                // Fetch room details
                room = roomDAO.getRoomById(roomId);

                if (room != null) {
                    // ✅ Fetch all feedbacks for this room
                    List<Feedback> feedbackList = feedbackDAO.getFeedbackByRoomId(roomId);
                    request.setAttribute("feedbackList", feedbackList);
                }

            } catch (NumberFormatException e) {
                System.err.println("Invalid roomId: " + roomIdParam);
            }
        }

        if (room == null) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        request.setAttribute("room", room);
        request.getRequestDispatcher("/views/customer/room-details.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            // No user logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Get logged-in user from session
        User loggedUser = (User) session.getAttribute("loggedUser");
        int userId = loggedUser.getUserId();

        // Get roomId from the form
        String roomIdStr = request.getParameter("roomId");
        if (roomIdStr == null || roomIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/views/error.jsp");
            return;
        }
        int roomId = Integer.parseInt(roomIdStr);

        // Create feedback object
        Feedback fb = new Feedback();
        fb.setName(request.getParameter("name"));
        fb.setEmail(request.getParameter("email"));
        fb.setRating(Integer.parseInt(request.getParameter("rating")));
        fb.setReview(request.getParameter("review"));
        fb.setRoomId(roomId);
        fb.setUserId(userId);

        // Insert feedback
        feedbackDAO.insertFeedback(fb);

        // Redirect back to room details
        response.sendRedirect(request.getContextPath() + "/room-details?roomId=" + roomId);
    }
}