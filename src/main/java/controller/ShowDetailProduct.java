package controller;

import bean.*;
import services.LogService;
import services.ProductService;
import services.ReviewService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "ShowDetailProduct", value = "/detail-product")
public class ShowDetailProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProduct = Integer.parseInt(request.getParameter("id"));

        Product product = ProductService.getInstance().getProductById(idProduct);
        request.setAttribute("product", product);

        List<Review> listReview = ReviewService.getInstance().getListReviewByPage(idProduct, 1);
        request.setAttribute("listReview", listReview);

        int countPage = ReviewService.getInstance().getCountPageById(idProduct);
        request.setAttribute("countPage", countPage);

        List<Product> listSameProduct = ProductService.getInstance().getListSameProduct(product.getCategory().getPaCategory().getId());
        request.setAttribute("listSameProduct", listSameProduct);

        request.getRequestDispatcher("product.jsp").forward(request, response);

        Log log = new Log();
        log.setEvent("/detail-product");
        log.setSeverityLevel(Log.INFO);
        log.setDescription("Truy cập chi tiết sản phẩm: " + product.getName());
        User user = (User) request.getSession().getAttribute("auth");

        if (user != null) log.setUser(user);

        LogService.getInstance().insert(log);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
