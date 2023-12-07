<%@ page import="java.util.List" %>
<%@ page import="bean.Format" %>
<%@ page import="bean.Vendor" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="https://mdbootstrap.com/docs/b4/jquery/getting-started/cdn/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="stylesheet" href="css/vendorManager.css">
    <link rel="stylesheet" href="css/admin.css">
</head>

<body>
<%@include file="header-admin.jsp" %>
<div class="card-body px-0 pb-2 content">
    <div class="item-left search-item">
        <input type="text" oninput="searchByAll(this)" class="search-input" placeholder="Tìm kiếm..."
               name="txtSearch" value=""/>
        <div class="rightBar">
            <button id="add-Vendor" class="submit" onclick="show()"> Thêm nhà cung cấp</button>
        </div>
    </div>

    <div class="table-responsive p-0">
        <table class="table align-items-center mb-0">
            <thead>
            <tr>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Tên nhà cung cấp
                </th>
                <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Số điện thoại
                </th>
                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                    Địa chỉ
                </th>
                <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">
                    Trạng thái
                </th>
                <th class="text-secondary opacity-7"></th>
            </tr>
            </thead>
            <tbody id="vendor-item">
            <%
                List<Vendor> list = (List<Vendor>) request.getAttribute("vendors");
                for (Vendor vendor : list) {
            %>
            <tr>
                <td>
                    <div class="d-flex px-2 py-1">
                        <div class="d-flex flex-column justify-content-center">
                            <h6 class="mb-0 text-sm"><%=vendor.getInformation().getName()%>
                            </h6>
                            <p class="text-xs text-secondary mb-0"><%=vendor.getEmail()%>
                            </p>
                            <p class="text-xs text-secondary mb-0"><%=vendor.getWebsite()%>
                            </p>
                        </div>
                    </div>
                </td>
                <td class="align-middle text-center text-sm">
                    <span class="text-secondary text-xs font-weight-bold"><%=vendor.getInformation().getPhone()%></span>

                </td>
                <td class="align-middle text-center address">
                    <p class="address-text"><%=vendor.getInformation().getAddress().formatAddress()%>
                    </p>
                </td>
                <td class="align-middle text-center">
                    <span class="text-secondary text-xs font-weight-bold"><%=vendor.getStatusNow()%></span>
                </td>
                <td class="align-middle">
                    <button class="edit-vendor submit" value="<%=vendor.getId()%>" style="width: 150px">
                        sửa
                    </button>
                </td>
            </tr>
            <%}%>


            </tbody>
        </table>
    </div>
    <div class="addVendor" id="addVendorForm">
        <section class="container">
            <header>Thêm nhà cung cấp</header>
            <form action="/addVendor" method="post" class="form">
                <div class="input-box">
                    <label>Tên nhà cung cấp</label>
                    <input type="text" name="name" placeholder="Tên nhà cung cấp" required/>
                </div>
                <div class="input-box">
                    <label>Địa chỉ mail</label>
                    <input type="text" name="email" placeholder="Địa chỉ mail" required/>
                </div>
                <div class="column">
                    <div class="input-box">
                        <label>Số điện thoại</label>
                        <input type="text" name="phone" placeholder="Số điện thoại" required/>
                    </div>
                    <div class="input-box">
                        <label>Địa chỉ website</label>
                        <input type="text" name="website" placeholder="Địa chỉ website" required/>
                    </div>
                </div>
                <div class="input-box address">
                    <label>Địa chỉ</label>
                    <input type="text" name="detail" placeholder="Số nhà,tên đường, xã/phường" required/>
                    <input type="text" name="district" placeholder="Quận/huyện" required/>
                    <div class="column">
                        <input type="text" name="city" placeholder="Tỉnh/thành phố" required/>
                        <input type="number" name="cityId" placeholder="Mã tỉnh/thành phố" required/>
                    </div>
                    <div class="column">
                        <input type="number" name="districtId" placeholder="Mã huyện" required/>
                        <input type="text" name="warId" placeholder="Mã xã/phường" required/>
                    </div>
                </div>
                <div class="bottom-form">
                    <button class="submit" type="submit">Thêm</button>
                    <div class="submit cant" onclick="hide()">Hủy</div>

                </div>
            </form>
        </section>
    </div>
</div>

<script type="text/javascript">
<%--    tìm kiếm --%>
    function searchByAll(param) {
        var txtSearch = param.value;
        console.log(txtSearch)
        $.ajax({
                url: "/searchVendor",
                type: "get",
                data: {
                    txtSearch: txtSearch
                },
                success: function (data) {
                    var row = document.getElementById('vendor-item');
                    row.innerHTML = data;
                }
            }
        )
    }

    function show() {
        document.getElementById('addVendorForm').style.display = "block";
    }

    function hide() {
        document.getElementById('addVendorForm').style.display = "none";
    }

</script>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
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
<!-- <script src="js/general.js"></script> -->
<script src="js/jquery.dataTables.min.js"></script>
<script src="js/admin.js"></script>
</body>

</html>