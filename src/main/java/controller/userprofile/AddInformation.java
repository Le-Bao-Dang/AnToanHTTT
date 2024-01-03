package controller.userprofile;

import bean.Address;
import bean.Information;
import bean.User;
import services.InformationService;
import services.UserInformationService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddInformation", value = "/userprofile/addInformation")
public class AddInformation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String detail = request.getParameter("detail");

        int cityId = Integer.parseInt(request.getParameter("cityId"));
        int districtId = Integer.parseInt(request.getParameter("districtId"));
        String detailId = request.getParameter("detailId");

        Address address = new Address(detail, district, city, detailId, districtId, cityId);

        Information information = new Information(name, phone, address);

        InformationService.getInstance().addNewInformation(information);
        int id = InformationService.getInstance().maxId();
        UserInformationService.getInstance().addNewUserInformation(user.getId(), id);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
