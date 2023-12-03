package controller;

import services.KeyServices;

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
        ks.addPublicKey(cuser);
        File file = new File("");
        String fileName = cuser+"privatekey.pem";

        String privateKeyFilePath = file.getAbsolutePath()+"\\"+fileName;
        savePrivateKeyToFile(ks.exportPrivateKey(), privateKeyFilePath);

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        // Đọc nội dung của tệp Private Key và gửi nó dưới dạng phản hồi HTTP
        try (InputStream inputStream = new FileInputStream(privateKeyFilePath);
             OutputStream outputStream = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

        } catch (IOException e) {
            e.printStackTrace();
            // Xử lý lỗi nếu cần thiết
        }
        File pf = new File(fileName);
        if (pf.exists()) pf.delete();
        request.setAttribute("error", "Đăng ký thành công, mời bạn đăng nhập!");
        request.getRequestDispatcher("sign-up.jsp").forward(request, response);
    }
    private void savePrivateKeyToFile(PrivateKey privateKey, String filePath) throws IOException {
//        Path path = Paths.get(filePath);
//        Files.createDirectories(path.getParent());
//        try (FileWriter writer = new FileWriter(filePath)) {
//            writer.write(privateKey);
//        }
        PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(privateKey.getEncoded());

        // Lưu private key vào file
        try (FileOutputStream fos = new FileOutputStream(filePath)) {
            fos.write(pkcs8EncodedKeySpec.getEncoded());
            fos.flush();
        }catch (Exception e){
            e.printStackTrace();
        }

//        System.out.println("Private key đã được lưu vào file: " + fileName);
    }
}
