package controller.shipping;

import bean.*;
import services.AddressService;
import services.DiscountService;
import services.InformationService;
import services.LogService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "Shipping", value = "/shipping")
public class Shipping extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        String discountCode = request.getParameter("discountCode");
        if(!"".equals(discountCode)){
            Discount discount = DiscountService.getInstance().getDiscountByCode(discountCode);
            request.setAttribute("discountFee", discount.getValue());
        }else{
            request.setAttribute("discountFee", 0);
        }

        List<Information> informations = InformationService.getInstance().getListInformationByUserId(user.getId());

        request.setAttribute("discountCode", discountCode);
        request.setAttribute("informations", informations);
        request.getRequestDispatcher("shipping.jsp").forward(request, response);

//        Log log = new Log();
//        log.setEvent("/shipping");
//        log.setDescription("Truy cập trang thanh toán");
//        log.setUser(user);
//        log.setSeverityLevel(Log.INFO);
//        LogService.getInstance().insert(log);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


}
