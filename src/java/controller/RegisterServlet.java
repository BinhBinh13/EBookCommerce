/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.SystemDAO;
import dal.loginDAO;
import java.io.File;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.User;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy các tham số từ form
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String password2 = request.getParameter("passwordAgain");
        String roles = "customer";
        String mess;
        boolean found = false;

        // Xử lý file avatar
        Part filePart = request.getPart("avatar"); // Lấy file từ form
        String avatar = "";
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart); // Lấy tên file gốc
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir(); // Tạo thư mục uploads nếu chưa có
            }
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath); // Lưu file vào server
            avatar = "uploads" + File.separator + fileName; // Đường dẫn tương đối để lưu vào DB
        }

        SystemDAO sd = new SystemDAO();
        loginDAO ld = new loginDAO();
        User user2 = new User(username, password, fullName, email, phoneNumber, gender, roles, avatar);
        List<User> list = sd.getAll();

        // Kiểm tra input rỗng
        if (isEmpty(fullName) || isEmpty(email) || isEmpty(phoneNumber) || isEmpty(gender)
                || isEmpty(username) || isEmpty(password)) {
            mess = "Input must not be empty! Please enter a valid input.";
            request.setAttribute("error", mess);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra password match
        if (!password.equals(password2)) {
            mess = "Passwords do not match! Please try again.";
            request.setAttribute("error", mess);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra username va email đã tồn tại chưa
        for (User user : list) {
            if (user.getUsername().equals(username)) {
                mess = "Username already exists! Please enter another username.";
                request.setAttribute("error", mess);
                found = true;
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
            }
            if (user.getEmail().equals(email)) {
                mess = "Email already exists! Please enter another Email.";
                request.setAttribute("error", mess);
                found = true;
                request.getRequestDispatcher("register.jsp").forward(request, response);
                break;
            }
        }

        // Nếu không có lỗi, thực hiện đăng ký
        if (!found) {
            ld.Register(user2);
            mess = "Register successfully! Please return to login page.";
            request.setAttribute("result", mess);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // Hàm hỗ trợ kiểm tra chuỗi rỗng
    private boolean isEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    // Hàm lấy tên file từ Part
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String fileName = s.substring(s.indexOf("=") + 2, s.length() - 1);
                return fileName;
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Register Servlet for EBOOK STORE";
    }
}
