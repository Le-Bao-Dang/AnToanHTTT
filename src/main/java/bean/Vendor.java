package bean;

import java.io.Serializable;

public class Vendor implements Serializable {
    private int id;
    private String email;
    private Information information;
    private String website;
    private int status;
    static final int DangHopTac = 0;
    static final int NgungHopTac = 1;

    public Vendor() {
    }

    public Vendor(int id, String email, Information information, String website, int status) {
        this.id = id;
        this.email = email;
        this.information = information;
        this.website = website;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Information getInformation() {
        return information;
    }

    public void setInformation(Information information) {
        this.information = information;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatusNow() {
        if (this.status == NgungHopTac)
            return "Ngưng hợp tác";
        return "Đang Hợp tác";
    }

    ;

    @Override
    public String toString() {
        return "Vendor{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", information=" + information +
                ", website='" + website + '\'' +
                ", status=" + status +
                '}';
    }
}
