package controller.admins;

import controller.Contact;
import services.ContactService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ContactManager", value = "/contactManager")
public class ContactManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = "Quản lý phản hồi";
//        List<Contact> listContact = ContactService.getInstance().getListContact();
//        request.setAttribute("name", name);
//        request.setAttribute("listContact", listContact);
//        request.getRequestDispatcher("contact-manager.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
