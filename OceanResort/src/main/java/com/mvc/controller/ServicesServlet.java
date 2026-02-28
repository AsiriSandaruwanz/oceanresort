package com.mvc.controller;

import com.mvc.dao.RoomDAO;
import com.mvc.dao.ServiceDAO;
import com.mvc.model.Room;
import com.mvc.model.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/services")
public class ServicesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ServiceDAO serviceDAO = new ServiceDAO();

    // ---------------- GET Requests ----------------
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action != null ? action : "") {

            case "new":
                // Fetch all rooms to populate dropdown
                List<Room> roomList = new RoomDAO().getAllRooms();
                request.setAttribute("roomList", roomList);

                // Show Add Service form
                request.setAttribute("pageTitle", "Add Service");
                request.setAttribute("contentPage", "/views/admin/services/add-service.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
                       .forward(request, response);
                break;

            case "edit":
                // Show Edit Service form
                int editId = Integer.parseInt(request.getParameter("id"));
                Service service = serviceDAO.getServiceById(editId);

                // Get all rooms for the dropdown
                List<Room> roomLists = new RoomDAO().getAllRooms();

                request.setAttribute("service", service);
                request.setAttribute("roomList", roomLists); // <-- send rooms to JSP
                request.setAttribute("pageTitle", "Edit Service");
                request.setAttribute("contentPage", "/views/admin/services/edit-service.jsp");
                request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
                       .forward(request, response);
                break;

            case "delete":
                // Delete service
                int deleteId = Integer.parseInt(request.getParameter("id"));
                serviceDAO.deleteService(deleteId);
                response.sendRedirect(request.getContextPath() + "/services");
                break;

            default:
            	// Show list of services
            	List<Service> serviceList = serviceDAO.getAllServices();

            	// Fetch all rooms to get room titles
            	List<Room> roomListx = new RoomDAO().getAllRooms();
            	Map<Integer, String> roomMap = new HashMap<>();
            	for (Room r : roomListx) {
            	    roomMap.put(r.getRoomId(), r.getTitle()); // <-- use title here
            	}

            	request.setAttribute("serviceList", serviceList);
            	request.setAttribute("roomMap", roomMap); // Pass the room map to JSP
            	request.setAttribute("pageTitle", "Manage Services");
            	request.setAttribute("contentPage", "/views/admin/services-content.jsp");
            	request.getRequestDispatcher("/views/layouts/admin-layout.jsp")
            	       .forward(request, response);
        }
    }

    // ---------------- POST Requests ----------------
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action) || "update".equals(action)) {

            // 1️⃣ Get form fields
            String name = request.getParameter("name");
            double price = 0;
            int roomId = 0;

            try { price = Double.parseDouble(request.getParameter("price")); } catch(Exception e){}
            try { roomId = Integer.parseInt(request.getParameter("roomId")); } catch(Exception e){}

            // 2️⃣ Create Service object
            Service service = new Service();
            service.setName(name);
            service.setPrice(price);
            service.setRoomId(roomId);

            // 3️⃣ Insert or Update
            if ("update".equals(action)) {
                int serviceId = Integer.parseInt(request.getParameter("serviceId"));
                service.setServiceId(serviceId);
                serviceDAO.updateService(service);
            } else {
                serviceDAO.insertService(service);
            }

            // 4️⃣ Redirect to service list
            response.sendRedirect(request.getContextPath() + "/services");
        }
    }
}