package controller.userprofile;

import bean.User;
import services.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;


@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
@WebServlet(name = "EditAvatarUser", value = "/userprofile/editAvatarUser")
public class EditAvatarUser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "images/user-avatar";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
        User user = (User) request.getSession().getAttribute("auth");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        Part filePart = request.getPart("imageUpload");
        String fileName = getFileName(filePart);
        filePart.write(uploadPath + File.separator + fileName);
        filePart.write("D:\\Git\\Project\\src\\main\\webapp\\images\\user-avatar\\" + fileName);
        String imageUrl = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
//        user.setAvatar(imageUrl);
        UserService.getInstance().editAvatar(user, imageUrl);

        response.getWriter().write(imageUrl);
    }

    private String getFileName(Part part) {
        String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
