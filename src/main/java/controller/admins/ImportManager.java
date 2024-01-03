package controller.admins;

import bean.Import;
import bean.User;
import bean.Vendor;
import services.ImprotService;
import services.VendorService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ImportManager", value = "/importManager")
public class ImportManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("authAdmin");
        if (user.getVariety() != 1 && user.getVariety() != 3) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        String name = "Quản lý nhập kho";
        List<Import> importList = ImprotService.getInstance().getListImport();
        List<Vendor> vendors = VendorService.getInstance().getListVendor();
        request.setAttribute("name", name);
        request.setAttribute("importList", importList);
        request.setAttribute("vendors", vendors);
        request.getRequestDispatcher("import-manager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
