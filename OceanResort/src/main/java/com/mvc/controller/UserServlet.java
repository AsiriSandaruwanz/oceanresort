package com.mvc.controller;

import com.mvc.dao.UserDAO;
import com.mvc.model.User;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/users")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO = new UserDAO();

    // ---------------- GET requests ----------------
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action != null ? action : "") {

            case "new":
                // Show Add User form
                request.setAttribute("pageTitle", "Add User");
                request.setAttribute("contentPage", "/views/admin/users/add-user.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
                break;

            case "edit":
                // Show Edit User form
                int editId = Integer.parseInt(request.getParameter("id"));
                User user = userDAO.getUserById(editId);
                request.setAttribute("user", user);
                request.setAttribute("pageTitle", "Edit User");
                request.setAttribute("contentPage", "/views/admin/users/edit-user.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
                break;

            case "delete":
                // Delete user
                int deleteId = Integer.parseInt(request.getParameter("id"));
                userDAO.deleteUser(deleteId);
                response.sendRedirect(request.getContextPath() + "/users");
                break;

            default:
                // Show user list
                List<User> userList = userDAO.getAllUsers();
                request.setAttribute("userList", userList);
                request.setAttribute("pageTitle", "Manage Users");
                request.setAttribute("contentPage", "/views/admin/users-content.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
                break;
        }
    }

    // ---------------- POST requests ----------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action) || "update".equals(action)) {

            // 1️⃣ Get form fields
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            // 2️⃣ Create User object
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setPassword(password);
            user.setRole(role);

            if ("update".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                user.setUserId(userId);
                userDAO.updateUser(user);
            } else {
                userDAO.registerUser(user);
            }

            // 3️⃣ Redirect to user list
            response.sendRedirect(request.getContextPath() + "/users");
        }
    }
}