package controller.cart;

import bean.Cart;
import bean.Discount;
import bean.Log;
import bean.User;
import services.DiscountService;
import services.LogService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringTokenizer;

@WebServlet(name = "CheckVoucher", value = "/cart/checkVoucher")
public class CheckVoucher extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String discountCode = request.getParameter("voucher");
        User user = (User) request.getSession().getAttribute("auth");
        Discount discount = DiscountService.getInstance().getDiscountByCode(discountCode);
        String message;

        if (discount == null)
            message = "Voucher không đúng";
        else if (discount.checkTime())
            message = "Voucher đã hết hạn sử dụng";
        else if (!discount.checkQuantity())
            message = "Voucher đã hết lượt sử dụng";
        else if (!discount.checkCondition(Cart.total(user.getListCartItem())))
            message = "Tổng đơn hàng của bạn phải lớn hơn " + discount.getCondition() + " VND để sử dụng mã giảm giá này!";
        else message = "Chúc mừng bạn đã được giảm " + discount.getValue() + " VND";

        response.getWriter().println(message);
        if (discount == null) {
            response.getWriter().println(0);
            response.getWriter().println(Cart.total(user.getListCartItem()));
        } else {
            response.getWriter().println(discount.getValue());
            response.getWriter().println(Cart.total(user.getListCartItem(), discount.getValue()));
        }

        Log log = new Log();
        log.setEvent("/cart/checkVoucher");
        log.setDescription("Nhập mã giảm giá \"" + discountCode + "\". " + message);
        log.setUser(user);
        log.setSeverityLevel(Log.INFO);
        LogService.getInstance().insert(log);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
