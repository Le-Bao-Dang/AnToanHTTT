package bean;

import java.io.Serializable;

public class LineItem implements Serializable {
    private int id;
    private Product product;
    private int quantity;

    public LineItem(int id, Product product, int quantity) {
        this.id = id;
        this.product = product;
        this.quantity = quantity;
    }

    public LineItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public LineItem() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int totalPrice() {
        if (this.product.getPriceSale() != 0) {
            return this.product.getPriceSale() * this.quantity;
        }
        return this.product.getPrice() * this.quantity;
    }

    @Override
    public String toString() {
        return "LineItem{" +
                "id=" + id +
                ", product=" + product +
                ", quantity=" + quantity +
                '}';
    }


}
