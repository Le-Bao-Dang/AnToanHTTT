package controller.userprofile;

import bean.User;
import services.AddressService;
import services.InformationService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteAllInformation", value = "/userprofile/deleteAllInformation")
public class DeleteAllAddress extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        InformationService.getInstance().deleteAllInformation(user.getId());
        response.getWriter().println("");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
