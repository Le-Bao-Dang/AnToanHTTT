package services;

import bean.Category;
import db.JDBIConnector;

import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;

public class PaCategoryService implements Serializable {
    private static PaCategoryService instance;

    private PaCategoryService() {

    }

    public static PaCategoryService getInstance() {
        if (instance == null) {
            instance = new PaCategoryService();
        }
        return instance;
    }

    public Category getPaCategoryById(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT id, `name`,status from category WHERE id = :id")
                    .bind("id", id)
                    .mapToBean(Category.class).one();
        });
    }

    public Category getPaCategoryByIdCa(int caId) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT pa.id, pa.`name`,pa.`status` from category ca join category pa on ca.pa_category = pa.id WHERE ca.id = :ca_id")
                    .bind("ca_id", caId)
                    .mapToBean(Category.class).one();
        });
    }

    public List<Category> getListPaCategory() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT id, `name`, status  from  category where pa_category is null").mapToBean(Category.class).stream().collect(Collectors.toList());

        });
    }

    public int nextId() {
        return 1 + JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(id) as numberPaCategory FROM category").mapTo(Integer.class).one();
        });
    }

    public void addPaCategory(String name) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO category VALUES (:id,:name, :category,:status)")
                    .bind("pa_category_id",nextId())
                    .bind("name", name)
                    .bind("status",0)
                    .execute();
        });
    }

    public void editPaCategory(int id, String name) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE `pa_category` SET name=? where pa_category_id=" + id + ";")
                    .bind(0, name)
                    .execute();
        });
    }

    public void deletePaCategory(int id) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("DELETE from `pa_category` where pa_category_id=?")
                    .bind(0, id).execute();
        });
    }

    public static void main(String[] args) {
        System.out.println(getInstance().getPaCategoryByIdCa(5));;
    }


}
