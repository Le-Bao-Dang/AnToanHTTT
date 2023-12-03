package services;

import bean.Cart;
import bean.LineItem;
import bean.Order;
import db.JDBIConnector;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class OrderService implements Serializable {
    private static OrderService instance;

    private OrderService() {

    }

    public static OrderService getInstance() {
        if (instance == null) {
            instance = new OrderService();
        }
        return instance;
    }

    public List<Order> getOrderListByUserId(int userId) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Order> orders = handle.createQuery("select id, note, total, status_delivery, payment_method, delivery_date, receiving_date, create_date, is_payment, `status` from `order` where user_id =  ?")
                    .bind(0, userId)
                    .mapToBean(Order.class).stream().collect(Collectors.toList());
            for (Order order : orders) {
                int id = order.getId();
                order.setListOrderItem(LineItemService.getInstance().getListLineItemByOrderId(id));
                order.setDiscount(DiscountService.getInstance().getDiscountByOrderId(id));
                order.setUser(UserService.getInstance().getUserByOrderId(id));
                order.setTransport(TransportService.getInstance().getTransportByOrderId(id));
                order.setInformation(InformationService.getInstance().getInformationByOrderId(id));
            }
            return orders;
        });
    }

    public List<Order> getOrderList() {
        return JDBIConnector.get().withHandle(handle -> {
            List<Order> orderList = handle.createQuery("select id, note, total, status_delivery, payment_method, delivery_date, receiving_date,is_payment, create_date, `status` from `order`;").mapToBean(Order.class).stream().collect(Collectors.toList());
            for (Order order : orderList) {
                order.setListOrderItem(LineItemService.getInstance().getListLineItemByOrderId(order.getId()));
                order.setDiscount(DiscountService.getInstance().getDiscountByOrderId(order.getId()));
                order.setUser(UserService.getInstance().getUserByOrderId(order.getId()));
                order.setTransport(TransportService.getInstance().getTransportByOrderId(order.getId()));
                order.setInformation(InformationService.getInstance().getInformationByOrderId(order.getId()));
            }
            return orderList;
        });
    }
