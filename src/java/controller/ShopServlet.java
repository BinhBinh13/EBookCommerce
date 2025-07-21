/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookDAO;
import dal.CategoryDAO;
import dal.SupplierDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Book;
import model.Category;
import model.PageControl;
import model.Supplier;

/**
 *
 * @author Phong vu
 */
public class ShopServlet extends HttpServlet {

    private BookDAO bdao = new BookDAO();
    private CategoryDAO cdao = new CategoryDAO();
    private SupplierDAO sdao = new SupplierDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int totalPage = 0;
        HttpSession session = req.getSession();
        List<Book> listBooks = new ArrayList<>();
        int total_recod = 0;
        String requestURl = req.getRequestURI().toString();
        PageControl pageControl = new PageControl();
        String page_raw = req.getParameter("page");
        int page;
        try {
            page = Integer.parseInt(page_raw);
            if (page <= 0) {
                page = 1;
            }

        } catch (Exception e) {
            page = 1;

        }
        String action = req.getParameter("action");
        if (action == null) {
            listBooks = getAllBooks(page);
            pageControl.setUrlPattern(requestURl + "?");
            total_recod = bdao.totalRecord();
            totalPage = (total_recod % 12) == 0 ? (total_recod / 12) : (total_recod / 12 + 1);
            pageControl.setPage(page);
            pageControl.setTotalRecord(total_recod);
            pageControl.setTotalPage(totalPage);
            session.removeAttribute("title");
            session.setAttribute("pageControl", pageControl);
            session.setAttribute("minPrice", bdao.getMinPrice());
            session.setAttribute("maxPrice", bdao.getMaxPrice());
            session.setAttribute("listBooks", listBooks);
            session.setAttribute("count", listBooks.size());
            session.setAttribute("cList", cdao.getAllCategories());
            session.setAttribute("sList", sdao.getAllSuppliers());
            req.getRequestDispatcher("shop.jsp").forward(req, resp);

        } else {
            switch (action) {
                case "category":
                    String categoryId = req.getParameter("cId");
                    listBooks = bdao.getBooksByCategoryWithPaging(categoryId, page);
                    pageControl.setUrlPattern(requestURl + "?action=category&cId=" + categoryId + "&");
                    total_recod = bdao.totalRecordByCategory(categoryId);
                    totalPage = (total_recod % 12) == 0 ? (total_recod / 12) : (total_recod / 12 + 1);
                    pageControl.setPage(page);
                    pageControl.setTotalRecord(total_recod);
                    pageControl.setTotalPage(totalPage);

                    Category c = cdao.getCategoryById(categoryId);
                    session.setAttribute("title", c.getCategoryName());
                    session.setAttribute("cId", categoryId);
                    session.setAttribute("listBooks", listBooks);
                    session.setAttribute("pageControl", pageControl);
                    session.setAttribute("origin", listBooks);
                    req.getRequestDispatcher("shop.jsp").forward(req, resp);
                    break;
                case "price_filter":
                    try {
                    String minStr = req.getParameter("minPrice");
                    String maxStr = req.getParameter("maxPrice");

                    double min = 0, max = Double.MAX_VALUE;

                    if (minStr != null && !minStr.isEmpty()) {
                        min = Double.parseDouble(minStr.replace(",", ""));
                    }
                    if (maxStr != null && !maxStr.isEmpty()) {
                        max = Double.parseDouble(maxStr.replace(",", ""));
                    }

                    categoryId = (String) session.getAttribute("cId");
                    String[] supplierId = (String[]) session.getAttribute("supplier");
                    if (supplierId == null) {
                        supplierId = req.getParameterValues("supplier");
                    }
                    if (categoryId != null && !categoryId.isEmpty()) {
                        listBooks = bdao.getBooksByCategoryAndPrice(categoryId, min, max, page);
                        pageControl.setUrlPattern(requestURl + "?action=price_filter&cId=" + categoryId + "&minPrice=" + min + "&maxPrice=" + max + "&");
                        total_recod = bdao.totalRecordByCategoryAndPrice(categoryId, min, max);
                    } else if (supplierId != null) {
                        listBooks = bdao.getBooksBySupplierAndPrice(supplierId, min, max, page);
                        String s = "";
                        for (int i = 0; i < supplierId.length; i++) {
                            s += "supplier=" + supplierId[i] + "&";
                        }
                        pageControl.setUrlPattern(requestURl + "?action=price_filter&" + s + "minPrice=" + min + "&maxPrice=" + max + "&");
                        total_recod = bdao.totalRecordBySupplierAndPrice(supplierId, min, max);
                    } else {
                        listBooks = bdao.getBooksByPriceRangeWithPaging(min, max, page);
                        pageControl.setUrlPattern(requestURl + "?action=price_filter&minPrice=" + min + "&maxPrice=" + max + "&");
                        total_recod = bdao.totalRecordByPriceRange(min, max);
                    }

                    totalPage = (total_recod % 12) == 0 ? (total_recod / 12) : (total_recod / 12 + 1);

                    pageControl.setPage(page);
                    pageControl.setTotalRecord(total_recod);
                    pageControl.setTotalPage(totalPage);
                    session.setAttribute("origin", listBooks);
                    session.setAttribute("cList", cdao.getAllCategories());
                    session.setAttribute("sList", sdao.getAllSuppliers());
                    session.setAttribute("minPrice", bdao.getMinPrice());
                    session.setAttribute("maxPrice", bdao.getMaxPrice());
                    session.setAttribute("listBooks", listBooks);
                    session.setAttribute("pageControl", pageControl);
                    req.getRequestDispatcher("shop.jsp").forward(req, resp);

                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                break;
                case "sort":
                 try {
                    String orderby = req.getParameter("orderby");
                    String sortOrder = "DESC";
                    String sortColumn = "addeddate";
                    if ("menu_order".equals(orderby)) {
                        listBooks = getAllBooks(page);
                        pageControl.setUrlPattern(requestURl + "?");
                        total_recod = bdao.totalRecord();
                        totalPage = (total_recod % 12) == 0 ? (total_recod / 12) : (total_recod / 12 + 1);
                        pageControl.setPage(page);
                        pageControl.setTotalRecord(total_recod);
                        pageControl.setTotalPage(totalPage);
                        session.removeAttribute("title");
                        session.setAttribute("pageControl", pageControl);
                        session.setAttribute("minPrice", bdao.getMinPrice());
                        session.setAttribute("maxPrice", bdao.getMaxPrice());
                        session.setAttribute("listBooks", listBooks);
                        session.setAttribute("count", listBooks.size());
                        session.setAttribute("cList", cdao.getAllCategories());
                        session.setAttribute("sList", sdao.getAllSuppliers());
                        req.getRequestDispatcher("shop.jsp").forward(req, resp);
                        return;
                    } else if ("price".equals(orderby)) {
                        sortColumn = "price";
                        sortOrder = "ASC";
                    } else if ("price-desc".equals(orderby)) {
                        sortColumn = "price";
                        sortOrder = "DESC";
                    } else if ("date".equals(orderby)) {
                        sortColumn = "addeddate";
                        sortOrder = "DESC";
                    }

                    categoryId = (String) session.getAttribute("cId");
                    String supplierId = req.getParameter("sId");
                    String baseUrl = requestURl + "?action=sort&orderby=" + orderby;

                    if (categoryId != null && !categoryId.isEmpty()) {
                        listBooks = bdao.getBooksByCategoryAndSort(categoryId, sortColumn, sortOrder, page);
                        total_recod = bdao.totalRecordByCategory(categoryId);
                        pageControl.setUrlPattern(baseUrl + "&cId=" + categoryId + "&");
                    } else if (supplierId != null && !supplierId.isEmpty()) {
                        listBooks = bdao.getBooksBySupplierAndSort(supplierId, sortColumn, sortOrder, page);
                        total_recod = bdao.totalRecordBySupplier(supplierId);
                        pageControl.setUrlPattern(baseUrl + "&sId=" + supplierId + "&");
                    } else {
                        listBooks = bdao.getBooksSort(sortColumn, sortOrder, page);
                        total_recod = bdao.totalRecord();
                        pageControl.setUrlPattern(baseUrl + "&");
                    }

                    totalPage = (total_recod % 12 == 0) ? (total_recod / 12) : (total_recod / 12 + 1);

                    pageControl.setPage(page);
                    pageControl.setTotalRecord(total_recod);
                    pageControl.setTotalPage(totalPage);

                    session.setAttribute("listBooks", listBooks);
                    session.setAttribute("pageControl", pageControl);

                    req.getRequestDispatcher("shop.jsp").forward(req, resp);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
                case "search":
                    String search = req.getParameter("search");

                    if (search == null || search.trim().isEmpty()) {
                        listBooks = bdao.getBooks(page);
                        pageControl.setUrlPattern(requestURl + "?");
                        total_recod = bdao.totalRecord();
                    } else {
                        listBooks = bdao.searchBooks(search, page);
                        total_recod = bdao.totalRecordBySearch(search);
                        if (listBooks.isEmpty()) {
                            listBooks = bdao.getBooksByCategoryName(search, page);
                            total_recod = bdao.totalRecordByCategoryName(search);

                            if (listBooks.isEmpty()) {
                                listBooks = bdao.getBooksBySupplierName(search, page);
                                total_recod = bdao.totalRecordBySupplierName(search);
                            }
                        }
                    }
                    pageControl.setUrlPattern(requestURl + "?action=search&search=" + search + "&");
                    totalPage = (total_recod % 12 == 0) ? (total_recod / 12) : (total_recod / 12 + 1);

                    pageControl.setPage(page);
                    pageControl.setTotalRecord(total_recod);
                    pageControl.setTotalPage(totalPage);
                    session.setAttribute("cList", cdao.getAllCategories());
                    session.setAttribute("sList", sdao.getAllSuppliers());
                    session.setAttribute("minPrice", bdao.getMinPrice());
                    session.setAttribute("maxPrice", bdao.getMaxPrice());
                    session.setAttribute("origin", listBooks);
                    session.setAttribute("listBooks", listBooks);
                    session.setAttribute("pageControl", pageControl);
                    req.getRequestDispatcher("shop.jsp").forward(req, resp);
                    break;
                default:
                    return;
            }
        }

    }

    private List<Book> getAllBooks(int page) {
        List<Book> listBooks = bdao.getBooks(page);
        return listBooks;
    }

    private void addBooks(List<Book> result, List<Book> books) {
        for (Book b : books) {
            result.add(b);
        }
    }

}
