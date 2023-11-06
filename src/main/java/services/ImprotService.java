package services;

import bean.*;
import db.JDBIConnector;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ImprotService {
    public static ImprotService instance;

    public ImprotService() {

    }

    public static ImprotService getInstance() {
        if (instance == null) {
            instance = new ImprotService();
        }
        return instance;
    }

    public List<Import> getListImport() { // Lấy ra danh sách nhập hàng
        return JDBIConnector.get().withHandle(handle -> {
            List<Import> list = handle.createQuery("select id , create_date, user_import_id, note, status from import").mapToBean(Import.class).stream().collect(Collectors.toList());
            for (Import anImport : list) {
                anImport.setVendor(VendorService.getInstance().getVendorbyImportId(anImport.getId()));
                anImport.setListLineItem(LineItemImportService.getInstance().getListProductImportByImportId(anImport.getId()));
                anImport.setUserImport(UserService.getInstance().getUserByImportId(anImport.getId()));
            }
            return list;
        });
    }

    public Import getImportByImportId(int id) { // Lấy ra hóa đơn nhập hàng
        return JDBIConnector.get().withHandle(handle -> {
            Import anImport = handle.createQuery("select id, create_date, user_import_id, note, status from import where id =" + id).mapToBean(Import.class).one();
            anImport.setVendor(VendorService.getInstance().getVendorbyImportId(anImport.getId()));
            anImport.setListLineItem(LineItemImportService.getInstance().getListProductImportByImportId(anImport.getId()));
            anImport.setUserImport(UserService.getInstance().getUserByImportId(anImport.getId()));
            return anImport;
        });
    }

    public void addImport(Import anImport) { // Thêm thông tin nhập hàng
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO import(id, vendor_id, create_date, user_import_id, note, status) values (:id, :vendor_id,:create_date, :user_import_id, :note, :status)")
                    .bind("id", getInstance().maxId() + 1)
                    .bind("vendor_id", anImport.getVendor().getId())
                    .bind("create_date", anImport.getCreateDate())
                    .bind("user_import_id", anImport.getUserImport().getId())
                    .bind("note", anImport.getNote())
                    .bind("status", 0)
                    .execute();
        });

    }

    public void addImportAll(Import anImport) {
        anImport.setId(getInstance().maxId() + 1);
        addImport(anImport);
        for (LineItemImport lineItemImport : anImport.getListLineItem()) {
            LineItemImportService.getInstance().addImportProduct(lineItemImport);
        }

    }

    public boolean editStatusImport(int status, int id) { // Chỉnh sửa trạng thái đơn nhập hàng
        Import anImport = getImportByImportId(id);
        if (status > anImport.getStatus()) {
            JDBIConnector.get().withHandle(handle -> {
                return handle.createUpdate("UPDATE import set status =? where id = " + id).bind(0, status).execute();
            });
            return true;
        }
        return false;

    }

    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select MAX(id) as maxnumberid from import ").mapTo(Integer.class).one();
        });
    }

    public List<Import> getImportByProductImportId(int id) { // Lấy ra danh sách hóa đơn có chứa sản phẩm
        return JDBIConnector.get().withHandle(handle -> {
            List<Import> list = handle.createQuery("select i.id, i.create_date, i.user_import_id, i.note, i.status from import i join product_import pi on i.id = pi.import_id where pi.id =" + id).mapToBean(Import.class).stream().collect(Collectors.toList());
            for (Import anImport : list) {
                anImport.setVendor(VendorService.getInstance().getVendorbyImportId(anImport.getId()));
                anImport.setListLineItem(LineItemImportService.getInstance().getListProductImportByImportId(anImport.getId()));
                anImport.setUserImport(UserService.getInstance().getUserByImportId(anImport.getId()));
            }
            return list;
        });
    }

    public static void main(String[] args) {
    }
}
