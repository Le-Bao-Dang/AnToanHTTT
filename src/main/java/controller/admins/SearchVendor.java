package controller.admins;

import bean.Format;
import bean.Product;
import bean.Vendor;
import services.ProductService;
import services.VendorService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchVendor", value = "/searchVendor")
public class SearchVendor extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("txtSearch");
        List<Vendor> vendorList = VendorService.getInstance().searchByAll(search);
        System.out.println(vendorList.size());
        for (Vendor vendor : vendorList) {
            response.getWriter().println("<tr>\n" +
                    "                <td>\n" +
                    "                    <div class=\"d-flex px-2 py-1\">\n" +
                    "                        <div class=\"d-flex flex-column justify-content-center\">\n" +
                    "                            <h6 class=\"mb-0 text-sm\">" + vendor.getInformation().getName() + "\n" +
                    "                            </h6>\n" +
                    "                            <p class=\"text-xs text-secondary mb-0\"> " + vendor.getEmail() + "\n" +
                    "                            </p>\n" +
                    "                            <p class=\"text-xs text-secondary mb-0\">" + vendor.getWebsite() + "\n" +
                    "                            </p>\n" +
                    "                        </div>\n" +
                    "                    </div>\n" +
                    "                </td>\n" +
                    "                <td class=\"align-middle text-center text-sm\">\n" +
                    "                    <span class=\"text-secondary text-xs font-weight-bold\">" + vendor.getInformation().getPhone() + "</span>\n" +
                    "\n" +
                    "                </td>\n" +
                    "                <td class=\"align-middle text-center address\">\n" +
                    "                    <p class=\"address-text\">+" + vendor.getInformation().getAddress().formatAddress() + "\n" +
                    "                    </p>\n" +
                    "                </td>\n" +
                    "                <td class=\"align-middle text-center\">\n" +
                    "                    <span class=\"text-secondary text-xs font-weight-bold\">" + vendor.getStatusNow() + "</span>\n" +
                    "                </td>\n" +
                    "                <td class=\"align-middle\">\n" +
                    "                    <button class=\"edit-vendor submit\" value=\"" + vendor.getId() + "\" style=\"width: 150px\">\n" +
                    "                        sửa\n" +
                    "                    </button>\n" +
                    "                </td>\n" +
                    "            </tr>");

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
