package services;

import bean.Review;
import bean.User;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class ReviewService {
    private static ReviewService instance;

    private ReviewService() {

    }

    public static ReviewService getInstance() {
        if (instance == null) {
            instance = new ReviewService();
        }
        return instance;
    }

    public List<Review> getListReviewByPage(int idProduct, int page) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Review> listResult = handle.createQuery("select id, comment, rate, create_date, status \n" +
                            "from review \n" +
                            "where product_id=? order by id DESC LIMIT ?, 5")
                    .bind(0, idProduct).bind(1, page * 5 - 5)
                    .mapToBean(Review.class)
                    .stream()
                    .collect(Collectors.toList());
            for (Review review : listResult) {
                review.setUser(UserService.getInstance().getUserByReviewId(review.getId()));
            }
            return listResult;
        });
    }

    public void addReview(Review review) {
        JDBIConnector.get().withHandle(
                handle -> handle.createUpdate("insert into review( comment, rate, user_id, product_id, create_date, status) values(:comment, :rate, :user_id, :product_id, :create_date, :status) ")
                        .bind("comment", review.getComment())
                        .bind("rate", review.getRate())
                        .bind("user_id", review.getUser().getId())
                        .bind("product_id", review.getProduct().getId())
                        .bind("create_date", review.getCreateDate())
                        .bind("status", review.getStatus())
                        .execute());
    }

    public List<Review> getListReviewByProductId(int idProduct) {
        List<Review> listResult = JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select id, comment, rate, create_date, status from `review` WHERE product_id = :idProduct ORDER BY create_date")
                    .bind("idProduct", idProduct)
                    .mapToBean(Review.class).stream()
                    .collect(Collectors.toList());
        });
        for (Review review : listResult) {
            review.setUser(UserService.getInstance().getUserByReviewId(review.getId()));
        }
        return listResult;
    }

    public int getCountReviewById(int id) {
        return getListReviewByProductId(id).size();
    }

    public int getCountPageById(int id) {
        int countCmt = getCountReviewById(id);
        return countCmt % 5 == 0 ? countCmt / 5 : countCmt / 5 + 1;
    }
}
