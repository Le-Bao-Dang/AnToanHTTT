package controller;

import bean.User;
import services.CartService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LogOut", value = "/logOut")
public class LogOut extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        if (user != null) {
            CartService.getInstance().addCartUser(user);
        } else {
            user = (User) request.getSession().getAttribute("authAdmin");
        }
        request.getSession().invalidate();
        response.sendRedirect("/homepage");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
