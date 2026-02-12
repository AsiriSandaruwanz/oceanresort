<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String path = request.getContextPath();
%>

<jsp:include page="/components/customer/header.jsp" />

<section class="contact-section spad">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-10">

                <div class="contact-text" style="background:#fff; padding:40px; border-radius:8px; box-shadow:0 5px 20px rgba(0,0,0,0.1);">
                    
                    <div class="section-title text-center">
                        <span>Ocean Resort</span>
                        <h2>Create Account</h2>
                    </div>

                    <!-- ERROR MESSAGE DISPLAY -->
                    <% if (request.getAttribute("error") != null) { %>
                        <div style="color:red; margin-bottom:15px; text-align:center;">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <form action="<%=path%>/RegisterServlet" method="post" class="contact-form">

                        <div class="form-group mb-3">
                            <label>Full Name</label>
                            <input type="text" name="name" class="form-control" 
                                   placeholder="Enter your full name" required>
                        </div>

                        <div class="form-group mb-3">
                            <label>Email Address</label>
                            <input type="email" name="email" class="form-control" 
                                   placeholder="Enter your email" required>
                        </div>

                        <div class="form-group mb-3">
                            <label>Phone Number</label>
                            <input type="text" name="phone" class="form-control" 
                                   placeholder="Enter your phone number" required>
                        </div>

                        <div class="form-group mb-3">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" 
                                   placeholder="Enter your password" required>
                        </div>

                        <div class="form-group mb-4">
                            <label>Confirm Password</label>
                            <input type="password" name="confirm_password" class="form-control" 
                                   placeholder="Re-enter your password" required>
                        </div>

                        <button type="submit" class="primary-btn btn-block" style="width:100%;">
                            Register
                        </button>

                        <div class="text-center mt-3">
                            <p style="margin-top:15px;">
                                Already have an account?
                                <a href="<%=path%>/views/login.jsp">Login Here</a>
                            </p>
                        </div>

                    </form>

                </div>

            </div>
        </div>
    </div>
</section>

<jsp:include page="/components/customer/footer.jsp" />
