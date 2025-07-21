/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Book;
import model.Cart;
import model.Item;

/**
 *
 * @author Phong vu
 */
public class ProcesServlet extends HttpServlet {
    BookDAO bdao = new BookDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String book_id = req.getParameter("book_id");
        HttpSession session = req.getSession();
        Cart cart = null;
        Object o = session.getAttribute("cart");
        Book b = bdao.getBookById(book_id);
        double price = b.getPrice();
        Item t = new Item(b, price);
        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();
        }
        cart.removeItem(book_id);
        List<Item> list = cart.getItems();
        session.setAttribute("cart", cart);
        session.setAttribute("size", list.size());
    }
   
    

}
