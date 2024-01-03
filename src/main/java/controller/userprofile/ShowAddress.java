package controller.userprofile;

import bean.Address;
import bean.Information;
import bean.User;
import services.AddressService;
import services.InformationService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ShowAddress", value = "/showAddress")
public class ShowAddress extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        List<Information> informationList = InformationService.getInstance().getListInformationByUserId(user.getId());

        request.setAttribute("informationList", informationList);

        request.getRequestDispatcher("show-address.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
