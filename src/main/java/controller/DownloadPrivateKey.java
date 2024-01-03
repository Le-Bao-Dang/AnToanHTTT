package controller;

import services.KeyServices;
import services.MailService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.PrivateKey;
import java.security.spec.PKCS8EncodedKeySpec;

@WebServlet(name = "DownloadPrivateKey", value = "/downloadPrivateKey")
public class DownloadPrivateKey extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        KeyServices ks = new KeyServices();
        ks.createKey();
        int cuser = (int) request.getAttribute("cuser");
        String email = (String) request.getAttribute("email");
        ks.addPublicKey(cuser);
        File file = new File("");
        String fileName = cuser+"privatekey.pem";

        String privateKeyFilePath = file.getAbsolutePath()+"\\"+fileName;

        File privateKeyFile = createKeyFile(new File(fileName));
        try (FileOutputStream fos = new FileOutputStream(privateKeyFile)) {
            PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(ks.exportPrivateKey().getEncoded());

            fos.write(pkcs8EncodedKeySpec.getEncoded());
            fos.flush();
            fos.close();
            // Gửi key mới qua mail
            MailService.sendPrivateKeyEmail("PrivateKey của bạn", privateKeyFile.getAbsolutePath(),cuser,email,"Đây là khóa private key của bạn," +
                    " được khởi tạo để bạn có thể sử dụng để xác minh đơn hàng cũng như là thanh toán đơn hàng là chính chủ của bạn: ");
            if(privateKeyFile.exists()) privateKeyFile.delete();
        } catch (Exception e){
            e.printStackTrace();
            request.setAttribute("error", "Lỗi gửi file khóa private về mail!");
            request.getRequestDispatcher("sign-up.jsp").forward(request, response);
        }
//        savePrivateKeyToFile(ks.exportPrivateKey(), privateKeyFilePath);
//
//        response.setContentType("application/octet-stream");
//        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
//
//        // Đọc nội dung của tệp Private Key và gửi nó dưới dạng phản hồi HTTP
//        try (InputStream inputStream = new FileInputStream(privateKeyFilePath);
//             OutputStream outputStream = response.getOutputStream()) {
//            byte[] buffer = new byte[4096];
//            int bytesRead;
//            while ((bytesRead = inputStream.read(buffer)) != -1) {
//                outputStream.write(buffer, 0, bytesRead);
//            }
//
//        } catch (IOException e) {
//            e.printStackTrace();
//            // Xử lý lỗi nếu cần thiết
//        }
//        File pf = new File(fileName);
//        if (pf.exists()) pf.delete();
        request.setAttribute("error", "Đăng ký thành công, mời bạn đăng nhập!");
        request.getRequestDispatcher("sign-up.jsp").forward(request, response);
    }
//    private void savePrivateKeyToFile(PrivateKey privateKey, String filePath) throws IOException {
//        PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(privateKey.getEncoded());
//        // Lưu private key vào file
//        try (FileOutputStream fos = new FileOutputStream(filePath)) {
//            fos.write(pkcs8EncodedKeySpec.getEncoded());
//            fos.flush();
//            fos.close();
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//
//    }
    private File createKeyFile(File file) throws IOException {
        if (!file.exists()) {
            file.createNewFile();
        } else file.delete();
        file.createNewFile();
        return file;
    }
}
