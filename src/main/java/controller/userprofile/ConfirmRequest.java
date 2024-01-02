package controller.userprofile;

import bean.Request;

import jakarta.activation.*;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import services.KeyServices;
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
        // Khóa key hiện tại


        // Tạo key mới
        KeyServices ks = new KeyServices();

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
        sendEmail("PrivateKey mới", privateKeyFile.getAbsolutePath(), r.getUser().getEmail());
        privateKeyFile.delete();
        RequestService.getInstance().setStatus(r.getId(), 1);
        response.sendRedirect("/userManager");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    public static  void sendEmail(String from, String path, String send) {
        final String username = "20130010@st.hcmuaf.edu.vn";
        final String password = "lnuariqpmwocsadl";

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

        Session session = Session.getInstance(prop,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(send)
            );
            message.setSubject(from);
            Multipart multipart = new MimeMultipart();
            BodyPart bodyPart = new MimeBodyPart();
            bodyPart.setText("Yêu cầu bảo mật của bạn đã được chấp nhận với chữ ký mới của bạn: ");
            multipart.addBodyPart(bodyPart);
            bodyPart = new MimeBodyPart();
            DataSource source =  new FileDataSource(path);
            bodyPart.setDataHandler(new DataHandler( source));
            bodyPart.setFileName(path);
            multipart.addBodyPart(bodyPart);


            message.setContent(multipart);
            Transport.send(message);
            System.out.println("Done");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
    private File createKeyFile(File file) throws IOException {
        if (!file.exists()) {
            file.createNewFile();
        } else file.delete();
        file.createNewFile();
        return file;
    }

}
