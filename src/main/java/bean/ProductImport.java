package bean;

import java.io.Serializable;

public class ProductImport implements Serializable {
    private int id;
    private String name;
    private int quantity;
    private int priceImport;

    public ProductImport(int id, String name, int quantity, int priceImport) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.priceImport = priceImport;
    }

    public ProductImport() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getpriceImport() {
        return priceImport;
    }

    public void setpriceImport(int priceImport) {
        this.priceImport = priceImport;
    }

    @Override
    public String toString() {
        return "ProductImport{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", priceImport=" + priceImport +
                '}';
    }
}
