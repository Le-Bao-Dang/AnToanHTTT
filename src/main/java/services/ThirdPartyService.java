package services;

import bean.Information;
import bean.ThirdParty;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class ThirdPartyService {
    private static ThirdPartyService instance;

    private ThirdPartyService() {

    }

    public static ThirdPartyService getInstance() {
        if (instance == null) {
            instance = new ThirdPartyService();
        }
        return instance;
    }

    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as numberOfThirdParty FROM `third_party`").mapTo(Integer.class).one();
        });
    }

    public ThirdParty getIdThirdPartyByUserId(int id) {
        return JDBIConnector.get().withHandle(handle -> {

            List<ThirdParty> list = handle.createQuery("select tp.id, tp.name, tp.value from third_party tp join `user` u on tp.id = u.id_third_party where u.id = ?;")
                    .bind(0, id).mapToBean(ThirdParty.class).stream().collect(Collectors.toList());
            if (list.size() == 0) return null;
            return list.get(0);
        });
    }


    public ThirdParty getThirdPartyById(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select id, name, value from third_party where id = ?")
                    .bind(0, id).mapToBean(ThirdParty.class).one();
        });
    }

    public static void main(String[] args) {
        System.out.println(getInstance().maxId());
    }
}
