<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Reservation" %>
<%@ page import="com.mvc.model.User" %>
<%@ page import="com.mvc.model.Feedback" %>

<%
    String ctx = request.getContextPath();
    User loggedUser = (User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        response.sendRedirect(ctx + "/views/login.jsp");
        return;
    }
%>

<jsp:include page="/components/customer/header.jsp" />

<!-- Custom Styles -->
<style>
    .profile-container { padding-top: 60px; padding-bottom: 60px; }
    .card-subtitle { font-size: 1rem; color: #6c757d; }
    .tab-pane { padding-top: 20px; }
    .profile-card img { max-width: 150px; border-radius: 50%; margin-bottom: 15px; }
    .btn-pay-now {
        border: 2px solid #ff6600; background-color: #fff; color: #ff6600;
        font-weight: bold; border-radius: 5px; min-width: 120px; height: 30px;
        line-height: 26px; font-size: 14px; padding: 0 15px; text-align: center; cursor: pointer;
        transition: all 0.3s ease;
    }
    .btn-pay-now:hover { background-color: #ff6600; color: #fff; }
</style>

<div class="container profile-container">
    <!-- Header with Logout -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1>My Profile</h1>
            <p class="text-muted">Manage your profile, reservations, and feedback easily</p>
        </div>
        <div>
            <a href="<%= ctx %>/logout" class="btn btn-outline-danger"
               onclick="return confirm('Are you sure you want to logout?');">Logout</a>
        </div>
    </div>

    <!-- Tabs Navigation -->
    <ul class="nav nav-tabs justify-content-center mb-4" id="profileTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" type="button" role="tab">Profile Info</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="reservations-tab" data-bs-toggle="tab" data-bs-target="#reservations" type="button" role="tab">Reservations</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="feedback-tab" data-bs-toggle="tab" data-bs-target="#feedback" type="button" role="tab">Feedback</button>
        </li>
    </ul>

    <!-- Tabs Content -->
    <div class="tab-content" id="profileTabsContent">

        <!-- Profile Info Tab -->
        <div class="tab-pane fade show active" id="info" role="tabpanel">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card shadow profile-card text-center p-4">
                        <img src="<%= ctx %>/images/default-avatar.png" alt="Profile Picture">
                        <h3><%= ((User)request.getAttribute("userProfile")).getName() %></h3>
                        <p class="card-subtitle mb-4"><%= ((User)request.getAttribute("userProfile")).getRole() %></p>

                        <form method="post" action="<%= ctx %>/profile">
                            <div class="mb-3 text-start">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control" id="fullName"
                                       value="<%= ((User)request.getAttribute("userProfile")).getName() %>">
                            </div>
                            <div class="mb-3 text-start">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" id="email"
                                       value="<%= ((User)request.getAttribute("userProfile")).getEmail() %>" readonly>
                            </div>
                            <div class="mb-3 text-start">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" name="phone" class="form-control" id="phone"
                                       value="<%= ((User)request.getAttribute("userProfile")).getPhone() %>">
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Update Profile</button>
                        </form>                        
                    </div>
                </div>
            </div>
        </div>

        <!-- Reservations Tab -->
        <div class="tab-pane fade" id="reservations" role="tabpanel">
            <h3 class="mb-3 text-center">Your Reservations</h3>
            <p class="text-center text-muted mb-4">Keep track of your upcoming and past reservations</p>
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="card shadow p-4">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Reservation ID</th>
                                    <th>Guest Name</th>
                                    <th>Phone</th>
                                    <th style="min-width: 250px;">Address</th>
                                    <th>Check-In</th>
                                    <th>Check-Out</th>
                                    <th>Guests</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Reservation> reservations = 
                                        (List<Reservation>) request.getAttribute("userReservations");
                                    if (reservations != null && !reservations.isEmpty()) {
                                        for (Reservation res : reservations) {
                                %>
                                <tr>
                                    <td><%= res.getReservationId() %></td>
                                    <td><%= res.getGuestName() %></td>
                                    <td><%= res.getPhoneNumber() %></td>
                                    <td style="max-width:400px; word-wrap:break-word;"><%= res.getAddress() %></td>
                                    <td><%= res.getCheckInDate() %></td>
                                    <td><%= res.getCheckOutDate() %></td>
                                    <td><%= res.getMembers() %></td>
                                    <td>
                                        <% if ("Confirmed".equalsIgnoreCase(res.getReservationStatus())) { %>
                                            <span class="badge bg-success"><%= res.getReservationStatus() %></span>
                                        <% } else if ("Pending".equalsIgnoreCase(res.getReservationStatus())) { %>
                                            <span class="badge bg-warning text-dark"><%= res.getReservationStatus() %></span>
                                        <% } else { %>
                                            <span class="badge bg-secondary"><%= res.getReservationStatus() %></span>
                                        <% } %>
                                    </td>
                                    <td>
                                       <% if (!"Paid".equalsIgnoreCase(res.getReservationStatus())) { %>
                                           <form method="post" action="<%= ctx %>/payment">
                                               <input type="hidden" name="reservationId" value="<%= res.getReservationId() %>">
                                               <button type="submit" class="btn-pay-now">Pay Now</button>
                                           </form>
                                       <% } else { %>
                                           <span class="text-success">Paid</span>
                                       <% } %>
                                   </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="9" class="text-center text-muted">No reservations found.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Feedback Tab -->
        <div class="tab-pane fade" id="feedback" role="tabpanel">
            <h3 class="mb-3 text-center">Your Feedback</h3>
            <p class="text-center text-muted mb-4">View feedback you have given for your reservations</p>
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card shadow p-4">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Feedback ID</th>
                                    <th>Room ID</th>
                                    <th>Rating</th>
                                    <th>Message</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Feedback> userFeedbacks = (List<Feedback>) request.getAttribute("userFeedbacks");
                                    if (userFeedbacks != null && !userFeedbacks.isEmpty()) {
                                        for (Feedback fb : userFeedbacks) {
                                %>
                                <tr>
                                    <td><%= fb.getFeedbackId() %></td>
                                    <td><%= fb.getRoomId() %></td>
                                    <td><%= fb.getRating() %></td>
                                    <td><%= fb.getReview() %></td>
                                    <td><%= fb.getFeedbackDate() %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center text-muted">No feedbacks found.</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/components/customer/footer.jsp" />

<!-- Bootstrap JS for tabs -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>