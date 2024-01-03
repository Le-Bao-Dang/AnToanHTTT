package controller.admins;

import bean.Request;
import bean.User;
import services.RequestService;
import services.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserManager", value = "/securityRequestManager")
public class SecurityRequestManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("authAdmin");
        if (user.getVariety() != 1) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        String name = "Yêu cầu bảo mật";
        List<Request> requestlist = RequestService.getInstance().getListRequest();
        request.setAttribute("listRequest", requestlist);
        request.setAttribute("name", name);
        request.getRequestDispatcher("security-request-manager.jsp").forward(request, response);
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
