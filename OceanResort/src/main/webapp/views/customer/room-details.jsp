<%@ page import="com.mvc.model.Room" %>

<%
    String path = request.getContextPath();
    Room room = (Room) request.getAttribute("room");
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

<!-- Room Details Section Begin -->
<section class="room-details-section spad">
    <div class="container">
        <div class="row">

            <!-- Room Main Info -->
            <div class="col-lg-8">
                <div class="room-details-item">

                    <!-- ✅ Dynamic Image (SIZE PRESERVED) -->
                    <img src="<%=path%>/<%=room.getImagePath()%>" 
                         alt="<%=room.getTitle()%>"
                         style="width:100%; height:500px; object-fit:cover;">

                    <div class="rd-text">
                        <div class="rd-title">
                            <h3><%=room.getTitle()%></h3>
                            <div class="rdt-right">
                                <div class="rating">
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star"></i>
                                    <i class="icon_star-half_alt"></i>
                                </div>
                                <a href="#">Booking Now</a>
                            </div>
                        </div>

                        <h2>$<%=room.getPricePerNight()%><span>/Pernight</span></h2>

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
                            Enjoy a comfortable and luxurious stay in our <%=room.getTitle()%>.
                        </p>
                        <p>
                            Designed for comfort and relaxation with premium facilities.
                        </p>
                    </div>
                </div>

                <!-- Reviews (Design Unchanged) -->
                <div class="rd-reviews">
                    <h4>Reviews</h4>
                    <p>No reviews yet.</p>
                </div>

                <!-- Add Review Form (Design Unchanged) -->
                <div class="review-add">
                    <h4>Add Review</h4>
                    <form action="#" class="ra-form">
                        <div class="row">
                            <div class="col-lg-6">
                                <input type="text" placeholder="Name*">
                            </div>
                            <div class="col-lg-6">
                                <input type="text" placeholder="Email*">
                            </div>
                            <div class="col-lg-12">
                                <div>
                                    <h5>Your Rating:</h5>
                                    <div class="rating">
                                        <i class="icon_star"></i>
                                        <i class="icon_star"></i>
                                        <i class="icon_star"></i>
                                        <i class="icon_star"></i>
                                        <i class="icon_star-half_alt"></i>
                                    </div>
                                </div>
                                <textarea placeholder="Your Review"></textarea>
                                <button type="submit">Submit Now</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Booking Sidebar -->
            <div class="col-lg-4">
                <div class="room-booking">
                    <h3>Your Reservation</h3>
                    <form action="#">
                        <div class="check-date">
                            <label>Check In:</label>
                            <input type="text" class="date-input">
                            <i class="icon_calendar"></i>
                        </div>
                        <div class="check-date">
                            <label>Check Out:</label>
                            <input type="text" class="date-input">
                            <i class="icon_calendar"></i>
                        </div>

                        <div class="select-option">
                            <label>Guests:</label>
                            <select>
                                <option>Max <%=room.getCapacity()%> Persons</option>
                            </select>
                        </div>

                        <div class="select-option">
                            <label>Room:</label>
                            <select>
                                <option><%=room.getTitle()%></option>
                            </select>
                        </div>

                        <button type="submit">Check Availability</button>
                    </form>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- Room Details Section End -->

<% } else { %>

<div class="container text-center">
    <h3>Room not found.</h3>
</div>

<% } %>

<jsp:include page="/components/customer/footer.jsp" />