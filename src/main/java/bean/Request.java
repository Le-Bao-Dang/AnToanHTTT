package bean;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Request implements Serializable {
    private int id;
    private User user;
    private LocalDateTime create_at;
    private LocalDateTime confirm_at;
    private String note;
    private int status;

    public Request() {

    }

    public Request(int id, User user, LocalDateTime create_at, LocalDateTime confirm_at, String note, int status) {
        this.id = id;
        this.user = user;
        this.create_at = create_at;
        this.confirm_at = confirm_at;
        this.note = note;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getCreate_at() {
        return create_at;
    }


    public void setCreate_at(LocalDateTime create_at) {
        this.create_at = create_at;
    }

    public LocalDateTime getConfirm_at() {
        return confirm_at;
    }

    public void setConfirm_at(LocalDateTime confirm_at) {
        this.confirm_at = confirm_at;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getStatus() {
        return status;
    }
    public String getStatusString(){
        if(status ==0){
            return "Đang duyệt";
        }
        if(status == -1){
            return "Không được duyệt";
        }
        if(status == 1){
            return "Đã duyệt";
        }
        return "";
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Request{" +
                "id=" + id +
                ", user=" + user +
                ", create_at=" + create_at +
                ", confim_at=" + confirm_at +
                ", note='" + note + '\'' +
                ", status=" + status +
                '}';
    }
}
