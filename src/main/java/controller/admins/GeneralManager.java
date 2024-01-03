package controller.admins;

import bean.Category;
import services.CaterogyService;
import services.PaCategoryService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "GeneralManager", value = "/generalManager")
public class GeneralManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = "Quản lý chung";
//        List<Banner> bannerList = BannerService.getInstance().getListBanner();
        List<Category> paCategoryList = PaCategoryService.getInstance().getListPaCategory();
        List<Category> categoryList = CaterogyService.getInstance().getListCategoryAll();
//        request.setAttribute("listBanner",bannerList);
//        request.setAttribute("listPaCategory",paCategoryList);
//        request.setAttribute("listCategory",categoryList);
        request.setAttribute("name", name);
        request.setAttribute("categories",categoryList);
        request.setAttribute("listPaCategory",paCategoryList);
        request.getRequestDispatcher("general-manager.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
