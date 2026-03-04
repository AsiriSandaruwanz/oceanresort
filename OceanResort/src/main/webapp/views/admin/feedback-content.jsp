<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Feedback" %>

<div class="content-header">
  <div class="container-fluid d-flex justify-content-between align-items-center">
    <h1 class="m-0">Feedback Management</h1>

    <!-- OPTIONAL ADD BUTTON (Remove if not needed) -->
    <!--
    <a href="<%=request.getContextPath()%>/feedbacks?action=new"
        class="btn btn-primary">
        <i class="fas fa-plus"></i> Add Feedback
    </a>
    -->
  </div>
</div>

<section class="content">
  <div class="container-fluid">
    <div class="card">

      <div class="card-body">

        <table id="feedbackTable" class="table table-bordered table-striped">
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Rating</th>
              <th>Review</th>
              <th>Room ID</th>
              <th>Date</th>
              <th width="120">Actions</th>
            </tr>
          </thead>

          <tbody>
          <%
              List<Feedback> feedbackList =
                  (List<Feedback>) request.getAttribute("feedbackList");

              if (feedbackList != null && !feedbackList.isEmpty()) {
                  for (Feedback fb : feedbackList) {
          %>

            <tr>
              <td><%= fb.getFeedbackId() %></td>
              <td><%= fb.getName() %></td>
              <td><%= fb.getEmail() %></td>

              <!-- RATING COLUMN -->
              <td>
                <span class="badge badge-warning">
                  <%= fb.getRating() %> ★
                </span>
              </td>

              <!-- REVIEW COLUMN (SHORTENED) -->
              <td>
                <%
                    String review = fb.getReview();
                    if (review != null && review.length() > 60) {
                        out.print(review.substring(0, 60) + "...");
                    } else {
                        out.print(review);
                    }
                %>
              </td>

              <td><%= fb.getRoomId() %></td>
              <td><%= fb.getFeedbackDate() %></td>

              <!-- ACTION BUTTONS -->
              <td>
                <!-- DELETE -->
                <a href="<%=request.getContextPath()%>/feedbacks?action=delete&id=<%=fb.getFeedbackId()%>"
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
                <td colspan="8" class="text-center">No feedback found</td>
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
      $('#feedbackTable').DataTable({
          "responsive": true,
          "autoWidth": false
      });
  });
</script>