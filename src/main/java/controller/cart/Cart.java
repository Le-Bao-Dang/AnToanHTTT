package controller.cart;

import bean.Log;
import bean.User;
import services.LogService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "Cart", value = "/cart")
public class Cart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        Log log = new Log();
        if (user != null) {
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            log.setEvent("/cart");
            log.setSeverityLevel(Log.INFO);
            log.setDescription("Truy cập giỏ hàng thành công");
            log.setUser(user);
        } else {
            response.sendRedirect("/doLogin");
            log.setEvent("/cart");
            log.setSeverityLevel(Log.INFO);
            log.setDescription("Truy cập giỏ hàng không thành công, người dùng chưa đăng nhập.");
        }

        LogService.getInstance().insert(log);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
