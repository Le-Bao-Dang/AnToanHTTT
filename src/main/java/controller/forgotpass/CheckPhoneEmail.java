package controller.forgotpass;

import services.MailService;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CheckPhoneEmail", value = "/forgotpass/checkPhoneEmail")
public class CheckPhoneEmail extends HttpServlet {

    public int random() {
        return (int) (Math.floor(Math.random() * 9000) + 1000);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phoneEmail = request.getParameter("phoneEmail");
        boolean check = UserService.getInstance().checkPhoneEmail(phoneEmail);

        int code = 0;
        if (check) {
            code = random();
            MailService.sendMail("Doi mat khau", "Ma xac nhan la:"+code, phoneEmail);
        }
        response.getWriter().println(code);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
