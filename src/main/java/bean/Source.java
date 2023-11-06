package bean;

import java.io.Serializable;

public class Source implements Serializable {
    private int id;
    private String ip;
    private User user;

    public Source() {
    }

    public Source(int id, String ip, User user) {
        this.id = id;
        this.ip = ip;
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Source{" +
                "id=" + id +
                ", ip='" + ip + '\'' +
                ", user=" + user +
                '}';
    }
}
