package controller.admins;

import services.OrderService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "GetStatisticalOrderInYear", value = "/getStatisticalOrderInYear")
public class GetStatisticalOrderInYear extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int year = Integer.parseInt(request.getParameter("year"));

        response.getWriter().println(OrderService.getInstance().listStatisticalInYear(year).toString());

    }
}
