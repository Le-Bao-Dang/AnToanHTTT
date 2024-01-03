package controller.admins;

import bean.Category;
import bean.Image;
import bean.Product;
import services.ImageService;
import services.PaCategoryService;
import services.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EditProduct", value = "/admins/editProduct")
public class EditProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Product product = ProductService.getInstance().getProductById(id);
        List<Category> paCategoryList = PaCategoryService.getInstance().getListPaCategory();// Pa_Category_list
        String result = "";
        for (Category pa : paCategoryList) {
            if (product.getCategory().getPaCategory().getId()== pa.getId()) {
                result += "<option value=\"" + pa.getId() + "\" selected>" + pa.getName() + "</option>\n";
            } else {
                result += "<option value=\"" + pa.getId() + "\">" + pa.getName() + "</option>\n";
            }
        }
        List<Image> images = ImageService.getInstance().getListImageByProductId(product.getId());
        int index = 1;
        String htmlImg = "<div class=\"col-4 item" + index + "\">\n" +
                "                                            <img class=\"img-load image-item\" " + index + "\" src=\"" +  product.getMainImage() + "\" alt=\"\">\n" +
                "                                            <button class=\"remove-img\" value=\"" + index + "\">X</button>\n" +
                "                                       </div>";
        for (Image src : images) {
            index++;
            htmlImg += " <div class=\"col-4 item" + index + "\">\n" +
                    "                                <img class=\"img-load image-item" + index + "\" src=\"" + src.getSource() + "\" alt=\"\">\n" +
                    "                                <button class=\"remove-img\" value=\"" + index + "\">X</button>\n" +
                    "                            </div>";

        }
        response.getWriter().println("<form class=\"form-add-address\" action=\"/editProductinForm\">\n" +
                "                    <div class=\"name\">\n" +
                "                        <label>Tên sản phẩm</label>\n" +
                "                        <input class=\"input\" type=\"text\" name=\"name\" id=\"edit-name\" value=\"" + product.getName() + "\"></div>\n" +
                "                    <div class=\"price\">\n" +
                "                        <label>Giá sản phẩm</label>\n" +
                "                        <input class=\"input\" type=\"number\" min=\"0\" name=\"price\" id=\"edit-price\"\n" +
                "                               value=\"" + product.getListHistoryPrice().get(0).getPrice() + "\"></div>\n" +
                "                    <div class=\"priceReal\">\n" +
                "                        <label>Giá khuyến mãi</label>\n" +
                "                        <input class=\"input\" type=\"number\" min=\"0\" name=\"priceReal\" id=\"edit-priceReal\"\n" +
                "                               value=\"" + product.getListHistoryPrice().get(0).getPriceSale() + "\"></div>\n" +
                "                    <div class=\"type\">\n" +
                "                        <label>Loại sản phẩm</label>\n" +
                "                        <select class=\"input\" name=\"pa_category\" id=\"edit-pa_category\" >\n" +
                result +
                "                        </select>\n" +
                "                    </div>\n" +
                "                    <div class=\"group\">\n" +
                "                        <label>Nhóm sản phẩm</label>\n" +
                "                        <select class=\"input category\" name=\"category\" id=\"edit-category\">\n" +
                "                           <option value=\"" + product.getCategory().getId() + "\">" + product.getCategory().getName() + "</option>" +
                "                        </select>\n" +
                "                    </div>\n" +
                "                    <div class=\"inventory\">\n" +
                "                        <label>Số lượng</label>\n" +
                "                        <input class=\"input\" type=\"number\" min=\"0\" name=\"inventory\" id=\"edit-inventory\"\n" +
                "                               value=\"" + 2 + "\">\n" +
                "                    </div>\n" +
                "                    <div class=\"stt\">\n" +
                "                        <label>Trạng thái</label>\n" +
                "                        <input class=\"input\" type=\"number\" min=\"0\" name=\"stt\" id=\"edit-stt\"\n" +
                "                               value=\"" +   product.getStatus() + "\">\n" +
                "                    </div>\n" +
                "                    <div class=\"images\">\n" +
                "                        <form action=\"/admins/uploadImageProduct\" method=\"post\" class=\"upload\" enctype=\"multipart/form-data\">\n" +
                "                            <label>Hình ảnh sản phẩm (Tối thiểu 5 ảnh)</label>\n" +
                "                            <div class=\"row\">\n" +
                htmlImg + "<input type=\"file\" name=\"file-img1\" id=\"file-img1\" class=\"input-img submit\"\n" +
                "                                       accept=\"image/png\">" +
                "                            </div>\n" +
                "                            <button type=\"submit\" class=\"btn-submit-img\">submit</button>\n" +
                "                        </form>" +
                "                    </div>\n" +
                "                    <div class=\"detail\">\n" +
                "                        <label>Thông số sản phẩm</label>\n" +
                "                        <textarea class=\"input\" name=\"detail\" id=\"edit-detail\">" + product.getDetail() + "</textarea></div>\n" +
                "                    <div class=\"decription\">\n" +
                "                        <label>Mô tả sản phẩm</label>\n" +
                "                        <textarea class=\"input\" name=\"decription\" id=\"edit-decription\">" + product.getDescription() + "</textarea></div>\n" +
                "                    <div class=\"modal-footer\">\n" +
                "                    <div class=\"updateDate\">\n" +
                "                        <label>Mô tả sản phẩm</label>\n" +
                "                        <p class=\"input\" name=\"update\" id=\"edit-updateDate\">" + product.getListHistoryPrice().get(0).getCreateDate() + "</p></div>\n" +
                "                    <div class=\"modal-footer\">\n" +
                "                        <button type=\"button\" class=\"button button-close submit\" data-dismiss=\"modal\">Hủy</button>\n" +
                "                        <button type=\"button\" class=\"button button-save submit\" id=\"editProduct\"\n" +
                "                                value=\"Lưu sản phẩm\"> Cập nhật</button>\n" +
                "                    </div>\n" +
                "                </form>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
