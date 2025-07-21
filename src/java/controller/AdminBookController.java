/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.SupplierDAO;
import dal.BookDAO;
import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.List;
import model.Book;
import model.Category;
import model.Supplier;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(name = "AdminBookController", urlPatterns = {"/adminbooklist", "/adminupdatebook", "/admineditbook", "/adminaddbook", "/adminbookupdatestatus"})
public class AdminBookController extends HttpServlet {

    BookDAO bookDAO = new BookDAO();
    CategoryDAO cdao = new CategoryDAO();
    SupplierDAO sdao = new SupplierDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = request.getServletPath();
        List<Category> cat = cdao.getAllCategories();
        List<Supplier> sup = sdao.getAllSuppliers();
        switch (url) {
            case "/adminbooklist":
                handleListBook(request, response);
                break;
            case "/adminupdatebook":
                Book b = bookDAO.getBookById(request.getParameter("bookId"));
                request.setAttribute("category", cat);
                request.setAttribute("supplier", sup);
                request.setAttribute("book", b);
                request.getRequestDispatcher("/editbooklist.jsp").forward(request, response);
                break;
            case "/adminaddbook":
                request.setAttribute("category", cat);
                request.setAttribute("supplier", sup);
                request.getRequestDispatcher("/addbook.jsp").forward(request, response);
                break;
            case "/adminbookupdatestatus":
                String status = request.getParameter("status");
                String bookid = request.getParameter("bookId");
                boolean isUpdated = bookDAO.updateBookStatus(bookid, status);

                if (isUpdated) {
                    request.setAttribute("message", "Book status changed successfully!");
                } else {
                    request.setAttribute("error", "Failed to update status the book.");
                }
                handleListBook(request, response);
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
        String url = request.getServletPath();
        String action = request.getParameter("submit");
        switch (url) {
            case "/admineditbook":
                if (action.equalsIgnoreCase("add")) {
                    handleAddBook(request, response);
                    return;
                }
                if (action.equalsIgnoreCase("update")) {
                    handleUpdateBook(request, response);
                }
                break;
        }
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

    protected void handleListBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageNo = 1;
        int pageSize = 10;
        String page = request.getParameter("pageNo");

        if (page != null && !page.isEmpty()) {
            pageNo = Integer.parseInt(page);
        }

        BookDAO bookDAO = new BookDAO();
        List<Book> bookList = bookDAO.getAllBooks(pageNo, pageSize);
        int totalBooks = bookDAO.countBooks();
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        request.setAttribute("booklist", bookList);
        request.setAttribute("pageNo", pageNo);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/adminbook.jsp").forward(request, response);

    }

    protected void handleUpdateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookId = request.getParameter("bookId");
        String bookName = request.getParameter("bookName");
        String supplierId = request.getParameter("supplierId");
        String categoryId = request.getParameter("categoryId");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");

        String currentImage = request.getParameter("currentImage");
        String currentContent = request.getParameter("currentContent");

        Part coverPics = request.getPart("coverPics");
        Part bookContent = request.getPart("bookContent");

        String imagePath = currentImage;
        String contentPath = currentContent;

        if (coverPics != null && coverPics.getSize() > 0) {
            String uploadPath = request.getServletContext().getRealPath("/images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = coverPics.getSubmittedFileName();
            File file = new File(uploadDir, fileName);
            coverPics.write(file.getAbsolutePath());
            imagePath = request.getContextPath() + "/images/" + fileName;
        }

        if (bookContent != null && bookContent.getSize() > 0) {
            String uploadPath = request.getServletContext().getRealPath("/content");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String fileName = bookContent.getSubmittedFileName();
            File file = new File(uploadDir, fileName);
            bookContent.write(file.getAbsolutePath());
            contentPath = request.getContextPath() + "/content/" + fileName;
        }

        double price = 0.0;
        try {
            if (priceStr != null && !priceStr.isEmpty()) {
                price = Double.parseDouble(priceStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid price format.");
            request.getRequestDispatcher("updateBook.jsp").forward(request, response);
            return;
        }

        Book book = new Book();
        book.setBookId(bookId);
        book.setBookName(bookName);
        book.setSupplierId(supplierId);
        book.setCategoryId(categoryId);
        book.setCoverPics(imagePath);
        book.setAuthor(author);
        book.setDescription(description);
        book.setBookContent(contentPath);
        book.setPrice(price);

        boolean isUpdated = bookDAO.updateBook(book);

        if (isUpdated) {
            request.setAttribute("message", "Book updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update the book.");
        }

        handleListBook(request, response);
    }

    protected void handleAddBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String bookId = "B" + (Integer.parseInt(bookDAO.getLatestBook().substring(1)) + 1);
            String bookName = request.getParameter("bookName");
            String supplierId = request.getParameter("supplierId");
            String categoryId = request.getParameter("categoryId");
            String author = request.getParameter("author");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            Part coverPics = request.getPart("coverPics");
            Part bookContent = request.getPart("bookContent");
            String path = request.getServletContext().getRealPath("/images");
            String path_content = request.getServletContext().getRealPath("/content");
            File dir = new File(path);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            File dir2 = new File(path_content);
            if (!dir2.exists()) {
                dir2.mkdirs();
            }
            File image = new File(dir, coverPics.getSubmittedFileName());
            File content = new File(dir2, bookContent.getSubmittedFileName());
            bookContent.write(content.getAbsolutePath());
            coverPics.write(image.getAbsolutePath());
            String pathOfFile = request.getContextPath() + "/images/" + image.getName();
            String pathOfContent = request.getContextPath() + "/content/" + content.getName();
            double price = 0.0;
            if (priceStr != null && !priceStr.isEmpty()) {
                price = Double.parseDouble(priceStr);
            }

            Book book = new Book();
            book.setBookId(bookId);
            book.setBookName(bookName);
            book.setSupplierId(supplierId);
            book.setCategoryId(categoryId);
            book.setCoverPics(pathOfFile);
            book.setAuthor(author);
            book.setDescription(description);
            book.setBookContent(pathOfContent);
            book.setPrice(price);

            boolean isUpdated = bookDAO.insertBook(book);

            if (isUpdated) {
                request.setAttribute("message", "Book added successfully!");
            } else {
                request.setAttribute("error", "Failed to update the book.");
            }

            handleListBook(request, response);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
