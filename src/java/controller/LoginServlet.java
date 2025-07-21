package controller;

import dal.SystemDAO;
import dal.loginDAO;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login_test.jsp");
    }

    /**
     * doPost xử lý đăng nhập: - Kiểm tra input rỗng.
     *
     * - Sử dụng stored procedure thông qua loginDAO.authenticateUserProcedure()
     * để xác thực tài khoản, giúp tối ưu hiệu năng và bảo mật.
     *
     * - Dựa vào giá trị roles (admin hoặc user) chuyển hướng đến trang tương
     * ứng.
     *
     * - Đối với customer, lấy đầy đủ thông tin từ SystemDAO và lưu vào
     * session/request với thuộc tính "currentUser".
     *
     * - Đối với admin, lấy đầy đủ thông tin tương tự và lưu với thuộc tính
     * "currentAdmin".
     *
     * - Nếu không xác thực được, hiển thị thông báo lỗi và chuyển về trang
     * login.jsp.
     *
     * @param request
     * @param response
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String mess;
        String username = request.getParameter("username");
        String password = request.getParameter("password");

//        SystemDAO sd = new SystemDAO();
//        List<User> list = sd.getAll();
//        boolean found = false;
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            mess = "Error! Username and password must not empty. Please try again!";
            request.setAttribute("error", mess);
            request.getRequestDispatcher("login_test.jsp").forward(request, response);
            return;
        }

        // Sử dụng loginDAO để gọi stored procedure xác thực người dùng
        loginDAO ld = new loginDAO();
        User partialUser = ld.authenticateUserProcedure(username, password);

        if (partialUser != null) {
            SystemDAO systemDAO = new SystemDAO();
            List<User> userList = systemDAO.getAll();
            if (partialUser.getRoles() != null && partialUser.getRoles().equalsIgnoreCase("admin")) {
                User fullAdmin = null;
                if (userList != null) {
                    for (User u : userList) {
                        if (u.getAccountId() == partialUser.getAccountId()
                                && u.getRoles().equalsIgnoreCase("admin")) {
                            fullAdmin = u;
                            break;
                        }
                    }
                }
                if (fullAdmin == null) {
                    fullAdmin = partialUser;
                }
                // Lưu thông tin admin vào request và session
                request.getSession().setAttribute("currentAdmin", fullAdmin);
                request.setAttribute("username", username);
                request.setAttribute("password", password);
                response.sendRedirect("admin");
                return;
            } else if (partialUser.getRoles() != null && partialUser.getRoles().equalsIgnoreCase("customer")) {

                // Loại bỏ thông tin admin cũ nếu tồn tại
                request.getSession().removeAttribute("currentAdmin");

                User fullCustomer = null;
                if (userList != null) {
                    for (User u : userList) {
                        if (u.getAccountId() == partialUser.getAccountId()
                                && u.getRoles().equalsIgnoreCase("customer")) {
                            fullCustomer = u;
                            break;
                        }
                    }
                }
                if (fullCustomer == null) {
                    fullCustomer = partialUser;
                }
                request.getSession().setAttribute("currentUser", fullCustomer);
                response.sendRedirect("home");
            } else {
                mess = "Unknown role. Please contact support.";
                request.setAttribute("error", mess);
                request.getRequestDispatcher("login_test.jsp").forward(request, response);
            }
        } else {
            // Nếu không tìm thấy tài khoản khớp
            mess = "Incorrect username or password! Please try again.";
            request.setAttribute("error", mess);
            request.getRequestDispatcher("login_test.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "LoginServlet handles user authentication using a stored procedure for security and efficiency.";
    }

}
