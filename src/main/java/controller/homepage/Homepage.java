package controller.homepage;

import bean.Product;
import bean.User;
import services.ProductService;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Homepage", value = "/homepage")
public class Homepage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> favouriteProducts = ProductService.getInstance().getListFavouriteProduct();
        request.setAttribute("favouriteProducts", favouriteProducts);

        List<Product> newProducts = ProductService.getInstance().getNewProducts();
        request.setAttribute("newProducts", newProducts);

        List<Product> topWoodProducts = ProductService.getInstance().getTopProducts(ProductService.WOOD);
        request.setAttribute("topWoodProducts", topWoodProducts);

        List<Product> topCeramicProducts = ProductService.getInstance().getTopProducts(ProductService.CERAMIC);
        request.setAttribute("topCeramicProducts", topCeramicProducts);

        List<Product> topPaintingProducts = ProductService.getInstance().getTopProducts(ProductService.PAINT);
        request.setAttribute("topPaintingProducts", topPaintingProducts);

        request.getRequestDispatcher("home-page.jsp").forward(request, response);


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
