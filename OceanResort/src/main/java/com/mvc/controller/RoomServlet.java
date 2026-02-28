package com.mvc.controller;

import com.mvc.dao.RoomDAO;
import com.mvc.model.Room;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/rooms")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // 1 MB
    maxFileSize = 1024 * 1024 * 5,          // 5 MB
    maxRequestSize = 1024 * 1024 * 10       // 10 MB
)
public class RoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RoomDAO roomDAO = new RoomDAO();

    // ---------------- GET requests ----------------
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action != null ? action : "") {

            case "new":
                // Show Add Room form
                request.setAttribute("pageTitle", "Add Room");
                request.setAttribute("contentPage", "/views/admin/Rooms/add-room.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
                break;

            case "edit":
                // Show Edit Room form
                int editId = Integer.parseInt(request.getParameter("id"));
                Room room = roomDAO.getRoomById(editId);
                request.setAttribute("room", room);
                request.setAttribute("pageTitle", "Edit Room");
                request.setAttribute("contentPage", "/views/admin/Rooms/edit-room.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
                break;

            case "delete":
                // Delete room
                int deleteId = Integer.parseInt(request.getParameter("id"));
                roomDAO.deleteRoom(deleteId);
                response.sendRedirect(request.getContextPath() + "/rooms");
                break;

            default:
                // Show room list
                List<Room> roomList = roomDAO.getAllRooms();
                request.setAttribute("roomList", roomList);
                request.setAttribute("pageTitle", "Manage Rooms");
                request.setAttribute("contentPage", "/views/admin/rooms-content.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp").forward(request, response);
                break;
        }
    }

    // ---------------- POST requests ----------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action) || "update".equals(action)) {

            // 1️⃣ Get form fields
            String roomNumber = request.getParameter("roomNumber");
            String title = request.getParameter("title");
            String bedType = request.getParameter("bedType");
            String size = request.getParameter("size");
            String amenities = request.getParameter("amenities");

            double pricePerNight = 0;
            int capacity = 0;
            try { pricePerNight = Double.parseDouble(request.getParameter("pricePerNight")); } catch(Exception e){}
            try { capacity = Integer.parseInt(request.getParameter("capacity")); } catch(Exception e){}

            // 2️⃣ Handle image upload
            Part filePart = request.getPart("image");
            String fileName = filePart != null ? filePart.getSubmittedFileName() : null;

            String uploadPath = getServletContext().getRealPath("") + "uploads";
            java.io.File uploadDir = new java.io.File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String imagePath = request.getParameter("existingImage"); // fallback for update
            if (fileName != null && !fileName.isEmpty()) {
                filePart.write(uploadPath + java.io.File.separator + fileName);
                imagePath = "uploads/" + fileName;
            }

            // 🔹 Log incoming data
            System.out.println("===== Room Form Data =====");
            System.out.println("Room Number: " + roomNumber);
            System.out.println("Title: " + title);
            System.out.println("Bed Type: " + bedType);
            System.out.println("Size: " + size);
            System.out.println("Amenities: " + amenities);
            System.out.println("Price Per Night: " + pricePerNight);
            System.out.println("Capacity: " + capacity);
            System.out.println("Image File Name: " + fileName);
            System.out.println("Image Path: " + imagePath);
            System.out.println("==========================");

            // 3️⃣ Create Room object
            Room room = new Room();
            room.setRoomNumber(roomNumber);
            room.setTitle(title);
            room.setBedType(bedType);
            room.setSize(size);
            room.setAmenities(amenities);
            room.setPricePerNight(pricePerNight);
            room.setCapacity(capacity);
            room.setImagePath(imagePath);

            if ("update".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                room.setRoomId(roomId);
                roomDAO.updateRoom(room);
            } else {
                roomDAO.insertRoom(room);
            }

            // 4️⃣ Redirect to room list
            response.sendRedirect(request.getContextPath() + "/rooms");
        }
    }
}