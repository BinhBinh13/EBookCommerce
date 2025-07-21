/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BillDAO;
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
import model.User;

/**
 *
 * @author Phong vu
 */
public class CheckOutServlet extends HttpServlet {

    private BookDAO bdao = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User account = null;
        Cart cart = null;
        Object a = session.getAttribute("currentUser");
        Object o = session.getAttribute("cart");

        if (o != null) {
            cart = (Cart) o;
        } else {
            cart = new Cart();

        }

        if (a != null) {

            account = (User) a;
            session.setAttribute("username", account.getUsername());
            session.setAttribute("fullname", account.getFullName());
            session.setAttribute("email", account.getEmail());
            session.setAttribute("totalPrice", cart.getToTalMoney());
            session.setAttribute("text", account.getAccountId());

        } else {
            resp.sendRedirect("login");
            return;
        }
        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Cart cart = null;
        Object o = session.getAttribute("cart");

        if (o != null) {
            cart = (Cart) o;
        } else {

        }

        User acount = null;
        Object a = session.getAttribute("currentUser");

        if (a != null) {
            if (cart.getToTalMoney() > 0) {
                acount = (User) a;
                BillDAO odb = new BillDAO();
                odb.addOrder(acount, cart);
                session.removeAttribute("total_money");
                session.removeAttribute("cart");
                session.setAttribute("size", 0);
                resp.sendRedirect("thankyou.jsp");
                return;
            }
            req.getRequestDispatcher("checkout.jsp").forward(req, resp);
        } else {
            resp.sendRedirect("login");
        }
    }

}
