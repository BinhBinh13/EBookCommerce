/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Supplier;

public class BookDAO extends DBConnection {

    public String getLatestBook() {
        String sql = "SELECT TOP 1 book_id FROM book ORDER BY book_id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getString("book_id"); 
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public List<Book> bestSelling() {
        List<Book> list = new ArrayList<>();
        String sql = "select top 10 bill_detail.book_id\n"
                + "       ,b.[book_name]\n"
                + "      ,[supplier_id]\n"
                + "      ,[category_id]\n"
                + "      ,[cover_pics]\n"
                + "      ,[author]\n"
                + "      ,[ratings]\n"
                + "      ,b.[price]\n"
                + "      ,[description]\n"
                + "      ,[book_content]\n"
                + "      ,[addeddate]\n"
                + "      ,b.[status], COUNT(bd_id) as [count]   from bill_detail join book b on bill_detail.book_id = b.book_id join bill on bill.bill_id = bill_detail.bill_id where b.[status] = 1 and bill.[status] =1  group by \n"
                + "	  bill_detail.book_id,\n"
                + "	  b.book_name,\n"
                + "	  b.supplier_id,\n"
                + "      b.category_id,\n"
                + "      b.cover_pics,\n"
                + "      b.author,\n"
                + "      b.ratings,\n"
                + "      b.price,\n"
                + "      b.description,\n"
                + "      b.book_content,\n"
                + "      b.addeddate,\n"
                + "      b.status\n"
                + "	  order by count desc";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");
                list.add(new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateBook(Book book) {
        String sql = "UPDATE book SET book_name = ?, supplier_id = ?, category_id = ?, cover_pics = ?, author = ?, description = ?, book_content = ?, price = ? "
                + "WHERE book_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, book.getBookName());
            pstmt.setString(2, book.getSupplierId());
            pstmt.setString(3, book.getCategoryId());
            pstmt.setString(4, book.getCoverPics());
            pstmt.setString(5, book.getAuthor());
            pstmt.setString(6, book.getDescription());
            pstmt.setString(7, book.getBookContent());
            pstmt.setDouble(8, book.getPrice());
            pstmt.setString(9, book.getBookId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBookStatus(String bookId, String status) {
        String sql = "UPDATE book SET status = ? WHERE book_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, status);
            pstmt.setString(2, bookId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countBooks() {
        String sql = "SELECT COUNT(*) FROM book";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Book> getAllBooks(int pageNo, int pageSize) {
        String sql = "SELECT * FROM book "
                + "ORDER BY book_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        List<Book> result = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, (pageNo - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");
                int status = rs.getInt("status");
                result.add(new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate, status));
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean insertBook(Book book) {
        String sql = "INSERT INTO book (book_id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate,status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), 1)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, book.getBookId());
            pstmt.setString(2, book.getBookName());
            pstmt.setString(3, book.getSupplierId());
            pstmt.setString(4, book.getCategoryId());
            pstmt.setString(5, book.getCoverPics());
            pstmt.setString(6, book.getAuthor());
            pstmt.setInt(7, 0);
            pstmt.setString(8, book.getDescription());
            pstmt.setString(9, book.getBookContent());
            pstmt.setDouble(10, book.getPrice());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Book> getBooks() {
        String sql = "SELECT * FROM book ";
        List<Book> result = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");
                int status = rs.getInt("status");
                result.add(new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate, status));
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int totalRecordBySupplier(String supplierId) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM book WHERE supplier_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, supplierId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public List<Book> getBooksBySupplierId(String supplierId) {
        String sql = "SELECT * FROM book "
                + "WHERE supplier_id = ? AND status = 1 ";

        List<Book> result = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, supplierId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");

                Book book = new Book(id, book_name, supplierId, category_id, cover_pics, author, ratings, description, book_content, price, addeddate);
                result.add(book);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return result;
    }

    public List<Book> getBooksByCategoryName(String categoryName, int page) {
        String sql = "SELECT b.* FROM book b "
                + "JOIN category c ON b.category_id = c.category_id "
                + "WHERE c.category_name LIKE ? AND b.status = 1 "
                + "ORDER BY b.book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        List<Book> result = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + categoryName + "%");
            ps.setInt(2, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");

                Book book = new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate);
                result.add(book);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return result;
    }

    public List<Book> getBooksBySupplierName(String supplierName, int page) {
        String sql = "SELECT b.* FROM book b "
                + "JOIN supplier s ON b.supplier_id = s.supplier_id "
                + "WHERE s.supplier_name LIKE ? AND b.status = 1 "
                + "ORDER BY b.book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        List<Book> result = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + supplierName + "%");
            ps.setInt(2, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");

                Book book = new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate);
                result.add(book);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return result;
    }

    public int totalRecordBySupplierName(String supplierName) {
        String sql = "SELECT COUNT(*) FROM book b "
                + "JOIN supplier s ON b.supplier_id = s.supplier_id "
                + "WHERE s.supplier_name LIKE ? AND b.status = 1";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + supplierName + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int totalRecordByCategoryName(String categoryName) {
        String sql = "SELECT COUNT(*) FROM book b "
                + "JOIN category c ON b.category_id = c.category_id "
                + "WHERE c.category_name LIKE ? AND b.status = 1";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + categoryName + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public int totalRecordBySearch(String search) {
        String sql = "SELECT COUNT(*) FROM book WHERE title LIKE ? AND status = 1";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + search + "%");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Book> searchBooks(String search, int page) {
        String sql = "SELECT * FROM book WHERE book_name  LIKE ? AND status = 1 ORDER BY book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
        List<Book> result = new ArrayList<>();

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");

                result.add(new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public List<Book> getBooksSort(String sortBy, String order, int page) {
        List<Book> books = new ArrayList<>();
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "addeddate";
        }
        if (order == null || order.isEmpty()) {
            order = "DESC";
        }

        String sql = "SELECT * FROM book WHERE status = 1 ORDER BY " + sortBy + " " + order
                + " OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(new Book(
                        rs.getString("book_id"),
                        rs.getString("book_name"),
                        rs.getString("supplier_id"),
                        rs.getString("category_id"),
                        rs.getString("cover_pics"),
                        rs.getString("author"),
                        rs.getInt("ratings"),
                        rs.getString("description"),
                        rs.getString("book_content"),
                        rs.getDouble("price"),
                        rs.getDate("addeddate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> getBooksBySupplierAndSort(String sID, String sortBy, String order, int page) {
        List<Book> books = new ArrayList<>();
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "addeddate";
        }
        if (order == null || order.isEmpty()) {
            order = "DESC";
        }

        String sql = "SELECT * FROM book WHERE supplier_id = ? and status = 1 ORDER BY " + sortBy + " " + order
                + " OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sID);
            ps.setInt(2, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(new Book(
                        rs.getString("book_id"),
                        rs.getString("book_name"),
                        rs.getString("supplier_id"),
                        rs.getString("category_id"),
                        rs.getString("cover_pics"),
                        rs.getString("author"),
                        rs.getInt("ratings"),
                        rs.getString("description"),
                        rs.getString("book_content"),
                        rs.getDouble("price"),
                        rs.getDate("addeddate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> getBooksByCategoryAndSort(String categoryId, String sortBy, String order, int page) {
        List<Book> books = new ArrayList<>();
        if (sortBy == null || sortBy.isEmpty()) {
            sortBy = "addeddate";
        }
        if (order == null || order.isEmpty()) {
            order = "DESC";
        }

        String sql = "SELECT * FROM book WHERE category_id = ? and status = 1 ORDER BY " + sortBy + " " + order
                + " OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, categoryId);
            ps.setInt(2, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(new Book(
                        rs.getString("book_id"),
                        rs.getString("book_name"),
                        rs.getString("supplier_id"),
                        rs.getString("category_id"),
                        rs.getString("cover_pics"),
                        rs.getString("author"),
                        rs.getInt("ratings"),
                        rs.getString("description"),
                        rs.getString("book_content"),
                        rs.getDouble("price"),
                        rs.getDate("addeddate")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> getBooksByCategoryAndPrice(String categoryId, double minPrice, double maxPrice, int page) {
        List<Book> result = new ArrayList<>();
        String sql = "SELECT * FROM book WHERE category_id = ? and status = 1 AND price BETWEEN ? AND ? "
                + "ORDER BY book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, categoryId);
            ps.setDouble(2, minPrice);
            ps.setDouble(3, maxPrice);
            ps.setInt(4, (page - 1) * 12);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Book(
                        rs.getString("book_id"),
                        rs.getString("book_name"),
                        rs.getString("supplier_id"),
                        rs.getString("category_id"),
                        rs.getString("cover_pics"),
                        rs.getString("author"),
                        rs.getInt("ratings"),
                        rs.getString("description"),
                        rs.getString("book_content"),
                        rs.getDouble("price"),
                        rs.getDate("addeddate")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public List<Book> getBooksBySupplierAndPrice(String[] supplierId, double minPrice, double maxPrice, int page) {
        String s = "(";
        for (int i = 0; i < supplierId.length - 1; i++) {
            s += "?, ";
        }
        s += "?)";
        List<Book> result = new ArrayList<>();
        String sql = "SELECT * FROM book WHERE supplier_id in" + s + "and status = 1 AND price BETWEEN ? AND ? "
                + "ORDER BY book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            for (int i = 0; i < supplierId.length; i++) {
                ps.setString(i + 1, supplierId[i]);
            }
            ps.setDouble(supplierId.length + 1, minPrice);
            ps.setDouble(supplierId.length + 2, maxPrice);
            ps.setInt(supplierId.length + 3, (page - 1) * 12);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Book(
                        rs.getString("book_id"),
                        rs.getString("book_name"),
                        rs.getString("supplier_id"),
                        rs.getString("category_id"),
                        rs.getString("cover_pics"),
                        rs.getString("author"),
                        rs.getInt("ratings"),
                        rs.getString("description"),
                        rs.getString("book_content"),
                        rs.getDouble("price"),
                        rs.getDate("addeddate")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public List<Book> getBooksByPriceRangeWithPaging(double minPrice, double maxPrice, int page) {
        List<Book> result = new ArrayList<>();
        String sql = "SELECT * FROM book WHERE price BETWEEN ? AND ?  and status = 1 "
                + "ORDER BY book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            ps.setInt(3, (page - 1) * 12);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Book(
                        rs.getString("book_id"),
                        rs.getString("book_name"),
                        rs.getString("supplier_id"),
                        rs.getString("category_id"),
                        rs.getString("cover_pics"),
                        rs.getString("author"),
                        rs.getInt("ratings"),
                        rs.getString("description"),
                        rs.getString("book_content"),
                        rs.getDouble("price"),
                        rs.getDate("addeddate")
                ));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public int totalRecordByPriceRange(double minPrice, double maxPrice) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM book WHERE price BETWEEN ? AND ? and status = 1";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, minPrice);
            ps.setDouble(2, maxPrice);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int totalRecordBySupplierAndPrice(String[] supplierId, double minPrice, double maxPrice) {
        String s = "(";
        for (int i = 0; i < supplierId.length - 1; i++) {
            s += "?, ";
        }
        s += "?)";
        int count = 0;
        String sql = "SELECT COUNT(*) FROM book WHERE supplier_id in " + s + " AND price BETWEEN ? AND ? and status = 1";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            for (int i = 0; i < supplierId.length; i++) {
                ps.setString(i + 1, supplierId[i]);
            }
            ps.setDouble(supplierId.length + 1, minPrice);
            ps.setDouble(supplierId.length + 2, maxPrice);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int totalRecordByCategoryAndPrice(String categoryId, double minPrice, double maxPrice) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM book WHERE category_id = ? AND price BETWEEN ? AND ? and status = 1";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, categoryId);
            ps.setDouble(2, minPrice);
            ps.setDouble(3, maxPrice);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public int totalRecordByCategory(String categoryId) {
        int count = 0;
        String sql = "SELECT count(*) FROM book where category_id = ? and status = 1";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    //ham dem tong so sach ban dau
    public int totalRecord() {
        int count = 0;
        String sql = "SELECT count(*) FROM book where status = 1 ";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public List<Book> getNewArrivals() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT Top 10 * FROM book where status = 1 ORDER BY addeddate DESC ";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book book = new Book(
                        rs.getString("book_id"),
                        rs.getString("book_name"),
                        rs.getString("supplier_id"),
                        rs.getString("category_id"),
                        rs.getString("cover_pics"),
                        rs.getString("author"),
                        rs.getInt("ratings"),
                        rs.getString("description"),
                        rs.getString("book_content"),
                        rs.getDouble("price"),
                        rs.getDate("addeddate")
                );
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public List<Book> getBooks(int page) {
        String sql = "SELECT * FROM book where status = 1 ORDER BY book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
        List<Book> result = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");
                result.add(new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate));
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Book getBookById(String bookId) {
        String sql = "SELECT * FROM book WHERE book_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, bookId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Book(
                            rs.getString("book_id"),
                            rs.getString("book_name"),
                            rs.getString("supplier_id"),
                            rs.getString("category_id"),
                            rs.getString("cover_pics"),
                            rs.getString("author"),
                            rs.getInt("ratings"),
                            rs.getString("description"),
                            rs.getString("book_content"),
                            rs.getDouble("price"),
                            rs.getDate("addeddate")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Book> getBooksBySupplierWithPaging(String supplierId, int page) {
        List<Book> result = new ArrayList<>();
        try {
            String sql = "SELECT * FROM book WHERE supplier_id = ? and status = 1 ORDER BY book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, supplierId);
            ps.setInt(2, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");

                result.add(new Book(id, book_name, supplierId, category_id, cover_pics, author, ratings, description, book_content, price, addeddate));
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }

    public List<Book> getBooksByCategoryWithPaging(String cid, int page) {
        List<Book> result = new ArrayList<>();
        try {
            String sql = "select * from book where category_id = ? and status = 1 ORDER BY book_id OFFSET ? ROWS FETCH NEXT 12 ROWS ONLY";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cid);
            ps.setInt(2, (page - 1) * 12);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");
                result.add(new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate));

            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Book> getBooksByCategory(String cid) {
        List<Book> result = new ArrayList<>();
        try {
            String sql = "select * from book where category_id = ? and status = 1 ";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");
                result.add(new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate));

            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int getMinPrice() {
        String sql = "SELECT MIN(price) FROM book";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getMaxPrice() {
        String sql = "SELECT MAX(price) FROM book";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        BookDAO bookDAO = new BookDAO();
        String[] supplierid = new String[]{"S01", "S02"};
        List<Book> list = bookDAO.getBooksBySupplierAndPrice(supplierid, 10, 10, 1);
        for (Book book : list) {
            System.out.println(book);
        }
    }

    public Book getBookByName(String name) {
        String sql = "Select * from book where book_name = ? and status = 1";
        Book book = null;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String id = rs.getString("book_id");
                String book_name = rs.getString("book_name");
                String supplier_id = rs.getString("supplier_id");
                String category_id = rs.getString("category_id");
                String cover_pics = rs.getString("cover_pics");
                String author = rs.getString("author");
                int ratings = rs.getInt("ratings");
                String description = rs.getString("description");
                String book_content = rs.getString("book_content");
                double price = rs.getDouble("price");
                Date addeddate = rs.getDate("addeddate");
                book = new Book(id, book_name, supplier_id, category_id, cover_pics, author, ratings, description, book_content, price, addeddate);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return book;
    }
}
