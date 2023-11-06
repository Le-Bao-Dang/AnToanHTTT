package bean;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Export implements Serializable {
    private int id;
    private User user;
    private List<LineItem> listLineItem;
    private int total;
    private LocalDateTime createDate;
    private int status;

    public Export(int id, User user, List<LineItem> listLineItem, int total, LocalDateTime createDate, int status) {
        this.id = id;
        this.user = user;
        this.listLineItem = listLineItem;
        this.total = total;
        this.createDate = createDate;
        this.status = status;
    }

    public Export() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<LineItem> getListLineItem() {
        return listLineItem;
    }

    public void setListLineItem(List<LineItem> listLineItem) {
        this.listLineItem = listLineItem;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
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
}
