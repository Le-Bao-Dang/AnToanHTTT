package bean;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Discount implements Serializable {
    private int id;
    private String code;
    private int value;
    private int condition;
    private int quantity;
    private LocalDateTime startDate;
    private LocalDateTime endDate;

    public Discount() {
    }

    public Discount(int id, String code, int value, int condition, int quantity, List<Product> listProduct, LocalDateTime startDate, LocalDateTime endDate) {
        this.id = id;
        this.code = code;
        this.value = value;
        this.condition = condition;
        this.quantity = quantity;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public int getCondition() {
        return condition;
    }

    public void setCondition(int condition) {
        this.condition = condition;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }

    public boolean checkTime() {
        return endDate.isBefore(LocalDateTime.now());
    }

    public boolean checkQuantity() {
        return quantity > 0;
    }

    public boolean checkCondition(int total) {
        return total > this.condition;
    }


    @Override
    public String toString() {
        return "Discount{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", value=" + value +
                ", condition=" + condition +
                ", quantity=" + quantity +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                '}';
    }

}
