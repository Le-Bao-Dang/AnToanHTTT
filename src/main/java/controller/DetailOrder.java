package controller;

import bean.Format;
import bean.LineItem;
import bean.Order;
import bean.User;
import services.LineItemService;
import services.OrderService;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DetailOrder", value = "/detailOrder")
public class DetailOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = OrderService.getInstance().getOrderByOrderId(id);

        User user = UserService.getInstance().getUserById(order.getUser().getId());
        int total = OrderService.getInstance().total(order);
        System.out.println("đã dô");
        String result = "";
        int discount = 0;
        String delivery = "";
        List<LineItem> orderDetails = LineItemService.getInstance().getListLineItemByOrderId(order.getId());
        for (LineItem or : orderDetails) {
            result += "<div class=\"col-md-8 \" style=\" display:flex;\">\n" +
                    "       <p>" + or.getProduct().getName() + " </p><p>" +" x " + or.getQuantity()+ "</p>\n" +
                    "   </div>\n" +
                    "   <div class=\"col-md-4 col-lg-3\">\n" +
                    "    <p clas=\"formatPrice\" style=\"width:300px \">" + Format.format(or.totalPrice()) + " VNĐ</p>\n" +
                    " </div>\n";
        }
        if(order.getStatusDelivery()==1){
            delivery = "Giao hàng thành công";
        }
        if(order.getStatusDelivery()==0){
            delivery ="Đang giao hàng";
        }
        if (order.getDiscount() == null) {
            discount = 0;
        } else {
            discount = order.getDiscount().getValue();
        }
        response.getWriter().println("   <form class=\"h-100 h-custom\" >\n" +
                "                        <div class=\"container py-5 h-100\">\n" +
                "                            <div class=\"row d-flex justify-content-center align-items-center h-100\">\n" +
                "                                <div class=\"\">\n" +
                "                                    <div class=\"card  width-card\" style=\"width: 490px\">\n" +
                "                                        <div class=\"card-body p-5\">\n" +
                "\n" +
                "                                            <p class=\"lead fw-bold mb-5\">" + user.getName() + "</p>\n" +
                "\n" +
                "                                            <div class=\"row\">\n" +
                "                                                <div class=\"col mb-3\">\n" +
                "                                                    <p class=\"small text-muted mb-1\">Địa chỉ</p>\n" +
                "                                                    <p>" + order.getInformation().getAddress().formatAddress() + "</p>\n" +
                "                                                </div>\n" +
                "                                                <div class=\"col mb-3\">\n" +
                "                                                    <p class=\"small text-muted mb-1\">Mã hóa đơn</p>\n" +
                "                                                    <p>" + order.getId() + "</p>\n" +
                "                                                </div>\n" +
                "                                            </div>\n" +
                "\n" +
                "                                            <div class=\"mx-n5 px-5 py-4\" >\n" +
                "                                                <div class=\"row\">\n" +
                result +
                "                                                </div>\n" +
                "                                                <div class=\"row\">\n" +
                "                                                    <div class=\"col-md-8 \">\n" +
                "                                                        <p class=\"mb-0\">Phí vận chuyển</p>\n" +
                "                                                    </div>\n" +
                "                                                    <div class=\"col-md-4 col-lg-3\">\n" +
                "                                                        <p clas=\"formatPrice mb-0\" style=\"width:300px \">" + Format.format(order.getTransport().getFee())+ " VNĐ</p>\n" +
                "                                                    </div>\n" +
                "                                                </div>\n" +
                "                                                <div class=\"row\">\n" +
                "                                                    <div class=\"col-md-8 \">\n" +
                "                                                        <p class=\"mb-0\">Khuyến mãi</p>\n" +
                "                                                    </div>\n" +
                "                                                    <div class=\"col-md-4 col-lg-3\">\n" +
                "                                                        <p clas=\"formatPrice mb-0\" style=\"width:300px \" >" + Format.format(discount) + " VNĐ</p>\n" +
                "                                                    </div>\n" +
                "                                                </div>\n" +
                "                                            </div>\n" +
                "\n" +
                "                                            <div class=\"mx-n5 px-5 py-4\">\n" +
                "                                                <div class=\"row\">\n" +
                "                                                    <div class=\"col-md-8 \">\n" +
                "                                                        <p>Tổng tiền</p>\n" +
                "                                                    </div>\n" +
                "                                                    <div class=\"col-md-4 col-lg-3\">\n" +
                "                                                        <p clas=\"formatPrice\" style=\"width:300px \"> " + Format.format(total) + " VNĐ</p>\n" +
                "                                                    </div>\n" +
                "                                                </div>\n" +
                "                                            </div>\n" +
                "\n" +
                "                                            <p class=\"lead fw-bold mb-4 pb-2\" >Trạng thái đơn hàng</p>\n" +
                "\n" +
                "                                            <div class=\"row\">\n" +
                "                                                <div class=\"col-lg-12\">\n" +
                "                                                    <p>" + delivery+ "</p>\n" +
                "                                                </div>\n" +
                "                                            </div>\n" +
                "                                        </div>\n" +
                "                                    </div>\n" +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                    </form>");
//
        System.out.println("đã tới");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
