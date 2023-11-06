package controller.listProducts;

import bean.Format;
import bean.Product;
import services.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListProductInPage", value = "/listProducts/listProductInPage")
public class ListProductInPage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pages = (request.getParameter("page"));
        int kind = Integer.parseInt(request.getParameter("kind"));
        String group = request.getParameter("group");
        String sort = request.getParameter("sort");
        System.out.println(sort);
        List<Product> list = ProductService.getInstance().getListProductInPageName(kind, group, pages);
        for (Product product : list) {
            StringBuilder rate = new StringBuilder();
            StringBuilder priceReal = new StringBuilder();
            int count = product.getRate();
            for (int i = 0; i < 5; i++) {
                if (count > 0) {
                    rate.append("<i class=\"fa fa-star yellow\"></i>\n");
                    count--;
                } else {
                    rate.append(" <i class=\"fa fa-star  \"></i>\n");
                }
            }
            if (product.getPriceSale() != 0) {
                priceReal.append(" <span class=\\\"price-real\\\">" + Format.format(product.getPriceSale()) + " VND</span>");
            }


            response.getWriter().println("   <div class=\"col-4\">\n" +
                    "                        <div class=\"thumbnail\">\n" +
                    "                            <div class=\"cont-item \">\n" +
                    "                                <a href=\"http://localhost:8080/detail-product?id=" + product.getId() + "&page=1\"><img src=\"" + product.getListImage().get(1).getSource() + " \" alt=\"\">\n" +
                    "                                </a>\n" +
                    "                            </div>\n" +
                    "                            <div class=\"button\">\n" +
                    "                                <a href=\"\" class=\"buy-now\"> Mua ngay</a>\n" +
                    "                                <a href=\"\" class=\"wish-list \"><i class=\"fa-solid fa-cart-plus\"></i></a>\n" +
                    "                            </div>\n" +
                    "                            <div class=\"caption\">\n" +
                    "                                <h3><a href=\"http://localhost:8080/detail-product?id=" + product.getId() + "&page=1\">" + product.getName() + "</a></h3>\n" +
                    "                                <div class=\"ratting\">\n" + rate +
                    "                                </div>\n" +
                    "                                <h3 class=\"price\">\n" + Format.format(product.getPrice()) + " VND\n" + priceReal +
                    "                                </h3>\n" +
                    "                            </div>\n" +
                    "                        </div>\n" +
                    "                    </div>");

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
