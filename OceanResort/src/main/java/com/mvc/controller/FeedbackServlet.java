package com.mvc.controller;

import com.mvc.dao.FeedbackDAO;
import com.mvc.model.Feedback;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/feedbacks")
public class FeedbackServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private FeedbackDAO feedbackDAO;

    @Override
    public void init() {
        feedbackDAO = new FeedbackDAO();
    }

    // ===================== GET =====================
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "delete":
                deleteFeedback(request, response);
                break;

            default:
                listFeedbacks(request, response);
                break;
        }
    }

    // ===================== POST =====================
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }

    // ===================== LIST =====================
    private void listFeedbacks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Feedback> feedbackList = feedbackDAO.getAllFeedback();

        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("pageTitle", "All Feedbacks");
        request.setAttribute("contentPage", "/views/admin/feedback-content.jsp");

        request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
               .forward(request, response);
    }

    // ===================== DELETE =====================
    private void deleteFeedback(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            // You must create this method in DAO if not exists
            feedbackDAO.deleteFeedback(id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("feedbacks");
    }
}