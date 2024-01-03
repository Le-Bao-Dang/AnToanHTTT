package bean;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Product implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String name;
    private String description;
    private String detail;
    private LocalDateTime createDate;
    private int rate;
    private List<HistoryPrice> listHistoryPrice;
    private List<Image> listImage;
    private Category category;
    private User userAdd;
    private int status;

    public Product() {
    }

    public Product(int id, String name, String description, String detail, LocalDateTime createDate, int rate, List<HistoryPrice> listHistoryPrice, List<Image> listImage, Category category, User userAdd, int status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.detail = detail;
        this.createDate = createDate;
        this.rate = rate;
        this.listHistoryPrice = listHistoryPrice;
        this.listImage = listImage;
        this.category = category;
        this.userAdd = userAdd;
        this.status = status;
    }

    public Product(int id, String name, String description, String detail, int rate, Category category, User userAdd, int status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.detail = detail;
        this.rate = rate;
        this.category = category;
        this.userAdd = userAdd;
        this.status = status;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public List<HistoryPrice> getListHistoryPrice() {
        return listHistoryPrice;
    }

    public void setListHistoryPrice(List<HistoryPrice> listHistoryPrice) {
        this.listHistoryPrice = listHistoryPrice;
    }

    public List<Image> getListImage() {
        return listImage;
    }

    public void setListImage(List<Image> listImage) {
        this.listImage = listImage;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public User getUserAdd() {
        return userAdd;
    }

    public void setUserAdd(User userAdd) {
        this.userAdd = userAdd;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPrice() {
        return listHistoryPrice.get(0).getPrice();
    }

    public int getPriceSale() {
        return listHistoryPrice.get(0).getPriceSale();
    }

    public Image getMainImage() {
        return listImage.get(0);
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", detail='" + detail + '\'' +
                ", createDate=" + createDate +
                ", rate=" + rate +
                ", listHistoryPrice=" + listHistoryPrice +
                ", listImage=" + listImage +
                ", category=" + category +
                ", userAdd=" + userAdd +
                ", status=" + status +
                '}';
    }

    public boolean equals(Product product) {
        return this.id == product.id;
    }
}
