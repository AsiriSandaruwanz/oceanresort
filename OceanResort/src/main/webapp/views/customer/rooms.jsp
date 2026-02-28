<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Room" %>

<%
    String path = request.getContextPath();
    List<Room> roomList = (List<Room>) request.getAttribute("roomList");
%>

<jsp:include page="/components/customer/header.jsp" />

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
                <h4>No rooms available</h4>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>

<jsp:include page="/components/customer/footer.jsp" />