package services;

import bean.Log;
import db.JDBIConnector;

public class LogService {
    private static LogService instance;

    private LogService() {

    }

    public static LogService getInstance() {
        if (instance == null) {
            instance = new LogService();
        }
        return instance;
    }

    public Log getLogById(int id) {
        return null;
    }

    public void insert(Log log) {
        if (log.getUser() == null) {
            JDBIConnector.get().withHandle(
                    handle ->
                            handle.createUpdate("insert into log(ip, severity_level, event, description, create_date) \n" +
                                            "values(:ip, :severity_level, :event, :description, :create_date) ")
                                    .bind("ip", log.getIp())
                                    .bind("severity_level", log.getSeverityLevel())
                                    .bind("event", log.getEvent())
                                    .bind("description", log.getDescription())
                                    .bind("create_date", log.getCreateDate())
                                    .execute());
        } else {
            JDBIConnector.get().withHandle(
                    handle ->
                            handle.createUpdate("insert into log(ip, user_id, severity_level, event, description, create_date) \n" +
                                            "values(:ip, :user_id, :severity_level, :event, :description, :create_date) ")
                                    .bind("ip", log.getIp())
                                    .bind("user_id", log.getUser().getId())
                                    .bind("severity_level", log.getSeverityLevel())
                                    .bind("event", log.getEvent())
                                    .bind("description", log.getDescription())
                                    .bind("create_date", log.getCreateDate())
                                    .execute());
        }

    }

}
