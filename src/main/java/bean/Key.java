package bean;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Key implements Serializable {
    private int id;
    private int user_id;
    private String public_key_base64 ;
    private LocalDateTime locked_date;
    private int status;

    public Key() {

    }

    public Key(int id, int user_id, String public_key_base64, LocalDateTime locked_date, int status) {
        this.id = id;
        this.user_id = user_id;
        this.public_key_base64 = public_key_base64;
        this.locked_date = locked_date;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getPublic_key_base64() {
        return public_key_base64;
    }

    public void setPublic_key_base64(String public_key_base64) {
        this.public_key_base64 = public_key_base64;
    }

    public LocalDateTime getLocked_date() {
        return locked_date;
    }

    public void setLocked_date(LocalDateTime locked_date) {
        this.locked_date = locked_date;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Key{" +
                "id=" + id +
                ", user_id=" + user_id +
                ", public_key_base64='" + public_key_base64 + '\'' +
                ", locked_date=" + locked_date +
                ", status=" + status +
                '}';
    }
}
