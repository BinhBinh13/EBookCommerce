/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bill;
import model.BillDetail;
import model.Cart;
import model.Item;
import model.User;

/**
 *
 * @author Phong vu
 */
public class BillDAO extends DBConnection {

    public List<Bill> getBillByAccount(int account_id) {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT * FROM [bill] WHERE account_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, account_id);
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

                if (list.isEmpty()) {
                    return null;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateBill(int bill_id, int status) {
        String sql1 = "UPDATE bill SET status = 1 WHERE bill_id = ? AND status = 0";
        String sql2 = "UPDATE bill SET status = 0 WHERE bill_id = ? AND status = 1";
        try {
            if (status == 0) {
                PreparedStatement st = conn.prepareStatement(sql1);
                st.setInt(1, bill_id);
                st.executeUpdate();
            } else if (status == 1) {
                PreparedStatement st = conn.prepareStatement(sql2);
                st.setInt(1, bill_id);
                st.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public List<Bill> getAllBill() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT * FROM [bill]";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
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

    public List<BillDetail> getAllBillDetail(int bill_id) {
        List<BillDetail> list = new ArrayList<>();
        String sql = "SELECT bd.bd_id, bd.bill_id, bd.book_id, b.price AS book_price, "
                + "b.book_name "
                + "FROM [bill_detail] bd "
                + "INNER JOIN [book] b ON bd.book_id = b.book_id "
                + "WHERE bd.bill_id = ?";
        try {
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, bill_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                BillDetail c = new BillDetail(
                        rs.getInt("bd_id"),
                        rs.getInt("bill_id"),
                        rs.getString("book_name"),
                        rs.getString("book_id"),
                        rs.getDouble("book_price")
                );
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<BillDetail> getBillDetailsByBillStatus(int accountId) {
        List<BillDetail> billDetails = new ArrayList<>();
        String sql = "SELECT bd.* FROM bill_detail bd "
                + "JOIN bill b ON bd.bill_id = b.bill_id "
                + "WHERE b.account_id = ? AND b.status = 1";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                billDetails.add(new BillDetail(
                        rs.getInt("bd_id"),
                        rs.getInt("bill_id"),
                        rs.getString("book_id"),
                        rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billDetails;
    }

    public List<BillDetail> getBillItemsByBillId(int bill_id) {
        List<BillDetail> billDetails = new ArrayList<>();
        String sql = "SELECT * FROM bill_detail WHERE bill_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bill_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                billDetails.add(new BillDetail(
                        rs.getInt("bd_id"),
                        rs.getInt("bill_id"),
                        rs.getString("book_id"),
                        rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return billDetails;
    }

    public List<Bill> getBillsByAccountId(int accountId) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM Bill WHERE account_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bills.add(new Bill(
                        rs.getInt("bill_id"),
                        rs.getInt("account_id"),
                        rs.getString("payment"),
                        rs.getDate("create_date"),
                        rs.getDouble("total_money"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public void addOrder(User u, Cart cart) {
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();

        try {
            String sql = "insert into [dbo].[bill]  (account_id, total_money, payment, status) values(?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, u.getAccountId());
            ps.setDouble(2, cart.getToTalMoney());
            ps.setString(3, "QR_Code");
            ps.setInt(4, 0);
            ps.executeUpdate();
            //lay ra id cua order vua add
            String sql1 = "Select top 1 bill_id from [dbo].[bill]  ORDER BY  bill_id desc";
            PreparedStatement ps1 = conn.prepareStatement(sql1);
            ResultSet rs = ps1.executeQuery();
            //add vao billdetail_id;
            if (rs.next()) {
                int bill_id = rs.getInt(1);
                for (Item i : cart.getItems()) {
                    String sql2 = "insert into [dbo].[bill_detail] (bill_id, book_id, price) values(?, ?, ?)";
                    PreparedStatement ps2 = conn.prepareStatement(sql2);
                    ps2.setInt(1, bill_id);
                    ps2.setString(2, i.getBook().getBookId());
                    ps2.setDouble(3, i.getPrice());
                    ps2.executeUpdate();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static void main(String[] args) {
        BillDAO bd = new BillDAO();
        loginDAO lg = new loginDAO();
        User u = lg.authenticateUserProcedure("customerUser1", "password1");

    }
}
