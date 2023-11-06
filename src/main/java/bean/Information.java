package bean;

import java.io.Serializable;

public class Information implements Serializable {
    private int id;
    private String name;
    private String phone;
    private Address address;
    private int status;

    public Information() {
    }

    public Information(int id, String name, String phone, Address address, int status) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.status = status;
    }

    public Information(String name, String phone, Address address, int status) {
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.status = status;
    }

    public Information(String name, String phone, Address address) {
        this.name = name;
        this.phone = phone;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Information{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", phone='" + phone + '\'' +
                ", address=" + address +
                ", status=" + status +
                '}';
    }
}
