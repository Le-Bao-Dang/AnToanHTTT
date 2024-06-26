package controller.userprofile;

import bean.Request;

import jakarta.activation.*;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import services.KeyServices;
import services.MailService;
import services.RequestService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Properties;

@WebServlet(name = "ConfirmRequest", value = "/userprofile/confirmRequest")
public class ConfirmRequest extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int i = Integer.parseInt(request.getParameter("i"));
        int rId = Integer.parseInt(request.getParameter("id"));
        Request r = RequestService.getInstance().getRequestById(rId);
        if (i == -1) {
            RequestService.getInstance().setStatus(rId, -1);
            response.sendRedirect("/userManager");
        }



        // Tạo key mới
        KeyServices ks = new KeyServices();
        // Khóa key hiện tại
        KeyServices.getInstance().lockKeyforUser(r.getUser().getId());
        System.out.println("đã khóa key");

        ks.createKey();
        ks.addPublicKey(r.getUser().getId());
        System.out.println("đã thêm key mới");
        // Lưu key mới vào file
        File privateKeyFile = createKeyFile(new File(r.getUser().getId() + "privatekey.pem"));
        FileOutputStream fos = new FileOutputStream(privateKeyFile);
        PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(ks.exportPrivateKey().getEncoded());
        fos.write(pkcs8EncodedKeySpec.getEncoded());
        fos.flush();
        fos.close();
        // Gửi key mới qua mail
        MailService.sendPrivateKeyEmail("PrivateKey mới", privateKeyFile.getAbsolutePath(), r.getUser().getId(), r.getUser().getEmail(),"Yêu cầu bảo mật của bạn đã được chấp nhận với chữ ký mới của bạn: ");
        privateKeyFile.delete();
        RequestService.getInstance().setStatus(r.getId(), 1);
        response.sendRedirect("/securityRequestManager");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    private File createKeyFile(File file) throws IOException {
        if (!file.exists()) {
            file.createNewFile();
        } else file.delete();
        file.createNewFile();
        return file;
    }

}
