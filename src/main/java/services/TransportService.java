package services;

import bean.Transport;
import bean.User;
import db.JDBIConnector;

import java.time.LocalDateTime;

public class TransportService {

    private static TransportService instance;

    private TransportService() {

    }

    public static TransportService getInstance() {
        if (instance == null) {
            instance = new TransportService();
        }
        return instance;
    }

    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> handle.createQuery("SELECT MAX(`id`) as numberProduct FROM `transport`").mapTo(Integer.class).one());
    }

    public Transport getTransportById(int idTransportService) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery(
                            "select id, id_shipping,create_date,fee\n" +
                                    "from transport\n" +
                                    "WHERE id = ?;")
                    .bind(0, idTransportService)
                    .mapToBean(Transport.class)
                    .one();
        });
    }

    public Transport getTransportByOrderId(int id) {
        return JDBIConnector.get().withHandle(handle -> handle.createQuery("select t.id,  t.id_shipping,t.create_date, t.fee, t.`time` from transport t join `order` o on t.id = o.transport_id where o.id = ?")
                .bind(0, id)
                .mapToBean(Transport.class)
                .one());
    }

    public int add(Transport transport) {
        JDBIConnector.get().withHandle(handle -> handle.createUpdate("INSERT INTO transport(fee, `time`, create_date) values (:fee, :time, :create_date)")
                .bind("fee", transport.getFee())
                .bind("time", transport.getTime())
                .bind("create_date", transport.getCreateDate())
                .execute());

        return maxId();

    }

    public static void main(String[] args) {
    }
}
