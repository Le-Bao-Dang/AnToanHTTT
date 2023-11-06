package controller;

import bean.Category;
import bean.Log;
import bean.Product;
import bean.User;
import services.CaterogyService;
import services.LogService;
import services.PaCategoryService;
import services.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductManager", value = "/ProductManager")
public class ProductManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("authAdmin");
        if (user.getVariety() != 1 && user.getVariety() != 2 && user.getVariety() != 3) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        String name = "Quản lý sản phẩm";
        List<Product> list = ProductService.getInstance().getListProduct();
        List<Category> listPaCategories = PaCategoryService.getInstance().getListPaCategory();
        List<Category> categoryList = CaterogyService.getInstance().getListCategory(1);
        int quantity = list.size();
//        List<Integer> wood = ProductService.getInstance().statisticalProduct(1);
//        List<Integer> ceramic = ProductService.getInstance().statisticalProduct(2);
//        List<Integer> picture = ProductService.getInstance().statisticalProduct(3);
        request.setAttribute("quantity", quantity);
        request.setAttribute("list", list);
        request.setAttribute("listPacategories", listPaCategories);
        request.setAttribute("listCategory", categoryList);
        request.setAttribute("name", name);
//        request.setAttribute("wood",wood);
//        request.setAttribute("ceramic",ceramic);
//        request.setAttribute("picture",picture);
        request.getRequestDispatcher("product-manager.jsp").forward(request, response);

        Log log = new Log();
        log.setEvent("/ProductManager");
        log.setDescription("Truy cập trang \"" + name + " \"");
        log.setSeverityLevel(Log.INFO);
        log.setUser(user);
        LogService.getInstance().insert(log);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
