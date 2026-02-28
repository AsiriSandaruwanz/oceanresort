package com.mvc.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/room")   // URL becomes: /yourProject/room
public class RoomsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RoomsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("RoomsServlet: doGet called"); // debug

        // If needed, you can send data here
        // request.setAttribute("roomList", someData);

        request.getRequestDispatcher("/views/customer/rooms.jsp")
               .forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
