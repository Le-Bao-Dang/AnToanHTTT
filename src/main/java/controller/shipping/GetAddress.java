package controller.shipping;

import bean.Address;
import services.AddressService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(name = "GetAddress", value = "/getAddress")
public class GetAddress extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int addressId = Integer.parseInt(request.getParameter("addressId"));
        Address address = AddressService.getInstance().getAddressByInformationId(addressId);
        response.getWriter().println(address.getWardId());
        response.getWriter().println(address.getDistrictId());
        response.getWriter().print(address.getProvinceId());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

}
