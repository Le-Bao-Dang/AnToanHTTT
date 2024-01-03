package services;

import bean.Address;
import bean.Category;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class CaterogyService {
    private static CaterogyService instance;

    private CaterogyService() {

    }

    public static CaterogyService getInstance() {
        if (instance == null) {
            instance = new CaterogyService();
        }
        return instance;
    }

    public List<Category> getListCategory(int kind) {
        if (kind == ProductService.ALL && kind == ProductService.SALE) {
            return JDBIConnector.get().withHandle(handle -> {
                List<Category> categoryList = handle.createQuery("SELECT id, name, status  FROM category ;").mapToBean(Category.class).stream().collect(Collectors.toList());
                for (Category category : categoryList) {
                    category.setPaCategory(PaCategoryService.getInstance().getPaCategoryByIdCa(category.getId()));
                }
                return categoryList;
            });
        }

        return JDBIConnector.get().withHandle(handle -> {
            List<Category> categoryList = handle.createQuery("SELECT  id, name, status  FROM category where pa_category=" + kind + ";").mapToBean(Category.class).stream().collect(Collectors.toList());
            for (Category category : categoryList) {
                category.setPaCategory(PaCategoryService.getInstance().getPaCategoryByIdCa(category.getId()));
            }
            return categoryList;
        });
    }


    public Category getCategoryById(int id) {
        Category category = JDBIConnector.get().withHandle(handle ->
                handle.createQuery("SELECT id, `name`,status FROM category WHERE id=:id")
                        .bind("id", id)
                        .mapToBean(Category.class).one());
        category.setPaCategory(PaCategoryService.getInstance().getPaCategoryByIdCa(category.getId()));
        return category;
    }


    public List<Category> getListCategoryAll() {
        return JDBIConnector.get().withHandle(handle -> {
            List<Category> categoryList = handle.createQuery("SELECT id, name, status  FROM category where pa_category is not null ").mapToBean(Category.class).stream().collect(Collectors.toList());
            for (Category category : categoryList) {
                category.setPaCategory(PaCategoryService.getInstance().getPaCategoryByIdCa(category.getId()));
            }
            return categoryList;
        });
    }

    public int nextID() {
        return 1 + JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(id) as numberCategory FROM `category`").mapTo(Integer.class).one();
        });
    }

    public void addCategory(String name, int paCategory) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO category VALUES (name=?, pa_category=?,status=?)")
                    .bind(1, name)
                    .bind(2, paCategory)
                    .bind(3, 0)
                    .execute();
        });
    }

    public void editCategory(int id, int paCategory) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE category SET pa_category where id=" + id + ";")
                    .bind(0, paCategory)
                    .execute();
        });
    }

    public void deleteCategory(int id) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE category set `status` =1 WHERE id = ?;")
                    .bind(0, id).execute();
        });
    }

    public Category getCategoryByProductId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            Category c = handle.createQuery("select c.id, c.name,  c.`status` from category c join product p on c.id = p.category_id WHERE p.id = ?")
                    .bind(0, id)
                    .mapToBean(Category.class)
                    .one();
            c.setPaCategory(PaCategoryService.getInstance().getPaCategoryByIdCa(c.getId()));
            return c;
        });
    }
}
