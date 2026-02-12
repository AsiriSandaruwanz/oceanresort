<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctx = request.getContextPath();
    com.mvc.model.User loggedUser = (com.mvc.model.User) session.getAttribute("loggedUser");
    if (loggedUser == null) {
        response.sendRedirect(ctx + "/views/login.jsp");
        return;
    }
%>

<jsp:include page="/components/customer/header.jsp" />

<!-- Custom Styles -->
<style>
    .profile-container {
        padding-top: 60px;
        padding-bottom: 60px;
    }
    .card-subtitle {
        font-size: 1rem;
        color: #6c757d;
    }
    .tab-pane {
        padding-top: 20px;
    }
    .profile-card img {
        max-width: 150px;
        border-radius: 50%;
        margin-bottom: 15px;
    }
</style>

<div class="container profile-container">
    <!-- Header with Logout -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1>My Profile</h1>
            <p class="text-muted">Manage your profile, reservations, and feedback easily</p>
        </div>
        <div>
            <a href="<%= ctx %>/logout" class="btn btn-outline-danger" onclick="return confirm('Are you sure you want to logout?');">Logout</a>
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
                        <h3>John Doe</h3>
                        <p class="card-subtitle mb-4">Customer</p>

                        <form>
                            <div class="mb-3 text-start">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" value="John Doe">
                            </div>
                            <div class="mb-3 text-start">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" value="john@example.com" readonly>
                            </div>
                            <div class="mb-3 text-start">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="phone" value="+1234567890">
                            </div>
                            <button type="button" class="btn btn-primary w-100">Update Profile</button>
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
                <div class="col-lg-8">
                    <div class="card shadow p-4">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Reservation ID</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Guests</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>R001</td>
                                    <td>2026-02-15</td>
                                    <td>7:00 PM</td>
                                    <td>2</td>
                                    <td><span class="badge bg-success">Confirmed</span></td>
                                </tr>
                                <tr>
                                    <td>R002</td>
                                    <td>2026-02-20</td>
                                    <td>8:30 PM</td>
                                    <td>4</td>
                                    <td><span class="badge bg-warning text-dark">Pending</span></td>
                                </tr>
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
                <div class="col-lg-8">
                    <div class="card shadow p-4">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Feedback ID</th>
                                    <th>Reservation ID</th>
                                    <th>Message</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>F001</td>
                                    <td>R001</td>
                                    <td>Great service!</td>
                                    <td>2026-02-16</td>
                                </tr>
                                <tr>
                                    <td>F002</td>
                                    <td>R002</td>
                                    <td>Table was not ready on time.</td>
                                    <td>2026-02-21</td>
                                </tr>
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
