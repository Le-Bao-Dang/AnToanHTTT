package controller.detailProduct;

import bean.Log;
import bean.Product;
import bean.Review;
import bean.User;
import services.LogService;
import services.ProductService;
import services.ReviewService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "UpComment", value = "/detailProduct/upComment")
public class UpComment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        String text = request.getParameter("text");
        int idProduct = Integer.parseInt(request.getParameter("idProduct"));
        int rate = Integer.parseInt(request.getParameter("rate"));
        Product product = ProductService.getInstance().getProductById(idProduct);

        Log log = new Log();
        log.setEvent("/detailProduct/upComment");

        if (user == null) {
            response.getWriter().println(0);
            log.setSeverityLevel(Log.INFO);
            log.setDescription("Bình luận sản phẩm \"" + product.getName() + "\" không thành công, người dùng chưa đăng nhập!");
            LogService.getInstance().insert(log);
            return;
        }
        log.setSeverityLevel(Log.INFO);
        log.setDescription("Bình luận sản phẩm \"" + product.getName() + "\" thành công. Nội dung \"" + text + "\"");
        log.setUser(user);
        LogService.getInstance().insert(log);

        LocalDateTime now = LocalDateTime.now();

        StringBuilder rateHtml = new StringBuilder();
        int count = rate;
        for (int i = 0; i < 5; i++) {
            if (count > 0) {
                rateHtml.append("<i class=\"fa fa-star yellow\"></i>\n");
                count--;
            } else {
                rateHtml.append(" <i class=\"fa fa-star  \"></i>\n");
            }
        }

        Review review = new Review(text, rate, user, product, now, 0);
        ReviewService.getInstance().addReview(review);

        response.getWriter().println("<li class=\"item-comment bd-bottom\">\n" +
                "                        <div class=\"user-cmt\">\n" +
                "                            <img src=\"" + user.getAvatar().getSource() + "\"\n" +
                "                                alt=\"\" class=\"img-user-cmt\">\n" +
                "                            <div>\n" +
                "                                <div class=\"name-user-cmt\">" + user.getName() + "</div>\n" +
                "                                <div class=\"ratting rate-user\">\n" +
                rateHtml +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                        <div class=\"date-cmt\">" + now.getDayOfMonth() + "/" + now.getMonthValue() + "/" + now.getYear() + "</div>\n" +
                "                        <div class=\"comment\">\n" +
                "                            <p>\n" +
                text +
                "                            </p>\n" +
                "                        </div>\n" +
                "\n" +
                "                    </li>");


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
