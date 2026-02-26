<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
%>

<jsp:include page="/components/customer/header.jsp" />

<!-- Contact Section Begin -->
<section class="contact-section spad">
    <div class="container">
        <div class="row">
            <!-- Contact Info -->
            <div class="col-lg-4">
                <div class="contact-text">
                    <h2>Contact Info</h2>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                        labore et dolore magna aliqua.</p>
                    <table>
                        <tbody>
                            <tr>
                                <td class="c-o">Address:</td>
                                <td>856 Cordia Extension Apt. 356, Lake, US</td>
                            </tr>
                            <tr>
                                <td class="c-o">Phone:</td>
                                <td>(12) 345 67890</td>
                            </tr>
                            <tr>
                                <td class="c-o">Email:</td>
                                <td>info.colorlib@gmail.com</td>
                            </tr>
                            <tr>
                                <td class="c-o">Fax:</td>
                                <td>+(12) 345 67890</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Contact Form -->
            <div class="col-lg-7 offset-lg-1">
                <div class="contact-form-wrapper">

                    <!-- Display success or error message -->
                    <%
                        String successMessage = (String) request.getAttribute("successMessage");
                        String errorMessage = (String) request.getAttribute("errorMessage");

                        if (successMessage != null) {
                    %>
                        <div style="padding:15px; margin-bottom:20px; color:#155724; background-color:#d4edda; border:1px solid #c3e6cb; border-radius:5px;">
                            <%= successMessage %>
                        </div>
                    <%
                        } else if (errorMessage != null) {
                    %>
                        <div style="padding:15px; margin-bottom:20px; color:#721c24; background-color:#f8d7da; border:1px solid #f5c6cb; border-radius:5px;">
                            <%= errorMessage %>
                        </div>
                    <%
                        }
                    %>

                    <form action="<%=path%>/contact" method="post" class="contact-form">
                        <div class="row">
                            <div class="col-lg-6 mb-4">
                                <div class="form-group">
                                    <input type="text" name="name" class="form-control"
                                           placeholder="Your Name" required
                                           value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                                </div>
                            </div>

                            <div class="col-lg-6 mb-4">
                                <div class="form-group">
                                    <input type="email" name="email" class="form-control"
                                           placeholder="Your Email" required
                                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                                </div>
                            </div>

                            <div class="col-lg-12 mb-4">
                                <div class="form-group">
                                    <input type="text" name="subject" class="form-control"
                                           placeholder="Subject" required
                                           value="<%= request.getParameter("subject") != null ? request.getParameter("subject") : "" %>">
                                </div>
                            </div>

                            <div class="col-lg-12 mb-4">
                                <div class="form-group">
                                    <textarea name="message" rows="6"
                                              class="form-control"
                                              placeholder="Your Message"
                                              required><%= request.getParameter("message") != null ? request.getParameter("message") : "" %></textarea>
                                </div>
                            </div>

                            <div class="col-lg-12 text-right">
                                <button type="submit" class="primary-btn contact-btn">
                                    Send Message
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Google Map -->
        <div class="map mt-5">
            <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3022.0606825994123!2d-72.8735845851828!3d40.760690042573295!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89e85b24c9274c91%3A0xf310d41b791bcb71!2sWilliam%20Floyd%20Pkwy%2C%20Mastic%20Beach%2C%20NY%2C%20USA!5e0!3m2!1sen!2sbd!4v1578582744646!5m2!1sen!2sbd"
                width="100%" height="470" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
        </div>
    </div>
</section>
<!-- Contact Section End -->

<jsp:include page="/components/customer/footer.jsp" />

<!-- Optional CSS for contact form -->
<style>
.contact-form-wrapper {
    background: #ffffff;
    padding: 40px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    border-radius: 8px;
}

.contact-form .form-control {
    width: 100%;
    height: 50px;
    border: 1px solid #e1e1e1;
    border-radius: 5px;
    padding: 0 20px;
    font-size: 14px;
    transition: 0.3s;
}

.contact-form textarea.form-control {
    height: auto;
    padding: 15px 20px;
    resize: none;
}

.contact-form .form-control:focus {
    border-color: #dfa974;
    box-shadow: none;
}

.contact-btn {
    padding: 12px 35px;
    border-radius: 30px;
    font-weight: 600;
    background-color: #dfa974;
    color: #fff;
    border: none;
    transition: 0.3s;
}

.contact-btn:hover {
    background-color: #c78b50;
}
</style>