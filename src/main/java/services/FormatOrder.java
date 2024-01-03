package services;

import bean.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class FormatOrder {
    private static FormatOrder instance;

    private FormatOrder() {

    }

    public static FormatOrder getInstance() {
        if (instance == null) {
            instance = new FormatOrder();
        }
        return instance;
    }
    public Order format(Order order){
        Order result = new Order();
        result.setId(order.getId());
        result.setNote(order.getNote());
        result.setTotal(order.getTotal());
        List<LineItem> listOrderItems = new ArrayList<>();

        for (LineItem li:
             order.getListOrderItem()) {
            Product p = li.getProduct();
            p.setDescription(null);
            p.setDetail(null);
            p.setCreateDate(null);
            p.setRate(0);
            List<HistoryPrice> listHistoryPrices = p.getListHistoryPrice();
            for (HistoryPrice hp:
                 listHistoryPrices) {
                hp.setCreateDate(null);
                hp.setStatus(0);
            }
            p.setListHistoryPrice(listHistoryPrices);
            p.setListImage(null);
            p.setCategory(null);
            p.setUserAdd(null);
            p.setStatus(0);
            li.setProduct(p);
            listOrderItems.add(li);
        }
        result.setListOrderItem(listOrderItems);
        result.setDiscount(null);
        result.setTransport(order.getTransport());
//        result.setStatusDelivery(order.getStatusDelivery());
        result.setPaymentMethod(order.getPaymentMethod());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

        String deliverFormattedDateTime = order.getDeliveryDate().format(formatter);
        LocalDateTime deliverDateTime = LocalDateTime.parse(deliverFormattedDateTime, formatter);

        String receiveFormattedDateTime = order.getReceivingDate().format(formatter);
        LocalDateTime receiveDateTime = LocalDateTime.parse(receiveFormattedDateTime, formatter);

        String createFormattedDateTime = order.getCreateDate().format(formatter);
        LocalDateTime createDateTime = LocalDateTime.parse(createFormattedDateTime, formatter);

        result.setDeliveryDate(deliverDateTime);
        result.setReceivingDate(receiveDateTime);
        result.setCreateDate(createDateTime);
        result.setPayment(order.isPayment());

        User u = new User();
        u.setId(order.getUser().getId());
        u.setEmail(order.getUser().getEmail());

        result.setUser(u);
        result.setInformation(order.getInformation());
//        result.setStatus(order.getStatus());

        return result;
    }
}
