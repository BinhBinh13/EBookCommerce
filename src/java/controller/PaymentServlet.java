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
public class PaymentServlet extends HttpServlet {

    BookDAO bdao = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
        cart.addItem(t);
        List<Item> list = cart.getItems();
        session.setAttribute("total_money", cart.getToTalMoney());
        session.setAttribute("cart", cart);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Object o = session.getAttribute("cart");
        String action = req.getParameter("action");
        List<Item> list = null;
        Cart cart = null;
        switch (action) {
            case "delete":
                cart = deleteCart(req, resp);
                list = cart.getItems();
                session.setAttribute("cart", cart);
                for (Item i : list) {
                    resp.getWriter().println("                                    "
                            + "<div id=\"test\" class=\"single_cart_item\">\n"
                            + "    <div >\n"
                            + "        <img width=\"100px\" height=\"120px\" src=\"" + i.getBook().getCoverPics() + "\" alt=\"cart\">\n"
                            + "    </div>\n"
                            + "    <div class=\"cart_item_content\">\n"
                            + "        <a href=\"product-single.html\" class=\"book_name\">" + i.getBook().getBookName() + "</a>\n"
                            + "        <div class=\"author_name\"> " + i.getBook().getAuthor() + "</div>\n"
                            + "        <div class=\"cart_action\">\n"
                            + "            <button onclick=\"big_remove('" + i.getBook().getBookId() + "')\" class=\"cart_remove\"><i class=\"ti-trash\"></i></button>\n"
                            + "        </div>\n"
                            + "    </div>\n"
                            + "    <div class=\"cart_quantity\">\n"
                            + "    </div>\n"
                            + "    <div class=\"cart_item_price\">\n"
                            + "        <div class=\"cart_item_price_discount\">" + i.getBook().getPrice() + "</div>\n"
                            + "        <div class=\"cart_item_price_mrp\"></div>\n"
                            + "    </div>\n"
                            + "</div>\n");
                }
                break;
            case "total":
                o = session.getAttribute("cart");
                cart = (Cart) o;
                session.setAttribute("total_money", cart.getToTalMoney());
                resp.getWriter().println("<span>Payable Total</span>\n"
                        + "                                        <span id=\"total\"><sup></sup>" + cart.getToTalMoney() + "<sup>đ</sup></span>");
                break;
            case "delete_submenu":
                cart = deleteCart(req, resp);
                list = cart.getItems();
                session.setAttribute("cart", cart);
                for (Item i : list) {
                    resp.getWriter().println("<li class=\"cart-single-item clearfix\">\n"
                            + "                                                <div class=\"cart-img\">\n"
                            + "                                                    <img width=\"100px\" height=\"80px\" src=\"" + i.getBook().getCoverPics() + "\" alt=\"styler\" />\n"
                            + "                                                </div>\n"
                            + "                                                <div class=\"cart-content text-left\">\n"
                            + "                                                    <p class=\"cart-title\">\n"
                            + "                                                        <a href=\"bookdetail?bookid=" + i.getBook().getBookId() + "\">" + i.getBook().getBookName() + "</a>\n"
                            + "                                                    </p>\n"
                            + "                                                    <p>" + i.getBook().getPrice() + "<sup>đ</sup></p>\n"
                            + "                                                </div>\n"
                            + "                                                <div class=\"cart-remove\">\n"
                            + "                                                    <span onclick=\"remove('" + i.getBook().getBookId() + "')\" class=\"ti-close\"></span>\n"
                            + "                                                </div>\n"
                            + "                                            </li>");
                }
                break;
            case "add_submenu":
                cart = addCart(req, resp);
                list = cart.getItems();
                session.setAttribute("cart", cart);
                for (Item i : list) {
                    resp.getWriter().println("                                            <li class=\"cart-single-item clearfix\">\n"
                            + "                                                <div class=\"cart-img\">\n"
                            + "                                                    <img width=\"100px\" height=\"80px\" src=\"" + i.getBook().getCoverPics() + "\" alt=\"styler\" />\n"
                            + "                                                </div>\n"
                            + "                                                <div class=\"cart-content text-left\">\n"
                            + "                                                    <p class=\"cart-title\">\n"
                            + "                                                        <a href=\"bookdetail?bookid=" + i.getBook().getBookId() + "\">" + i.getBook().getBookName() + "</a>\n"
                            + "                                                    </p>\n"
                            + "                                                    <p>" + i.getBook().getPrice() + "<sup>đ</sup></p>\n"
                            + "                                                </div>\n"
                            + "                                                <div class=\"cart-remove\">\n"
                            + "                                                    <span onclick=\"remove('" + i.getBook().getBookId() + "')\" class=\"ti-close\"></span>\n"
                            + "                                                </div>\n"
                            + "                                            </li>");
                }
                break;
            case "size":
                o = session.getAttribute("cart");
                cart = (Cart) o;
                session.setAttribute("size", cart.getItems().size());
                resp.getWriter().println("<span class=\"num total-cart-count\">" + cart.getItems().size() + "</span>");
                break;
            case "subtotal":
                o = session.getAttribute("cart");
                cart = (Cart) o;
                session.setAttribute("total_money", cart.getToTalMoney());
                resp.getWriter().print("                                    <p class=\"total\">Subtotal :<span class=\"p-total text-end\">" + cart.getToTalMoney() + "<sup>đ</sup>\n"
                        + "                                    </p>");
                break;
            default:
                throw new AssertionError();
        }
    }

    private Cart deleteCart(HttpServletRequest req, HttpServletResponse resp) {
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
        return cart;
    }

    private Cart addCart(HttpServletRequest req, HttpServletResponse resp) {
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
        cart.addItem(t);
        List<Item> list = cart.getItems();
        return cart;
    }
}
