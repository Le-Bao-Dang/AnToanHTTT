package controller.admins;

import bean.Banner;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EditBanner", value = "/admins/editBannerForm")
public class EditBannerForm extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: 4/9/2023
//        int id = Integer.parseInt(request.getParameter("id"));
//        Banner banner = BannerService.getInstance().getBannerbyId(id);
//        String result = "";
//        if (banner.getName() == "home") {
//            result = "<option value=\"home\" selected>Trang chủ</option>\n+" +
//                    "<option value=\"product\">Sản phẩm</option>\n" +
//                    "<option value=\"none\">Ẩn</option>";
//        } else {
//            result = "<option value=\"home\" >Trang chủ</option>\n+" +
//                    "<option value=\"product\" selected>Sản phẩm</option>\n" +
//                    "<option value=\"none\">Ẩn</option>";
//        }
//        response.getWriter().println("<form class=\"form-add-address\">\n" +
//                "                                <div class=\"name\">\n" +
//                "                                    <label>Tên quản cáo</label>\n" +
//                "                                 <select id=\"edit-name\">\n" + result + " </select>\n</div>\n" +
//                "                                <div class=\"images\">\n" +
//                "                                    <label>Hình ảnh </label>\n" +
//                "                                     <img src\"" + banner.getImage_src() + "\" class=\"banner-img\"></img>" +
//                "                                    <input type=\"file\" name=\"file-img\" id=\"file-img\" class=\"submit\"\n" +
//                "                                           placeholder=\"Tải ảnh lên\">\n" +
//                "                                </div>\n" +
//                "                                <div class=\"modal-footer\">\n" +
//                "                                    <button type=\"button\" class=\"button button-close\" data-dismiss=\"modal\">Hủy\n" +
//                "                                    </button>\n" +
//                "                                    <button type=\"button\" class=\"button button-save\" id=\"save-editBanner\"\n" +
//                "                                            value=\"Lưu thay đổi\">Lưu thay đổi\n" +
//                "                                    </button>\n" +
//                "                                </div>\n" +
//                "                            </form>");
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
