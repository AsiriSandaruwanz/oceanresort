package com.mvc.controller;

import com.mvc.dao.ReservationDAO;
import com.mvc.model.Reservation;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/reservations")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;

    @Override
    public void init() {
        reservationDAO = new ReservationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Reservation> reservationList = reservationDAO.getAllReservations();

        request.setAttribute("reservationList", reservationList);
        request.setAttribute("pageTitle", "Reservation Management");
        request.setAttribute("contentPage", "/views/admin/reservation-content.jsp");

        request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {

            int reservationId = Integer.parseInt(request.getParameter("reservationId"));
            String status = request.getParameter("status");

            reservationDAO.updateReservationStatus(reservationId, status);
        }

        response.sendRedirect("reservations");
    }
}