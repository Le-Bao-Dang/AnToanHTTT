package bean;

import db.JDBIConnector;
import org.jdbi.v3.core.mapper.JoinRow;
import org.jdbi.v3.core.mapper.JoinRowMapper;
import org.jdbi.v3.core.mapper.Nested;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;
import org.jdbi.v3.core.mapper.reflect.ColumnName;

import java.beans.ConstructorProperties;
import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;

public class Category implements Serializable {
    private int id;
   private String name;
   private Category paCategory;
   private  int status;

    public Category() {
    }

    public Category(int id, String name, Category paCategory, int status) {
        this.id = id;
        this.name = name;
        this.paCategory = paCategory;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Category getPaCategory() {
        return paCategory;
    }

    public void setPaCategory(Category paCategory) {
        this.paCategory = paCategory;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", paCategory=" + paCategory +
                ", status=" + status +
                '}';
    }
}

