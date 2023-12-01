package services;

import bean.Order;

import java.security.*;
import java.util.Base64;

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
//        String orderInfo = order.toString();
//        try {
//            Signature signature = Signature.getInstance(Name, "BC");
//            signature.initSign(privateKey, new SecureRandom());
//            // Cập nhật dữ liệu để ký
//            signature.update(orderInfo.getBytes());
//
//            // Tạo chữ ký điện tử
//            byte[] digitalSignature = signature.sign();
//            String base64OrderData = Base64.getEncoder().encodeToString(digitalSignature);
//            // In ra chữ ký điện tử
//            System.out.println("Digital Signature: " + base64OrderData);
//            return base64OrderData;
//        }catch (Exception e){
//            e.printStackTrace();
//            return null;
//        }
        return false;
    }
}
