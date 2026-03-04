<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.List, com.mvc.model.Blog, com.mvc.model.Room, com.mvc.model.Feedback" %>

<%
    String path = request.getContextPath();
    List<Feedback> feedbacks = (List<Feedback>) request.getAttribute("allFeedback");
%>

<style>
/* Room card container */
.hp-room-item {
    position: relative;
    background-size: cover;
    background-position: center;
    height: 450px; /* adjust if needed */
    display: flex;
    align-items: flex-end;
    padding: 20px;
    overflow: hidden;
}

/* Black overlay */
.room-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6); /* adjust darkness here */
    z-index: 1;
}

/* Text above overlay */
.hr-text {
    position: relative;
    z-index: 2;
    color: #ffffff;
}

/* Make table text white */
.hr-text table td {
    color: #ffffff;
}
</style>

<jsp:include page="/components/customer/header.jsp" />

<!-- Hero Section Begin -->
<section class="hero-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="hero-text">
                    <h1>Sona A Luxury Hotel</h1>
                    <p>Here are the best hotel booking sites, including recommendations for international
                        travel and for finding low-priced hotel rooms.</p>
                    <a href="#" class="primary-btn">Discover Now</a>
                </div>
            </div>
            <div class="col-xl-4 col-lg-5 offset-xl-2 offset-lg-1">
    <div class="booking-form">
        <h3>Booking Your Hotel</h3>
        <form action="<%=path%>/availableRooms" method="get">
            <div class="check-date">
                <label for="date-in">Check In:</label>
                <input type="date" class="date-input" id="date-in" name="checkIn" required>
                <i class="icon_calendar"></i>
            </div>
            <div class="check-date">
                <label for="date-out">Check Out:</label>
                <input type="date" class="date-input" id="date-out" name="checkOut" required>
                <i class="icon_calendar"></i>
            </div>
            <div class="select-option">
                <label for="guest">Guests:</label>
                <select id="guest" name="guests" required>
                    <option value="2">2 Adults</option>
                    <option value="3">3 Adults</option>
                    <option value="4">4 Adults</option>
                    <option value="5">5 Adults</option>
                    <option value="6">6 Adults</option>
                </select>
            </div>
            <button type="submit">Check Availability</button>
        </form>
    </div>
</div>
        </div>
    </div>
    <div class="hero-slider owl-carousel">
        <div class="hs-item set-bg" data-setbg="<%=path%>/assets/customer/img/hero/hero-1.jpg"></div>
        <div class="hs-item set-bg" data-setbg="<%=path%>/assets/customer/img/hero/hero-2.jpg"></div>
        <div class="hs-item set-bg" data-setbg="<%=path%>/assets/customer/img/hero/hero-3.jpg"></div>
    </div>
</section>
<!-- Hero Section End -->

<!-- About Us Section Begin -->
<section class="aboutus-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="about-text">
                    <div class="section-title">
                        <span>About Us</span>
                        <h2>Intercontinental LA <br />Westlake Hotel</h2>
                    </div>
                    <p class="f-para">Sona.com is a leading online accommodation site. We’re passionate about
                        travel. Every day, we inspire and reach millions of travelers across 90 local websites in 41
                        languages.</p>
                    <p class="s-para">So when it comes to booking the perfect hotel, vacation rental, resort,
                        apartment, guest house, or tree house, we’ve got you covered.</p>
                    <a href="#" class="primary-btn about-btn">Read More</a>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="about-pic">
                    <div class="row">
                        <div class="col-sm-6">
                            <img src="<%=path%>/assets/customer/img/about/about-1.jpg" alt="">
                        </div>
                        <div class="col-sm-6">
                            <img src="<%=path%>/assets/customer/img/about/about-2.jpg" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- About Us Section End -->

<!-- Services Section End -->
<section class="services-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <span>What We Do</span>
                    <h2>Discover Our Services</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Service Items unchanged -->
        </div>
    </div>
</section>
<!-- Services Section End -->

<section class="hp-room-section">
    <div class="container-fluid">
        <div class="hp-room-items">
            <div class="row">

<%
    List<Room> rooms = (List<Room>) request.getAttribute("latestRooms");

    if (rooms != null && !rooms.isEmpty()) {
        for (Room room : rooms) {
%>

                <div class="col-lg-3 col-md-6">
                    <div class="hp-room-item set-bg"
                         data-setbg="<%=path%>/<%=room.getImagePath()%>">

                        <!-- BLACK OVERLAY -->
                        <div class="room-overlay"></div>

                        <div class="hr-text">
                            <h3><%=room.getTitle()%></h3>
                            <h2><%=room.getPricePerNight()%>$<span>/Pernight</span></h2>
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
                            <a href="<%=path%>/room-details?id=<%=room.getRoomId()%>"
                               class="primary-btn">More Details</a>
                        </div>
                    </div>
                </div>

<%
        }
    } else {
%>
        <div class="col-lg-12">
            <p>No rooms available.</p>
        </div>
<%
    }
