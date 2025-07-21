package controller;

import dal.loginDAO;
import java.io.IOException;
import java.util.List;
import java.util.Base64;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import model.User;

@WebServlet(name = "UpdateServlet", urlPatterns = {"/update"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateInfoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("editCustomer.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the user information from the form
        String accountId = request.getParameter("accountId");
        int id = Integer.parseInt(accountId);
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        // Handle avatar image upload 
        String currentImage = request.getParameter("currentImage");
        Part avatarPics = request.getPart("avatarPics");
        String imagePath = currentImage;
        if (avatarPics != null && avatarPics.getSize() > 0) {
            String uploadPath = request.getServletContext().getRealPath("/avatars");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = avatarPics.getSubmittedFileName();
            File file = new File(uploadDir, fileName);
            avatarPics.write(file.getAbsolutePath());
            imagePath = request.getContextPath() + "/avatars/" + fileName;
        }
        // Create the user object with the updated information
        User updatedUser = new User(
                id,
                fullName,
                email,
                phoneNumber,
                gender,
                imagePath
        );

        loginDAO ld = new loginDAO();
        boolean success = ld.updateUser(updatedUser);

        // Handle response based on the success of the update
        if (success) {
            // Update the currentUser in session with the updated info
            request.getSession().setAttribute("currentUser", updatedUser);
            request.getSession().setAttribute("currentAdmin", updatedUser);
            // Success message
            request.setAttribute("message", "User information updated successfully!");
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response); // Redirect to the profile page
        } else {
            request.setAttribute("error", "Failed to update user information.");
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response); // Stay on the edit page if failed
        }
    }

    @Override
    public String getServletInfo() {
        return "Update User Information Servlet";
    }
}
