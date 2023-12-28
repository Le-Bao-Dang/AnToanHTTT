package controller.userprofile;

import bean.Request;
import bean.User;
import services.RequestService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "AddRequest", value = "/userprofile/addRequest")
public class AddRequest extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        String note = (String) request.getAttribute("note");
        Request re = new Request(0, user, LocalDateTime.now(), null, note, RequestService.REQUESTING);
        RequestService.getInstance().createRequest(re);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
