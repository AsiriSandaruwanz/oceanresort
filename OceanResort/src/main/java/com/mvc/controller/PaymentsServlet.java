package com.mvc.controller;

import com.mvc.dao.PaymentDAO;
import com.mvc.dao.ReservationDAO;
import com.mvc.model.Payment;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/payment")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max
public class PaymentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private PaymentDAO paymentDAO;
    private ReservationDAO reservationDAO;

    @Override
    public void init() {
        paymentDAO = new PaymentDAO();
        reservationDAO = new ReservationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            String paymentMethod = request.getParameter("payment_method");
            double amount = Double.parseDouble(request.getParameter("amount"));
            java.time.LocalDate paymentDate = java.time.LocalDate.parse(request.getParameter("payment_date"));
            String paymentStatus = request.getParameter("payment_status");

            // Handle file upload
            Part filePart = request.getPart("slip_image");
            String fileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + "uploads";
                java.io.File uploadDir = new java.io.File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                filePart.write(uploadPath + java.io.File.separator + fileName);
            }

            // Create Payment object
            Payment payment = new Payment();
            payment.setPaymentMethod(paymentMethod);
            payment.setAmount(amount);
            payment.setPaymentDate(paymentDate); // now matches LocalDate
            payment.setPaymentStatus(paymentStatus);
            payment.setSlipImage(fileName);      // save file name/path as String

            // Save payment and get generated ID
            int paymentId = paymentDAO.insertPayment(payment);

            // Update reservation with payment_id
            reservationDAO.updatePaymentId(reservationId, paymentId);

            response.sendRedirect(request.getContextPath() + "/profile?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/profile?error=true");
        }
    }
}