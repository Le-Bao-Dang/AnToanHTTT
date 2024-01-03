package bean;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

public class IPConnect {
    public static String getIpWlanConnect() {
        String ip = null;
        try {
            URL url = new URL("https://checkip.amazonaws.com/");
            BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
            ip = br.readLine();
        } catch (Exception e) {
        }
        return ip;
    }
}
