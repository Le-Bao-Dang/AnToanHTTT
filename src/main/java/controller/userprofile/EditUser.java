package controller.userprofile;

import bean.User;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EditUser", value = "/userprofile/editUser")
public class EditUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");

        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String email = request.getParameter("email");

        user.setName(fullName);
        user.setPhone(phoneNumber);
        user.setEmail(email);

        UserService.getInstance().editInfor(user.getId(), fullName, phoneNumber, email);

        response.getWriter().println("<li>Họ và tên: " + fullName + "</li>\n" +
                "                     <li>Số điện thoại: " + phoneNumber + "</li>\n" +
                "                    <li>Email: " + email + "</li>");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
