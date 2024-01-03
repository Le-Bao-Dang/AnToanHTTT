package services;

import bean.Discount;
import db.JDBIConnector;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class DiscountService implements Serializable {
    private static DiscountService instance;

    private DiscountService() {

    }

    public static DiscountService getInstance() {
        if (instance == null) {
            instance = new DiscountService();
        }
        return instance;
    }

    public Discount getDiscountByDiscountId(int discountId) {
        if (discountId == 0) return null;
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery(
                            "select discount_id, `code`, discount_fee, start_date, end_date, quantity, `condition`\n" +
                                    "from discount where discount_id = ?;")
                    .bind(0, discountId)
                    .mapToBean(Discount.class)
                    .one();

        });
    }

    public Discount getDiscountByCode(String code) {
        return JDBIConnector.get().withHandle(handle -> {
            try {
                return handle.createQuery(
                                "select id, `code`, `value`, `condition`,quantity , start_date, end_date\n" +
                                        "from discount where code = :code;")
                        .bind("code", code)
                        .mapToBean(Discount.class)
                        .one();
            } catch (Exception e) {
                return null;
            }
        });
    }

    public List<Discount> getListDiscountByListCode(List<String> listCode) {
        List<Discount> list = new ArrayList<>();
        for (String code : listCode) {
            list.add(getDiscountByCode(code));
        }
        return list;
    }

    public int totalDiscount(List<Discount> discountList) {
        return 0;
    }

    public Discount getDiscountByOrderId(int idOrder) {
        List<Discount> list = JDBIConnector.get().withHandle(
                handle -> handle.createQuery("select d.id, d.`code`, d.`value`, d.`condition`, d.quantity, d.start_date, d.end_date \n" +
                                "from discount d join `order` o on d.id = o.discount_id \n" +
                                "where o.id = :idOrder")
                .bind("idOrder", idOrder)
                .mapToBean(Discount.class)
                .stream().collect(Collectors.toList()));
        if (list.size() > 0)
            return list.get(0);
        else return null;

    }

    public static void main(String[] args) {

    }
}
