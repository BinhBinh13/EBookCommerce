/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Supplier {
    private String supplierId;
    private String supplierName;
    private String description;
    private int status;
    public Supplier() {
    }

    public Supplier(String supplierId, String supplierName, String description, int status) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.description = description;
        this.status = status;
    }

    public Supplier(String supplierId, String supplierName, String description) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.description = description;
    }

    public String getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(String supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Supplier{" +
                "supplierId='" + supplierId + '\'' +
                ", supplierName='" + supplierName + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
