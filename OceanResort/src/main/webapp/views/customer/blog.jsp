<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
%>

<jsp:include page="/components/customer/header.jsp" />

<!-- Breadcrumb Section Begin -->
<div class="breadcrumb-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <div class="breadcrumb-text">
                    <h2>Blog</h2>
                    <div class="bt-option">
                        <a href="<%=path%>/index.jsp">Home</a>
                        <span>Blog Grid</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Breadcrumb Section End -->

<!-- Blog Section Begin -->
<section class="blog-section blog-page spad">
    <div class="container">
        <div class="row">

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-1.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Travel Trip</span>
                        <h4><a href="<%=path%>/blog-details.jsp">Tremblant In Canada</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 15th April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-2.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Camping</span>
                        <h4><a href="<%=path%>/blog-details.jsp">Choosing A Static Caravan</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 15th April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-3.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Event</span>
                        <h4><a href="<%=path%>/blog-details.jsp">Copper Canyon</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 21st April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-4.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Trivago</span>
                        <h4><a href="<%=path%>/blog-details.jsp">A Time Travel Postcard</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 22nd April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-5.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Camping</span>
                        <h4><a href="<%=path%>/blog-details.jsp">A Time Travel Postcard</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 25th April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-6.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Travel Trip</span>
                        <h4><a href="<%=path%>/blog-details.jsp">Virginia Travel For Kids</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 28th April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-7.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Travel Trip</span>
                        <h4><a href="<%=path%>/blog-details.jsp">Bryce Canyon A Stunning</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 29th April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-8.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Event & Travel</span>
                        <h4><a href="<%=path%>/blog-details.jsp">Motorhome Or Trailer</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 30th April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg" data-setbg="<%=path%>/assets/customer/img/blog/blog-9.jpg">
                    <div class="bi-text">
                        <span class="b-tag">Camping</span>
                        <h4><a href="<%=path%>/blog-details.jsp">Lost In Lagos Portugal</a></h4>
                        <div class="b-time"><i class="icon_clock_alt"></i> 30th April, 2019</div>
                    </div>
                </div>
            </div>

            <div class="col-lg-12">
                <div class="load-more">
                    <a href="#" class="primary-btn">Load More</a>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- Blog Section End -->

<jsp:include page="/components/customer/footer.jsp" />
