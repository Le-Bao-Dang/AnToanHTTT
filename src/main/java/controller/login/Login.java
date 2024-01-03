package controller.login;

import bean.IncorrectTime;
import bean.User;
import services.CartService;
import services.IncorrectTimeService;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "Login", value = "/doLogin")
public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("user");
        String password = request.getParameter("password");
        User user = UserService.getInstance().checkLogin(username, password);

        // kiem tra userName co ton tai
        if (UserService.getInstance().checkExistUserName(username)) {
            int id = UserService.getInstance().getIdByUserName(username);
            // kiểm tra tài khoản có bị khóa vĩnh viễn
            if (UserService.getInstance().isBlockedForever(id)) {
                request.setAttribute("error", "Tài khoản của bạn bị khóa vĩnh viễn!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            // TH tài khoản ko bị khóa vĩnh viễn
            else {
                // kiểm tra tài khoản có bị khóa tạm thời
                if (IncorrectTimeService.getInstance().checkLocked(LocalDateTime.now(), username)) {
                    LocalDateTime time = IncorrectTimeService.getInstance().getTimeUnLock(id);
                    request.setAttribute("error", "Tài khoản của bạn đang tạm khóa, sẽ được mở lại sau " + time.getHour() + "h" + time.getMinute() + " " + time.getDayOfMonth() + "/" + time.getMonthValue() + "/" + time.getYear());
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
                // TH ko bị khóa tạm thời
                else {
                    //kiểm tra có đăng nhập đúng
                    if (user != null) {
                        // reset thời gian khóa
                        IncorrectTimeService.getInstance().deleteIncorrectTime(id);
                        // Vào trang Admin
                        if (user.getVariety() > 0) {
                            HttpSession session = request.getSession(true);
                            session.setAttribute("authAdmin", user);
                            response.sendRedirect("orderManager");
                        }
                        // User bình thường
                        else {
                            user.setListCartItem(CartService.getInstance().getCartOfUser(id));
                            HttpSession session = request.getSession(true);
                            session.setAttribute("auth", user);
                            response.sendRedirect("homepage");
                        }
                    }
                    // TH đăng nhập sai
                    else {
                        IncorrectTimeService.getInstance().insertIncorrectAttemptsPassword(id);
                        // TH User nhập sai 5 lần
                        if (UserService.getInstance().isEligibilityToLock(id)) {
                            LocalDateTime tomorrow = LocalDateTime.now().plusDays(1);
                            IncorrectTimeService.getInstance().setLockTimePassword(id, tomorrow);
                            request.setAttribute("error", "Bạn đã nhập sai 5 lần, tài khoản của bạn bị khóa cho đến " + tomorrow.getHour() + "h" + tomorrow.getMinute() + " " + tomorrow.getDayOfMonth() + "/" + tomorrow.getMonthValue() + "/" + tomorrow.getYear());
                            request.getRequestDispatcher("login.jsp").forward(request, response);

                        }
                        // TH User nhập sai <5 lần
                        else {
                            request.setAttribute("error", "Bạn đã nhập sai " + IncorrectTimeService.getInstance().getInccorrectAttempts(id) + " lần, tài khoản sẽ khóa sau 5 lần  sai");
                            request.getRequestDispatcher("login.jsp").forward(request, response);
                        }
                    }
                }
            }
        } else {
            request.setAttribute("error", "Username không tồn tại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
