
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Bill;

public class statisticDAO extends DBContext{
    
    public List<Bill> getListPaidBill() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT * FROM [bill] WHERE status = ? ORDER BY create_date DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, 1);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Bill c = new Bill(
                        rs.getInt("bill_id"),
                        rs.getInt("account_id"),
                        rs.getString("payment"),
                        rs.getDate("create_date"),
                        rs.getDouble("total_money"),
                        rs.getInt("status")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    // Phương thức lấy tổng doanh thu theo tháng
    public List<Object[]> getRevenueByMonth() {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT YEAR(create_date) AS year, MONTH(create_date) AS month, SUM(total_money) AS total "
                + "FROM [bill] WHERE status = 1 "
                + "GROUP BY YEAR(create_date), MONTH(create_date) "
                + "ORDER BY YEAR(create_date), MONTH(create_date)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Object[] record = new Object[3];
                record[0] = rs.getInt("year");       // Năm
                record[1] = rs.getInt("month");      // Tháng
                record[2] = rs.getDouble("total");   // Tổng doanh thu
                list.add(record);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    // Phương thức lấy tổng doanh thu theo tháng trong một năm cụ thể
    public List<Object[]> getRevenueByYear(int year) {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT MONTH(create_date) AS month, SUM(total_money) AS total "
                + "FROM [bill] WHERE status = 1 AND YEAR(create_date) = ? "
                + "GROUP BY MONTH(create_date) "
                + "ORDER BY MONTH(create_date)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Object[] record = new Object[2];
                record[0] = rs.getInt("month");   // Tháng
                record[1] = rs.getDouble("total"); // Tổng doanh thu
                list.add(record);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    // Phương thức lấy danh sách các năm có dữ liệu
    public List<Integer> getAvailableYears() {
        List<Integer> years = new ArrayList<>();
        String sql = "SELECT DISTINCT YEAR(create_date) AS year FROM [bill] WHERE status = 1 ORDER BY year";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                years.add(rs.getInt("year"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return years;
    }
    
    // Phương thức lấy chi tiết doanh thu từng ngày và tổng theo tháng trong một năm
    public List<Object[]> getRevenueDetailsByYear(int year) {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT CONVERT(date, create_date) AS bill_date, MONTH(create_date) AS month, total_money "
                + "FROM [bill] WHERE status = 1 AND YEAR(create_date) = ? "
                + "ORDER BY create_date";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Object[] record = new Object[3];
                record[0] = rs.getDate("bill_date");  // Ngày
                record[1] = rs.getInt("month");       // Tháng
                record[2] = rs.getDouble("total_money"); // Giá tiền
                list.add(record);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    // Phương thức lấy số lượng book_id từ bill_detail với status = 1
    public List<Object[]> getBookCountInBills() {
        List<Object[]> list = new ArrayList<>();
        String sql = "SELECT bd.book_id, b.book_name, COUNT(*) AS quantity " +
                     "FROM [dbo].[bill_detail] bd " +
                     "INNER JOIN [dbo].[bill] bll ON bd.bill_id = bll.bill_id " +
                     "INNER JOIN [dbo].[book] b ON bd.book_id = b.book_id " +
                     "WHERE bll.status = 1 " +
                     "GROUP BY bd.book_id, b.book_name " +
                     "ORDER BY bd.book_id";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Object[] record = new Object[3];
                record[0] = rs.getString("book_id");    // book_id
                record[1] = rs.getString("book_name");  // book_name
                record[2] = rs.getInt("quantity");      // quantity
                list.add(record);
            }
        } catch (SQLException e) {
            System.out.println("Error while fetching book count: " + e.getMessage());
        }
        return list;
    }
    
    // Phương thức lấy số lượng book_id từ bill_detail với status = 1 và lọc theo năm
public List<Object[]> getBookCountInBillsByYear(int year) {
    List<Object[]> list = new ArrayList<>();
    String sql = "SELECT bd.book_id, b.book_name, COUNT(*) AS quantity " +
                 "FROM [dbo].[bill_detail] bd " +
                 "INNER JOIN [dbo].[bill] bll ON bd.bill_id = bll.bill_id " +
                 "INNER JOIN [dbo].[book] b ON bd.book_id = b.book_id " +
                 "WHERE bll.status = 1 AND YEAR(bll.create_date) = ? " +
                 "GROUP BY bd.book_id, b.book_name " +
                 "ORDER BY bd.book_id";

    try {
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, year);
        ResultSet rs = st.executeQuery();

        while (rs.next()) {
            Object[] record = new Object[3];
            record[0] = rs.getString("book_id");    // book_id
            record[1] = rs.getString("book_name");  // book_name
            record[2] = rs.getInt("quantity");      // quantity
            list.add(record);
        }
    } catch (SQLException e) {
        System.out.println("Error while fetching book count by year: " + e.getMessage());
    }
    return list;
}
    
}
