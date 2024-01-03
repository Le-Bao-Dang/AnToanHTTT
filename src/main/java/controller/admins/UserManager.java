package controller.admins;

import bean.Log;
import bean.User;
import services.LogService;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManager", value = "/userManager")
public class UserManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("authAdmin");
        if (user.getVariety() != 1) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        String name = "Quản lý tài khoản";
        List<User> list = UserService.getInstance().getListUser();
        request.setAttribute("listUser", list);
        request.setAttribute("name", name);
        request.getRequestDispatcher("user-manager.jsp").forward(request, response);
//        Log log = new Log();
//        log.setEvent("/searches");
//        log.setDescription("Truy cập trang \"" + name + " \"");
//        log.setSeverityLevel(Log.INFO);
//        log.setUser(user);
//        LogService.getInstance().insert(log);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
