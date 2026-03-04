package com.mvc.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.dao.PaymentDAO;
import com.mvc.model.Payment;

@WebServlet("/payments")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ✅ Declare DAO object
    private PaymentDAO paymentDAO;

    // ✅ Initialize DAO once when servlet loads
    @Override
    public void init() throws ServletException {
        paymentDAO = new PaymentDAO();
    }

    // ✅ Handle GET request
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ Call method using object (NOT static)
            List<Payment> payments = paymentDAO.getAllPayments();

            // Send data to JSP
            request.setAttribute("payments", payments);
            request.setAttribute("pageTitle", "Payments");
            request.setAttribute("contentPage", "/views/admin/payment-content.jsp");

            // Forward to layout
            request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to load payments.");
        }
    }

    // ✅ Handle POST (optional – currently just reloads page)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}