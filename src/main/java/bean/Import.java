package bean;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Import implements Serializable {
    private int id;
    private Vendor vendor;
    private List<LineItemImport> listLineItem;
    private LocalDateTime createDate;
    private User userImport;
    private String note;
    private int status;

    public Import(int id, Vendor vendor, List<LineItemImport> listLineItem, LocalDateTime createDate, User userImport, String note, int status) {
        this.id = id;
        this.vendor = vendor;
        this.listLineItem = listLineItem;
        this.createDate = createDate;
        this.userImport = userImport;
        this.note = note;
        this.status = status;
    }

    public Import() {

    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Vendor getVendor() {
        return vendor;
    }

    public void setVendor(Vendor vendor) {
        this.vendor = vendor;
    }

    public List<LineItemImport> getListLineItem() {
        return listLineItem;
    }

    public void setListLineItem(List<LineItemImport> listLineItem) {
        this.listLineItem = listLineItem;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public User getUserImport() {
        return userImport;
    }

    public void setUserImport(User userImport) {
        this.userImport = userImport;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatustoString() { // Trạng thái đơn hàng
        String result = "";
        if (this.status == 0) result = "Đang đuyệt";
        if (this.status == 1) result = "Đã duyệt";
        if (this.status == 2) result = "Chờ nhận hàng";
        if (this.status == 3) result = "Nhập hàng thành công";
        return result;
    }

    @Override
    public String toString() {
        return "Import{" +
                "id=" + id +
                ", vendor=" + vendor +
                ", listLineItem=" + listLineItem +
                ", createDate=" + createDate +
                ", userImport=" + userImport +
                ", note='" + note + '\'' +
                ", status=" + status +
                '}';
    }

    public int getTotal() {
        int result = 0;
        for (LineItemImport lineItemImport : getListLineItem()) {
            result += lineItemImport.getTotalPrice();
        }
        return result;
    }
}
