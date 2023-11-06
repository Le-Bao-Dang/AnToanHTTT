package bean;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Review implements Serializable {
    private int id;
    private String comment;
    private int rate;
    private User user;
    private Product product;
    private LocalDateTime createDate;
    private int status;

    public Review() {
    }

    public Review(int id, String comment, int rate, User user, Product product, LocalDateTime createDate, int status) {
        this.id = id;
        this.comment = comment;
        this.rate = rate;
        this.user = user;
        this.product = product;
        this.createDate = createDate;
        this.status = status;
    }
    public Review(String comment, int rate, User user, Product product, LocalDateTime createDate, int status) {
        this.comment = comment;
        this.rate = rate;
        this.user = user;
        this.product = product;
        this.createDate = createDate;
        this.status = status;
    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
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
        return "Review{" +
                "id=" + id +
                ", comment='" + comment + '\'' +
                ", rate=" + rate +
                ", user=" + user +
                ", product=" + product +
                ", createDate=" + createDate +
                ", status=" + status +
                '}';
    }
}
