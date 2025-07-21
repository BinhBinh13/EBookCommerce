/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 */
public class CategoryDAO extends DBConnection {

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM category where status = 1";

        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String categoryId = rs.getString("category_id");
                String categoryName = rs.getString("category_name");

                Category category = new Category(categoryId, categoryName);
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public Category getCategoryById(String categoryId) {
        String sql = "SELECT * FROM category WHERE category_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, categoryId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    // Lấy dữ liệu trước
                    String id = rs.getString("category_id");
                    String name = rs.getString("category_name");

                    return new Category(id, name);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Category> searchCategoryByName(String keyword) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM category WHERE category_name LIKE ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String categoryId = rs.getString("category_id");
                    String categoryName = rs.getString("category_name");

                    Category category = new Category(categoryId, categoryName);
                    categories.add(category);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public boolean updateCategory(String categoryId, String newCategoryName, String status) {
        String sql = "UPDATE category SET category_name = ?, status = ? WHERE category_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newCategoryName);
            pstmt.setString(2, status);
            pstmt.setString(3, categoryId);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean deleteCategory(String categoryId) {
        String sql = "DELETE FROM category WHERE category_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, categoryId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insertCategory(String categoryId, String categoryName, String status) {
        String sql = "INSERT INTO category (category_id, category_name, status) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, categoryId);
            pstmt.setString(2, categoryName);
            pstmt.setString(3, status);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Category> getRandomCategories(int limit) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT TOP " + limit + " * FROM category ";

        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String categoryId = rs.getString("category_id");
                String categoryName = rs.getString("category_name");

                Category category = new Category(categoryId, categoryName);
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public static void main(String[] args) {
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> list = categoryDAO.getRandomCategories(12);
        for (Category category : list) {
            System.out.println(category);
        }
    }

    public List<Category> getAllCategory(int pageNo, int pageSize, String nameOrId) {

        String sql = "SELECT * FROM category "
                + (nameOrId != null && !nameOrId.isEmpty() ? "WHERE category_id LIKE ? OR category_name LIKE ? " : " ")
                + "ORDER BY category_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ";

        List<Category> result = new ArrayList<>();
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
                Category c = new Category();
                c.setCategoryId(rs.getString("category_id"));
                c.setCategoryName(rs.getString("category_name"));
                c.setStatus(rs.getInt("status"));
                result.add(c);
            }
            return result;
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int countCategory(String nameOrId) {
        String sql = "SELECT COUNT(*) FROM category "
                + (nameOrId != null && !nameOrId.isEmpty() ? "WHERE category_id LIKE ? OR category_name LIKE ?" : "");
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            int paramIndex = 1;
            if (nameOrId != null && !nameOrId.isEmpty()) {
                ps.setString(paramIndex++, "%" + nameOrId + "%");
                ps.setString(paramIndex++, "%" + nameOrId + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0; // Return 0 if an error occurs
    }

    public String getLatestCategory() {
        String sql = "SELECT TOP 1 category_id FROM category ORDER BY category_id DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getString("category_id"); // Return the latest category ID
            }
        } catch (SQLException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null; 
    }

    public boolean updateCategory(String categoryId, String newCategoryName) {
        String sql = "UPDATE category SET category_name = ? WHERE category_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newCategoryName);
            pstmt.setString(2, categoryId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public List<Category> getRandomCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = " SELECT DISTINCT c.category_id, c.category_name \n"
                + "        FROM category c\n"
                + "        JOIN book b ON c.category_id = b.category_id\n"
                + "        WHERE b.status = 1";

        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String categoryId = rs.getString("category_id");
                String categoryName = rs.getString("category_name");

                Category category = new Category(categoryId, categoryName);
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

}
