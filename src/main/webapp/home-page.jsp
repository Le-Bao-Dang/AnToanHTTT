<%@ page import="bean.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="services.ProductService" %>
<%@ page import="bean.Format" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ</title>
    <link rel="stylesheet" href="css/reset.css">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>

    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/home-page.css">
</head>

<body>
<%--header--%>
<%@include file="header.jsp" %>

<%-- end header--%>
<div class="banner-slider">
    <div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/home-page/main-banner-1-1903x975.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="images/home-page/main-banner-2-1903x975.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="images/home-page/main-banner-2-1903x975.jpg" class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-target="#carouselExampleFade" data-slide="prev">

        </button>
        <button class="carousel-control-next" type="button" data-target="#carouselExampleFade" data-slide="next">

        </button>
    </div>


</div>
<!-- favourite -->
<div class="container favourite bd-bottom ">
    <div class="title top-favourite">
        <h2>Sản phẩm được yêu thích nhất</h2>
    </div>
    <%List<Product> favouriteProducts = (List<Product>) request.getAttribute("favouriteProducts");%>
    <div class="favourite top-product">
        <% for (Product product : favouriteProducts) { %>
        <div class="top-product-img">
            <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><img
                    src="<%= product.getListImage().get(0).getSource()%>" alt=""></a>
        </div>

        <% } %>
    </div>
</div>
<!-- new-product -->
<div class="container new-products bd-bottom ">
    <div class="title new-product">
        <h2>Sản phẩm mới nhất</h2>
    </div>
    <%List<Product> newProducts = (List<Product>) request.getAttribute("newProducts");%>

    <div class="slider-new-products">
        <% for (Product product : newProducts) { %>
        <div class="product">
            <div class="thumbnail">
                <div class="cont-item ">
                    <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><img
                            src="<%=product.getListImage().get(0).getSource()%>"
                            alt="">
                    </a>
                </div>

                <div class="caption">

                    <h3>
                        <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><%=product.getName()%>
                        </a></h3>


                    <div class="ratting">
                        <% int count = product.getRate();
                            for (int i = 0; i < 5; i++) {
                                if (count > 0) {%>
                        <i class="fa fa-star yellow"></i>
                        <%} else {%>
                        <i class="fa fa-star  "></i>
                        <%
                            }
                            count--;
                        %>

                        <%}%>
                    </div>
                    <h3 class="price">
                        <% if (product.getPriceSale() == 0) {%>
                        <%=Format.format(product.getPrice())%> VND
                        <%} else{%>
                        <%=Format.format(product.getPrice())%> VND
                        <span class="price-real"><%=Format.format(product.getPriceSale())%> VND</span>
                        <% }%>
                    </h3>
                </div>
            </div>
        </div>
        <% } %>

    </div>
