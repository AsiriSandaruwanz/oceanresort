<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Room" %>

<div class="content-header">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <h1 class="m-0">Room Management</h1>

    <!-- ADD ROOM BUTTON -->
    <a href="<%=request.getContextPath()%>/rooms?action=new"
        class="btn btn-primary">
        <i class="fas fa-plus"></i> Add Room
    </a>
  </div>
</div>

<section class="content">
  <div class="container-fluid">
    <div class="card">

      <div class="card-body">

        <table id="roomTable" class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Image</th>
              <th>Room Number</th>
              <th>Title</th>
              <th>Bed Type</th>
              <th>Price</th>
              <th>Capacity</th>
              <th width="120">Actions</th>
            </tr>
          </thead>

          <tbody>
          <%
              List<Room> roomList = (List<Room>) request.getAttribute("roomList");

              if (roomList != null && !roomList.isEmpty()) {
                  for (Room room : roomList) {
          %>

            <tr>
              <td><%= room.getRoomId() %></td>

              <!-- IMAGE COLUMN -->
              <td>
                <%
                    String imagePath = room.getImagePath();
                    if (imagePath != null && !imagePath.isEmpty()) {
                %>
                    <img src="<%=request.getContextPath()%>/<%= imagePath %>"
                         width="80"
                         height="60"
                         style="object-fit:cover; border-radius:5px;">
                <%
                    } else {
                %>
                    <span class="text-muted">No Image</span>
                <%
                    }
                %>
              </td>

              <td><%= room.getRoomNumber() %></td>
              <td><%= room.getTitle() %></td>
              <td><%= room.getBedType() %></td>
              <td>$<%= room.getPricePerNight() %></td>
              <td><%= room.getCapacity() %></td>

              <!-- ACTION BUTTONS -->
              <td>
                <!-- EDIT -->
               <a href="<%=request.getContextPath()%>/rooms?action=edit&id=<%=room.getRoomId()%>"
                  class="btn btn-sm btn-warning">
                  Edit
               </a>

               <!-- DELETE -->
               <a href="<%=request.getContextPath()%>/rooms?action=delete&id=<%=room.getRoomId()%>"
                  class="btn btn-sm btn-danger"
                  onclick="return confirm('Are you sure?')">
                  Delete
               </a>
              </td>
            </tr>

          <%
                  }
              } else {
          %>
              <tr>
                <td colspan="8" class="text-center">No rooms found</td>
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
      $('#roomTable').DataTable({
          "responsive": true,
          "autoWidth": false
      });
  });
</script>