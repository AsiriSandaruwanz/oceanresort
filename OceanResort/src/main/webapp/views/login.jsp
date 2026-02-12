<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String path = request.getContextPath();
%>

<jsp:include page="/components/customer/header.jsp" />

<!-- Login Section Begin -->
<section class="contact-section spad">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-8">

                <div class="contact-text" style="background:#fff; padding:40px; border-radius:8px; box-shadow:0 5px 20px rgba(0,0,0,0.1);">
                    
                    <div class="section-title text-center">
                        <span>Ocean Resort</span>
                        <h2>Login</h2>
                    </div>

                    <form action="<%=path%>/login" method="post" class="contact-form">

                        <div class="form-group mb-3">
                            <label>Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                        </div>

                        <div class="form-group mb-3">
                            <label>Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                        </div>

                        <div class="form-group mb-3 text-right">
                            <a href="#" style="font-size:14px;">Forgot Password?</a>
                        </div>

                        <button type="submit" class="primary-btn btn-block" style="width:100%;">
                            Login
                        </button>

                        <div class="text-center mt-3">
                            <p style="margin-top:15px;">
                                Don't have an account?
                                <a href="<%=path%>/views/registration.jsp">Register Here</a>
                            </p>
                        </div>

                    </form>

                </div>

            </div>
        </div>
    </div>
</section>
<!-- Login Section End -->

<jsp:include page="/components/customer/footer.jsp" />
