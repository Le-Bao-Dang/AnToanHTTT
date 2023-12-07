<%@ page import="bean.*" %>
<%@ page import="services.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<ul class="nav nav-page">
    <li class=" left">
        <a href="/homepage"><img src="images/logo/logo-rmbg1.png" alt=""></a>
    </li>


    <li class="nav-item center" id="nav-items">

        <a class="nav-link  " id="sanpham"
           href="http://localhost:8080/listProduct?kind=<%=ProductService.ALL%>">Sản
            Phẩm</a>
        <a class="nav-link  " id="go"
           href="http://localhost:8080/listProduct?kind=<%=ProductService.WOOD%>">Gỗ</a>
        <a class="nav-link  " id="gom"
           href="http://localhost:8080/listProduct?kind=<%=ProductService.CERAMIC%>">Gốm</a>
        <a class="nav-link "
           href="http://localhost:8080/listProduct?kind=<%=ProductService.PAINT%>">Tranh</a>
        <a class="nav-link  "
           href="http://localhost:8080/listProduct?kind=<%=ProductService.SALE%>">giảm
            giá</a>

    </li>
    <li class=" right">
        <div class="item-right search-item">

            <input type="text" class="search-input" placeholder="Tìm kiếm..."
                   name="txName" value=""/>
            <span class="icon" id="search">
                <i class=" fa fa-search" name="action"></i>
            </span>
        </div>


        <% User user = (User) session.getAttribute("auth");
            List<LineItem> cartItems = null;
            if (user != null) {
                cartItems = user.getListCartItem();

        %>
        <a href="/cart" class="item-right"><i
                class="fa-solid fa-cart-shopping"></i>
            <%if (cartItems != null) {%>
            <p>Giỏ hàng (<span class="amount-product"><%=Cart.sumQuantity(cartItems)%></span>)</p>
            <%} else {%>
            <p>Giỏ hàng (<span class="amount-product">0</span>)</p>
            <%}%>
        </a>
        <a href="/userProfile" class="item-right">
            <%if (user.getAvatar() == null) {%>
            <img id="small-avt" src="images/userNull.png" alt="">

            <%} else {%>
            <img id="small-avt" src="<%=user.getAvatar().getSource()%>" alt="">
            <%}%>
            <a href="http://localhost:8080/userProfile" class="item-right">
                <p><%=user.getName()%>
                </p>
            </a>
        </a>
        <%} else {%>
        <a href="/cart" class="item-right"><i
                class="fa-solid fa-cart-shopping"></i>
            <p>Giỏ hàng</p>
        </a>
        <a href="http://localhost:8080/doLogin" class="item-right">
            <i class="fa-solid fa-user"></i>
            <p>Đăng nhập</p>
        </a>
        <%}%>


    </li>
</ul>