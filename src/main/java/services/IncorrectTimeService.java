package services;

import bean.IncorrectTime;
import db.JDBIConnector;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

public class IncorrectTimeService {
    private static IncorrectTimeService instance;

    private IncorrectTimeService() {

    }

    public static IncorrectTimeService getInstance() {
        if (instance == null) {
            instance = new IncorrectTimeService();
        }
        return instance;
    }

    public void deleteIncorrectTime(int userId) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("update incorrect_time set status = 1 where user_id = ?;")
                    .bind(0, userId)
                    .execute();
        });
        UserService.getInstance().updateStatus(userId);
    }

    public void insertIncorrectAttemptsPassword(int userId) {
        JDBIConnector.get().withHandle(handle -> {
            List<Integer> integers = handle.createQuery("SELECT user_id FROM incorrect_time WHERE user_id = ? AND `status` = 0")
                    .bind(0, userId)
                    .mapTo(Integer.class).stream().collect(Collectors.toList());
            if (integers.size() == 0) {
                return handle.createUpdate("insert into incorrect_time(user_id, incorrect_attempts, type, status) values(?,?,?,?)")
                        .bind(0, userId)
                        .bind(1, 1)
                        .bind(2, "password")
                        .bind(3, 0)
                        .execute();
            } else {
                return handle.createUpdate("update incorrect_time set incorrect_attempts = incorrect_attempts+1 where user_id =? and status =?")
                        .bind(0, userId)
                        .bind(1, 0)
                        .execute();
            }
        });
    }

    public boolean checkLocked(LocalDateTime time, String userName) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Boolean> result = handle.createQuery("SELECT CASE WHEN ? <= locked_until THEN 'true' ELSE 'false' END AS result FROM incorrect_time it join user u on it.user_id = u.id WHERE (u.email = ? or u.phone =?) and it.status = 0 and it.incorrect_attempts >= 5")
                    .bind(0, time).bind(1, userName).bind(2, userName)
                    .mapTo(Boolean.class).stream().collect(Collectors.toList());
            if (result.size() != 0) {
                return result.get(0);
            }
            return false;

        });
    }

    public LocalDateTime getTimeUnLock(int userId) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select max(locked_until) from incorrect_time where user_id = ? and status = 0")
                    .bind(0, userId)
                    .mapTo(LocalDateTime.class).one();
        });
    }

    public int getInccorrectAttempts(int userId) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Integer> result = handle.createQuery("select incorrect_attempts from incorrect_time where user_id = ? and status = 0")
                    .bind(0, userId)
                    .mapTo(Integer.class).stream().collect(Collectors.toList());
            if (result.size() != 0) {
                return result.get(0);
            }
            return 0;
        });
    }

    public void setLockTimePassword(int userId, LocalDateTime time) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("update incorrect_time set locked_until= ? where user_id = ? and status =0")
                    .bind(0, time).bind(1, userId).execute();
        });
    }

    public static void main(String[] args) {
//        System.out.println(getInstance().getTimeUnLock(5));
       getInstance().insertIncorrectAttemptsPassword(5);
    }

}
