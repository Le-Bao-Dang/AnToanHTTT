package controller.admins;

import services.OrderService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "GetStatisticalOrderAllYear", value = "/getStatisticalOrderAllYear")
public class GetStatisticalOrderAllYear extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        for (int i = 2022; i < 2024; i++) {
            response.getWriter().println(OrderService.getInstance().listStatisticalInYear(i));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
