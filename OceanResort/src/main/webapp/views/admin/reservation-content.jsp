<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Reservation" %>

<table id="reservationTable" class="table table-bordered table-striped">
<thead>
<tr>
  <th>ID</th>
  <th>Guest Name</th>
  <th>Phone</th>
  <th>Members</th>
  <th>Check-In</th>
  <th>Check-Out</th>
  <th>Status</th>
</tr>
</thead>

<tbody>
<%
List<Reservation> reservationList =
    (List<Reservation>) request.getAttribute("reservationList");

if (reservationList != null && !reservationList.isEmpty()) {
    for (Reservation res : reservationList) {
%>

<tr>
  <td><%= res.getReservationId() %></td>
  <td><%= res.getGuestName() %></td>
  <td><%= res.getPhoneNumber() %></td>
  <td><%= res.getMembers() %></td>
  <td><%= res.getCheckInDate() %></td>
  <td><%= res.getCheckOutDate() %></td>

  <td>
    <form method="post" action="<%=request.getContextPath()%>/reservations">
        <input type="hidden" name="action" value="updateStatus">
        <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>">

        <select name="status"
                class="form-control form-control-sm"
                onchange="this.form.submit()">

            <option value="PENDING"
                <%= "PENDING".equals(res.getReservationStatus()) ? "selected" : "" %>>
                Pending
            </option>

            <option value="CONFIRMED"
                <%= "CONFIRMED".equals(res.getReservationStatus()) ? "selected" : "" %>>
                Confirmed
            </option>

            <option value="CANCELLED"
                <%= "CANCELLED".equals(res.getReservationStatus()) ? "selected" : "" %>>
                Cancelled
            </option>

        </select>
    </form>
  </td>
</tr>

<%
    }
} else {
%>
<tr>
  <td colspan="7" class="text-center">No reservations found</td>
</tr>
<%
}
%>
</tbody>
</table>

<script>
$(document).ready(function () {
    $('#reservationTable').DataTable({
        "responsive": true,
        "autoWidth": false
    });
});
</script>