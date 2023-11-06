package controller.userprofile;

import bean.*;
import services.HistoryPriceService;
import services.OrderService;

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

        Order order = OrderService.getInstance().getOrderByOrderId(orderId);
        request.setAttribute("order", order);

        List<HistoryPrice> listPrice = new ArrayList<>();

        for(LineItem lineItem: order.getListOrderItem()){
            System.out.println(lineItem.getProduct().getId());
            System.out.println(order.getCreateDate());
            listPrice.add(HistoryPriceService.getInstance().getPriceOfProductAtTime(lineItem.getProduct().getId(), order.getCreateDate()));
            System.out.println(listPrice);
        }

        request.setAttribute("listPrice", listPrice);

        request.getRequestDispatcher("order-detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
