package services;

import bean.Address;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class AddressService {
    private static AddressService instance;

    private AddressService() {

    }

    public static AddressService getInstance() {
        if (instance == null) {
            instance = new AddressService();
        }
        return instance;
    }

    public Address getAddressByInformationId(int id) {
        return JDBIConnector.get().withHandle(handle ->
                handle.createQuery("select detail, district, city, ward_id, district_id, province_id from information where id = ?")
                        .bind(0, id)
                        .mapToBean(Address.class)
                        .one());
    }

    public static void main(String[] args) {
        System.out.println(getInstance().getAddressByInformationId(5));
    }
}