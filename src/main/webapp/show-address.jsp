<%@ page import="services.OrderService" %>
<%@ page import="bean.*" %>
<%@ page import="services.AddressService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ của tôi</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <!-- <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" /> -->
    <link rel="stylesheet" href="css/general.css">
    <link rel="stylesheet" href="css/user-profile.css">
    <link rel="stylesheet" href="css/show-address.css">

</head>

<body>
<%
    List<Information> informationList = (List<Information>) request.getAttribute("informationList");

%>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<div id="container">
    <!-- header -->
    <%@include file="header.jsp" %>

    <!-- end header -->


    <div class="after-header">
        <!-- content -->

        <div id="content">
            <!-- Nav tabs -->
            <div id="title">
                <h1>Tài khoản của tôi</h1>
                <div class="border-h1"></div>
            </div>
            <div id="main">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <h3>Tài khoản</h3>
                    <li class="nav-item" role="presentation">

                        <button class="nav-link active" id="infor-tab" data-toggle="tab" data-target="#infor"
                                type="button" role="tab" aria-controls="home" aria-selected="true"><i
                                class="fa-solid fa-user"></i>Thông tin tài khoản
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="address-tab" data-toggle="tab" data-target="#address" type="button"
                                role="tab" aria-controls="profile" aria-selected="false" value="<%=user.getId()%>">
                            <i class="fa-solid fa-location-dot"></i>Danh sách địa chỉ
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="security-tab" data-toggle="tab" data-target="#security"
                                type="button"
                                role="tab" aria-controls="profile" aria-selected="false" value="<%=user.getId()%>">
                            <i class="fa-solid fa-location-dot"></i>Bảo mật
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="logout-tab" data-toggle="tab" data-target="#messages" type="button"
                                role="tab" aria-controls="messages" aria-selected="false"><i
                                class="fa-solid fa-right-from-bracket"></i>Đăng xuất
                        </button>

                    </li>

                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane" id="address" role="tabpanel" aria-labelledby="address-tab">
                        <div class="choose-address inf">
                            <h3>Địa chỉ</h3>
                            <div class="contain-list-address">
                                <%for (Information i : informationList) {%>
                                <div class="list-address<%=i.getId()%> all-address">
                                    <div class="contain-address bd-bottom">
                                        <div class="contain-address<%=i.getId()%> left">
                                            <p>
                                                <label><span class="name"><%=i.getName()%></span> <span
                                                        class="phone-number"><%=i.getPhone()%></span></label>
                                            </p>
                                            <div class="address">
                                                <%=i.getAddress().formatAddress()%>
                                            </div>
                                        </div>
                                        <div class="contain-address right">

                                            <button class="btn-address delete-one button submit" id="delete-address"
                                                    value="<%=i.getId()%>">Xóa
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
                            </div>
                            <button type="button" class="btn-add-address button submit" data-toggle="modal"
                                    data-target="#exampleAddAddress">
                                Thêm địa chỉ mới
                            </button>
                            <button type="button" class="btn-delete-address button submit" data-toggle="modal"
                                    data-target="#exampleDeleteAllAddress">
                                Xóa tất cả
                            </button>


                        </div>
                    </div>

                </div>
            </div>
        </div>
        <!-- end content -->

        <!-- Modal add address-->

        <div class="modal fade" id="exampleAddAddress" tabindex="-1" role="dialog"
             aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title uppercase" id="exampleAddAddressTitle">Thêm địa chỉ mới</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-add-address">
                            <input class="input" type="text" name="" id="input-name" placeholder="Họ tên">
                            <input class="input" type="text" name="" id="input-number-phone"
                                   placeholder="Số điện thoại">
                            <select id="select-province" class="select-address input">
                                <option class="option-select-province default" value="-1">Tỉnh / Thành phố</option>
                                <option class="option-select-province" value="1">TP Hồ Chí Minh</option>
                                <%--                                <option  class="option-select-province" value="2">An Giang</option>--%>
                                <%--                                <option  class="option-select-province" value="3">TP Hồ Chí Minh</option>--%>
                            </select>
                            <select id="select-district" class="select-address input">
                                <option class="option-select-district default" value="-1">Quận / Huyện</option>
                                <option class="option-select-district" value="1">TP Thủ Đức</option>
                                <option class="option-select-district" value="1">Quận 1</option>
                                <option class="option-select-district" value="2">Quận 2</option>
                                <option class="option-select-district" value="3">Quận 3</option>
                                <option class="option-select-district" value="4">Quận 4</option>
                                <option class="option-select-district" value="5">Quận 6</option>
                                <option class="option-select-district" value="6">Quận 7</option>
                                <option class="option-select-district" value="7">Quận 8</option>
                                <option class="option-select-district" value="8">Quận 9</option>
                                <option class="option-select-district" value="9">Bình Chánh</option>
                                <option class="option-select-district" value="10">Hoc Môn</option>
                            </select>
                            <select id="select-ward" class="select-address input">
                                <option class="option-select-ward default" value="-1">Phường / Xã</option>
                                <option class="option-select-ward" value="1">Linh Trung</option>
                                <option class="option-select-ward" value="2">Linh Xuân</option>
                                <option class="option-select-ward" value="3">Hiệp Bình Chánh</option>
                                <option class="option-select-ward" value="4">Hiệp Bình Phước</option>
                                <option class="option-select-ward" value="5">Bình Thọ</option>
                                <option class="option-select-ward" value="6">Linh Tây</option>
                                <option class="option-select-ward" value="7">Linh Đông</option>
                            </select>
                            <div class="errorAddAddress"></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="button button-close submit"
                                data-dismiss="modal">Hủy
                        </button>
                        <button type="button" class="button button-save btn-save-address submit">
                            Lưu
                            địa chỉ
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <%--end modal add address--%>
        <!-- Modal delete all address-->
        <div class="modal fade" id="exampleDeleteAllAddress" tabindex="-1" role="dialog"
             aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title uppercase">Bạn chắc chắn xóa tất cả địa chỉ?</h5>
                        </button>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="button button-close submit" data-dismiss="modal">Hủy</button>
                        <button type="button" class="button button-save delete-address btn-delete-all submit">Vẫn xóa
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <%--end modal delete all address--%>
        <!-- footer -->

        <%@include file="footer.jsp" %>

        <!-- end footer -->
    </div>
</div>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
        integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"
        integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+"
        crossorigin="anonymous"></script>
<script src='https://cdn.jsdelivr.net/gh/vietblogdao/js/districts.min.js'></script>
<script src="js/api-logistic.js"></script>
<script src="js/general.js"></script>
<script>

    $(document).ready(function () {
        login();
        $('#infor-tab').click(function () {
            window.location = "<%=request.getContextPath()%>/userProfile";
        })

            // $(document).on('click', '.btn-add-address', function () {
            //     //Lấy danh sách các tỉnh
            //     if ($('#select-province').children('.option-select-province').length > 1)
            //         return;
            //
            //     $.ajax({
            //         url: "http://140.238.54.136/api/province",
            //         type: "get",
            //         data: {},
            //         beforeSend: function (xhr) {
            //             xhr.setRequestHeader('Authorization', 'Bearer ' + accessToken);
            //         },
            //         success: function (response) {
            //             const res = JSON.parse(response);
            //             let data = res.original.data;
            //             for (let i = 0; i < data.length; i++) {
            //                 let item = '<option  class="option-select-province" value="' + data[i].ProvinceID + '">' + data[i].ProvinceName + '</option>';
            //                 $('#select-province').append(item);
            //             }
            //         },
            //         error: function (xhr) {
            //         }
            //     });
            // })
            //
            // $(document).on('change', '#select-province', function () {
            //     $('#select-district').children('.option-select-district').not('.default').remove();
            //     $('#select-ward').children('.option-select-ward').not('.default').remove();
            //
            //     //Lấy danh sách các huyện của tỉnh
            //     const seProvince = $('#select-province');
            //     const provinceID = seProvince.val();
            //
            //     if (provinceID == -1) return;
            //
            //     $.ajax({
            //         url: "http://140.238.54.136/api/district",
            //         type: "get",
            //         data: {
            //             provinceID: provinceID
            //         },
            //         beforeSend: function (xhr) {
            //             xhr.setRequestHeader('Authorization', 'Bearer ' + accessToken);
            //         },
            //         success: function (response) {
            //             const res = JSON.parse(response);
            //             let data = res.original.data;
            //             for (let i = 0; i < data.length; i++) {
            //                 let item = '<option  class="option-select-district" value="' + data[i].DistrictID + '">' + data[i].DistrictName + '</option>';
            //                 $('#select-district').append(item);
            //             }
            //         },
            //         error: function (xhr) {
            //         }
            //     });
            // })
            //
            // $(document).on('change', '#select-district', function () {
            //     $('#select-ward').children('.option-select-ward').not('.default').remove();
            //
            //     //Lấy danh sách các huyện của tỉnh
            //     const seDistrict = $('#select-district');
            //     const districtID = seDistrict.val();
            //
            //     if (districtID == -1) return;
            //
            //     $.ajax({
            //         url: "http://140.238.54.136/api/ward",
            //         type: "get",
            //         data: {
            //             districtID: districtID
            //         },
            //         beforeSend: function (xhr) {
            //             xhr.setRequestHeader('Authorization', 'Bearer ' + accessToken);
            //         },
            //         success: function (response) {
            //             const res = JSON.parse(response);
            //             let data = res.original.data;
            //             for (let i = 0; i < data.length; i++) {
            //                 let item = '<option  class="option-select-ward" value="' + data[i].WardCode + '">' + data[i].WardName + '</option>';
            //                 $('#select-ward').append(item);
            //             }
            //         },
            //         error: function (xhr) {
            //         }
            //     });
            // })

        // XÓA ĐỊA CHỈ
        $(document).on("click", ".delete-one", function (e) {
            let id = $(this).val();
            $.ajax({
                url: "/userprofile/deleteInformation",
                type: "get",
                data: {
                    id: id,
                },
                success: function (response) {
                    $(".list-address" + id).html(response);
                },
                error: function (xhr) {
                }
            });
        })
        // THÊM ĐỊA CHỈ
        $('.btn-save-address').click(function () {
            let name = $('#input-name').val();
            let phone = $('#input-number-phone').val();

            let cityId = $('#select-province').val();
            let districtId = $('#select-district').val();
            let detailId = $('#select-ward').val();

            let city = $('option.option-select-province[value=' + cityId + ']').text();
            let district = $('option.option-select-district[value=' + districtId + ']').text();
            let detail = $('option.option-select-ward[value=' + detailId + ']').text();


            if (checkNull(name) || checkNull(phone) || cityId == -1 || districtId == -1 || detailId == -1) {
                return $(".errorAddAddress").css('color', 'red').text("Chưa điền đủ thông tin");
            }

            $.ajax({
                url: "/userprofile/addInformation",
                type: "get",
                data: {
                    name: name,
                    phone: phone,
                    city: city,
                    district: district,
                    detail: detail,
                    cityId: cityId,
                    districtId: districtId,
                    detailId: detailId
                },
                success: function (response) {
                    $('.contain-list-address').append(response);
                },
                error: function (xhr) {
                }
            }).done(function () {
                window.location = "<%=request.getContextPath()%>/showAddress";
            })
            ;
            $('#exampleAddAddress').modal('toggle');
        })

        function checkNull(text) {
            return text.length == 0 || text == null;
        }

        $('.btn-delete-all').click(function () {

            $.ajax({
                url: "/userprofile/deleteAllInformation",
                type: "get", //send it through get method
                data: {},
                success: function (response) {
                    $(".all-address").html(response);
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
            $('#exampleDeleteAllAddress').modal('toggle');

        })
        $('#logout-tab').click(function () {
            window.location = "<%=request.getContextPath()%>/logOut";
        })
    })
</script>
</body>

</html>