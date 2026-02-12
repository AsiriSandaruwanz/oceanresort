package com.mvc.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout") // you can also just use "/logout"
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutServlet() {
        super();
    }

    /**
     * Handles GET requests (e.g., clicking the logout link)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get the current session, if it exists
        HttpSession session = request.getSession(false); 
        if (session != null) {
            session.invalidate(); // destroy session and logout
        }
        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/views/customer/index.jsp");
    }

    /**
     * Handles POST requests (optional, in case logout form uses POST)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
