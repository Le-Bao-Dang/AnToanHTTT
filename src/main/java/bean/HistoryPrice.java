package bean;

import java.io.Serializable;
import java.time.LocalDateTime;

public class HistoryPrice implements Serializable {
    private int id;
    private int price;
    private int priceSale;
    private LocalDateTime createDate;
    private int status;

    public HistoryPrice() {
    }

    public HistoryPrice(int id, int price, int priceSale, LocalDateTime createDate, int status) {
        this.id = id;
        this.price = price;
        this.priceSale = priceSale;
        this.createDate = createDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getPriceSale() {
        return priceSale;
    }

    public void setPriceSale(int priceSale) {
        this.priceSale = priceSale;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "HistoryPrice{" +
                "id=" + id +
                ", price=" + price +
                ", priceSale=" + priceSale +
                ", createDate=" + createDate +
                ", status=" + status +
                '}';
    }
}
