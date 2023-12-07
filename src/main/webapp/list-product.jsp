<%@ page import="java.util.List" %>
<%@ page import="services.ProductService" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sản phẩm</title>
    <link rel="stylesheet" href="css/reset.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/list-product.css">
</head>

<body>
<%@include file="header.jsp" %>
<div class="address-book-background">
    <div class="container address-book-vs-sort">
        <div class="address-book">
            <span><a href="/homepage">Trang chủ</a></span><span>|</span>
            <span><a href="/listProduct?kind=0">Danh sách sản phẩm</a></span>
        </div>

        <div class="sort">
            <select name="sort" class="sort-table" id="sort-tableID">
                <option class="sort-item" value="nameA">A-Z</option>
                <option class="sort-item" value="nameZ">Z-A</option>
                <option class="sort-item" value="priceHigh">Giá từ thấp đến cao</option>
                <option class="sort-item" value="priceLow">Giá từ cao đến thấp</option>
                <option class="sort-item" value="ratting">Đánh giá tốt nhất</option>
            </select>
        </div>
    </div>

</div>
<div class="container content">
    <div class="left">
        <div class="container-of-left ">
            <div class="row">
                <div class="row type-left">
                    <ul class="">
                        <li class="drivider"><a href="http://localhost:8080/listProduct?kind=0&page=1&group=0&sort=0">Tất
                            cả</a></li>
                    </ul>
                </div>
            </div>
            <div class="row boder-line">
            </div>
            <div class="row type-item">
                <div class="state">
                    <ul>
                        <li class="item"><a href="http://localhost:8080/listProduct?kind=4&group=0&page=1&sort=0">
                            Giảm giá</a></li>
                        <li class="item"><a href="http://localhost:8080/listProduct?kind=5&group=0&page=1&sort=0"> Sản
                            phẩm mới</a></li>
                    </ul>
                </div>
            </div>
            <div class="row boder-line"></div>
            <div class="row type-group">
                <div class="group">
                    <h3>Nhóm sản phẩm</h3>
                    <ul>
                        <% List<Category> categories = (List<Category>) request.getAttribute("categories");
                            int counts = 0;
                            for (Category category : categories) {
//                                if (Integer.parseInt(request.getAttribute("kind").toString()) == 0)
                        %>
                        <li class="item item-groupProduct">
                            <button class="button">
                                <%=category.getName()%>
                            </button>
                        </li>
                        <%}%>

                    </ul>
                </div>
            </div>
        </div>

    </div>

    <div class="right">
        <!-- slider -->
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <%
//                    List<Banner> listbanner = (List<Banner>) request.getAttribute("listBanner");
                    for (int i = 0; i < 3; i++) {
                %>
                <%if (i == 0) {%>
                <div class="carousel-item active">
                    <a href=""><img class="d-block w-100" src=" <% // TODO: 4/9/2023  =listbanner.get(i).getImage_src()%>"
                                    alt="First slide"></a>
                </div>
                <%}%>
                <div class="carousel-item ">
                    <a href=""><img class="d-block w-100" src="<% // TODO: 4/9/2023  =listbanner.get(i).getImage_src()%>"
                                    alt="Second slide"></a>
                </div>
                <%}%>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <!-- list product -->
        <div class="list-product">
            <div class="row">

                <%
                    List<Product> listProduct = (List<Product>) request.getAttribute("listProduct");
                    for (Product product : listProduct) {
                %>
                <div class="col-4">
                    <div class="thumbnail">
                        <div class="cont-item ">
                            <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><img
                                    src="<%=product.getListImage().get(0).getSource()%>" alt="">
                            </a>
                        </div>
                            <div class="button">
                                <a href="http://localhost:8080/detail-product?id=<%= product.getId()%>"
                                   class="buy-now"> Mua ngay</a>
                                <button class="wish-list btn-add-cart" value="<%= product.getId()%>"><i
                                        class="fa-solid fa-cart-plus"></i></button>

                            </div>
                            <div class="caption">
                                <h3>
                                    <a href="http://localhost:8080/detail-product?id=<%= product.getId()%>"><%= product.getName()%>
                                    </a></h3>
                                <div class="ratting">
                                    <% int count = product.getRate();
                                        for (int i = 0; i < 5; i++) {
                                            if (count > 0) {%>
                                    <i class="fa fa-star yellow"></i>
                                    <%} else {%>
                                    <i class="fa fa-star"></i>
                                    <%
                                        }
                                        count--;
                                        }
                                    %>
                                </div>
                                <h3 class="price">
                                    <%= Format.format(product.getPrice())%> VND
                                    <% if (product.getPriceSale() != 0) {%>
                                    <span class="price-real"><%= Format.format(product.getPriceSale())%> VND</span>
                                    <%}%>
                                </h3>
                            </div>
                    </div>
                </div>
                <%}%>

            </div>
        </div>
        <!-- pagination -->
        <nav aria-label="Page navigation example" class="pagination-page">
            <ul class="pagination">

                <li class="page-item">
                    <button class="page-link"
                            aria-label="Previous">
                        <span aria-hidden="true"><i class="fa-solid fa-angle-left"></i></span>
                        <span class="sr-only">Previous</span>
                    </button>
                </li>
                <%
                    int count = (int) request.getAttribute("count");
                    for (int i = 0; i < count; i++) {
                %>
                <li class="page-item ">
                    <button class="page-link"><%=i + 1%>
                    </button>
                </li>
                <%
                    }
                %>

                <li class="page-item">
                    <button class="page-link"
                            aria-label="Next">
                        <span aria-hidden="true"><i class="fa-solid fa-angle-right"></i></span>
                        <span class="sr-only">Next</span>
                    </button>
                </li>

            </ul>
        </nav>
    </div>


</div>


<%@include file="footer.jsp" %>
<%@include file="scroll-to-top.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
        integrity="sha512-aVKKRRi/Q/YV+4mjoKBsE4x3H+BkegoM/em46NNlCqNTmUYADjBbeNefNxYV7giUp0VxICtqdrbqU7iVaeZNXA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="js/general.js"></script>
<script src="js/list-product.js"></script>
</body>

</html>