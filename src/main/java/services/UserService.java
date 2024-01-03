package services;

import bean.Image;
import bean.ThirdParty;
import bean.User;
import db.JDBIConnector;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.stream.Collectors;

public class UserService {

    private static UserService instance;

    private UserService() {

    }

    public static UserService getInstance() {
        if (instance == null) {
            instance = new UserService();
        }
        return instance;
    }

    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as numberOfUser FROM `user`").mapTo(Integer.class).one();
        });
    }

    public List<User> getListUser() {
        List<User> list = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT id, name, phone, email, `password`,variety, `status`  FROM user").mapToBean(User.class).stream().collect(Collectors.toList());
        });
        for (User user : list) {
            user.setAvatar(ImageService.getInstance().getImageByUserId(user.getId()));
        }
        return list;
    }

//    public User getUserById(int id) {
//        User user = JDBIConnector.get().withHandle(handle -> {
//            return handle.createQuery("SELECT id, name, phone, email, avatar, `password`,variety, `status`  FROM user where id " + "=" + id).mapToBean(User.class).one();
//        });
//        user.setListOrderInformation(InformationService.getInstance().getListInformationByUserId(id));
//        user.setListCartItem(CartService.getInstance().getCartOfUser(id));
//        user.setListOrder(OrderService.getInstance().getOrderListByUserId(id));
//        user.setIdThirdParty(ThirdPartyService.getInstance().getIdThirdPartyByUserId(id));
//        return user;
//    }
    public User getUserById(int id) {
        User user = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT id, name, phone, email, `password`,variety, `status`  FROM user where id " + "=" + id).mapToBean(User.class).one();
        });
        user.setAvatar(ImageService.getInstance().getImageByUserId(id));
        user.setListOrderInformation(InformationService.getInstance().getListInformationByUserId(id));
        user.setListCartItem(CartService.getInstance().getCartOfUser(id));
        user.setListOrder(OrderService.getInstance().getOrderListByUserId(id));
        user.setIdThirdParty(ThirdPartyService.getInstance().getIdThirdPartyByUserId(id));
        return user;
    }

    public User getUserById3rd(String id3rd) {
        return JDBIConnector.get().withHandle(handle -> {
            User user = handle.createQuery("SELECT u.id, u.`name`, u.phone, u.email,u.avatar, u.variety, u.`status` FROM `user` u join third_party tp on u.id_third_party = tp.id where tp.value =?")
                    .bind(0, id3rd)
                    .mapToBean(User.class)
                    .one();
            user.setIdThirdParty(ThirdPartyService.getInstance().getIdThirdPartyByUserId(user.getId()));
            return user;
        });
    }

    public User checkLogin(String userName, String password) {
        List<User> users = JDBIConnector.get().withHandle(handle ->
                handle.createQuery("select id,`name`,  phone, email, `password`,variety, status from user where email=? or phone=?")
                        .bind(0, userName).bind(1, userName)
                        .mapToBean(User.class)
                        .stream()
                        .collect(Collectors.toList())
        );
        if (users.size() != 1) return null;
        User user = users.get(0);
        if (!user.getPassword().equals(UserService.getInstance().hashPassword(password))
                || !(user.getEmail().equals(userName) || user.getPhone().equals(userName))) {
            return null;
        }
        user.setAvatar(ImageService.getInstance().getImageByUserId(user.getId()));
        return user;
    }

    public int getIdByUserName(String userName) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select id from user where email =? or phone = ?")
                    .bind(0, userName).bind(1, userName)
                    .mapTo(Integer.class).one();
        });
    }

    public String hashPassword(String password) {
        try {
            MessageDigest sha256 = null;
            sha256 = MessageDigest.getInstance("SHA-256");
            byte[] hash = sha256.digest(password.getBytes());
            BigInteger number = new BigInteger(1, hash);
            return number.toString(16);
        } catch (NoSuchAlgorithmException e) {
            return null;
        }
    }

    public boolean checkExistEmail(String email) {
        List<String> emails = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT  email \n" +
                            "from user\n" +
                            " where email=?").bind(0, email)
                    .mapTo(String.class).stream().collect(Collectors.toList());
        });
        if (emails.size() != 0) {

            return true;
        }
        return false;

    }

    public boolean checkExistPhone(String phone) {
        List<String> phones = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT phone \n" +
                            "from user\n" +
                            " where phone=?").bind(0, phone)
                    .mapTo(String.class).stream().collect(Collectors.toList());
        });
        if (phones.size() != 0) {

            return true;
        }
        return false;

    }

    public boolean checkExistUserName(String userName) {
        List<String> strings = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT phone, email \n" +
                            "from user\n" +
                            " where phone=? or email =?").bind(0, userName).bind(1, userName)
                    .mapTo(String.class).stream().collect(Collectors.toList());
        });
        if (strings.size() != 0) {

            return true;
        }
        return false;
    }

    public boolean checkExistId3rd(String id3rd) {
        List<String> id3rds = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select value from third_party where value =?").bind(0, id3rd)
                    .mapTo(String.class).stream().collect(Collectors.toList());
        });
        if (id3rds.size() != 0) {

            return true;
        }
        return false;

    }

    public boolean checkSamePass(String pass, String passAgain) {
        return pass.equals(passAgain);
    }


    public void addUser(User user) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO user(id, name, phone, email,avatar, password, variety, status ) values (:id, :name, :phone, :email,:avatar, :pass, :variety, :status)")
                    .bind("id", user.getId())
                    .bind("name", user.getName())
                    .bind("email", user.getEmail())
                    .bind("avatar", 501)
                    .bind("phone", user.getPhone())
                    .bind("pass", user.getPassword())
                    .bind("variety", 0)
                    .bind("status", 0)
                    .execute();
        });
    }

    public void editInfor(int id, String fName, String phone, String mail) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE user SET name=?, email=?, phone=? WHERE id=?;")
                    .bind(0, fName)
                    .bind(1, mail)
                    .bind(2, phone)
                    .bind(3, id)
                    .execute();
        });
    }

    public void changePass(String phoneEmail, String newPass) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `user` SET password=?  WHERE email=?;")
                    .bind(0, UserService.getInstance().hashPassword(newPass))
                    .bind(1, phoneEmail)
                    .execute();
        });
    }

    public boolean checkPhoneEmail(String phoneEmail) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT COUNT(id)  FROM `user` WHERE phone = ? OR email = ?;")
                    .bind(0, phoneEmail)
                    .bind(1, phoneEmail)
                    .mapTo(Integer.class)
                    .one() == 1;

        });
    }

    public void editVarietiesUser(int id, int varieties) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `user` SET variety=? where id= " + id + " ;")
                    .bind(0, varieties)
                    .execute();
        });
    }

    public void editSttUser(int id, int stt) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `user` SET status=? where id= " + id + " ;")
                    .bind(0, stt)
                    .execute();
        });
    }


    public void addUserLoginBy3rdParty(User user) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("insert into third_party(id,name, value) values ( :id, :name, :value)")
                    .bind("id", user.getIdThirdParty().getId())
                    .bind("name", user.getIdThirdParty().getName())
                    .bind("value", user.getIdThirdParty().getValue())
                    .execute();
        });
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("insert into `user`(id,name, id_third_party, variety, status) values (:id, :name,:id_third_party, :variety, :stt)")
                    .bind("id", UserService.getInstance().maxId() + 1)
                    .bind("name", user.getName())
                    .bind("id_third_party", user.getIdThirdParty().getId())
                    .bind("variety", 0)
                    .bind("stt", 0)
                    .execute();
        });

    }

    public void editAvatar(User user, String url) {
        Image image = new Image(url);
        int idImg = ImageService.getInstance().add(image);
        image.setId(idImg);
        user.setAvatar(image);

        JDBIConnector.get().withHandle(handle -> handle.createUpdate("UPDATE `user` SET avatar= :idImg where id= :userId ;")
                .bind("idImg", idImg)
                .bind("userId", user.getId())
                .execute());
    }


    public void changeName(String name, String id3rd) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE user u join third_party t on u.id_third_party = t.id set u.name = :name where t.value =:value;")
                    .bind("name", name)
                    .bind("value", id3rd)
                    .execute();
        });
    }

    public User getUserByReviewId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            User user = handle.createQuery("select u.id, u.name, u.phone, u.email,  u.variety, u.status from `user` u join review r on u.id = r.user_id WHERE r.id = ?; ")
                    .bind(0, id)
                    .mapToBean(User.class)
                    .one();
            user.setAvatar(ImageService.getInstance().getImageByUserId(user.getId()));
            return user;
        });
    }

    public User getUserAddProductByProductId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select u.id, u.name, u.phone, u.email,  u.variety, u.status from `user` u join product p on u.id = p.user_add_id WHERE p.id = ?; ")
                    .bind(0, id)
                    .mapToBean(User.class)
                    .one();
        });
    }

    public User getUserByOrderId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select u.id, u.`name`, u.phone, u.email, u.variety, u.`status` from `user` u join `order` o on u.id = o.user_id WHERE o.id = ?; ")
                    .bind(0, id)
                    .mapToBean(User.class)
                    .one();
        });
    }

    public void updateStatus(int userId) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("update `user` u join incorrect_time it on u.id = it.user_id set u.`status` = 0 where u.id = ?")
                    .bind(0, userId).execute();
        });
    }

    public boolean isEligibilityToLock(int userId) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Boolean> booleans = handle.createQuery("select case when incorrect_attempts>=5 then 'true' else 'false' end as result from incorrect_time where user_id = ? and status = 0 ")
                    .bind(0, userId).mapTo(Boolean.class).stream().collect(Collectors.toList());
            for (Boolean b : booleans) {
                if (b == true) return true;
            }
            return false;
        });
    }

    public boolean isBlockedForever(int userId) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Integer> integers = handle.createQuery("SELECT status FROM user WHERE id=?")
                    .bind(0, userId)
                    .mapTo(Integer.class).stream().collect(Collectors.toList());
            if (integers.size() == 1) {
                return integers.get(0) == 2;
            }
            return false;
        });
    }
    public User getUserByImportId(int id) { // Lấy ra user theo import (nhân viên nhập đơn hàng)
        User user = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT u.id, u.name, u.phone, u.email, u.`password`,u.variety, u.`status`  FROM user u join import i on i.user_import_id = u.id where i.id = " + id).mapToBean(User.class).one();
        });
//        user.setAvatar(ImageService.getInstance().getImageByUserId(id));
        user.setListOrderInformation(InformationService.getInstance().getListInformationByUserId(id));
        user.setListCartItem(CartService.getInstance().getCartOfUser(id));
        user.setListOrder(OrderService.getInstance().getOrderListByUserId(id));
        user.setIdThirdParty(ThirdPartyService.getInstance().getIdThirdPartyByUserId(id));
        return user;
    }

    public static void main(String[] args) {
        User u = new User();
        u.setName("sfd");
        ThirdParty id = new ThirdParty();
        id.setValue("1630346147389912");
        id.setName("");
        id.setId(14);
        u.setIdThirdParty(id);
//        getInstance().addUserLoginBy3rdParty(u);
        System.out.println(getInstance().checkExistId3rd("1149673663101820"));

    }
}
