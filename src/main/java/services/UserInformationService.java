package services;

import db.JDBIConnector;

public class UserInformationService {
    private static UserInformationService instance;

    private UserInformationService() {

    }

    public static UserInformationService getInstance() {
        if (instance == null) {
            instance = new UserInformationService();
        }
        return instance;
    }

    public void addNewUserInformation(int userId, int informationId) {
        JDBIConnector.get().withHandle(handle -> {
            int num = handle.createUpdate("INSERT INTO user_information(user_id, information_id) VALUES (?,?)")
                    .bind(0, userId).bind(1, informationId)
                    .execute();
            return num;
        });
    }
}
