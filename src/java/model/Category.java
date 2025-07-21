/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Category {

    private String categoryId;
    private String categoryName;
    private int status;

    public Category() {
    }

    public Category(String categoryId, String categoryName, int status) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.status = status;
    }
    
    public Category(String categoryId, String categoryName) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Category{"
                + "categoryId='" + categoryId + '\''
                + ", categoryName='" + categoryName + '\''
                + '}';
    }
}
