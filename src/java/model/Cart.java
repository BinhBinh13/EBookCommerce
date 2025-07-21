/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Phong vu
 */
public class Cart {
    private List<Item> items;

    public Cart() {
        items = new ArrayList<>();
    }

    public Cart(List<Item> items) {
        this.items = items;
    }
    public List<Item> getItems() {
        return items;
    }
    private Item getItemById(String id) {
        for (Item i : items) {
            if(i.getBook().getBookId().equals(id))
                return i;
        }
        return null;
    }
    public void addItem(Item t) {
        if(getItemById(t.getBook().getBookId()) != null) {
            
        } else {
            items.add(t);
        }
    }
    public void removeItem(String id) {
        if(getItemById(id) != null) {
            items.remove(getItemById(id));
        }
    }
    public double getToTalMoney() {
        double t = 0;
        for(Item i : items)
            t +=i.getPrice();
        return t;
    }
} 
