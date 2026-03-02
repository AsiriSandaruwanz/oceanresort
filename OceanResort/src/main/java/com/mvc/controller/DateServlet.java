package com.mvc.controller;

import com.mvc.model.Reservation;
import com.mvc.dao.ReservationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/DateServlet")
public class DateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        LocalDate checkIn = LocalDate.parse(checkInStr);
        LocalDate checkOut = LocalDate.parse(checkOutStr);

        ReservationDAO reservationDAO = new ReservationDAO();
        List<Reservation> reservations = reservationDAO.getReservationsByRoomId(roomId);

        boolean isAvailable = true;

        for (Reservation res : reservations) {
            LocalDate existingCheckIn = res.getCheckInDate();
            LocalDate existingCheckOut = res.getCheckOutDate();

            if (!(checkOut.isBefore(existingCheckIn) || checkIn.isAfter(existingCheckOut))) {
                isAvailable = false;
                break;
            }
        }

        HttpSession session = request.getSession();

        if (isAvailable) {
            session.setAttribute("availabilityMessage", 
                "Room is Available !");
            session.setAttribute("availabilityType", "success");
        } else {
            session.setAttribute("availabilityMessage", 
                "Sorry! Room is not Available ");
            session.setAttribute("availabilityType", "danger");
        }

        // ✅ Redirect (important!)
        response.sendRedirect(request.getContextPath() +
                "/room-details?roomId=" + roomId);
    }
}