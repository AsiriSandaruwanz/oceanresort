package com.mvc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mvc.dao.BlogCategoryDAO;
import com.mvc.model.BlogCategory;

@WebServlet("/blog-categories")
public class BlogCategoriesServlet extends HttpServlet {

    private BlogCategoryDAO dao;

    public void init() {
        dao = new BlogCategoryDAO();
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
                 editCategory(request, response);
                 break;
     
             case "delete":
                 deleteCategory(request, response);
                 break;

             default:
                 listCategories(request, response);
                 break;
         }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertCategory(request, response);
        } else if ("update".equals(action)) {
            updateCategory(request, response);
        }
    }

    private void listCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("categoryList", dao.getAllCategories());
        request.setAttribute("pageTitle", "Blog Categories");
        request.setAttribute("contentPage", "/views/admin/blog-category-content.jsp");

        request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
                .forward(request, response);
    }

    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("pageTitle", "Add Blog Category");
        request.setAttribute("contentPage", "/views/admin/BlogCategory/blog-category-form.jsp");

        request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
                .forward(request, response);
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");

        dao.insertCategory(name, description);

        response.sendRedirect("blog-categories");
    }
    
    private void editCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        BlogCategory existingCategory = dao.getCategoryById(id);

        request.setAttribute("category", existingCategory);
        request.setAttribute("pageTitle", "Edit Blog Category");
        request.setAttribute("contentPage", "/views/admin/BlogCategory/blog-category-form.jsp");

        request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
                .forward(request, response);
    }
    
    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        dao.updateCategory(id, name, description);

        response.sendRedirect("blog-categories");
    }
    
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        dao.deleteCategory(id);

        response.sendRedirect("blog-categories");
    }
}