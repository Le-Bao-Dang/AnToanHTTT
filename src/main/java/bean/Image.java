package bean;

import java.io.Serializable;

public class Image implements Serializable {
    private int id;
    private String source;

    public Image() {
    }

    public Image(int id, String source) {
        this.id = id;
        this.source = source;
    }

    public Image(String source) {
        this.source = source;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    @Override
    public String toString() {
        return "Image{" +
                "id=" + id +
                ", source='" + source + '\'' +
                '}';
    }
}