// select id, note, total, status_delivery, payment_method, delivery_date, receiving_date,is_payment, create_date, `status`

    public Order getOrderByOrderId(int orderId) {
        return JDBIConnector.get().withHandle(handle -> {
            Order order = handle.createQuery("select id, note, total, status_delivery, payment_method, delivery_date, receiving_date,is_payment, create_date, `status` from `order` where id = ?")
                    .bind(0, orderId)
                    .mapToBean(Order.class).one();
            order.setListOrderItem(LineItemService.getInstance().getListLineItemByOrderId(orderId));
            order.setDiscount(DiscountService.getInstance().getDiscountByOrderId(orderId));
            order.setUser(UserService.getInstance().getUserByOrderId(orderId));
            order.setTransport(TransportService.getInstance().getTransportByOrderId(orderId));
            order.setInformation(InformationService.getInstance().getInformationByOrderId(orderId));

            return order;
        });
    }


    public boolean add(Order order) {
        int orderId =JDBIConnector.get().withHandle(handle -> handle.createUpdate("INSERT INTO `order`(note,total,transport_id,status_delivery,payment_method,delivery_date,receiving_date,is_payment,create_date,user_id,information_id,`status`,discount_id \n) " +
                        "VALUES (:note,:total,:transport_id,:status_delivery,:payment_method,:delivery_date,:receiving_date,:is_payment,:create_date,:user_id,:information_id,0,:discount_id)")
                .bind("note", order.getNote())
                .bind("total", order.getTotal())
                .bind("transport_id", order.getTransport().getId())
                .bind("status_delivery", order.getStatusDelivery())
                .bind("payment_method", order.getPaymentMethod())
                .bind("delivery_date", order.getDeliveryDate())
                .bind("receiving_date", order.getReceivingDate())
                .bind("is_payment", order.isPayment())
                .bind("create_date", order.getCreateDate())
                .bind("user_id", order.getUser().getId())
                .bind("information_id", order.getInformation().getId())
                .bind("discount_id", order.getDiscount() == null ? null : order.getDiscount().getId())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one());

        //Them danh sach cac item cua 1 order vao bang order_line
        StringBuilder query = new StringBuilder();
        for (int i = 0; i < order.getListOrderItem().size(); i++) {
            query.append("INSERT INTO `order_line` VALUES (" + orderId + order.getListOrderItem().get(i).getId() + ");");
        }
        JDBIConnector.get().withHandle(handle -> handle.createUpdate(query.toString()));


        for (LineItem lineItem : order.getListOrderItem()) {
            addOrderItem(lineItem);
            int liId =  LineItemService.getInstance().maxId();
            addOrderLine(orderId, liId);

        }


        return true;
    }
    public Order addOrderAndReturn(Order order) {
        int orderId =JDBIConnector.get().withHandle(handle -> handle.createUpdate("INSERT INTO `order`(note,total,transport_id,status_delivery,payment_method,delivery_date,receiving_date,is_payment,create_date,user_id,information_id,`status`,discount_id \n) " +
                        "VALUES (:note,:total,:transport_id,:status_delivery,:payment_method,:delivery_date,:receiving_date,:is_payment,:create_date,:user_id,:information_id,0,:discount_id)")
                .bind("note", order.getNote())
                .bind("total", order.getTotal())
                .bind("transport_id", order.getTransport().getId())
                .bind("status_delivery", order.getStatusDelivery())
                .bind("payment_method", order.getPaymentMethod())
                .bind("delivery_date", order.getDeliveryDate())
                .bind("receiving_date", order.getReceivingDate())
                .bind("is_payment", order.isPayment())
                .bind("create_date", order.getCreateDate())
                .bind("user_id", order.getUser().getId())
                .bind("information_id", order.getInformation().getId())
                .bind("discount_id", order.getDiscount() == null ? null : order.getDiscount().getId())
                .executeAndReturnGeneratedKeys("id")
                .mapTo(int.class)
                .one());

        //Them danh sach cac item cua 1 order vao bang order_line

        order.setId(orderId);
        List<LineItem> lils = new ArrayList<>();
        for (LineItem lineItem : order.getListOrderItem()) {
            addOrderItem(lineItem);
            int liId =  LineItemService.getInstance().maxId();
            lineItem.setId(liId);
            addOrderLine(orderId, liId);
            lils.add(lineItem);
        }
        order.setListOrderItem(lils);

        return order;
    }
    public void addOrderLine(int orderId, int lineItemId) {
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("INSERT INTO order_line VALUES (:order_id, :line_item_id);")
                        .bind("order_id", orderId)
                        .bind("line_item_id", lineItemId)
                        .execute());
    }

    public void addOrderItem(LineItem lineItem) {
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("INSERT INTO line_item(product_id, quantity) VALUES (:product_id, :quantity);")
                        .bind("product_id", lineItem.getProduct().getId())
                        .bind("quantity", lineItem.getQuantity())
                        .execute());
    }

    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as numberOfOrder FROM `order`").mapTo(Integer.class).one();
        });
    }


    public void removeAllDetailByOrderId(int id) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("DELETE FROM order_detail WHERE order_id = :id")
                    .bind("id", id)
                    .execute();
        });
    }

    public int total(Order order) {
        if (order.getDiscount() == null) {
            return Cart.total(order.getListOrderItem());
        }
        return Cart.total(order.getListOrderItem(), order.getDiscount().getValue());
    }

    public List<Integer> listStatisticalInYear(int year) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT coalesce(o.count,0) as count\n" +
                    "FROM\n" +
                    "(SELECT 1 AS `month`\n" +
                    "UNION \n" +
                    "SELECT 2 AS `month`\n" +
                    "UNION \n" +
                    "SELECT 3 AS `month`\n" +
                    "UNION \n" +
                    " SELECT 4 AS `month`\n" +
                    "UNION \n" +
                    " SELECT 5 AS `month`\n" +
                    "UNION\n" +
                    " SELECT 6 AS `month`\n" +
                    "UNION \n" +
                    " SELECT 7 AS `month`\n" +
                    "UNION \n" +
                    " SELECT 8 AS `month`\n" +
                    "UNION \n" +
                    "  SELECT 9 AS `month`\n" +
                    "UNION \n" +
                    "  SELECT 10 AS `month`\n" +
                    "UNION \n" +
                    "  SELECT 11 AS `month`\n" +
                    "UNION \n" +
                    "SELECT 12 AS `month`\n" +
                    ") AS t\n" +
                    "LEFT JOIN \n" +
                    "(\n" +
                    "  SELECT MONTH(create_date) as month, COUNT(id) as count FROM `order` WHERE YEAR(create_date)=:year GROUP BY MONTH(create_date)\n" +
                    ") as o \n" +
                    "ON t.month = o.month  \n" +
                    "ORDER BY t.`month` ASC").bind("year", year).mapTo(Integer.class).stream().collect(Collectors.toList());
        });
    }

    public static void main(String[] args) {

        System.out.println(getInstance().listStatisticalInYear(2023));

    }

}