</div>
<!-- featured -->
<div class="container featured ">
    <div class="title featured-product">
        <h2>Sản phẩm nổi bật</h2>
    </div>
    <div class="featured-list">
        <%List<Product> topWoodProducts = (List<Product>) request.getAttribute("topWoodProducts");%>

        <div class="wood featured-img-list">
            <% for (Product product : topWoodProducts) { %>
            <div class="product">
                <div class="thumbnail">
                    <div class="cont-item ">

                        <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><img
                                src="<%=product.getListImage().get(0).getSource()%>"></a>
                    </div>

                    <div class="caption">

                        <h3>
                            <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><%=product.getName()%>
                            </a></h3>
                        <div class="ratting">
                            <% int count = product.getRate();
                                for (int i = 0; i < 5; i++) {
                                    if (count > 0) {%>
                            <i class="fa fa-star yellow"></i>
                            <%} else {%>
                            <i class="fa fa-star  "></i>
                            <%
                                }
                                count--;
                            %>

                            <%}%>
                        </div>
                        <h3 class="price">
                            <% if (product.getPriceSale() == 0) {%>
                            <%=Format.format(product.getPrice())%> VND
                            <%} else{%>
                            <%=Format.format(product.getPrice())%> VND
                            <span class="price-real"><%=Format.format(product.getPriceSale())%> VND</span>
                            <% }%>
                        </h3>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

        <%List<Product> topCeramicProducts = (List<Product>) request.getAttribute("topCeramicProducts");%>

        <div class="ceramic featured-img-list">
            <% for (Product product : topCeramicProducts) { %>
            <div class="product">
                <div class="thumbnail">
                    <div class="cont-item ">

                        <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><img
                                src="<%=product.getListImage().get(0).getSource()%>"></a>
                    </div>

                    <div class="caption">

                        <h3>
                            <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><%=product.getName()%>
                            </a></h3>
                        <div class="ratting">
                            <% int count = product.getRate();
                                for (int i = 0; i < 5; i++) {
                                    if (count > 0) {%>
                            <i class="fa fa-star yellow"></i>
                            <%} else {%>
                            <i class="fa fa-star  "></i>
                            <%
                                }
                                count--;
                            %>

                            <%}%>
                        </div>
                        <h3 class="price">
                            <% if (product.getPriceSale() == 0) {%>
                            <%=Format.format(product.getPrice())%> VND
                            <%} else{%>
                            <%=Format.format(product.getPrice())%> VND
                            <span class="price-real"><%=Format.format(product.getPriceSale())%> VND</span>
                            <% }%>
                        </h3>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <%List<Product> topPaintingProducts = (List<Product>) request.getAttribute("topPaintingProducts");%>

        <div class="painting featured-img-list">
            <% for (Product product : topPaintingProducts) { %>
            <div class="product">
                <div class="thumbnail">
                    <div class="cont-item ">

                        <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><img
                                src="<%=product.getListImage().get(0).getSource()%>"></a>
                    </div>

                    <div class="caption">

                        <h3>
                            <a href="http://localhost:8080/detail-product?id=<%=product.getId()%>"><%=product.getName()%>
                            </a></h3>
                        <div class="ratting">
                            <% int count = product.getRate();
                                for (int i = 0; i < 5; i++) {
                                    if (count > 0) {%>
                            <i class="fa fa-star yellow"></i>
                            <%} else {%>
                            <i class="fa fa-star  "></i>
                            <%
                                }
                                count--;
                            %>

                            <%}%>
                        </div>
                        <h3 class="price">
                            <% if (product.getPriceSale() == 0) {%>
                            <%=Format.format(product.getPrice())%> VND
                            <%} else{%>
                            <%=Format.format(product.getPrice())%> VND
                            <span class="price-real"><%=Format.format(product.getPriceSale())%> VND</span>
                            <% }%>
                        </h3>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

    </div>

</div>
<!-- Footer -->

<%@include file="footer.jsp" %>
<%--end footer--%>

<a href="#" class="scrolltotop"><i class="fa fa-arrow-up"></i></a>


<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
<script type="text/javascript"
        src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>

<script src="js/general.js"></script>
<%--<script src="js/home-page.js"></script>--%>

<script>

    $(document).ready(function () {

        $(window).scroll(function () {
            var scroll = $(window).scrollTop();

            //>=, not <=
            if (scroll >= 5) {
                //clearHeader, not clearheader - caps H
                $(".nav-home").addClass("bg-light");

            } else {
                $(".nav-home").removeClass("bg-light");
            }
        }); //missing );

        $('.slider-new-products').slick({
            infinite: true,
            slidesToShow: 4,
            slidesToScroll: 1,
            centerMode: true,
            focusOnSelect: true,
            prevArrow: "<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
            nextArrow: "<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>"

        });

        $('.featured-img-list').slick({
            rows: 2,
            dots: false,
            arrows: true,
            infinite: true,
            speed: 300,
            slidesToShow: 4,
            slidesToScroll: 4,
            prevArrow: "<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
            nextArrow: "<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>"
        });
        $('.featured-list').slick({
            rows: 1,
            dots: true,
            arrows: false,
            infinite: false,
            speed: 300,
            slidesToShow: 1,
            slidesToScroll: 1,
            prevArrow: "<button type='button' class='slick-prev pull-left'><i class='fa fa-angle-left' aria-hidden='true'></i></button>",
            nextArrow: "<button type='button' class='slick-next pull-right'><i class='fa fa-angle-right' aria-hidden='true'></i></button>"
        });
        $('#slick-slide-control40').text("Gỗ");
        $('#slick-slide-control41').text("Gốm");
        $('#slick-slide-control42').text("Tranh");

    });
</script>

</body>

</html>