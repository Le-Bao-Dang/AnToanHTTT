package controller;

import bean.Category;
import bean.Log;
import bean.Product;
import bean.User;
import services.CaterogyService;
import services.LogService;
import services.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListProduct", value = "/listProduct")
public class ListProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        int kind = Integer.parseInt(request.getParameter("kind"));
        String page= "1";
        String group = "";
        int size = ProductService.getInstance().getCountProduct(kind, group) / 15;
        int count = ProductService.getInstance().getCountProduct(kind, group) % 15 > 0 ? size + 1 : size;
        List<Product> listProduct = ProductService.getInstance().getListProductInPageName(kind, group,page);// danh sach san pham theo trang
//        List<Banner> listbanner = BannerService.getInstance().getListBannerInPage("product");
        System.out.println(listProduct.size());
        request.setAttribute("listProduct", listProduct);
        request.setAttribute("kind", kind);
        request.setAttribute("group", group);
        request.setAttribute("count", count);
//        request.setAttribute("listBanner",listbanner);
        List<Category> categories = CaterogyService.getInstance().getListCategory(kind);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("list-product.jsp").forward(request, response);
        Log log = new Log();
        log.setEvent("/listProduct");
        log.setDescription("Truy cập trang danh sách sản phẩm loại: "+kind);
        log.setSeverityLevel(Log.INFO);
        if (user != null) {
            log.setUser(user);
        }
        LogService.getInstance().insert(log);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
