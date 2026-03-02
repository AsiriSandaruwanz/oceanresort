package com.mvc.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mvc.dao.UserDAO;
import com.mvc.model.User;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userId", user.getUserId()); 

            if (user.getRole().equalsIgnoreCase("admin")) {
                // Redirect to servlet, not JSP
                response.sendRedirect(request.getContextPath() + "/dashboard");

            } else if (user.getRole().equalsIgnoreCase("staff")) {
                response.sendRedirect(request.getContextPath() + "/staff"); // make staff servlet
            } else {
                response.sendRedirect(request.getContextPath() + "/views/customer/index.jsp"); // make customer servlet
            }

        } else {
            request.setAttribute("error", "Invalid Email or Password!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }

	}

}
