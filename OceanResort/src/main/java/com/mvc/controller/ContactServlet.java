 

        package com.mvc.controller;

        import java.io.IOException;
        import java.util.Properties;
        import javax.mail.*;
        import javax.mail.internet.*;
        import javax.servlet.ServletException;
        import javax.servlet.annotation.WebServlet;
        import javax.servlet.http.*;

        @WebServlet("/contact")
        public class ContactServlet extends HttpServlet {
            private static final long serialVersionUID = 1L;

            // Mailtrap credentials
            private static final String MAILTRAP_USERNAME = "cd02cdf0448852";
            private static final String MAILTRAP_PASSWORD = "964a4aa4b1be06";

            protected void doPost(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {


                // Get form data
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String subject = request.getParameter("subject");
                String messageText = request.getParameter("message");

                // Mailtrap SMTP setup
                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.mailtrap.io");
                props.put("mail.smtp.port", "587");

                try {
                    Session session = Session.getInstance(props, new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(MAILTRAP_USERNAME, MAILTRAP_PASSWORD);
                        }
                    });

                    // HTML email template
                    String htmlMessage = "<!DOCTYPE html>"
                            + "<html>"
                            + "<head>"
                            + "<meta charset='UTF-8'>"
                            + "<title>Contact Form Message</title>"
                            + "<style>"
                            + "body { font-family: Arial, sans-serif; background-color: #f4f4f4; }"
                            + ".container { background-color: #ffffff; padding: 20px; border-radius: 8px; }"
                            + "h2 { color: #333333; }"
                            + "p { font-size: 14px; color: #555555; }"
                            + ".info { margin-bottom: 10px; }"
                            + ".footer { margin-top: 20px; font-size: 12px; color: #999999; }"
                            + "</style>"
                            + "</head>"
                            + "<body>"
                            + "<div class='container'>"
                            + "<h2>New Contact Message</h2>"
                            + "<div class='info'><strong>Name:</strong> " + name + "</div>"
                            + "<div class='info'><strong>Email:</strong> " + email + "</div>"
                            + "<div class='info'><strong>Subject:</strong> " + subject + "</div>"
                            + "<div class='info'><strong>Message:</strong><br/>" + messageText.replace("\n", "<br/>") + "</div>"
                            + "<div class='footer'>This message was sent from your website contact form.</div>"
                            + "</div>"
                            + "</body>"
                            + "</html>";

                    // Prepare the message
                    MimeMessage message = new MimeMessage(session);
                    message.setFrom(new InternetAddress(email)); // sender email
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress("info@oceanresort.com")); // recipient
                    message.setSubject(subject);
                    message.setContent(htmlMessage, "text/html; charset=utf-8");

                    // Send email
                    Transport.send(message);

                    // Success
                    System.out.println("Email sent successfully!");
                    request.setAttribute("successMessage", "Message sent successfully!");

                } catch (MessagingException e) {
                    e.printStackTrace();
                    request.setAttribute("errorMessage", "Error sending message. Try again later.");
                }

                // Forward back to contact page
                request.getRequestDispatcher("/views/customer/contact.jsp").forward(request, response);
            }

            protected void doGet(HttpServletRequest request, HttpServletResponse response)
                    throws ServletException, IOException {
                request.getRequestDispatcher("/views/customer/contact.jsp").forward(request, response);
            }
        }