/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BillDAO;
import dal.BookDAO;
import dal.SupplierDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Bill;
import model.BillDetail;
import model.Book;
import model.Cart;
import model.User;

/**
 *
 * @author Phong vu
 */
public class UserProfile extends HttpServlet {

    private BillDAO bd = new BillDAO();
    private BookDAO bkdao = new BookDAO();
    private SupplierDAO sdao =new SupplierDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User account = null;
        Cart cart = null;
        Object a = session.getAttribute("currentUser");
        Object o = session.getAttribute("cart");
        String action = req.getParameter("action");
        Map<Integer, List<BillDetail>> billDetailsMap = new HashMap<>();
        Map<String, Book> bookMap = new HashMap<>();
        if (a != null) {
            account = (User) a;
            if (action == null) {
                req.setAttribute("phone", account.getPhoneNumber());
                req.setAttribute("gender", account.getGender());
                req.setAttribute("email", account.getEmail());
                req.setAttribute("fullname", account.getFullName());
                req.setAttribute("avatar", account.getAvatarPics());
                req.setAttribute("username", account.getUsername());
                req.getRequestDispatcher("userProfile.jsp").forward(req, resp);
                return;
            } else {
                switch (action) {
                    case "order_list":

                        List<Bill> billList = bd.getBillsByAccountId(account.getAccountId());
                        billDetailsMap = new HashMap<>();
                        bookMap = new HashMap<>();

                        for (Bill bill : billList) {
                            List<BillDetail> billDetails = bd.getBillItemsByBillId(bill.getBillId());
                            billDetailsMap.put(bill.getBillId(), billDetails);

                            for (BillDetail detail : billDetails) {
                                if (!bookMap.containsKey(detail.getBookId())) {
                                    Book book = bkdao.getBookById(detail.getBookId());
                                    bookMap.put(detail.getBookId(), book);
                                }
                            }
                        }
                        req.setAttribute("billList", billList);
                        req.setAttribute("avatar", account.getAvatarPics());
                        req.setAttribute("username", account.getUsername());
                        req.setAttribute("billDetailsMap", billDetailsMap);
                        req.setAttribute("bookMap", bookMap);
                        req.getRequestDispatcher("myorderlist.jsp").forward(req, resp);

                        break;
                    case "book_list":

                        bookMap = new HashMap<>();
                        List<BillDetail> billDetails = bd.getBillDetailsByBillStatus(account.getAccountId());
                        for (BillDetail detail : billDetails) {
                            if (!bookMap.containsKey(detail.getBookId())) {
                                Book book = bkdao.getBookById(detail.getBookId());
                                bookMap.put(detail.getBookId(), book);
                            }
                        }
                        req.setAttribute("sList", sdao.getAllSuppliers());
                        req.setAttribute("billDetails", billDetails);
                        req.setAttribute("bookMap", bookMap);
                        req.setAttribute("avatar", account.getAvatarPics());
                        req.setAttribute("username", account.getUsername());
                        req.getRequestDispatcher("mylibrary.jsp").forward(req, resp);
                        break;
                    default:
                        throw new AssertionError();
                }
            }
        } else {
            resp.sendRedirect("login");
        }
    }

}
