package bean;

import services.CartService;
import services.LogService;

import java.util.List;

public class Cart {
    public static int sumQuantity(List<LineItem> lineItems) {
        int result = 0;
        for (LineItem cartItem : lineItems) {
            result += cartItem.getQuantity();
        }
        return result;
    }

    public static int totalPrice(List<LineItem> lineItems) {
        int sum = 0;
        for (LineItem lineItem : lineItems) {
            sum += lineItem.totalPrice();
        }
        return sum;
    }

    public static int totalPriceSale(List<LineItem> lineItems) {
        int sum = 0;
        for (LineItem lineItem : lineItems) {
            Product product = lineItem.getProduct();
            if (product.getPriceSale() != 0)
                sum += (product.getPriceSale() - product.getPrice()) * lineItem.getQuantity();
        }
        return sum;
    }

    public static int total(List<LineItem> lineItems) {
        return totalPrice(lineItems) - totalPriceSale(lineItems);
    }

    public static int total(List<LineItem> lineItems, int discountFee) {
        return total(lineItems) - discountFee;
    }

    public static int totalHaveShipAndDiscount(List<LineItem> lineItems, int discountFee, int shipFee) {
        return total(lineItems, discountFee) + shipFee;
    }

    public static List<LineItem> removeItemCart(List<LineItem> lineItem, int idItemCart) {
        for (int i = 0; i < lineItem.size(); i++) {
            if (lineItem.get(i).getId() == idItemCart) {
                Log log = new Log();
                log.setEvent("/cart/removeProduct");
                log.setDescription("Xóa sản phẩm " + lineItem.get(i).getProduct().getName() + " khỏi giỏ it hàng thành công");
                log.setSeverityLevel(Log.INFO);
                LogService.getInstance().insert(log);
                lineItem.remove(i);
                return lineItem;
            }
        }
        return lineItem;
    }


}
