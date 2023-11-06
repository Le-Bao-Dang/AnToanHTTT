package controller.admins;

import bean.User;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EditUserManager", value = "/editUserManager")
public class EditUserManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = "Quản lý tài khoản";
        int id = Integer.parseInt(request.getParameter("id"));
        int varieties = Integer.parseInt(request.getParameter("varieties"));
        int stt = Integer.parseInt(request.getParameter("stt"));
        UserService.getInstance().editVarietiesUser(id, varieties);
        UserService.getInstance().editSttUser(id, stt);
        List<User> list = UserService.getInstance().getListUser();
        request.setAttribute("listUser", list);
        request.setAttribute("name", name);
        request.getRequestDispatcher("user-manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
