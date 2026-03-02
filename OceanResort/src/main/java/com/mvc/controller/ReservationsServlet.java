package com.mvc.controller;

import com.mvc.dao.ReservationDAO;
import com.mvc.dao.RoomDAO;
import com.mvc.model.Reservation;
import com.mvc.model.Room;
import com.mvc.model.User;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ReservationsServlet")
public class ReservationsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private RoomDAO roomDAO = new RoomDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Get roomId from URL
        String roomIdParam = request.getParameter("roomId");

        if (roomIdParam == null || roomIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        try {
            int roomId = Integer.parseInt(roomIdParam);

            // 2️⃣ Get room from database
            Room room = roomDAO.getRoomById(roomId);

            if (room == null) {
                response.sendRedirect(request.getContextPath() + "/room");
                return;
            }

            // 3️⃣ Send room to JSP
            request.setAttribute("room", room);

            // 4️⃣ Forward to reservations.jsp
            request.getRequestDispatcher("/views/customer/reservations.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/room");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // 1️⃣ Check logged user
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("loggedUser") == null) {
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
                return;
            }

            // 2️⃣ Get logged user
            User user = (User) session.getAttribute("loggedUser");

            // 3️⃣ Get form data
            int roomId = Integer.parseInt(request.getParameter("roomId"));

            String guestName = request.getParameter("guestName");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");

            int members = Integer.parseInt(request.getParameter("members"));

            LocalDate checkInDate =
                    LocalDate.parse(request.getParameter("checkIn"));

            LocalDate checkOutDate =
                    LocalDate.parse(request.getParameter("checkOut"));

            // 4️⃣ Create Reservation object
            Reservation reservation = new Reservation();

            reservation.setGuestName(guestName);
            reservation.setPhoneNumber(phoneNumber);
            reservation.setAddress(address);
            reservation.setMembers(members);
            reservation.setCheckInDate(checkInDate);
            reservation.setCheckOutDate(checkOutDate);
            reservation.setReservationStatus("PENDING"); // default
            reservation.setRoomId(roomId);
            reservation.setUserId(user.getUserId());
            reservation.setPaymentId(null); // NULL initially

            // 5️⃣ Save to database
            ReservationDAO dao = new ReservationDAO();
            dao.insertReservation(reservation);

            // 6️⃣ Redirect after success
            response.sendRedirect(request.getContextPath()
                    + "/room-details?roomId=" + roomId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/room");
        }
    }
}
