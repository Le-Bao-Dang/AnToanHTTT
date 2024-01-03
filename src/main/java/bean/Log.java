package bean;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Log implements Serializable {

    public static final int DEBUG = 1;
    public static final int INFO = 2;
    public static final int WARN = 3;
    public static final int ERROR = 4;
    public static final int FATAL = 5;
    private int id;
    private String ip;
    private User user;
    private int severityLevel;
    private String event;
    private LocalDateTime createDate;
    private String description;


    public Log() {
        this.ip = IPConnect.getIpWlanConnect();
        this.createDate = LocalDateTime.now();
    }

    public Log(int id, String ip, User user, int severityLevel, String event, LocalDateTime createDate, String description) {
        this.id = id;
        this.ip = ip;
        this.user = user;
        this.severityLevel = severityLevel;
        this.event = event;
        this.createDate = createDate;
        this.description = description;
    }

    public Log(String ip, User user, int severityLevel, String event, LocalDateTime createDate, String description) {
        this.ip = ip;
        this.user = user;
        this.severityLevel = severityLevel;
        this.event = event;
        this.createDate = createDate;
        this.description = description;
    }

    @Override
    public String toString() {
        return "Log{" +
                "id=" + id +
                ", ip='" + ip + '\'' +
                ", user=" + user +
                ", severityLevel=" + severityLevel +
                ", event='" + event + '\'' +
                ", createDate=" + createDate +
                ", description='" + description + '\'' +
                '}';
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

    public int getSeverityLevel() {
        return severityLevel;
    }

    public void setSeverityLevel(int severityLevel) {
        this.severityLevel = severityLevel;
    }

    public String getEvent() {
        return event;
    }

    public void setEvent(String event) {
        this.event = event;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
