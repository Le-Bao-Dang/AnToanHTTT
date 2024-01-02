package controller.userprofile;

import bean.Request;
import bean.User;
import services.RequestService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ShowSecurity", value = "/showSecurity")
public class ShowSecurity extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        List<Request> re = RequestService.getInstance().getRequestByUserId(user.getId());

        request.setAttribute("request", re);
        request.getRequestDispatcher("security.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
