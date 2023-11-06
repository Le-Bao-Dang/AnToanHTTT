package controller.admins;

import bean.Vendor;
import services.VendorService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "VendorManager", value = "/vendorManager")
public class VendorManager extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = "Quản lý nhà cung cấp";
        List<Vendor> vendors = VendorService.getInstance().getListVendor();
        LocalDateTime date = LocalDateTime.now();
        request.setAttribute("name", name);
        request.setAttribute("vendors", vendors);
        request.setAttribute("dateTime",date);
        request.getRequestDispatcher("vendorManager.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
