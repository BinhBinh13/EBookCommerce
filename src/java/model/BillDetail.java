/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
public class BillDetail {
    private int bdId;
    private int billId;
    private String bookId;
    private double price;
    private String bookName;
    public BillDetail() {
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public BillDetail(int bdId, int billId,String bookName, String bookId, double price ) {
        this.bdId = bdId;
        this.billId = billId;
        this.bookName = bookName;
        this.bookId = bookId;
        this.price = price;
        
    }
    
    public BillDetail(int bdId, int billId, String bookId, double price) {
        this.bdId = bdId;
        this.billId = billId;
        this.bookId = bookId;
        this.price = price;
    }

    public int getBdId() {
        return bdId;
    }

    public void setBdId(int bdId) {
        this.bdId = bdId;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "BillDetail{" +
                "bdId=" + bdId +
                ", billId=" + billId +
                ", bookId='" + bookId + '\'' +
                ", price=" + price +
                '}';
    }
}
