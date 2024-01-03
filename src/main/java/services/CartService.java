package services;

import bean.LineItem;
import bean.User;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class CartService {
    private static CartService instance;

    private CartService() {

    }

    public static CartService getInstance() {
        if (instance == null) {
            instance = new CartService();
        }
        return instance;
    }

    public void addLineItem(int userId, LineItem lineItem) {
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("INSERT INTO cart_item(user_id, product_id, quantity) VALUES (:user_id, :product_id, :quantity);")
                        .bind("user_id", userId)
                        .bind("product_id", lineItem.getProduct().getId())
                        .bind("quantity", lineItem.getQuantity())
                        .execute());
    }

    public void update(LineItem cartItem) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `cart_item` SET quantity=:quantity WHERE id=:id")
                    .bind("id", cartItem.getId())
                    .bind("quantity", cartItem.getQuantity())
                    .execute();
        });
    }

    public void addCartItem(User user, LineItem lineItem) {
        LineItem aLine = user.containProductInCart(lineItem.getProduct().getId());
        if (aLine != null) {
            aLine.setQuantity(lineItem.getQuantity() + aLine.getQuantity());
            update(aLine);
        } else {
            user.getListCartItem().add(lineItem);
            addLineItem(user.getId(), lineItem);
        }

    }

    public void addCartUser(User user) {
        removeAllProductByUserId(user.getId());
        List<LineItem> cartItems = user.getListCartItem();
        StringBuilder sql = new StringBuilder();
        for (LineItem cartItem : cartItems) {
            addLineItem(user.getId(), cartItem);
        }

    }

    public List<LineItem> getCartOfUser(int userId) {
        List<LineItem> result = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select id, quantity from cart_item  WHERE user_id = ?")
                    .bind(0, userId)
                    .mapToBean(LineItem.class).stream().collect(Collectors.toList());
        });
        for (LineItem l : result) {
            l.setProduct(ProductService.getInstance().getProductByCartItemId(l.getId()));
        }
        return result;
    }

    public void removeAllProductByUserId(int userId) {
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("DELETE FROM cart_item WHERE user_id = :user_id;")
                        .bind("user_id", userId)
                        .execute()
        );
    }

    public void removeCartItemById(int id) {
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("DELETE FROM cart_item WHERE id=:id;")
                        .bind("id", id)
                        .execute()
        );
    }

    public static void main(String[] args) {
        User u = UserService.getInstance().getUserById(5);

        getInstance().addCartUser(u);
    }
}
