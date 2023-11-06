package services;

import bean.Information;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;


public class InformationService {
    private static InformationService instance;

    private InformationService() {

    }

    public static InformationService getInstance() {
        if (instance == null) {
            instance = new InformationService();
        }
        return instance;
    }

    public int nextId() {
        return 1 + JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as numberOfInformation FROM `information`").mapTo(Integer.class).one();
        });
    }

    public void addNewInformation(Information information) {
        JDBIConnector.get().withHandle(handle -> {
            int num = handle.createUpdate("INSERT INTO information(`name`, phone, detail, district, city, ward_id, district_id, province_id, status)\n" +
                            "VALUES (:name, :phone, :detail, :district, :city, :detailId, :districtId, :cityId, 0);")
                    .bind("name", information.getName())
                    .bind("phone", information.getPhone())
                    .bind("detail", information.getAddress().getDetail())
                    .bind("district", information.getAddress().getDistrict())
                    .bind("city", information.getAddress().getCity())
                    .bind("detailId", information.getAddress().getWardId())
                    .bind("districtId", information.getAddress().getDistrictId())
                    .bind("cityId", information.getAddress().getProvinceId())
                    .execute();
            return num;
        });
    }

    public Information getInformationByInformationId(int id) {
        Information information = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select id, name, phone, status from information where id =?")
                    .bind(0, id)
                    .mapToBean(Information.class)
                    .one();
        });
        information.setAddress(AddressService.getInstance().getAddressByInformationId(id));
        return information;
    }

    public List<Information> getListInformationByUserId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Information> result = handle.createQuery("select id, name, phone,status\n" +
                            "from information i join user_information ui on i.id = ui.information_id\n" +
                            "where user_id = ? and i.`status` not LIKE 1;")
                    .bind(0, id)
                    .mapToBean(Information.class)
                    .stream().collect(Collectors.toList());
            for (Information information : result) {
                information.setAddress(AddressService.getInstance().getAddressByInformationId(information.getId()));
            }
            return result;
        });
    }

    public void deleteInformation(int id) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE information SET `status` =1 WHERE id = ?;")
                    .bind(0, id)
                    .execute();
        });
    }

    public void deleteAllInformation(int userId) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE information i\n" +
                            "join user_information ui on i.id = ui.information_id\n" +
                            " set i.`status` = 1\n" +
                            "WHERE user_id = ?")
                    .bind(0, userId)
                    .execute();
        });
    }

    public Information getInformationByOrderId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            Information result = handle.createQuery("select i.id, i.name, i.phone, i.status from information i join `order` o on i.id = o.information_id where o.id = ?")
                    .bind(0, id)
                    .mapToBean(Information.class)
                    .one();
            result.setAddress(AddressService.getInstance().getAddressByInformationId(result.getId()));
            return result;
        });
    }

    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as numberInformation FROM `information`").mapTo(Integer.class).one();
        });
    }

    //    Lấy ra thông tin chi tiết của nhà sản xuất
    public Information getInformationByVendorId(int id) {
        Information information = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select i.id, i.name, i.phone, i.status from information i join vendor v on i.id = v.information_id where v.id =?")
                    .bind(0, id)
                    .mapToBean(Information.class)
                    .one();
        });
        information.setAddress(AddressService.getInstance().getAddressByInformationId(information.getId()));
        return information;
    }

    public static void main(String[] args) {
        System.out.println(getInstance().getInformationByVendorId(8));
    }
}

