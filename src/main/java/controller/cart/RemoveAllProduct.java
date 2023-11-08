package controller.cart;

import bean.Log;
import bean.User;
import services.CartService;
import services.LogService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "RemoveAllProduct", value = "/cart/removeAllProduct")
public class RemoveAllProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
//        Log log = new Log();
//        log.setEvent("/cart/removeAllProduct");
//        log.setDescription("Xóa tất cả sản phẩm khỏi giỏ hàng thành công");
//        log.setSeverityLevel(Log.INFO);
//        log.setUser(user);
//        LogService.getInstance().insert(log);
        user.setListCartItem(new ArrayList<>());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
