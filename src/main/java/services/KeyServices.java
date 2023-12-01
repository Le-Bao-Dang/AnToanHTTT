package services;

import bean.Review;
import db.JDBIConnector;

import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

public class KeyServices {

    private static String name = "RSA/ECB/PKCS1Padding";
    private static String keyName = "RSA";
    private static int bits = 2048;
    private PublicKey publicKey ;
    private PrivateKey privateKey;
    public KeyServices() {

        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());

    }

    public void createKey(){
        try{
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(keyName);
            keyPairGenerator.initialize(bits); // Độ dài khóa 2048 bit
            KeyPair keyPair = keyPairGenerator.generateKeyPair();
            // Lấy khóa công khai và khóa bí mật từ cặp khóa
            this.publicKey = keyPair.getPublic();
            this.privateKey = keyPair.getPrivate();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public String exportStringPublicKey()
    {
        byte[] keyBytes = exportPublicKey().getEncoded();
        String base64Key = Base64.getEncoder().encodeToString(keyBytes);
        return base64Key;
    }
    public String exportStringPrivateKey()
    {
        byte[] keyBytes = exportPrivateKey().getEncoded();
        String base64Key = Base64.getEncoder().encodeToString(keyBytes);
        return base64Key;
    }
    public PublicKey exportPublicKey(){
        return this.publicKey;
    }
    public PrivateKey exportPrivateKey(){
        return this.privateKey;
    }
    public boolean checkPublicKeyValid(String publicKeyBase64){
        try {
            byte[] publicKeyBytes = Base64.getDecoder().decode(publicKeyBase64);
            KeyFactory keyFactory = KeyFactory.getInstance(keyName);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(publicKeyBytes);
            PublicKey publicKey = keyFactory.generatePublic(keySpec);
            // Check key size
            this.publicKey = publicKey;
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    public void create(int userid){
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("insert into `keys`( user_id,public_key_base64 ,status ) values(?,?,?) ")
                        .bind(0,userid)
                        .bind(1,exportStringPublicKey())
                        .bind(2,0)
                        .execute());
        savePrivateKeyToFile(exportPrivateKey(),System.getProperty("user.home") + "/Downloads/"+userid+"_private_key.pem");
    }
    private void savePrivateKeyToFile(PrivateKey privateKey, String fileName) {
        // Chuyển đổi private key sang định dạng PKCS#8
        PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(privateKey.getEncoded());

        // Lưu private key vào file
        try (FileOutputStream fos = new FileOutputStream(fileName)) {
            fos.write(pkcs8EncodedKeySpec.getEncoded());
        }catch (Exception e){
            e.printStackTrace();
        }

        System.out.println("Private key đã được lưu vào file: " + fileName);
    }
    private  boolean readPrivateKeyFromFile(String filePath)  {
        // Đọc nội dung của file vào mảng byte
        try{
            byte[] keyBytes = Files.readAllBytes(Paths.get(filePath));

            // Chuyển đổi mảng byte thành đối tượng PrivateKey
            KeyFactory keyFactory = KeyFactory.getInstance(keyName);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
            this.privateKey = keyFactory.generatePrivate(keySpec);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("Khóa private không hợp lệ");
            return false;
        }
    }
    private  boolean readPublicKeyFromDatabase(int userId)  {
        // Đọc nội dung của file vào mảng byte
        try{
            List<String> base64PublicKeys = JDBIConnector.get().withHandle(handle -> {
                return handle.createQuery("SELECT public_key_base64 FROM `keys` WHERE user_id = :userId AND status = 0")
                        .bind("userId", userId)
                        .mapTo(String.class)
                        .list();
            });
            if (base64PublicKeys.size() != 0) return false;
            checkPublicKeyValid(base64PublicKeys.get(0));
            return true;
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("Khóa public không hợp lệ");
            return false;
        }
    }

}

