/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

public class Book {

    private String bookId;
    private String bookName;
    private String supplierId;
    private String categoryId;
    private String coverPics;
    private String author;
    private int ratings;
    private String description;
    private String bookContent;
    private double price;
    private Date addedDate;
    private int status;

    public Book() {
    }

    public Book(String bookId, String bookName, String supplierId, String categoryId, String coverPics, String author, int ratings, String description, String bookContent, double price, Date addedDate, int status) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.supplierId = supplierId;
        this.categoryId = categoryId;
        this.coverPics = coverPics;
        this.author = author;
        this.ratings = ratings;
        this.description = description;
        this.bookContent = bookContent;
        this.price = price;
        this.addedDate = addedDate;
        this.status = status;
    }

    public Book(String bookId, String bookName, String supplierId, String categoryId, String coverPics,
            String author, int ratings, String description, String bookContent, double price, Date addedDate) {
        this.bookId = bookId;
        this.bookName = bookName;
        this.supplierId = supplierId;
        this.categoryId = categoryId;
        this.coverPics = coverPics;
        this.author = author;
        this.ratings = ratings;
        this.description = description;
        this.bookContent = bookContent;
        this.price = price;
        this.addedDate = addedDate;
    }

    // Getter và Setter
    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCoverPics() {
        return coverPics;
    }

    public void setCoverPics(String coverPics) {
        this.coverPics = coverPics;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getRatings() {
        return ratings;
    }

    public void setRatings(int ratings) {
        this.ratings = ratings;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBookContent() {
        return bookContent;
    }

    public void setBookContent(String bookContent) {
        this.bookContent = bookContent;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Book{"
                + "bookId='" + bookId + '\''
                + ", bookName='" + bookName + '\''
                + ", supplierId='" + supplierId + '\''
                + ", categoryId='" + categoryId + '\''
                + ", coverPics='" + coverPics + '\''
                + ", author='" + author + '\''
                + ", ratings=" + ratings
                + ", description='" + description + '\''
                + ", bookContent='" + bookContent + '\''
                + ", price=" + price
                + ", addedDate=" + addedDate
                + '}';
    }
}
