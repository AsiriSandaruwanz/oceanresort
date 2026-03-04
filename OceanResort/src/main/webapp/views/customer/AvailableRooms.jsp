<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Room" %>

<%
    String path = request.getContextPath();
    List<Room> roomList = (List<Room>) request.getAttribute("availableRooms"); // match servlet attribute
    String checkIn = (String) request.getAttribute("checkIn");
    String checkOut = (String) request.getAttribute("checkOut");
    int guests = request.getAttribute("guests") != null ? (Integer) request.getAttribute("guests") : 0;
%>

<jsp:include page="/components/customer/header.jsp" />

<div class="breadcrumb-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb-text">
                    <h2>Available Rooms</h2>
                    <div class="bt-option">
                        <a href="<%=path%>/home">Home</a>
                        <span>Rooms</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Availability Info Card -->
<div class="container">
    <div class="availability-info">
        <div class="info-item">
            <i class="icon_calendar"></i>
            <span>Check-in: <strong><%=checkIn%></strong></span>
        </div>
        <div class="info-item">
            <i class="icon_calendar"></i>
            <span>Check-out: <strong><%=checkOut%></strong></span>
        </div>
        <div class="info-item">
            <i class="icon_profile"></i>
            <span>Guests: <strong><%=guests%></strong></span>
        </div>
    </div>
</div>

<section class="rooms-section spad">
    <div class="container">
        <div class="row">
            <%
                if (roomList != null && !roomList.isEmpty()) {
                    for (Room room : roomList) {
            %>
            <div class="col-lg-4 col-md-6">
                <div class="room-item">
                    <img src="<%=path%>/<%=room.getImagePath()%>" alt="<%=room.getTitle()%>">
                    <div class="ri-text">
                        <h4><%=room.getTitle()%></h4>
                        <h3>$<%=room.getPricePerNight()%><span>/Per Night</span></h3>
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
                        <a href="<%=path%>/room-details?roomId=<%=room.getRoomId()%>" class="primary-btn">More Details</a>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-lg-12 text-center">
                <h4>No rooms available for the selected dates and guests.</h4>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>

<style>
/* Availability Info Card Container */
.availability-info {
    display: flex;
    flex-wrap: wrap;           /* Wrap on small screens */
    gap: 20px;                 /* Space between items */
    margin: 20px 0;            /* Top & bottom spacing */
    padding: 15px 20px;        /* Inner padding */
    background-color: #f8f9fa; /* Light grey background */
    border-radius: 10px;       /* Rounded corners */
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
    justify-content: center;    /* Center items horizontally */
}

/* Individual Info Item */
.availability-info .info-item {
    display: flex;
    align-items: center;
    font-size: 16px;
    color: #333;
    background-color: #fff;
    padding: 10px 15px;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
    min-width: 150px;          /* Keep items uniform width */
}

/* Icon in Info Item */
.availability-info .info-item i {
    font-size: 20px;
    color: #ff5a5f;            /* Accent color */
    margin-right: 10px;
}

/* Strong text styling */
.availability-info .info-item strong {
    color: #000;
}
</style>

<jsp:include page="/components/customer/footer.jsp" />