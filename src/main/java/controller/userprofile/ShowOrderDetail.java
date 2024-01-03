package controller.userprofile;

import bean.*;
import services.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ShowOrderDetail", value = "/showOrderDetail")
public class ShowOrderDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        User user = (User) request.getSession().getAttribute("auth");
        Order oldOrder = OrderService.getInstance().getOrderByOrderId(orderId);

        System.out.println(oldOrder.toString());

        KeyServices ks = new KeyServices();

        if (ks.checkPublicKeyWithOrderCreate(oldOrder,user.getId())){
            Order order = FormatOrder.getInstance().format(oldOrder);
            if(SignVerifyServices.getInstance().verifyOrder(order, ks.exportPublicKey())){
                request.setAttribute("verify", "Verified");
            }else{
                request.setAttribute("verify", "Not Verified");
            }
        }else{
            request.setAttribute("error", "User không có khóa Public Key!!");
        }


        request.setAttribute("order", oldOrder);

        List<HistoryPrice> listPrice = new ArrayList<>();

        for(LineItem lineItem: oldOrder.getListOrderItem()){
            System.out.println(lineItem.getProduct().getId());
            System.out.println(oldOrder.getCreateDate());
            listPrice.add(HistoryPriceService.getInstance().getPriceOfProductAtTime(lineItem.getProduct().getId(), oldOrder.getCreateDate()));
            System.out.println(listPrice);
        }

        request.setAttribute("listPrice", listPrice);

        request.getRequestDispatcher("order-detail.jsp").forward(request, response);
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
