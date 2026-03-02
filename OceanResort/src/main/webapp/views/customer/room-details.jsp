<%@ page import="com.mvc.model.Room" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.User" %>
<%@ page import="com.mvc.model.Feedback" %>

<%
    String path = request.getContextPath();
    Room room = (Room) request.getAttribute("room");
    List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");

    // Get logged-in user from session
    User loggedUser = (User) session.getAttribute("loggedUser");
%>

<jsp:include page="/components/customer/header.jsp" />

<!-- Breadcrumb Section Begin -->
<div class="breadcrumb-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb-text">
                    <h2>Our Rooms</h2>
                    <div class="bt-option">
                        <a href="<%=path%>/views/customer/index.jsp">Home</a>
                        <span>Rooms</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb Section End -->

<% if (room != null) { %>

<section class="room-details-section spad">
    <div class="container">
        <div class="row">

            <!-- ================= LEFT SIDE ================= -->
            <div class="col-lg-8">
                <div class="room-details-item">

                    <!-- Dynamic Image (Original Size Preserved) -->
                    <img src="<%=path%>/<%=room.getImagePath()%>" 
                         alt="<%=room.getTitle()%>"
                         style="width:100%; height:500px; object-fit:cover;">

                    <div class="rd-text">
                        <div class="rd-title">
                            <h3><%=room.getTitle()%></h3>

                            <div class="rdt-right">
                                <div class="rating">
                                    <%
                                        double avgRating = 0;
                                        if (feedbackList != null && !feedbackList.isEmpty()) {
                                            int total = 0;
                                            for (Feedback fb : feedbackList) total += fb.getRating();
                                            avgRating = (double) total / feedbackList.size();
                                        }
                                        for (int i = 1; i <= 5; i++) {
                                            if (i <= Math.round(avgRating)) { %>
                                                <i class="icon_star"></i>
                                            <% } else { %>
                                                <i class="icon_star_alt"></i>
                                            <% }
                                        }
                                    %>
                                </div>
                               <a href="<%=request.getContextPath()%>/ReservationsServlet?roomId=<%=room.getRoomId()%>" 
                                  class="primary-btn">
                                  Booking Now
                               </a>
                            </div>
                        </div>

                        <h2>$<%=room.getPricePerNight()%><span>/Per night</span></h2>

                        <table>
                            <tbody>
                                <tr>
                                    <td class="r-o">Size:</td>
                                    <td><%=room.getSize()%></td>
                                </tr>
                                <tr>
                                    <td class="r-o">Capacity:</td>
                                    <td>Max person <%=room.getCapacity()%></td>
                                </tr>
                                <tr>
                                    <td class="r-o">Bed:</td>
                                    <td><%=room.getBedType()%></td>
                                </tr>
                                <tr>
                                    <td class="r-o">Services:</td>
                                    <td><%=room.getAmenities()%></td>
                                </tr>
                            </tbody>
                        </table>

                        <p class="f-para">
                            Experience luxury and comfort in our <%=room.getTitle()%>.
                        </p>
                        <p>
                            Designed with premium facilities to ensure a relaxing and memorable stay.
                        </p>
                    </div>
                </div>

                <!-- ================= REVIEWS ================= -->
                <div class="rd-reviews">
                    <h4>Reviews (<%=feedbackList != null ? feedbackList.size() : 0%>)</h4>

                    <% if (feedbackList != null && !feedbackList.isEmpty()) {
                        for (Feedback fb : feedbackList) { %>
                            <div class="review-item">
                                <div class="ri-text">
                                    <span><%=fb.getFeedbackDate()%></span>
                                    <div class="rating">
                                        <% for (int i = 1; i <= fb.getRating(); i++) { %>
                                            <i class="icon_star"></i>
                                        <% } %>
                                        <% for (int i = fb.getRating()+1; i <= 5; i++) { %>
                                            <i class="icon_star_alt"></i>
                                        <% } %>
                                    </div>
                                    <h5><%=fb.getName()%></h5>
                                    <p><%=fb.getReview()%></p>
                                </div>
                            </div>
                    <% } } else { %>
                        <p>No reviews yet.</p>
                    <% } %>
                </div>

                <!-- ================= ADD REVIEW ================= -->
                <div class="review-add">
                    <h4>Add Review</h4>
                    <form action="<%=path%>/room-details" method="post" class="ra-form">
                        <input type="hidden" name="roomId" value="<%=room.getRoomId()%>">
                        
                        <% if (loggedUser != null) { %>
                            <input type="hidden" name="userId" value="<%= loggedUser.getUserId() %>">
                        <% } %>
 
                        <div class="row">
                            <div class="col-lg-6">
                                <input type="text" name="name" placeholder="Name*" required>
                            </div>
                            <div class="col-lg-6">
                                <input type="email" name="email" placeholder="Email*" required>
                            </div>
                            <div class="col-lg-12">
                                <div>
                                    <h5>Your Rating:</h5>
                                    <!-- Star Rating -->
                                    <div class="star-rating">
                                        <input type="radio" id="star5" name="rating" value="5" required>
                                        <label for="star5"></label>
                                        <input type="radio" id="star4" name="rating" value="4">
                                        <label for="star4"></label>
                                        <input type="radio" id="star3" name="rating" value="3">
                                        <label for="star3"></label>
                                        <input type="radio" id="star2" name="rating" value="2">
                                        <label for="star2"></label>
                                        <input type="radio" id="star1" name="rating" value="1">
                                        <label for="star1"></label>
                                    </div>
                                </div>

                                <textarea name="review" placeholder="Your Review*" required></textarea>
                                <button type="submit">Submit Now</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>

<!-- ================= RIGHT SIDE ================= -->
<div class="col-lg-4">
    <div class="room-booking">
        <h3>Your Reservation</h3>

        <form action="<%= path %>/DateServlet" method="post">
            <input type="hidden" name="roomId" value="<%= room.getRoomId() %>">

            <div class="check-date">
                <label>Check In:</label>
                <input type="date" name="checkIn" class="date-input" required>
                <i class="icon_calendar"></i>
            </div>

            <div class="check-date">
                <label>Check Out:</label>
                <input type="date" name="checkOut" class="date-input" required>
                <i class="icon_calendar"></i>
            </div>

            <div class="select-option">
                <label>Guests:</label>
                <select name="guests">
                    <option>Max <%= room.getCapacity() %> Persons</option>
                </select>
            </div>

            <div class="select-option">
                <label>Room:</label>
                <select>
                    <option><%= room.getTitle() %></option>
                </select>
            </div>

            <button type="submit">Check Availability</button>
        </form>

        <% 
            // Get availability message from session
            String availabilityMessage = (String) session.getAttribute("availabilityMessage");
            String availabilityType = (String) session.getAttribute("availabilityType");

            // Remove from session so it doesn’t persist on reload
            session.removeAttribute("availabilityMessage");
            session.removeAttribute("availabilityType");
        %>

        <% if (availabilityMessage != null && availabilityType != null) { %>
            <div style="padding: 10px; margin-top: 15px; 
                        color: <%= "success".equals(availabilityType) ? "green" : "red" %>; 
                        border: 1px solid <%= "success".equals(availabilityType) ? "green" : "red" %>; 
                        border-radius: 5px; 
                        background-color: <%= "success".equals(availabilityType) ? "#d4edda" : "#f8d7da" %>;">
                <strong><%= availabilityMessage %></strong>
            </div>
        <% } %>
    </div>
</div>
        </div>
    </div>
</section>

<% } else { %>
<div class="container text-center">
    <h3>Room not found.</h3>
</div>
<% } %>

<jsp:include page="/components/customer/footer.jsp" />

<!-- ===== STAR RATING CSS ===== -->
<style>
.star-rating {
    direction: rtl;
    font-size: 1.5em;
    display: inline-block;
}
.star-rating input[type="radio"] {
    display: none;
}
.star-rating label {
    color: #ddd;
    cursor: pointer;
    display: inline-block;
    position: relative;
}
.star-rating label:before {
    content: "\f005"; /* FontAwesome star */
    font-family: FontAwesome;
}
.star-rating input[type="radio"]:checked ~ label,
.star-rating label:hover,
.star-rating label:hover ~ label {
    color: #ffb400;
}
</style>