package controller.detailProduct;

import bean.Review;
import bean.User;
import services.ReviewService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoadComment", value = "/detailProduct/loadComment")
public class LoadComment extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int page = Integer.parseInt(request.getParameter("page"));
        List<Review> reviews = ReviewService.getInstance().getListReviewByPage(id, page);
        for (Review review : reviews) {
            User user = review.getUser();
            StringBuilder rate = new StringBuilder();
            int count = review.getRate();
            for (int i = 0; i < 5; i++) {
                if (count > 0) {
                    rate.append("<i class=\"fa fa-star yellow\"></i>\n");
                    count--;
                } else {
                    rate.append(" <i class=\"fa fa-star  \"></i>\n");
                }

            }
            response.getWriter().println("<li class=\"item-comment bd-bottom\">\n" +
                    "                        <div class=\"user-cmt\">\n" +
                    "                            <img src=\"" + user.getAvatar().getSource() + "\"\n" +
                    "                                alt=\"\" class=\"img-user-cmt\">\n" +
                    "                            <div>\n" +
                    "                                <div class=\"name-user-cmt\">" + user.getName() + "</div>\n" +
                    "                                <div class=\"ratting rate-user\">\n" +
                    rate +
                    "                                </div>\n" +
                    "                            </div>\n" +
                    "                        </div>\n" +
                    "                        <div class=\"date-cmt\">" + review.getCreateDate().getDayOfMonth() + "/" + review.getCreateDate().getMonthValue() + "/" + review.getCreateDate().getYear() + "</div>\n" +
                    "                        <div class=\"comment\">\n" +
                    "                            <p>\n" +
                    review.getComment() +
                    "                            </p>\n" +
                    "                        </div>\n" +
                    "\n" +
                    "                    </li>");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
