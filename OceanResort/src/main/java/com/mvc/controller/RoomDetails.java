package com.mvc.controller;

import com.mvc.dao.RoomDAO;
import com.mvc.model.Room;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet implementation class RoomDetailsServlet
 * Displays detailed information about a single room for customers
 */
@WebServlet("/room-details")
public class RoomDetails extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RoomDAO roomDAO = new RoomDAO();

    /**
     * Handles GET requests to show room details
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("RoomDetailsServlet: doGet called"); // debug

        // 1️⃣ Get roomId from request parameter
        String roomIdParam = request.getParameter("roomId");
        Room room = null;

        if (roomIdParam != null && !roomIdParam.isEmpty()) {
            try {
                int roomId = Integer.parseInt(roomIdParam);

                // 2️⃣ Fetch room details from database
                room = roomDAO.getRoomById(roomId);

            } catch (NumberFormatException e) {
                System.err.println("Invalid roomId: " + roomIdParam);
            }
        }

        // 3️⃣ Handle missing or invalid room
        if (room == null) {
            // Redirect back to the rooms list if room not found
            response.sendRedirect(request.getContextPath() + "/room");
            return;
        }

        // 4️⃣ Set room object in request for JSP access
        request.setAttribute("room", room);

        // 5️⃣ Forward to the room-details JSP
        request.getRequestDispatcher("/views/customer/room-details.jsp")
               .forward(request, response);
    }

    /**
     * Handles POST requests (simply forwards to doGet)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}