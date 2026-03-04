<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Payment" %>

<%
    List<Payment> payments = (List<Payment>) request.getAttribute("payments");
    String ctx = request.getContextPath();
%>

<div class="container-fluid">

    <h3 class="mb-4">All Payments</h3>

    <div class="card shadow p-3">

        <table id="paymentTable" class="display table table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Method</th>
                    <th>Amount</th>
                    <th>Date</th>
                    <th>Status</th>
                    <th>Slip</th>
                </tr>
            </thead>

            <tbody>
                <% if (payments != null) {
                    for (Payment p : payments) { %>

                <tr>
                    <td><%= p.getPaymentId() %></td>
                    <td><%= p.getPaymentMethod() %></td>
                    <td>₹ <%= p.getAmount() %></td>
                    <td><%= p.getPaymentDate() %></td>
                    <td>
                        <% if ("Paid".equalsIgnoreCase(p.getPaymentStatus())) { %>
                            <span class="badge bg-success">Paid</span>
                        <% } else { %>
                            <span class="badge bg-warning text-dark">
                                <%= p.getPaymentStatus() %>
                            </span>
                        <% } %>
                    </td>

                    <td>
    <% if (p.getSlipImage() != null) { %>

        <!-- Thumbnail -->
        <a href="#" data-bs-toggle="modal"
           data-bs-target="#imgModal<%=p.getPaymentId()%>">

            <img src="<%= ctx %>/uploads/<%= p.getSlipImage() %>"
                 width="60"
                 height="60"
                 style="object-fit:cover; border-radius:5px;">
        </a>

        <!-- Modal for Large Image -->
        <div class="modal fade"
             id="imgModal<%=p.getPaymentId()%>"
             tabindex="-1"
             aria-labelledby="imgModalLabel<%=p.getPaymentId()%>"
             aria-hidden="true">

            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="imgModalLabel<%=p.getPaymentId()%>">
                            Payment Slip - <%= p.getPaymentId() %>
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <div class="modal-body text-center">
                        <img src="<%= ctx %>/uploads/<%= p.getSlipImage() %>"
                             class="img-fluid rounded">
                    </div>
                </div>
            </div>

        </div>

    <% } else { %>
        No Image
    <% } %>
</td>
                </tr>

                <% } } %>
            </tbody>

        </table>

    </div>
</div>

<!-- Initialize DataTable -->
<script>
    $(document).ready(function () {
        $('#paymentTable').DataTable({
            "pageLength": 5,
            "lengthMenu": [5, 10, 25, 50],
            "ordering": true
        });
    });
</script>