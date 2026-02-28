package com.mvc.controller;

import com.mvc.dao.RoomDAO;
import com.mvc.model.Room;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/room") // URL becomes: /yourProject/room
public class RoomsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private RoomDAO roomDAO = new RoomDAO(); // use DAO

    public RoomsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch all rooms from database
        List<Room> roomList = roomDAO.getAllRooms();

        // Send list to JSP
        request.setAttribute("roomList", roomList);

        // Forward to JSP
        request.getRequestDispatcher("/views/customer/rooms.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
