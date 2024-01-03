package controller.forgotpass;

import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ChangePass", value = "/forgotpass/changePass")
public class ChangePass extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phoneEmail = request.getParameter("phoneEmail");
        String newPass = request.getParameter("pass");
        UserService.getInstance().changePass(phoneEmail, newPass);
        response.getWriter().println("Đổi mật khẩu thành công");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
