package controller.admins;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Collection;

@WebServlet(name = "UploadImageBanner", value = "/admins/uploadImageBanner")
@MultipartConfig(
        location = "E:\\LTWeb\\project\\Project\\src\\main\\webapp\\images\\image-banner",
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 101
)
public class UploadImageBanner extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {

            Part  part= request.getPart("img-banner");
            part.write(getFileName(part));

        } catch (Exception e) {

        }
        response.sendRedirect("/generalManager");
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");

        if (!contentDisposition.contains("filename=")) {
            return null;
        }
        int begin = contentDisposition.indexOf("filename=") + 10;
        int end = contentDisposition.length() - 1;
        return contentDisposition.substring(begin, end);

    }


}

