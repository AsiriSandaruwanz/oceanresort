package com.mvc.controller;

import com.mvc.dao.FeedbackDAO;
import com.mvc.dao.ReservationDAO;
import com.mvc.dao.UserDAO;
import com.mvc.model.Feedback;
import com.mvc.model.Reservation;
import com.mvc.model.User;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();

    public ProfileServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	System.out.println("ProfileServlet accessed!");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Fetch user info
        User userProfile = userDAO.getUserById(userId);
        if (userProfile == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
            return;
        }

        request.setAttribute("userProfile", userProfile);

        // Fetch reservations
        ReservationDAO reservationDAO = new ReservationDAO();
        List<Reservation> reservations = reservationDAO.getReservationsByUserId(userId);
        request.setAttribute("userReservations", reservations);

        // Fetch feedbacks
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Feedback> userFeedbacks = feedbackDAO.getFeedbacksByUserId(userId);
        request.setAttribute("userFeedbacks", userFeedbacks);

        // Forward to profile.jsp
        request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Get form values
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Prepare user object
        User user = new User();
        user.setUserId(userId);
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);

        // Update only name/email/phone
        boolean updated = userDAO.updateUserProfile(user); // use the new DAO method
        if (updated) {
            // Refresh user profile from DB
            request.setAttribute("userProfile", userDAO.getUserById(userId));
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("userProfile", userDAO.getUserById(userId));
            request.setAttribute("errorMessage", "Failed to update profile.");
        }

        // Forward back to profile page
        request.getRequestDispatcher("/views/customer/profile.jsp").forward(request, response);
    }
    
    
}