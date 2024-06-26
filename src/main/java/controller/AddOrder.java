package controller;

import bean.*;
import services.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

@WebServlet(name = "AddOrder", value = "/addOrder")

public class AddOrder extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("auth");
        String note = request.getParameter("note");
        int idInformation = Integer.parseInt(request.getParameter("idInformation"));
        String discountCode = request.getParameter("discountCode");
        String filePrivateName = request.getParameter("fileName");

        int shipFee = 25000;

        LocalDateTime shipDate = LocalDateTime.now();
        LocalDateTime threeDaysLater = shipDate.plusDays(3);
        LocalDateTime fiveDaysLater = threeDaysLater.plusDays(5);

        Transport transport = new Transport(shipFee, shipDate, "", LocalDateTime.now());
        int idTransport = TransportService.getInstance().add(transport);
        transport.setId(idTransport);

        LocalDateTime nowDateTime = LocalDateTime.now(); // Đây là ví dụ, bạn có thể thay đổi thành đối tượng LocalDateTime của bạn
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

        String createFormattedDateTime = nowDateTime.format(formatter);
        LocalDateTime createdateTime = LocalDateTime.parse(createFormattedDateTime, formatter);

        String threeFormattedDateTime = threeDaysLater.format(formatter);
        LocalDateTime threedateTime = LocalDateTime.parse(threeFormattedDateTime, formatter);

        String fiveFormattedDateTime = fiveDaysLater.format(formatter);
        LocalDateTime fivedateTime = LocalDateTime.parse(fiveFormattedDateTime, formatter);

        Order order = new Order();

        order.setNote(note);
        order.setPayment(false);
        order.setInformation(InformationService.getInstance().getInformationByInformationId(idInformation));
        order.setTransport(transport);
        order.setPaymentMethod(0);
        order.setStatusDelivery(0);
        order.setCreateDate(createdateTime);
        order.setListOrderItem(user.getListCartItem());
        order.setStatus(0);
        order.setUser(user);
        order.setDeliveryDate(threedateTime);
        order.setReceivingDate(fivedateTime);

        if (!"".equals(discountCode)) {
            Discount discount = DiscountService.getInstance().getDiscountByCode(discountCode);
            order.setDiscount(discount);
            order.setTotal(Cart.totalHaveShipAndDiscount(order.getListOrderItem(), discount.getValue(), shipFee));
        } else {
            order.setTotal(Cart.totalHaveShipAndDiscount(order.getListOrderItem(), 0, shipFee));
        }

        MailService.sendMail("Thong tin don hang", "Tong don hang cua ban la: " + order.getTotal() + " VND", user.getEmail());

        user.setListCartItem(new ArrayList<>());

        Order o = OrderService.getInstance().addOrderAndReturn(order);
        o = FormatOrder.getInstance().format(o);
        // sign here
        KeyServices ks = new KeyServices();
        File file = new File("");

        if(ks.readPrivateKeyFromFile(file.getAbsolutePath()+"\\" + filePrivateName+".pem")){
            SignVerifyServices.getInstance().signOrder(o,ks.exportPrivateKey());

        }else{

            System.out.println("Lỗi đọc file private"+filePrivateName);
        }



        CartService.getInstance().removeAllProductByUserId(user.getId());

        request.getRequestDispatcher("finish-buy.jsp").forward(request, response);

//        Log log = new Log();
//        log.setEvent("/addOrder");
//        log.setDescription("Thanh toán thành công, tổng giá trị đơn hàng: " + order.getTotal());
//        log.setUser(user);
//        log.setSeverityLevel(Log.INFO);
//        LogService.getInstance().insert(log);

    }
    private String getSubmittedFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return fileName.substring(fileName.lastIndexOf('/') + 1)
                        .substring(fileName.lastIndexOf('\\') + 1);
            }
        }
        return null;
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
