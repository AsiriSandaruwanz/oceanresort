package com.mvc.controller;

import com.mvc.dao.ReservationDAO;
import com.mvc.dao.RoomDAO;
import com.mvc.model.Reservation;
import com.mvc.model.Room;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/availableRooms")
public class CheckAvailableRooms extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RoomDAO roomDAO = new RoomDAO();
    private ReservationDAO reservationDAO = new ReservationDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");
        String guestsStr = request.getParameter("guests");

        // System log
        System.out.println("===== CheckAvailabilityServlet =====");
        System.out.println("Received parameters:");
        System.out.println("checkIn = " + checkInStr);
        System.out.println("checkOut = " + checkOutStr);
        System.out.println("guests = " + guestsStr);

        if (checkInStr == null || checkOutStr == null || guestsStr == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            int guests = Integer.parseInt(guestsStr);
            LocalDate checkIn = LocalDate.parse(checkInStr);
            LocalDate checkOut = LocalDate.parse(checkOutStr);

            // Fetch all rooms that can accommodate the number of guests
            List<Room> allRooms = roomDAO.getRoomsByCapacity(guests);
            System.out.println("Rooms with enough capacity: " + allRooms.size());

            List<Room> availableRooms = new ArrayList<>();

            for (Room room : allRooms) {
                List<Reservation> reservations = reservationDAO.getReservationsByRoomId(room.getRoomId());

                boolean isAvailable = true;
                for (Reservation res : reservations) {
                    LocalDate existingCheckIn = res.getCheckInDate();
                    LocalDate existingCheckOut = res.getCheckOutDate();

                    // Check for overlapping dates
                    if (!(checkOut.isBefore(existingCheckIn) || checkIn.isAfter(existingCheckOut))) {
                        isAvailable = false;
                        break;
                    }
                }

                if (isAvailable) {
                    availableRooms.add(room);
                }
            }

            System.out.println("Available rooms after filtering: " + availableRooms.size());

            // Set attributes and forward to JSP
            request.setAttribute("availableRooms", availableRooms);
            request.setAttribute("checkIn", checkInStr);
            request.setAttribute("checkOut", checkOutStr);
            request.setAttribute("guests", guests);

            request.getRequestDispatcher("/views/customer/AvailableRooms.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}