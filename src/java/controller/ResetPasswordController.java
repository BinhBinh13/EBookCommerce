package controller;

import dal.loginDAO;
import model.User;
import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private loginDAO loginDAO;

    @Override
    public void init() throws ServletException {
        loginDAO = new loginDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        switch (action) {
            case "sendOTP":
                handleSendOTP(request, response, session);
                break;
            case "verifyOTP":
                handleVerifyOTP(request, response, session);
                break;
            case "resetPassword":
                handleResetPassword(request, response, session);
                break;
            default:
                response.sendRedirect("forgotpassword.jsp");
        }
    }

    private void handleSendOTP(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String userEmail = request.getParameter("email");

        if (!isValidEmail(userEmail)) {
            request.setAttribute("errorMessage", "Invalid email format!");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
            return;
        }

        User user = loginDAO.getUserByEmail(userEmail);
        if (user == null) {
            request.setAttribute("errorMessage", "Email does not exist!");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
            return;
        }

        String otp = generateOTP();
        session.setAttribute("otp", otp);
        session.setAttribute("userEmail", userEmail);
        session.setMaxInactiveInterval(300); // OTP expires in 5 minutes

        if (sendEmail(userEmail, otp)) {
            response.sendRedirect("verifyotp.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to send email. Please try again.");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
        }
    }

    private void handleVerifyOTP(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String enteredOTP = request.getParameter("otp");
        String sessionOTP = (String) session.getAttribute("otp");

        if (sessionOTP != null && sessionOTP.equals(enteredOTP)) {
            response.sendRedirect("resetpassword.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid or expired OTP!");
            request.getRequestDispatcher("verifyotp.jsp").forward(request, response);
        }
    }

    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String userEmail = (String) session.getAttribute("userEmail");

        if (userEmail == null) {
            response.sendRedirect("forgotpassword.jsp");
            return;
        }

        if (!newPassword.equals(confirmPassword) || newPassword.length() < 6) {
            request.setAttribute("errorMessage", "Invalid password or passwords do not match!");
            request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
            return;
        }

        loginDAO.resetPassword(userEmail, newPassword);
        session.invalidate(); // Clear session after password reset
        response.sendRedirect("login.jsp?resetSuccess=1");
    }

    private boolean isValidEmail(String email) {
        return email.matches("^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$");
    }

    private String generateOTP() {
        return String.format("%06d", new Random().nextInt(1000000));
    }

    private boolean sendEmail(String userEmail, String otp) {
        final String senderEmail = "ebookvn123@gmail.com";
        final String senderPassword = "vsur gxvg joms oftf";

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
            message.setSubject("Password Reset OTP");
            message.setContent("<h3>Your OTP code is:</h3><h2 style='color:blue;'>" + otp + "</h2>", "text/html");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            return false;
        }
    }
}
