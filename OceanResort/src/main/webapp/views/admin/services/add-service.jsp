<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Room" %>

<%
    // Get the list of rooms sent from ServicesServlet
    List<Room> roomList = (List<Room>) request.getAttribute("roomList");
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white">
                    <h4 class="mb-0">Add Service</h4>
                </div>

                <div class="card-body">

                    <form action="<%=request.getContextPath()%>/services"
                          method="post">

                        <input type="hidden" name="action" value="insert"/>

                        <!-- ================= SERVICE INFO ================= -->
                        <div class="mb-3">
                            <label class="form-label">Service Name</label>
                            <input type="text" name="name"
                                   class="form-control"
                                   placeholder="Enter service name"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" name="price"
                                   step="0.01"
                                   class="form-control"
                                   placeholder="Enter price"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Assign to Room</label>
                            <select name="roomId" class="form-select" required>
                                <option value="">-- Select Room --</option>
                                <%
                                    if (roomList != null) {
                                        for (Room room : roomList) {
                                %>
                                    <option value="<%=room.getRoomId()%>">
                                        <%=room.getTitle()%> (Room #: <%=room.getRoomNumber()%>)
                                    </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="<%=request.getContextPath()%>/services"
                               class="btn btn-outline-secondary">
                                Cancel
                            </a>
                            <button type="submit"
                                    class="btn btn-primary">
                                Add Service
                            </button>
                        </div>

                    </form>

                </div>
            </div>

        </div>
    </div>
</div>