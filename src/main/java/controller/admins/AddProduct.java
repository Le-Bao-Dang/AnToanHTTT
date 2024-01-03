package controller.admins;

import bean.*;
import services.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddProduct", value = "/admins/addProduct")
public class AddProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");
        int sizeProduct = ProductService.getInstance().getListProduct().size();
        int price = Integer.parseInt(request.getParameter("price"));
        int priceSale = Integer.parseInt(request.getParameter("priceReal"));
        int group = Integer.parseInt(request.getParameter("category"));
        int inventory = Integer.parseInt(request.getParameter("inventory"));
        User user = (User) request.getSession().getAttribute("authAdmin");
        String imgSrc = "";
        String detail = request.getParameter("detail");
        String decription = request.getParameter("decription");
//        add Price
        HistoryPrice historyPrice = new HistoryPrice(0, price, priceSale, LocalDateTime.now(), 0);
        HistoryPriceService.getInstance().addHistoryPriceByIdProduct(sizeProduct + 1, historyPrice);
//        add Image
        List<String> imageList = new ArrayList<>();
        ImageService.getInstance().addListImageByIdProduct(sizeProduct+1, imageList);
//        Categry
        Category category = CaterogyService.getInstance().getCategoryById(group);
//        add Product
        Product product = new Product(sizeProduct + 1, name, decription, detail, 0, category, user, 0);
        ProductService.getInstance().addProduct(product);
        System.out.println("đã thêm");
//        response.sendRedirect("/admins/uploadImageProduct");

//        Log log = new Log();
//        log.setEvent("/admins/addProduct");
//        log.setDescription("Thêm sản phẩm mới \" "+name+" \"");
//        log.setSeverityLevel(Log.INFO);
//        if (user != null) {
//            log.setUser(user);
//        }
//        LogService.getInstance().insert(log);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
