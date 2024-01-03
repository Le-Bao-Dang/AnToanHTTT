package services;


import bean.Key;
import bean.Order;
import db.JDBIConnector;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;


public class KeyServices {

    private static String name = "RSA/ECB/PKCS1Padding";
    private static String keyName = "RSA";
    private static int bits = 2048;
    private PublicKey publicKey;
    private PrivateKey privateKey;

    public static KeyServices instance;

    public KeyServices() {

        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());

    }

    public static KeyServices getInstance() {
        if (instance == null) {
            instance = new KeyServices();
        }
        return instance;
    }

    public void createKey() {
        try {
            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(keyName);
            keyPairGenerator.initialize(bits); // Độ dài khóa 2048 bit
            KeyPair keyPair = keyPairGenerator.generateKeyPair();
            // Lấy khóa công khai và khóa bí mật từ cặp khóa
            this.publicKey = keyPair.getPublic();
            this.privateKey = keyPair.getPrivate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String exportStringPublicKey() {
        byte[] keyBytes = exportPublicKey().getEncoded();
        String base64Key = Base64.getEncoder().encodeToString(keyBytes);
        return base64Key;
    }

    public String exportStringPrivateKey() {
        byte[] keyBytes = exportPrivateKey().getEncoded();
        String base64Key = Base64.getEncoder().encodeToString(keyBytes);
        return base64Key;
    }

    public PublicKey exportPublicKey() {
        return this.publicKey;
    }

    public PrivateKey exportPrivateKey() {
        return this.privateKey;
    }

    public boolean checkPublicKeyValid(String publicKeyBase64) {
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


    public void addPublicKey(int userid) {
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("insert into `keys`( user_id,public_key_base64 ,status ) values(?,?,?) ")
                        .bind(0, userid)
                        .bind(1, exportStringPublicKey())
                        .bind(2, 0)
                        .execute());
        //   savePrivateKeyToFile(exportPrivateKey(),System.getProperty("user.home") + "/Downloads/"+userid+"_private_key.pem");
    }

    //    public void savePrivateKeyToFile(PrivateKey privateKey, String fileName) {
//        // Chuyển đổi private key sang định dạng PKCS#8
//        PKCS8EncodedKeySpec pkcs8EncodedKeySpec = new PKCS8EncodedKeySpec(privateKey.getEncoded());
//
//        // Lưu private key vào file
//        try (FileOutputStream fos = new FileOutputStream(fileName)) {
//            fos.write(pkcs8EncodedKeySpec.getEncoded());
//        }catch (Exception e){
//            e.printStackTrace();
//        }
//
//        System.out.println("Private key đã được lưu vào file: " + fileName);
//    }
    public void lockKeyforUser(int idKey) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `keys` SET status = -1, locked_date = ? WHERE user_id = ? AND status = 0\n")
                    .bind(0, LocalDateTime.now())
                    .bind(1, idKey).execute();
        });
    }

    public boolean readPrivateKeyFromFile(String filePath) {
        // Đọc nội dung của file vào mảng byte
        try {
            byte[] keyBytes = Files.readAllBytes(Paths.get(filePath));

            // Chuyển đổi mảng byte thành đối tượng PrivateKey
            KeyFactory keyFactory = KeyFactory.getInstance(keyName);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(keyBytes);
            this.privateKey = keyFactory.generatePrivate(keySpec);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Khóa private không hợp lệ");
            return false;
        }
    }

    public boolean readPublicKeyFromDatabase(int userId) {
        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
        try {
            List<String> base64PublicKeys = JDBIConnector.get().withHandle(handle -> {
                return handle.createQuery("SELECT public_key_base64 FROM `keys` WHERE user_id = :userId AND status = 0")
                        .bind("userId", userId)
                        .mapTo(String.class)
                        .list();
            });

            if (base64PublicKeys.isEmpty()) {
                System.out.println("Khóa public không tồn tại");
                return false;
            }

            if (checkPublicKeyValid(base64PublicKeys.get(0))) {
                System.out.println("Khóa public thành công");
                return true;
            } else {
                System.out.println("Khóa public không hợp lệ");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Khóa public không hợp lệ");
            return false;
        }
    }
    public boolean checkPublicKeyWithOrderCreate(Order o, int user_id){
        Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
        try {
            List<Key> base64PublicKeys = JDBIConnector.get().withHandle(handle -> {
                return handle.createQuery("SELECT * FROM `keys` WHERE user_id = :userId AND status = -1 ORDER BY locked_date DESC ")
                        .bind("userId", user_id)
                        .mapToBean(Key.class)
                        .stream().collect(Collectors.toList());
            });
            int count = 0;
            Key newKey = new Key();
            for (Key k: base64PublicKeys) {
                if (k.getLocked_date() != null){
                  int date= o.getCreateDate().compareTo(k.getLocked_date());
//                    System.out.println(date);
                  if (date < 0){
                      count ++;
                      newKey  = k;

                  }
                }
            }
            if (count ==0){
                return readPublicKeyFromDatabase(user_id);
            }else{
                if (checkPublicKeyValid(newKey.getPublic_key_base64())) {
                    System.out.println("Khóa public thành công");
                    return true;
                }else{
                    System.out.println("Khóa public không hợp lệ");
                    return false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi đọc khóa public");
            return false;

        }

    }

    public static void main(String[] args) {
//        Order order = OrderService.getInstance().getOrderByOrderId(32);
//        order = FormatOrder.getInstance().format(order);
//        KeyServices ks = new KeyServices();
//        ks.publicKeyWithOrderCreate(order,17);
//        System.out.println(ks.exportStringPublicKey());
    }


}

