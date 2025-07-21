/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookDAO;
import dal.CategoryDAO;
import dal.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Book;
import model.Category;

/**
 *
 * @author Phong vu
 */
public class HomeServlet extends HttpServlet {

    BookDAO bkdao = new BookDAO();
    CategoryDAO cdao = new CategoryDAO();
    SupplierDAO sdao = new SupplierDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();

        List<Category> listC = cdao.getRandomCategories();
        session.setAttribute("listC", listC);
        String cid = req.getParameter("cid");
        if (cid == null) {
            cid = "c12";
        }
        List<Book> listBooks = bkdao.getBooksByCategory(cid);
        req.setAttribute("listBooks", listBooks);

        List<Book> newArrivals = bkdao.getNewArrivals();
        req.setAttribute("newArrivals", newArrivals);
        req.setAttribute("newArrivals", newArrivals);
        
        List<Book> bestSellings = bkdao.bestSelling();
        req.setAttribute("bestSellings", bestSellings);
        req.getRequestDispatcher("home.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
