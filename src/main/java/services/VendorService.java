package services;

import bean.Address;
import bean.Information;
import bean.Vendor;
import db.JDBIConnector;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class VendorService {
    private static VendorService instance;

    private VendorService() {

    }

    public static VendorService getInstance() {
        if (instance == null) {
            instance = new VendorService();
        }
        return instance;
    }

    //    Lay ra danh sach nha cung cap
    public List<Vendor> getListVendor() {
        return JDBIConnector.get().withHandle(handle -> {
                    List<Vendor> list = handle.createQuery("SELECT id, email, information_id, website, status from vendor").mapToBean(Vendor.class).stream().collect(Collectors.toList());
                    for (Vendor vendor : list) {
                        vendor.setInformation(InformationService.getInstance().getInformationByVendorId(vendor.getId()));
                    }
                    return list;
                }
        );
    }
//   Lay ra nha cung cap theo id

    public Vendor getVendorbyId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            Vendor vendor = handle.createQuery("SELECT  id, email, information_id,website, status from `vendor` where id =" + id).mapToBean(Vendor.class).one();
            vendor.setInformation(InformationService.getInstance().getInformationByVendorId(vendor.getId()));
            return vendor;
        });
    }

    //  Lay ra id lon nhat
    public int getVendorMaxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as maxnumber from `vendor`").mapTo(Integer.class).one();
        });
    }

    // Kiem tra nha cung cap co trung voi nha cung cap khac hay khong
    public boolean checkVendorBoth(Vendor vendor) {
        for (Vendor v : getListVendor()) {
            if (vendor.getEmail().equals(v.getEmail()) || vendor.getWebsite().equals(v.getWebsite()) ||
                    vendor.getInformation().getName().equals(v.getInformation().getName()) ||
                    vendor.getInformation().getPhone().equals(v.getInformation().getPhone()) ||
                    (vendor.getInformation().getAddress().getCity().equals(v.getInformation().getAddress().getCity()) &&
                            vendor.getInformation().getAddress().getDistrict().equals(v.getInformation().getAddress().getDistrict()) &&
                            vendor.getInformation().getAddress().getDetail().equals(v.getInformation().getAddress().getDetail()))) {
                return false;
            }
        }
        return true;
    }

    //    Them nha cung cap moi
    public boolean addVendor(Vendor vendor) {
        if (checkVendorBoth(vendor)) {
            InformationService.getInstance().addNewInformation(vendor.getInformation());
            vendor.getInformation().setId(InformationService.getInstance().maxId());
            JDBIConnector.get().withHandle(handle -> {
                return handle.createUpdate("INSERT INTO `vendor`(id, email, information_id, website, status) values (:id, :email,:information_id,:website,:status)")
                        .bind("id", VendorService.getInstance().getVendorMaxId() + 1)
                        .bind("email", vendor.getEmail())
                        .bind("information_id", vendor.getInformation().getId())
                        .bind("website", vendor.getWebsite())
                        .bind("status", vendor.getStatus())
                        .execute();
            });


            return true;
        }
        return false;
    }

    //    Thay doi thong tin nha cung cap
    public void editVendor(Vendor vendor) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `vendor` set email=?, website=?, status=? where id=?")
                    .bind(0, vendor.getEmail())
                    .bind(1, vendor.getWebsite())
                    .bind(2, vendor.getStatus())
                    .execute();
        });

    }

    public void deleteVendor(Vendor vendor) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `vendor` set status=? where id=?")
                    .bind(0, vendor.getStatus())
                    .bind(1, vendor.getId())
                    .execute();
        });

    }

    public List<Vendor> searchByAll(String text) {
        List<Vendor> listVendors = new ArrayList<>();
        for (Vendor vendor : getListVendor()) {
            if (vendor.getInformation().getName().toUpperCase().contains(text.toUpperCase()) || vendor.getInformation().getPhone().contains(text)
                    || vendor.getEmail().contains(text) || vendor.getWebsite().contains(text)) {
                listVendors.add(vendor);
            }
        }
        return listVendors;
    }

    public Vendor getVendorbyImportId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            Vendor vendor = handle.createQuery("SELECT  v.id, v.email, v.information_id, v.website, v.status from `vendor` v join import i on v.id = i.vendor_id where i.id =" + id).mapToBean(Vendor.class).one();
            vendor.setInformation(InformationService.getInstance().getInformationByVendorId(vendor.getId()));
            return vendor;
        });
    }

    public static void main(String[] args) {
        Address address = new Address("Phu Lam", "Phu Tan", "An Giang", "0", 1, 1);
        Information information = new Information(0, "Go Hoang Gia Anh", "0128878957", address, 0);
        Vendor vendor = new Vendor(0, "gohoanggiaanh@gmail.com", information, "google.com", 0);

        System.out.println(VendorService.getInstance().searchByAll("Mộc"));
    }


}
