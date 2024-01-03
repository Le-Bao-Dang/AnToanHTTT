package bean;

import services.OrderService;
import services.UserService;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Order implements Serializable {
    private int id;
    private String note;
    private int total;
    private List<LineItem> listOrderItem;  // chi tiết đơn hàng
    private Discount discount;
    private Transport transport;
    private int statusDelivery;
    private int paymentMethod;
    private LocalDateTime deliveryDate;
    private LocalDateTime receivingDate;
    private LocalDateTime createDate;
    private boolean isPayment;
    private User user;
    private Information information;
    private int status;

    public Order() {
    }

    public Order(int id, String note, int total, List<LineItem> listOrderItem, Discount discount, Transport transport, int statusDelivery, int paymentMethod, LocalDateTime deliveryDate, LocalDateTime receivingDate, LocalDateTime createDate, boolean isPayment, User user, Information information, int status) {
        this.id = id;
        this.note = note;
        this.total = total;
        this.listOrderItem = listOrderItem;
        this.discount = discount;
        this.transport = transport;
        this.statusDelivery = statusDelivery;
        this.paymentMethod = paymentMethod;
        this.deliveryDate = deliveryDate;
        this.receivingDate = receivingDate;
        this.createDate = createDate;
        this.isPayment = isPayment;
        this.user = user;
        this.information = information;
        this.status = status;
    }



    public Information getInformation() {
        return information;
    }

    public void setInformation(Information information) {
        this.information = information;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<LineItem> getListOrderItem() {
        return listOrderItem;
    }

    public void setListOrderItem(List<LineItem> listOrderItem) {
        this.listOrderItem = listOrderItem;
    }

    public Discount getDiscount() {
        return discount;
    }

    public void setDiscount(Discount discount) {
        this.discount = discount;
    }

    public Transport getTransport() {
        return transport;
    }

    public void setTransport(Transport transport) {
        this.transport = transport;
    }

    public int getStatusDelivery() {
        return statusDelivery;
    }

    public void setStatusDelivery(int statusDelivery) {
        this.statusDelivery = statusDelivery;
    }

    public int getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(int paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public LocalDateTime getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(LocalDateTime deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public LocalDateTime getReceivingDate() {
        return receivingDate;
    }

    public void setReceivingDate(LocalDateTime receivingDate) {
        this.receivingDate = receivingDate;
    }

    public boolean isPayment() {
        return isPayment;
    }

    public void setPayment(boolean payment) {
        isPayment = payment;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", note='" + note + '\'' +
                ", total=" + total +
                ", listOrderItem=" + listOrderItem +
                ", discount=" + discount +
                ", transport=" + transport +
                ", statusDelivery=" + statusDelivery +
                ", paymentMethod=" + paymentMethod +
                ", deliveryDate=" + deliveryDate +
                ", receivingDate=" + receivingDate +
                ", createDate=" + createDate +
                ", isPayment=" + isPayment +
                ", user=" + user +
                ", information=" + information +
                ", status=" + status +
                '}';
    }

    public static void main(String[] args) {
        Order o = OrderService.getInstance().getOrderByOrderId(1);
        System.out.println(o.getListOrderItem());
    }
}
