/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Book;
import model.Supplier;

public class SupplierDAO extends DBConnection {


    public boolean insertSupplier(String supplierId, String supplierName, String description, String status) {
        String sql = "INSERT INTO supplier (supplier_id, supplier_name, description, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, supplierId);
            pstmt.setString(2, supplierName);
            pstmt.setString(3, description);
            pstmt.setString(4, status);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateSupplier(String supplierId, String newSupplierName, String newDescription, String status) {
        String sql = "UPDATE supplier SET supplier_name = ?, description = ?, status = ? WHERE supplier_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newSupplierName);
            pstmt.setString(2, newDescription);
            pstmt.setString(3, status);
            pstmt.setString(4, supplierId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteSupplier(String supplierId) {
        String sql = "DELETE FROM supplier WHERE supplier_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, supplierId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Supplier> searchSupplierByName(String keyword) {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM supplier WHERE supplier_name LIKE ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy dữ liệu trước
                    String supplierId = rs.getString("supplier_id");
                    String supplierName = rs.getString("supplier_name");
                    String description = rs.getString("description");

                    // Tạo object từ constructor có tham số
                    Supplier supplier = new Supplier(supplierId, supplierName, description);
                    suppliers.add(supplier);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public List<Book> getBooksBySupplierId(String supplierId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM book WHERE supplier_id = ? and status =1 ";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, supplierId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    // Lấy dữ liệu trước
                    String bookId = rs.getString("book_id");
                    String bookName = rs.getString("book_name");
                    String supId = rs.getString("supplier_id");
                    String categoryId = rs.getString("category_id");
                    String coverPics = rs.getString("cover_pics");
                    String author = rs.getString("author");
                    int ratings = rs.getInt("ratings");
                    String description = rs.getString("description");
                    String bookContent = rs.getString("book_content");
                    double price = rs.getDouble("price");
                    Date addedDate = rs.getDate("addedDate");
                    int status = rs.getInt("status");
                    Book book = new Book(bookId, bookName, supId, categoryId, coverPics, author, ratings, description, bookContent, price, addedDate, status);
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public static void main(String[] args) {
        SupplierDAO supplierDAO = new SupplierDAO();
    }
    
    public List<Supplier> getAllSupplier(int pageNo, int pageSize, String nameOrId) {

        String sql = "SELECT * FROM supplier "
                + (nameOrId != null && !nameOrId.isEmpty() ? "WHERE supplier_id LIKE ? OR supplier_name LIKE ? " : " ")
                + "ORDER BY supplier_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ";

        List<Supplier> result = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            int paramIndex = 1;
            if (nameOrId != null && !nameOrId.isEmpty()) {
                ps.setString(paramIndex++, "%" + nameOrId + "%"); // Search by book_id
                ps.setString(paramIndex++, "%" + nameOrId + "%"); // Search by title
            }
            ps.setInt(paramIndex++, (pageNo - 1) * pageSize); // OFFSET
            ps.setInt(paramIndex++, pageSize); // FETCH NEXT
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Supplier c = new Supplier();
                c.setSupplierId(rs.getString("supplier_id"));
                c.setSupplierName(rs.getString("supplier_name"));
                c.setStatus(rs.getInt("status"));
                c.setDescription(rs.getString("description"));
                result.add(c);
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int countSupplier(String nameOrId) {
        String sql = "SELECT COUNT(*) FROM supplier "
                + (nameOrId != null && !nameOrId.isEmpty() ? "WHERE supplier_id LIKE ? OR supplier_name LIKE ?" : "");
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (nameOrId != null && !nameOrId.isEmpty()) {
                ps.setString(paramIndex++, "%" + nameOrId + "%"); // Bind category_id
                ps.setString(paramIndex++, "%" + nameOrId + "%"); // Bind category_name
            }

            try (ResultSet rs = ps.executeQuery()) {  // Execute query after setting parameters
                if (rs.next()) {
                    return rs.getInt(1); // Get the total count
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0; // Return 0 if an error occurs
    }
    
    public String getLatestSupplier() {
        String sql = "SELECT TOP 1 supplier_id FROM supplier ORDER BY supplier_id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getString("supplier_id"); // Return the latest category ID
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null; // Return null if no category is found
    }
    public List<Supplier> getAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        String sql = "SELECT * FROM supplier where status = 1";

        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                String supplierId = rs.getString("supplier_id");
                String supplierName = rs.getString("supplier_name");
                String description = rs.getString("description");

                Supplier supplier = new Supplier(supplierId, supplierName, description);
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public Supplier getSupplierById(String supplierId) {
        String sql = "SELECT * FROM supplier WHERE supplier_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, supplierId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Lấy dữ liệu trước
                    String id = rs.getString("supplier_id");
                    String name = rs.getString("supplier_name");
                    String description = rs.getString("description");

                    // Tạo object từ constructor có tham số
                    return new Supplier(id, name, description);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }




}


