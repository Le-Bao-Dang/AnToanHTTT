package services;

import bean.*;
import db.JDBIConnector;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

public class ProductService {
    private static ProductService instance;
    //    kind
    public static final int ALL = 0;
    public static final int WOOD = 1;
    public static final int CERAMIC = 2;
    public static final int PAINT = 3;
    public static final int SALE = 4;
    public static final int NEW = 5;

    //    group;
    public static final int MOHINH = 1;
    public static final int GIADUNG = 2;
    public static final int VANPHONG = 3;
    public static final int TRANGSUC = 4;
    public static final int TRANGTRI = 5;
    public static final int SONDAU = 6;
    public static final int SONMAI = 7;
    public static final int VAI = 8;


    private ProductService() {

    }

    public static ProductService getInstance() {
        if (instance == null) {
            instance = new ProductService();
        }
        return instance;
    }

    public List<Product> getListProduct() {
        return JDBIConnector.get().withHandle(handle -> {
            List<Product> list = handle.createQuery("select p.id, p.name, p.description, p.detail, p.rate, p.status from product p where p.status = 0")
                    .mapToBean(Product.class).stream()
                    .collect(Collectors.toList());
            for (Product product : list) {
                product.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(product.getId()));
                product.setListImage(ImageService.getInstance().getListImageByProductId(product.getId()));
                product.setCategory(CaterogyService.getInstance().getCategoryByProductId(product.getId()));
                product.setUserAdd(UserService.getInstance().getUserAddProductByProductId(product.getId()));
            }
            return list;
        });
    }

    public Product getProductById(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            Product product = handle.createQuery("select p.id, p.name, p.description, p.detail, p.rate, p.status from product p where p.id" + "=" + id).mapToBean(Product.class).one();
            product.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(product.getId()));
            product.setListImage(ImageService.getInstance().getListImageByProductId(product.getId()));
            product.setCategory(CaterogyService.getInstance().getCategoryByProductId(product.getId()));
            product.setUserAdd(UserService.getInstance().getUserAddProductByProductId(product.getId()));
            return product;
        });
    }

    //---------------------------- Danh sach san pham theo loai -----------------------
    public List<Product> getListProductByKind(int kind) {

        if (kind == ALL) {
            return JDBIConnector.get().withHandle(handle -> {

                List<Product> productList = handle.createQuery("SELECT pd.id,pd.`name`, pd.description, pd.detail, pd.rate,pd.category_id, pd.user_add_id,pd.`status` from product pd where pd.`status` =0").mapToBean(Product.class).stream().collect(Collectors.toList());
                for (Product product : productList) {
                    product.setCategory(CaterogyService.getInstance().getCategoryByProductId(product.getId()));
                    product.setListHistoryPrice(HistoryPriceService.getInstance().getPriceNow(product.getId()));
                    product.setListImage(ImageService.getInstance().getListImageByProductId(product.getId()));
                }
                return productList;
            });
        } else if (kind == SALE) {
            return JDBIConnector.get().withHandle(handle -> {
                List<Product> productList = handle.createQuery("SELECT pd.id,pd.`name`, pd.description, pd.detail, pd.rate,pd.category_id, pd.user_add_id,pd.`status` from product pd join history_price hp on hp.product_id=pd.id where( hp.price_sale is not null and pd.status = 0) ").mapToBean(Product.class).stream().collect(Collectors.toList());
                for (Product product : productList) {
                    product.setCategory(CaterogyService.getInstance().getCategoryByProductId(product.getId()));
                    product.setListHistoryPrice(HistoryPriceService.getInstance().getPriceNow(product.getId()));
                    product.setListImage(ImageService.getInstance().getListImageByProductId(product.getId()));
                }
                return productList;

            });
        } else if (kind == NEW) {
            return JDBIConnector.get().withHandle(handle -> {
                List<Product> productList = handle.createQuery("SELECT pd.id,pd.`name`, pd.description, pd.detail, pd.rate,pd.category_id, pd.user_add_id,pd.`status` from product pd where() pd.status = 0)").mapToBean(Product.class).stream().collect(Collectors.toList());
                for (Product product : productList) {
                    product.setCategory(CaterogyService.getInstance().getCategoryByProductId(product.getId()));
                    product.setListHistoryPrice(HistoryPriceService.getInstance().getPriceNow(product.getId()));
                    product.setListImage(ImageService.getInstance().getListImageByProductId(product.getId()));
                }
                return productList;

            });
        }
        return JDBIConnector.get().withHandle(handle -> {
            List<Product> productList = handle.createQuery("SELECT pd.id,pd.`name`, pd.description, pd.detail, pd.rate,pd.category_id, pd.user_add_id,pd.`status` from product pd join category c on pd.category_id = c.id WHERE (pd.status=0 and  c.pa_category = " + kind + ")").mapToBean(Product.class).stream().collect(Collectors.toList());
            for (Product product : productList) {
                product.setCategory(CaterogyService.getInstance().getCategoryByProductId(product.getId()));
                product.setListHistoryPrice(HistoryPriceService.getInstance().getPriceNow(product.getId()));
                product.setListImage(ImageService.getInstance().getListImageByProductId(product.getId()));
            }
            return productList;

        });


    }


    // -------------------- Loc san pham theo nhom --------------------------------
    public List<Product> getListProductInGroupName(int kind, String group) {

        List<Product> list = getListProductByKind(kind);
        List<Product> listResult = new ArrayList<Product>();
        if ("".equals(group))
            return list;
        for (Product product : list) {
            if (product.getCategory().getName().equals(group)) {
                listResult.add(product);
            }
        }

        return listResult;

    }


