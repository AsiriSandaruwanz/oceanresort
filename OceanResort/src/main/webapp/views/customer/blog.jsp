<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.mvc.model.Blog" %>

<%
    String path = request.getContextPath();
    List<Blog> blogs = (List<Blog>) request.getAttribute("blogList");
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

        <%
            if (blogs != null && !blogs.isEmpty()) {
                for (Blog b : blogs) {
        %>

            <div class="col-lg-4 col-md-6">
                <div class="blog-item set-bg"
                     data-setbg="<%=path%>/<%= b.getImagePath() %>">
                    <div class="bi-text">
                        <span class="b-tag">
                            <%= b.getCategoryName() != null ? b.getCategoryName() : "General" %>
                        </span>

                        <h4>
                            <a href="<%=path%>/blog-details?id=<%= b.getId() %>">
                                <%= b.getTitle() %>
                            </a>
                        </h4>

                        <div class="b-time">
                            <i class="icon_clock_alt"></i>
                            <%= b.getBlogDate() %>
                        </div>
                    </div>
                </div>
            </div>

        <%
                }
            } else {
        %>

            <div class="col-lg-12 text-center">
                <h4>No blogs available.</h4>
            </div>

        <%
            }
        %>

            <!-- Load More Button -->
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