%>

            </div>
        </div>
    </div>
</section>

<!-- Testimonial Section Begin -->
<section class="testimonial-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <span>Testimonials</span>
                    <h2>What Customers Say?</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8 offset-lg-2">
                <div class="testimonial-slider owl-carousel">

<% if (feedbacks != null && !feedbacks.isEmpty()) { 
       for (Feedback fb : feedbacks) { %>
                    <div class="ts-item">
                        <p><%= fb.getReview() %></p>
                        <div class="ti-author">
                            <div class="rating">
                                <%-- Display star icons dynamically based on rating --%>
                                <%
                                    int rating = fb.getRating();
                                    for (int i = 1; i <= 5; i++) {
                                        if (i <= rating) { %>
                                            <i class="icon_star"></i>
                                        <% } else { %>
                                            <i class="icon_star_alt"></i>
                                        <% } 
                                    }
                                %>
                            </div>
                            <h5> - <%= fb.getName() %></h5>
                        </div>
                        <img src="<%=path%>/assets/customer/img/testimonial-logo.png" alt="">
                    </div>
<%     } 
   } else { %>
                    <div class="ts-item">
                        <p>No testimonials available yet.</p>
                        <div class="ti-author">
                            <div class="rating">
                                <i class="icon_star"></i>
                                <i class="icon_star"></i>
                                <i class="icon_star"></i>
                                <i class="icon_star"></i>
                                <i class="icon_star"></i>
                            </div>
                            <h5> - Admin</h5>
                        </div>
                        <img src="<%=path%>/assets/customer/img/testimonial-logo.png" alt="">
                    </div>
<% } %>

                </div>
            </div>
        </div>
    </div>
</section>
<!-- Testimonial Section End -->

<!-- Services Section End -->
<section class="services-section spad">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="section-title">
                    <span>What We Do</span>
                    <h2>Discover Our Blogs</h2>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- Service Items unchanged -->
        </div>
    </div>
</section>
<!-- Services Section End -->

<!-- Blog Section Begin -->
<section class="blog-section spad">
    <div class="container">
        <div class="row">

<%
    List<Blog> blogs = (List<Blog>) request.getAttribute("latestBlogs");

    if (blogs != null && !blogs.isEmpty()) {
        int index = 0;

        for (Blog blog : blogs) {
            index++;
%>

    <% if (index <= 3) { %>
        <div class="col-lg-4">
            <div class="blog-item set-bg"
                 data-setbg="<%=path%>/<%=blog.getImagePath()%>">
                <div class="bi-text">
                    <span class="b-tag"><%=blog.getCategoryName()%></span>
                    <h4>
                        <a href="<%=path%>/blog-details?id=<%=blog.getId()%>">
                            <%=blog.getTitle()%>
                        </a>
                    </h4>
                    <div class="b-time">
                        <i class="icon_clock_alt"></i>
                        <%=blog.getBlogDate()%>
                    </div>
                </div>
            </div>
        </div>
    <% } %>

    <% if (index == 4) { %>
        <div class="col-lg-8">
            <div class="blog-item small-size set-bg"
                 data-setbg="<%=path%>/<%=blog.getImagePath()%>">
                <div class="bi-text">
                    <span class="b-tag"><%=blog.getCategoryName()%></span>
                    <h4>
                        <a href="<%=path%>/blog-details?id=<%=blog.getId()%>">
                            <%=blog.getTitle()%>
                        </a>
                    </h4>
                    <div class="b-time">
                        <i class="icon_clock_alt"></i>
                        <%=blog.getBlogDate()%>
                    </div>
                </div>
            </div>
        </div>
    <% } %>

    <% if (index == 5) { %>
        <div class="col-lg-4">
            <div class="blog-item small-size set-bg"
                 data-setbg="<%=path%>/<%=blog.getImagePath()%>">
                <div class="bi-text">
                    <span class="b-tag"><%=blog.getCategoryName()%></span>
                    <h4>
                        <a href="<%=path%>/blog-details?id=<%=blog.getId()%>">
                            <%=blog.getTitle()%>
                        </a>
                    </h4>
                    <div class="b-time">
                        <i class="icon_clock_alt"></i>
                        <%=blog.getBlogDate()%>
                    </div>
                </div>
            </div>
        </div>
    <% } %>

<%
        }
    } else {
%>
        <div class="col-lg-12">
            <p>No blogs available.</p>
        </div>
<%
    }
%>

        </div>
    </div>
</section>
<!-- Blog Section End -->

<jsp:include page="/components/customer/footer.jsp" />
