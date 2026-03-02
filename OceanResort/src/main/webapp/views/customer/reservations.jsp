<%@ page import="com.mvc.model.Room" %>
<%
    String path = request.getContextPath();
    Room room = (Room) request.getAttribute("room");
%>

<jsp:include page="/components/customer/header.jsp" />

<section class="room-details-section spad">
    <div class="container">
        <div class="row justify-content-center">

            <div class="col-lg-8">

                <div class="room-booking"
                     style="padding:40px; border:1px solid #f5a623; border-radius:8px;">

                    <h3 style="color:#f5a623; margin-bottom:25px;">
                        Reservation - <%=room.getTitle()%>
                    </h3>

                    <form action="<%=path%>/ReservationsServlet" method="post">

                        <!-- Hidden Room ID -->
                        <input type="hidden"
                               name="roomId"
                               value="<%=room.getRoomId()%>">

                        <!-- Guest Name -->
                        <div class="check-date">
                            <label>Guest Name</label>
                            <input type="text"
                                   name="guestName"
                                   class="form-control"
                                   required>
                        </div>

                        <!-- Phone Number -->
                        <div class="check-date">
                            <label>Phone Number</label>
                            <input type="text"
                                   name="phoneNumber"
                                   class="form-control"
                                   required>
                        </div>

                        <!-- Address -->
                        <div class="check-date">
                            <label>Address</label>
                            <textarea name="address"
                                      class="form-control"
                                      rows="3"
                                      required></textarea>
                        </div>

                        <!-- Members -->
                        <div class="check-date">
                            <label>Members</label>
                            <input type="number"
                                   name="members"
                                   min="1"
                                   max="<%=room.getCapacity()%>"
                                   class="form-control"
                                   required>
                            <small style="color:#999;">
                                Max Capacity: <%=room.getCapacity()%> Persons
                            </small>
                        </div>

                        <!-- Check In -->
                        <div class="check-date">
                            <label>Check In Date</label>
                            <input type="date"
                                   name="checkIn"
                                   class="form-control"
                                   required>
                        </div>

                        <!-- Check Out -->
                        <div class="check-date">
                            <label>Check Out Date</label>
                            <input type="date"
                                   name="checkOut"
                                   class="form-control"
                                   required>
                        </div>

                        <br>

                        <!-- Submit Button -->
                        <button type="submit"
                                class="primary-btn"
                                style="background:#f5a623; border:none; width:100%;">
                            Reserve Now
                        </button>

                    </form>

                </div>

            </div>

        </div>
    </div>
</section>

<jsp:include page="/components/customer/footer.jsp" />