package services;

import bean.Import;
import bean.LineItemImport;
import bean.Product;
import db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class LineItemImportService {
    public static LineItemImportService instance;

    public LineItemImportService() {

    }

    public static LineItemImportService getInstance() {
        if (instance == null) {
            instance = new LineItemImportService();
        }
        return instance;
    }

    public List<LineItemImport> getListProductImportByImportId(int id) { // Lấy ra danh sách sản phẩm đã nhập theo đơn nhập hàng
        return JDBIConnector.get().withHandle(handle -> {
            List<LineItemImport> list = handle.createQuery("select pi.id, pi.quantity, pi.price_import from product_import pi where pi.import_id=" + id).mapToBean(LineItemImport.class).stream().collect(Collectors.toList());
            for (LineItemImport lineItemImport : list) {
                lineItemImport.setProduct(ProductService.getInstance().getProductById(lineItemImport.getId()));
            }
            return list;
        });
    }

    public int getTotalByProductImportId(int id) { // Tổng tiền hóa đơn
        List<LineItemImport> list = getListProductImportByImportId(id);
        int total = 0;
        for (LineItemImport lineItemImport : list) {
            total += lineItemImport.getTotalPrice();
        }
        return total;
    }

    public void addImportProduct(LineItemImport lineItemImport) {
        JDBIConnector.get().withHandle(handle -> {
            return handle.createUpdate("INSERT INTO product_import(id, import_id, quantity, price_import) values(:id, :import_id, :quantity, :price_import)")
                    .bind("id", lineItemImport.getProduct().getId())
                    .bind("import_id", ImprotService.getInstance().maxId())
                    .bind("quantity", lineItemImport.getQuantity())
                    .bind("price_import", lineItemImport.getPriceImport()).execute();
        });
    }

    public static void main(String[] args) {


        System.out.println(getInstance().getListProductImportByImportId(1));
    }


}
