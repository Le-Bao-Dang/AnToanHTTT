package services;

import bean.Image;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class ImageService {
    private static ImageService instance;

    private ImageService() {

    }

    public static ImageService getInstance() {
        if (instance == null) {
            instance = new ImageService();
        }
        return instance;
    }

    public int nextId() {
        return 1 + JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`image_id`) as numberProduct FROM `image`").mapTo(Integer.class).one();
        });
    }

    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> handle.createQuery("SELECT MAX(`id`) as numberProduct FROM `image`").mapTo(Integer.class).one());
    }

    public void addListImageByIdProduct(int idProduct, List<String> srcImage) {
        for (String src : srcImage) {
            JDBIConnector.get().withHandle(handle -> {
                return handle.createUpdate("INSERT INTO image VALUES (:image_id,:product_id,:image_src)")
                        .bind("image_id", nextId())
                        .bind("product_id", idProduct)
                        .bind("image_src", src)
                        .execute();
            });
        }

    }

    public void addImageByIdProduct(int idProduct, String srcImage) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO image VALUES (:image_id,:product_id,:image_src)")
                    .bind("image_id", nextId())
                    .bind("product_id", idProduct)
                    .bind("image_src", srcImage)
                    .execute();
        });
    }

    public List<Image> getListImageByProductId(int idProduct) {
        return JDBIConnector.get().withHandle(
                handle -> handle.createQuery("SELECT i.id, i.source FROM product_image pi join image i on pi.image_id = i.id where pi.product_id= ?;")
                        .bind(0, idProduct)
                        .mapToBean(Image.class).stream()
                        .collect(Collectors.toList()));
    }

    public Image getImageByUserId(int idUser) {
        return JDBIConnector.get().withHandle(
                handle -> handle.createQuery("SELECT i.id, i.`source` FROM image i join `user` u on i.id = u.avatar WHERE u.id= :idUser;")
                        .bind("idUser", idUser)
                        .mapToBean(Image.class)
                        .one());
    }

    public int add(Image image) {
        JDBIConnector.get().withHandle(handle -> handle.createUpdate("INSERT INTO image(`source`) VALUES (:image_src)")
                .bind("image_src", image.getSource())
                .execute());

        return maxId();
    }

    public static void main(String[] args) {
        System.out.println(getInstance().getListImageByProductId(2).get(0).getSource());
    }
}
