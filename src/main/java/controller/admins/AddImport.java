package controller.admins;

import bean.*;
import com.google.gson.Gson;
import services.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "AddImport", value = "/addImport")
public class AddImport extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("authAdmin");
        //import
        int vendorId = Integer.parseInt(request.getParameter("vendorId"));
        Vendor vendor = VendorService.getInstance().getVendorbyId(vendorId);
        LocalDateTime createDate = LocalDateTime.now();


        String note = request.getParameter("note");
        //lineItemImport
        String jsonItem = request.getParameter("jsonItem");
        Gson gson = new Gson();
        ProductImport[] listPr = gson.fromJson(jsonItem, ProductImport[].class);
        Category category = CaterogyService.getInstance().getCategoryById(4);
        List<LineItemImport> lineItemImports = new ArrayList<>();
        System.out.println(Arrays.toString(listPr));
        for (ProductImport p : listPr) {
            Product product = new Product(0, p.getName(), "", "", createDate, 0, null, null, category, user, 1);
            if (ProductService.getInstance().getProductByName(p.getName()) == null) {
                ProductService.getInstance().addProduct(product);
            }
            product = ProductService.getInstance().getProductByName(p.getName());
            LineItemImport lineItemImport = new LineItemImport(product.getId(), product, p.getQuantity(), p.getpriceImport());
            lineItemImports.add(lineItemImport);
        }
        Import aImport = new Import(0, vendor, lineItemImports, createDate, user, note, 0);
        ImprotService.getInstance().addImportAll(aImport);
        response.sendRedirect("/importManager");


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
