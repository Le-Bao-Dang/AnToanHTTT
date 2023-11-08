package controller.cart;

import bean.*;
import bean.Cart;
import services.CartService;
import services.LogService;
import services.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.sound.sampled.Line;
import java.io.IOException;

@WebServlet(name = "AddCart", value = "/cart/addCart")
public class AddCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");

        int idProduct = Integer.parseInt(request.getParameter("idProduct"));

        int amount = Integer.parseInt(request.getParameter("amount"));

        Product product = ProductService.getInstance().getProductById(idProduct);

//        Log log = new Log();
//        log.setEvent("/cart/addCart");
//
//        if (user == null) {
//            log.setSeverityLevel(Log.INFO);
//            log.setDescription("Thêm sản phẩm \"" + product.getName() + "\" vào giỏ hàng không thành công, người dùng chưa đăng nhập!");
//            LogService.getInstance().insert(log);
//            return;
//        }

//        log.setSeverityLevel(Log.INFO);
//        log.setDescription("Thêm sản phẩm \"" + product.getName() + "\" vào giỏ hàng thành công. Số lượng " + amount);
//        LogService.getInstance().insert(log);

        LineItem lineItem = new LineItem(product, amount);
        user.addToCart(lineItem);
        response.getWriter().println(Cart.sumQuantity(user.getListCartItem()));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
