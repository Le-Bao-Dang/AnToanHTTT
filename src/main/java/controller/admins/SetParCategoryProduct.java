package controller.admins;

import bean.Category;
import services.CaterogyService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SetParCategoryProduct", value = "/setParCategoryProduct")
public class SetParCategoryProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pa_categoryId =Integer.parseInt(request.getParameter("idPacategory"));
        List<Category> categoryList = CaterogyService.getInstance().getListCategory(pa_categoryId);
        for (Category ca: categoryList) {
            response.getWriter().println("<option value=\""+ca.getId()+"\">"+ca.getName()+"</option>\n");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
