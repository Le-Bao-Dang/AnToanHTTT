package controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;

@WebServlet(name = "FileUpload", value = "/uploadfile")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class FileUpload extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /* Receive file uploaded to the Servlet from the HTML5 form */
        File file = new File("");
        Part filePart = request.getPart("file");
        String fileName = filePart.getSubmittedFileName();
        for (Part part : request.getParts()) {
            part.write(file.getAbsolutePath()+"\\" + fileName);
        }
        System.out.println(file.getAbsolutePath()+"\\" + fileName);
    }
}
