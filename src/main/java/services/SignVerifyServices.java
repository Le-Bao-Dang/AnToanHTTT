package services;

import bean.Order;
import db.JDBIConnector;

import java.security.*;
import java.util.Base64;
import java.util.List;

public class SignVerifyServices {
    private static SignVerifyServices instance;
    private static String Name = "SHA256withRSA";

    private SignVerifyServices() {
        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
    }

    public static SignVerifyServices getInstance() {
        if (instance == null) {
            instance = new SignVerifyServices();
        }
        return instance;
    }

    public String signOrder(Order order, PrivateKey privateKey){
        String orderInfo = order.toString();
        try {
            Signature signature = Signature.getInstance(Name, "BC");
            signature.initSign(privateKey, new SecureRandom());
            // Cập nhật dữ liệu để ký
            signature.update(orderInfo.getBytes());

            // Tạo chữ ký điện tử
            byte[] digitalSignature = signature.sign();
            String base64OrderData = Base64.getEncoder().encodeToString(digitalSignature);
            // In ra chữ ký điện tử
            System.out.println("Digital Signature: " + base64OrderData);
            return base64OrderData;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }
    public boolean verifyOrder(Order order, PublicKey publicKey){
        String orderInfo = order.toString();
        try {
            List<String> base64Signatures = JDBIConnector.get().withHandle(handle -> {
                return handle.createQuery("SELECT signature_base64 FROM `order_signatures` WHERE order_id = :orderID AND status = 0")
                        .bind("orderID", order.getId())
                        .mapTo(String.class)
                        .list();
            });
            if (base64Signatures.size() != 0) return false;
            byte[] orderSignatureInfo = Base64.getDecoder().decode(base64Signatures.get(0));

            Signature signature = Signature.getInstance(Name, "BC");
            signature.initVerify(publicKey);

            // Cập nhật dữ liệu để xác minh
            signature.update(orderInfo.getBytes());
            boolean isValid = signature.verify(orderSignatureInfo);

            if (isValid) {
                System.out.println("Đơn hàng không bị thay đổi.");
                return true;
            } else {
                System.out.println("Đơn hàng có thể đã bị thay đổi.");
                return false;
                // Thực hiện các biện pháp khẩn cấp, ví dụ như hủy đơn hàng hoặc thông báo người mua.
            }
        }catch (Exception e){
            e.printStackTrace();

            return false;
        }

    }
}
