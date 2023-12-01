package services;

import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class RSAKeyServices {

    private static String name = "RSA/ECB/PKCS1Padding";
    private static String keyName = "RSA";
    private static int bits = 2048;
    private PublicKey publicKey ;
    private PrivateKey privateKey;
    public RSAKeyServices() {
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
    public boolean checkPrivateKeyValid(String privateKeyBase64){
        try {
            byte[] privateKeyBytes = Base64.getDecoder().decode(privateKeyBase64);
            KeyFactory keyFactory = KeyFactory.getInstance(keyName);
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKeyBytes);
            PrivateKey privateKey = keyFactory.generatePrivate(keySpec);

            // Check key size
            this.privateKey = privateKey;
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}

