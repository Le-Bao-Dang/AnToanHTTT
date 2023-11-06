package controller.admins;

import bean.Address;
import bean.Information;
import bean.Vendor;
import services.VendorService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddVendor", value = "/addVendor")
public class AddVendor extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email").trim();
        String website = request.getParameter("website").trim();
        String phone = request.getParameter("phone").trim();
        String detail = request.getParameter("detail");
        String district = request.getParameter("district");
        String city = request.getParameter("city");
        String warID = request.getParameter("warId");
        int districtId = Integer.parseInt(request.getParameter("districtId"));
        int cityId = Integer.parseInt(request.getParameter("cityId"));
        Address address = new Address(detail, district, city, warID, districtId, cityId);
        Information information = new Information(name, phone, address, 0);
        Vendor vendor = new Vendor(0, email, information, website, 0);
        if (VendorService.getInstance().addVendor(vendor)) {
            request.setAttribute("log", "Thêm thành công");
        response.sendRedirect("/vendorManager");
        }
        request.setAttribute("log", "Vui lòng kiểm tra lại");
    }
}
