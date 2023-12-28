package controller.userprofile;

import bean.Request;
import bean.User;
import services.RequestService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RequestManager", value = "/userprofile/requestUserManager")
public class RequestUserManager extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Request r = RequestService.getInstance().getRequestById(id);
        System.out.println("oke");
        response.getWriter().println(" <div class=\"\">\n" +
                "                            <div class=\"form-add-address\">\n" +
                "                                <input class=\"input\" type=\"text\" name=\"input-note\"\n" +
                "                                       id=\"input-note\"\n" +
                "                                       value=\"" + r.getNote() + "\" readonly >\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                        <div class=\"modal-footer\">\n" +
                "                            <button type=\"button\" class=\"button button-close submit refuse-request\"\n" +
                "                                    data-dismiss=\"modal\" value=\"" + r.getId() + "\"> Từ chối\n" +
                "                            </button>\n" +
                "                            <button type=\"button\" class=\"button button-save confirm-request submit\" value=\"" + r.getId() + "\">\n" +
                "                                Chấp nhận\n" +
                "                            </button>\n" +
                "                        </div>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
