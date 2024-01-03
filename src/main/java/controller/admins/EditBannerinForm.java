package controller.admins;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EditBannerinForm", value = "/editBannerinForm")
public class EditBannerinForm extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: 4/9/2023
//        String namepage = "Quản lý chung";
//        String name = request.getParameter("name");
//        String imgSrc = request.getParameter("imgSrc");
//        int id = Integer.parseInt(request.getParameter("id"));
//        BannerService.getInstance().editBanner(id, name, imgSrc);
//        List<Banner> bannerList = BannerService.getInstance().getListBanner();
//        request.setAttribute("listBanner",bannerList);
//        request.setAttribute("name",namepage);
//        request.getRequestDispatcher("general-manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
