/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.*;
import dal.BookDAO;
import dal.CategoryDAO;
import dal.SupplierDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Phong vu
 */
public class BookDetailServlet extends HttpServlet {

    private BookDAO bdao = new BookDAO();
    private CategoryDAO cdao = new CategoryDAO();
    private SupplierDAO sdao = new SupplierDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Book book;
        String book_id = req.getParameter("bookid");
        if (book_id != null) {
            book = bdao.getBookById(book_id);
        } else {
            String book_name = req.getParameter("bookName");
            book = bdao.getBookByName(book_name);
        }

        req.setAttribute("book", book);

        Category c = cdao.getCategoryById(book.getCategoryId());
        req.setAttribute("c", c);

        Supplier s = sdao.getSupplierById(book.getSupplierId());
        req.setAttribute("s", s);


        req.getRequestDispatcher("singleproduct.jsp").forward(req, resp);
    }

}
