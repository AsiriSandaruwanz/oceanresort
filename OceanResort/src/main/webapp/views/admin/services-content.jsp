<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.mvc.model.Service" %>

<div class="content-header">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <h1 class="m-0">Service Management</h1>

        <!-- ADD SERVICE BUTTON -->
        <a href="<%=request.getContextPath()%>/services?action=new" class="btn btn-primary">
            <i class="fas fa-plus"></i> Add Service
        </a>
    </div>
</div>

<section class="content">
    <div class="container-fluid">
        <div class="card">

            <div class="card-body">
                <table id="serviceTable" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Service Name</th>
                            <th>Price</th>
                            <th>Room</th>
                            <th width="120">Actions</th>
                        </tr>
                    </thead>

                    <tbody>
                    <%
                        List<Service> serviceList = (List<Service>) request.getAttribute("serviceList");
                        Map<Integer, String> roomMap = (Map<Integer, String>) request.getAttribute("roomMap");

                        if (serviceList != null && !serviceList.isEmpty()) {
                            for (Service service : serviceList) {
                                String roomName = roomMap.get(service.getRoomId());
                    %>
                        <tr>
                            <td><%= service.getServiceId() %></td>
                            <td><%= service.getName() %></td>
                            <td>$<%= service.getPrice() %></td>
                            <td><%= roomName != null ? roomName : "N/A" %></td>

                            <!-- ACTION BUTTONS -->
                            <td>
                                <a href="<%=request.getContextPath()%>/services?action=edit&id=<%=service.getServiceId()%>"
                                   class="btn btn-sm btn-warning">
                                   Edit
                                </a>

                                <a href="<%=request.getContextPath()%>/services?action=delete&id=<%=service.getServiceId()%>"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this service?')">
                                   Delete
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" class="text-center">No services found</td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</section>

<!-- DATATABLE SCRIPT -->
<script>
    $(document).ready(function () {
        $('#serviceTable').DataTable({
            "responsive": true,
            "autoWidth": false
        });
    });
</script>