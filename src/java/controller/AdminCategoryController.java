/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AdminCategoryController", urlPatterns = {"/admincategorylist", "/adminaddcategory", "/adminupdatecategory"})
public class AdminCategoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminCategoryController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminCategoryController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = request.getServletPath();
        switch (url) {
            case "/admincategorylist":
                manageListCategory(request, response);
                break;
            case "/adminaddcategory":
                addCategory(request, response);
                break;
            case "/adminupdatecategory":
                updateCategory(request, response);
                break;

        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void manageListCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageNo = 1;
        int pageSize = 10;
        String page = request.getParameter("pageNo");
        String nameOrId = request.getParameter("nameOrId");

        if (page != null && !page.isEmpty()) {
            pageNo = Integer.parseInt(page);
        }

        CategoryDAO bookDAO = new CategoryDAO();
        List<Category> bookList = bookDAO.getAllCategory(pageNo, pageSize, nameOrId);
        int totalBooks = bookDAO.countCategory(nameOrId); 
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize); 

        request.setAttribute("booklist", bookList);
        request.setAttribute("nameOrId", nameOrId);
        request.setAttribute("pageNo", pageNo);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages); // Set total pages

        request.getRequestDispatcher("/admincategory.jsp").forward(request, response);
    }

    protected void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO c = new CategoryDAO();
        String categoryName = request.getParameter("bookName");
        String categoryStatus = request.getParameter("bookStatus");
        String categoryId = "C" + (Integer.parseInt(c.getLatestCategory().substring(1)) + 1);

        if (categoryName == null || categoryName.trim().isEmpty()
                || categoryStatus == null || categoryStatus.trim().isEmpty()) {
            request.setAttribute("error", "Please fill in all field");
            manageListCategory(request, response);
        }

        boolean isUpdated = c.insertCategory(categoryId, categoryName, categoryStatus);

        if (isUpdated) {
            request.setAttribute("message", "Category added successfully!");
        } else {
            request.setAttribute("error", "Failed to update the book.");
        }

        manageListCategory(request, response);
    }

    protected void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CategoryDAO c = new CategoryDAO();
        String categoryId = request.getParameter("bookId");
        String categoryName = request.getParameter("bookName");
        String categoryStatus = request.getParameter("bookStatus");

        if (categoryName == null || categoryName.trim().isEmpty()
                || categoryStatus == null || categoryStatus.trim().isEmpty()) {
            request.setAttribute("error", "Please fill in all field");
            manageListCategory(request, response);
        }
        
        boolean isUpdated = c.updateCategory(categoryId, categoryName, categoryStatus);

        if (isUpdated) {
            request.setAttribute("message", "Category updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update the book.");
        }

        manageListCategory(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