//------------------------ Danh sach san pham o 1 trang ---------------------------------------

    public List<Product> getListProductInPageName(int kind, String group, String page) {
        List<Product> list = getListProductInGroupName(kind, group);
//        List<Product> list = getSortListProductName(kind, group, sort);
        List<Product> listResult = new ArrayList<Product>();
        int pageInt = Integer.parseInt(page);
        int start = (pageInt - 1) * 15 < 0 ? 0 : (pageInt - 1) * 15;
        int end = pageInt <= list.size() / 15 ? pageInt * 15 : list.size() - ((pageInt - 1) * 15) + start;
        for (int i = start; i < end; i++) {
            listResult.add(list.get(i));
        }
        return listResult;
    }

    public List<Product> getListFavouriteProduct() {
        return JDBIConnector.get().withHandle(handle -> {

            List<Product> result = handle.createQuery("select id, name, description, detail, rate from product order by rate desc limit 3;").mapToBean(Product.class).stream().collect(Collectors.toList());
            for (Product p : result) {
                int id = p.getId();
                p.setListImage(ImageService.getInstance().getListImageByProductId(id));
                p.setCategory(CaterogyService.getInstance().getCategoryByProductId(id));
                p.setUserAdd(UserService.getInstance().getUserAddProductByProductId(id));
                p.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(id));
            }
            return result;
        });

    }


    public List<Product> getTopProducts(int kind) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Product> result = handle.createQuery("SELECT p.id, p.name, p.description, p.detail,p.rate from product p join category c on p.category_id = c.id WHERE c.pa_category = ?  order by p.description  desc limit 16")
                    .bind(0, kind)
                    .mapToBean(Product.class).stream().collect(Collectors.toList());
            for (Product p : result) {
                int id = p.getId();
                p.setListImage(ImageService.getInstance().getListImageByProductId(id));
                p.setCategory(CaterogyService.getInstance().getCategoryByProductId(id));
                p.setUserAdd(UserService.getInstance().getUserAddProductByProductId(id));
                p.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(id));
            }
            return result;
        });
    }

    public List<Product> getListSameProduct(int paCategoryId) {
        return JDBIConnector.get().withHandle(handle -> {
            List<Product> result = handle.createQuery("SELECT p.id, p.name, p.description, p.detail,p.rate from product p join category c on p.category_id = c.id WHERE c.pa_category = :paId  order by p.description  desc limit 20")
                    .bind("paId", paCategoryId)
                    .mapToBean(Product.class).stream().collect(Collectors.toList());
            for (Product p : result) {
                int id = p.getId();
                p.setListImage(ImageService.getInstance().getListImageByProductId(id));
                p.setCategory(CaterogyService.getInstance().getCategoryByProductId(id));
                p.setUserAdd(UserService.getInstance().getUserAddProductByProductId(id));
                p.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(id));
            }
            return result;

        });
    }

    public List<String> getImageOfProductById(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("select image_src from image where product_id " + "=" + id).mapTo(String.class).stream().collect(Collectors.toList());
        });
    }

    //------------------ Tong so san pham theo nhom ---------------------
    public int getCountProduct(int kind, String group) {

        return getListProductInGroupName(kind, group).size();
    }

    //----------------------------- Sap xep san pham ---------------------------
    public List<Product> getSortListProductName(int kind, String sort, String group) {
        List<Product> list = getListProductInGroupName(kind, group);
        switch (sort) {
            case "nameA":
                Collections.sort(list, new Comparator<Product>() {
                    @Override
                    public int compare(Product o1, Product o2) {
                        return o1.getName().compareTo(o2.getName());
                    }
                });
                break;
            case "nameZ":
                Collections.sort(list, new Comparator<Product>() {
                    @Override
                    public int compare(Product o1, Product o2) {
                        return o2.getName().compareTo(o1.getName());
                    }
                });
                break;
            case "priceHigh":
                Collections.sort(list, new Comparator<Product>() {

                    @Override
                    public int compare(Product o1, Product o2) {
                        return o1.getListHistoryPrice().get(0).getPrice() - o2.getListHistoryPrice().get(0).getPrice();
                    }
                });
                break;
            case "priceLow":
                Collections.sort(list, new Comparator<Product>() {
                    @Override
                    public int compare(Product o1, Product o2) {
                        return o2.getListHistoryPrice().get(0).getPrice() - o1.getListHistoryPrice().get(0).getPrice();
                    }
                });
                break;
            case "ratting":
                Collections.sort(list, new Comparator<Product>() {
                    @Override
                    public int compare(Product o1, Product o2) {
                        return o2.getRate() - o1.getRate();
                    }
                });
                break;

        }

        return list;
    }

    //------------------------------ Tim kiem----------------------------------------
    public List<Product> getListProductInSearch(String search) {
        List<Product> listProducts = new ArrayList<>();
        List<Product> pr = JDBIConnector.get().withHandle(handle -> {
            List<Product> list = handle.createQuery("select p.id, p.name, p.description, p.detail, p.rate, p.status from product p where p.status = 0")
                    .mapToBean(Product.class).stream()
                    .collect(Collectors.toList());
            for (Product product : list) {
                product.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(product.getId()));
                product.setListImage(ImageService.getInstance().getListImageByProductId(product.getId()));
                product.setCategory(CaterogyService.getInstance().getCategoryByProductId(product.getId()));
                product.setUserAdd(UserService.getInstance().getUserAddProductByProductId(product.getId()));
            }
            return list;
        });
