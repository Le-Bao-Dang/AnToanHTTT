package controller.admins;

import bean.Import;
import bean.LineItemImport;
import services.ImprotService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.Month;

@WebServlet(name = "ImportDetail", value = "/importDetail")
public class ImportDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Import anImport = ImprotService.getInstance().getImportByImportId(id);
        String result = "";
        int count = 0;
        for (LineItemImport lineItemImport : anImport.getListLineItem()) {
            count += 1;
            result += "  <tr>\n" +
                    "                <td>" + count + "</td>\n" +
                    "                <td>" + lineItemImport.getProduct().getName() + "</td>\n" +
                    "                <td>" + lineItemImport.getQuantity() + "</td>\n" +
                    "                <td>" + lineItemImport.getPriceImport() + "</td>\n" +
                    "                <td>" + lineItemImport.getTotalPrice() + "</td>\n" +
                    "            </tr> " + "\t";
        }
        int day = anImport.getCreateDate().getDayOfMonth();
        int month = anImport.getCreateDate().getMonthValue();
        int year = anImport.getCreateDate().getYear();

        response.getWriter().println(" <div class=\"contents\">\n" +
                "        <button class=\"button-close\" onclick=\"closes()\"><i class=\"fas fa-times\"></i></button>\n" +
                "        <h1 class=\"title\"> Phiếu nhập hàng</h1>\n" +
                "        <p class=\"date\">Ngày " + day + " tháng " + month + " năm " + year + "</p>\n" +
                "        <p class=\"id\">Số: " + anImport.getId() + "</p>\n" +
                "        <div class=\"form\">\n" +
                "            <p class=\"name-vendor\">Tên nhà cung cấp: " + anImport.getVendor().getInformation().getName() + "</p>\n" +
                "            <p class=\"address\">Địa chỉ: "+anImport.getVendor().getInformation().getAddress().formatAddress()+"</p>\n" +
                "            <p class=\"phone\">Số điện thoại: "+anImport.getVendor().getInformation().getPhone()+"</p>\n" +
                "        </div>\n" +
                "        <table>\n" +
                "            <tr>\n" +
                "                <th>STT</th>\n" +
                "                <th>Tên sản phẩm</th>\n" +
                "                <th>Số lượng</th>\n" +
                "                <th>Đơn giá</th>\n" +
                "                <th>Thành tiền</th>\n" +
                "            </tr>\n" +
                result
                +
                "            <tr>\n" +
                "                <td></td>\n" +
                "                <td><b>Cộng</b></td>\n" +
                "                <td>x</td>\n" +
                "                <td>x</td>\n" +
                "                <td>" + anImport.getTotal() + "</td>\n" +
                "            </tr>\n" +
                "        </table>\n" +
                "        <p class=\"employee\">Nhân viên nhập kho:" + anImport.getUserImport().getName() + "\n </p>\n" +
                "        <p class=\"status\">Trạng thái: <b>" + anImport.getStatustoString() + "</b></p>\n" +
                "    </div>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
