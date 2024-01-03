package bean;

import java.io.Serializable;

public class LineItemImport extends LineItem implements Serializable {
    private int priceImport;


    public LineItemImport(int id, Product product, int quantity, int priceImport) {
        super(id, product, quantity);
        this.priceImport = priceImport;
    }

    public LineItemImport() {
    }


    public int getPriceImport() {
        return priceImport;
    }

    public void setPriceImport(int priceImport) {
        this.priceImport = priceImport;
    }

    public int getTotalPrice() {
        return getQuantity() * getPriceImport();
    }
}
