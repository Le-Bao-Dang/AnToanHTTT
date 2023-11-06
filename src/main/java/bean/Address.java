package bean;

import java.io.Serializable;

public class Address implements Serializable {
    private String detail;
    private String district;
    private String city;

    private String wardId;
    private int districtId;
    private int provinceId;

    public Address() {
    }

    public Address(String detail, String district, String city) {
        this.detail = detail;
        this.district = district;
        this.city = city;
    }

    public Address(String detail, String district, String city, String wardId, int districtId, int provinceId) {
        this.detail = detail;
        this.district = district;
        this.city = city;
        this.wardId = wardId;
        this.districtId = districtId;
        this.provinceId = provinceId;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getWardId() {
        return wardId;
    }

    public void setWardId(String wardId) {
        this.wardId = wardId;
    }

    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    public int getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(int provinceId) {
        this.provinceId = provinceId;
    }

    @Override
    public String toString() {
        return "Address{" +
                ", detail='" + detail + '\'' +
                ", district='" + district + '\'' +
                ", city=" + city +
                '}';
    }

    public String formatAddress() {
        return getDetail() + ", " + getDistrict() + ", " + getCity() + ".";
    }
}
