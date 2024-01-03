package services;

import bean.Request;
import bean.User;
import db.JDBIConnector;

import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

public class RequestService {
    private static RequestService instance;

    public static final int REQUESTING = 0;
    public static final int CONFIRM = 1;
    public static final int REFUSE = -1;

    public RequestService() {

    }

    public static RequestService getInstance() {
        if (instance == null) {
            instance = new RequestService();
        }
        return instance;
    }

    public List<Request> getListRequest() {
        return JDBIConnector.get().withHandle(handle -> {
            List<Request> list = handle.createQuery("SELECT id, create_at,confirm_at,note,status from request ").mapToBean(Request.class).stream().collect(Collectors.toList());
            for (Request r : list) {
                r.setUser(getUserbyRequestId(r.getId()));
            }
            return list;
        });
    }

    public List<Request> getRequestByUserId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Request> r = handle.createQuery("SELECT r.id,create_at,confirm_at,note,r.status from request r where " +
                    "r.user_id =? ").bind(0,id).mapToBean(Request.class).stream().collect(Collectors.toList());


            return r;
        });
    }

    public List<Request> getRequestByUserIdAD( int userId) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Request> r = handle.createQuery("SELECT r.id,create_at,confirm_at,note,r.status from request r join user u on r.user_id =u.id where r.status = 0 and u.id = "+userId).mapToBean(Request.class).stream().collect(Collectors.toList());
            if (r.size() != 0) {
                r.get(0).setUser(getUserbyRequestId(r.get(0).getId()));
            }
            return r;
        });
    }

    public static void main(String[] args) {
        System.out.println( getInstance().getRequestByUserIdAD(18).get(0).getUser().getEmail());
    }

    public int getMaxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(id) from request").mapTo(Integer.class).one();
        });
    }

    public void createRequest(Request request) {
        Random r = new Random();
        int id = r.nextInt(0,100000) + r.nextInt(100000,999999);
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO request(id,user_id,create_at,confirm_at,note, status) values(?,?,?,?,?,?)")
                    .bind(0, id)
                    .bind(1, request.getUser().getId())
                    .bind(2, request.getCreate_at())
                    .bind(3, request.getConfim_at())
                    .bind(4, request.getNote())
                    .bind(5, request.getStatus())
                    .execute();
        });
    }

    public void setStatus(int id, int status) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE request set status=? where id=?")
                    .bind(0, status)
                    .bind(1, id)
                    .execute();
        });
    }

    public User getUserbyRequestId(int id) {
        User user = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT u.id, name, phone, email, `password`,variety, u.`status`  FROM user u join request r on u.id = r.user_id where r.id = " + id).mapToBean(User.class).one();
        });
        user.setAvatar(ImageService.getInstance().getImageByUserId(user.getId()));
        user.setListOrderInformation(InformationService.getInstance().getListInformationByUserId(user.getId()));
        user.setListCartItem(CartService.getInstance().getCartOfUser(user.getId()));
        user.setListOrder(OrderService.getInstance().getOrderListByUserId(user.getId()));
        user.setIdThirdParty(ThirdPartyService.getInstance().getIdThirdPartyByUserId(user.getId()));
        return user;
    }

    public Request getRequestById(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            Request r = handle.createQuery("SELECT r.id,create_at,confirm_at,note,r.status from request r where r.id =" +id).mapToBean(Request.class).one();
            r.setUser(getUserbyRequestId(r.getId()));
            return r;
        });
    }
}
