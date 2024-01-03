package bean;

import db.JDBIConnector;
import services.CartService;
import services.UserService;

import java.io.Serializable;
import java.util.List;

public class User implements Serializable {

    private int id;
    private String name;
    private String email;
    private String phone;
    private String password;
    private Image avatar;
    private List<Information> listOrderInformation;
    private List<LineItem> listCartItem;
    private List<Order> listOrder;
    private ThirdParty idThirdParty;
    private int variety;
    private int status;


    public User() {

    }

    public User(int id, String name, String email, String phone, String password, Image avatar, List<Information> listOrderInformation, List<LineItem> listCartItem, List<Order> listOrder, ThirdParty idThirdParty, int variety, int status) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.avatar = avatar;
        this.listOrderInformation = listOrderInformation;
        this.listCartItem = listCartItem;
        this.listOrder = listOrder;
        this.idThirdParty = idThirdParty;
        this.variety = variety;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Image getAvatar() {
        return avatar;
    }

    public void setAvatar(Image avatar) {
        this.avatar = avatar;
    }

    public List<Information> getListOrderInformation() {
        return listOrderInformation;
    }

    public void setListOrderInformation(List<Information> listOrderInformation) {
        this.listOrderInformation = listOrderInformation;
    }

    public List<LineItem> getListCartItem() {
        return listCartItem;
    }

    public void setListCartItem(List<LineItem> listCartItem) {
        this.listCartItem = listCartItem;
    }

    public List<Order> getListOrder() {
        return listOrder;
    }

    public void setListOrder(List<Order> listOrder) {
        this.listOrder = listOrder;
    }

    public ThirdParty getIdThirdParty() {
        return idThirdParty;
    }

    public void setIdThirdParty(ThirdParty idThirdParty) {
        this.idThirdParty = idThirdParty;
    }

    public int getVariety() {
        return variety;
    }

    public void setVariety(int variety) {
        this.variety = variety;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }


    public String getVarietyUser() {
        if (this.variety == 1) {
            return "Admin";
        }
        if (this.variety == 2) {
            return "Nhân viên bán hàng";
        }
        if(this.variety ==3){
            return "Nhân viên kho";
        }
        return "Khách hàng";
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", password='" + password + '\'' +
                ", avatar='" + avatar + '\'' +
                ", listInformation=" + listOrderInformation +
                ", listCartItem=" + listCartItem +
                ", listOrder=" + listOrder +
                ", idThirdParty='" + idThirdParty + '\'' +
                ", variety=" + variety +
                ", status=" + status +
                '}';
    }

    public LineItem containProductInCart(int idProduct) {
        for (LineItem cartItem : getListCartItem()) {
            if (cartItem.getProduct().getId() == idProduct)
                return cartItem;
        }
        return null;
    }

    public void addToCart(LineItem lineItem){
        LineItem aLine = containProductInCart(lineItem.getProduct().getId());
        if (aLine != null) {
            aLine.setQuantity(lineItem.getQuantity() + aLine.getQuantity());
        } else {
            getListCartItem().add(lineItem);
        }
    }

    public static void main(String[] args) {
        User u = UserService.getInstance().getUserById(5);
        System.out.println(u.getListOrder());
    }

}
