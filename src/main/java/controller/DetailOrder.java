package controller;

import bean.Format;
import bean.LineItem;
import bean.Order;
import bean.User;
import services.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DetailOrder", value = "/detailOrder")
public class DetailOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("orderId"));
        System.out.println(id);
        Order order = OrderService.getInstance().getOrderByOrderId(id);
        User user = UserService.getInstance().getUserById(order.getUser().getId());
        int total = OrderService.getInstance().total(order);

        List<LineItem> orderDetails = LineItemService.getInstance().getListLineItemByOrderId(order.getId());
        KeyServices ks = new KeyServices();

        if (ks.checkPublicKeyWithOrderCreate(order,user.getId())){
            if(SignVerifyServices.getInstance().verifyOrder(FormatOrder.getInstance().format(order), ks.exportPublicKey())){
                request.setAttribute("verify", true);
            }else{
                request.setAttribute("verify", false);
            }
        }else{
            request.setAttribute("error", "User không có khóa Public Key!!");
        }

        String name = "Chi tiet don hang";
        request.setAttribute("name", name);
        request.setAttribute("user",user);
        request.setAttribute("order",order);
        request.setAttribute("total",total);
        request.setAttribute("orderDetails",orderDetails);
        request.getRequestDispatcher("admin-order-detail.jsp").forward(request,response);




    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        int orderStatus = Integer.parseInt(request.getParameter("status"));

        // Thực hiện xử lý dữ liệu (ví dụ: cập nhật trạng thái đơn hàng trong cơ sở dữ liệu)
        boolean done = OrderService.getInstance().updateStatus(orderId,orderStatus);
        if (done){
            response.getWriter().write("Xử lý thành công!");
        }else{
            System.out.println("Lỗi");
        }
    }
}
