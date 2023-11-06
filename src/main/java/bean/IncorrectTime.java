package bean;

import java.io.Serializable;
import java.time.LocalDateTime;

public class IncorrectTime implements Serializable {
    private int id;
    private User user;
    private int incorrectTimes;
    private String type;
    private LocalDateTime lockedUntil;

    public IncorrectTime() {
    }

    public IncorrectTime(int id, User user, int incorrectTimes, String type, LocalDateTime lockedUntil) {
        this.id = id;
        this.user = user;
        this.incorrectTimes = incorrectTimes;
        this.type = type;
        this.lockedUntil = lockedUntil;
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

    public int getIncorrectTimes() {
        return incorrectTimes;
    }

    public void setIncorrectTimes(int incorrectTimes) {
        this.incorrectTimes = incorrectTimes;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public LocalDateTime getLockedUntil() {
        return lockedUntil;
    }

    public void setLockedUntil(LocalDateTime lockedUntil) {
        this.lockedUntil = lockedUntil;
    }

    @Override
    public String toString() {
        return "IncorrectTime{" +
                "id=" + id +
                ", user=" + user +
                ", incorrectTimes=" + incorrectTimes +
                ", type='" + type + '\'' +
                ", lockedUntil=" + lockedUntil +
                '}';
    }
}
