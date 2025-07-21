/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;
import model.Supplier;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AdminSupplierController", urlPatterns = {"/adminsupplierlist", "/adminaddsupplier", "/adminupdatesupplier"})
public class AdminSupplierController extends HttpServlet {

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
            out.println("<title>Servlet AdminSupplierController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminSupplierController at " + request.getContextPath() + "</h1>");
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
        switch(url){
            case "/adminsupplierlist":
                manageListSupplier(request,response);
                break;
            case "/adminaddsupplier":
                addSupplier(request,response);
                break;
            case "/adminupdatesupplier":
                updateSupplier(request,response);
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

    protected void manageListSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageNo = 1;
        int pageSize = 10;
        String page = request.getParameter("pageNo");
        String nameOrId = request.getParameter("nameOrId");
        
        if (page != null && !page.isEmpty()) {
            pageNo = Integer.parseInt(page);
        }

        SupplierDAO bookDAO = new SupplierDAO();
        List<Supplier> bookList = bookDAO.getAllSupplier(pageNo, pageSize, nameOrId);
        int totalBooks = bookDAO.countSupplier(nameOrId); // Get total number of books
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize); // Calculate total pages

        request.setAttribute("booklist", bookList);
        request.setAttribute("nameOrId", nameOrId);
        request.setAttribute("pageNo", pageNo);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages); // Set total pages

        request.getRequestDispatcher("/adminsupplier.jsp").forward(request, response);
    }
    
    protected void addSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SupplierDAO c = new SupplierDAO();
        String supplierName = request.getParameter("bookName");
        String supplierStatus = request.getParameter("bookStatus");
        String supplierDescription = request.getParameter("bookDescription");
        
        if(supplierDescription==null || supplierDescription.isEmpty()
           || supplierName == null || supplierName.isEmpty()){
            request.setAttribute("error", "Please fill in all field.");
            manageListSupplier(request,response);
        }
        
        int id = Integer.parseInt(c.getLatestSupplier().substring(1))+1;
        String a;
        if(id<10){
            a = "S" + "0" + id;
        }else{
            a = "S" + id;
        }
        
        boolean isUpdated = c.insertSupplier(a, supplierName, supplierDescription, supplierStatus);

        if (isUpdated) {
            request.setAttribute("message", "Supplier added successfully!");
        } else {
            request.setAttribute("error", "Failed to update the book.");
        }
        
        manageListSupplier(request,response);
    }
    
    protected void updateSupplier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SupplierDAO c = new SupplierDAO();
        String supplierId = request.getParameter("bookId");
        String supplierName = request.getParameter("bookName");
        String supplierStatus = request.getParameter("bookStatus");
        String supplierDescription = request.getParameter("bookDescription");
        
        if(supplierDescription==null || supplierDescription.isEmpty()
           || supplierName == null || supplierName.isEmpty()){
            request.setAttribute("error", "Please fill in all field.");
            manageListSupplier(request,response);
        }
        
        boolean isUpdated = c.updateSupplier(supplierId, supplierName, supplierDescription, supplierStatus);

        if (isUpdated) {
            request.setAttribute("message", "Category updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update the book.");
        }

        manageListSupplier(request,response);
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