//        List<Product> pr = getListProduct();
        for (Product p : pr) {
            if (p.getName().toUpperCase().contains(search.toUpperCase())) {
                listProducts.add(p);
            }
        }
        return listProducts;
    }

    //--------------------- Lay id lon nhat trong ban ----------------------------
    public int nextId() {
        return 1 + JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as numberProduct FROM `product`").mapTo(Integer.class).one();
        });
    }

    //    --------------------------- Them san pham ----------------------------
    public int maxId() {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("SELECT MAX(`id`) as numberProduct FROM `product`").mapTo(Integer.class).one();
        });
    }

    public void addProduct(Product product) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO product VALUES (:id, :name, :description,  :detail, :rate, :categoryId,:user_add_id, :status);")
                    .bind("id", nextId())
                    .bind("name", product.getName())
                    .bind("description", product.getDescription())
                    .bind("detail", product.getDetail())
                    .bind("rate", product.getRate())
                    .bind("categoryId", product.getCategory().getId())
                    .bind("user_add_id", product.getUserAdd().getId())
                    .bind("status", product.getStatus())
                    .execute();
        });
    }

    // ------------------------- Sua san pham ----------------------------------
    public void editProduct(int id, String name, Category category, String descriptin, String detail, User user, int status) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE product SET name=?,description=?, detail=?,category_id=?,user_add_id=?,status=? where id= " + id + ";")
                    .bind(0, name)
                    .bind(1, descriptin)
                    .bind(2, detail)
                    .bind(3, category.getId())
                    .bind(4, user.getId())
                    .bind(5, status)
                    .execute();
        });
    }

    public List<Product> getNewProducts() {
        return JDBIConnector.get().withHandle(handle -> {
            List<Product> result = handle.createQuery("SELECT p.id, p.name, p.description, p.detail,p.rate from product p  order by p.create_date desc limit 8")
                    .mapToBean(Product.class).stream().collect(Collectors.toList());
            for (Product p : result) {
                int id = p.getId();
                p.setListImage(ImageService.getInstance().getListImageByProductId(id));
                p.setCategory(CaterogyService.getInstance().getCategoryByProductId(id));
                p.setUserAdd(UserService.getInstance().getUserAddProductByProductId(id));
                p.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(id));
            }
            return result;
        });
    }

    public void editImageProduct(int id, String src) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE product SET image_src =:src where product_id=:id")
                    .bind("src", src)
                    .bind("id", id)
                    .execute();
        });
    }

    public void deleteProduct(int id) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("UPDATE product_detail SET stt =1 where product_detail_id=:id")
                    .bind("id", id)
                    .execute();
        });
    }

    public List<Integer> statisticalProduct(int kind) {
        List<Integer> result = new ArrayList<>();
        int sum = 0;
        for (int i = 1; i < 12; i++) {
            sum = statisticalProductInMonth(kind, i);
            result.add(sum);
        }
        return result;
    }

    public int statisticalProductInMonth(int kind, int month) {
        return JDBIConnector.get().withHandle(handle -> {
            return handle.createQuery("Select count(*) from ord o join  order_detail od on o.order_id=od.order_id join product pd on od.product_id = pd.product_id join category c on pd.category_id =c.category_id join pa_category pc on c.pa_category_id = pc.pa_category_id where ( MONTH(o.order_date)=" + month + ") and pc.pa_category_id= " + kind + ";").mapTo(Integer.class).one();
        });
    }

    public Product getProductByLineItemId(int id) {
        return JDBIConnector.get().withHandle(handle -> {
            Product result = handle.createQuery("SELECT p.id, p.name, p.description, p.detail,p.rate from product p join line_item li on p.id = li.product_id where li.id = ?")
                    .bind(0, id).mapToBean(Product.class).one();
            result.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(result.getId()));
            return result;
        });
    }

    public Product getProductByCartItemId(int userid) {
        return JDBIConnector.get().withHandle(handle -> {
            Product p = handle.createQuery("SELECT p.id, p.name, p.description, p.detail,p.rate from product p join cart_item ci on p.id = ci.product_id where ci.id =?")
                    .bind(0, userid).mapToBean(Product.class).one();

            p.setListHistoryPrice(HistoryPriceService.getInstance().getListHistoryPriceByProductId(p.getId()));
            p.setListImage(ImageService.getInstance().getListImageByProductId(p.getId()));
            return p;
        });
    }


    public static void main(String[] args) {
        System.out.println(getInstance().getListSameProduct(2));
    }


    public Product getProductByName(String name) {
        Product prd = null;
        for (Product product : getListProduct()) {
            if (product.getName().toUpperCase().equals(name.toUpperCase())) {
                prd = product;
            }
        }
        return prd;
    }
}
