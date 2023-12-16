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
        int id = Integer.parseInt(request.getParameter("orderId"));
        System.out.println(id);
        Order order = OrderService.getInstance().getOrderByOrderId(id);
        User user = UserService.getInstance().getUserById(order.getUser().getId());
        int total = OrderService.getInstance().total(order);

        List<LineItem> orderDetails = LineItemService.getInstance().getListLineItemByOrderId(order.getId());

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

    }
}
