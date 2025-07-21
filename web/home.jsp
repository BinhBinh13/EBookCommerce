<%-- 
    Document   : home
    Created on : Feb 26, 2025, 4:24:57 PM
    Author     : Phong vu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">


    <!-- Mirrored from html-template.spider-themes.net/bookjar/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:11:28 GMT -->
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" href="assets/img/favicon.png" />
        <!-- Bootstrap CSS -->
        <link href="assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/vendors/slick/slick.css" rel="stylesheet" />
        <link href="assets/vendors/slick/slick-theme.css" rel="stylesheet" />
        <link href="assets/vendors/elagent-icon/style.css" rel="stylesheet" />
        <link href="assets/vendors/themify-icon/themify-icons.css" rel="stylesheet" />
        <link href="assets/vendors/animation/animate.css" rel="stylesheet" />
        <link href="assets/vendors/font-awesome/css/all.min.css" rel="stylesheet" />
        <link href="assets/vendors/swiper/swiper.min.css" rel="stylesheet" />
        <link href="assets/vendors/icomoon/style.css" rel="stylesheet" />
        <link href="assets/css/style.css" rel="stylesheet" />
        <link href="assets/css/responsive.css" rel="stylesheet" />
        <title>Bookjar</title>
    </head>

    <body data-scroll-animation="true">
        <% 
    User currentUser = (User) session.getAttribute("currentUser");
    boolean isLoggedIn = (currentUser != null);
        %>


        <div class="body_wrapper">
            <div class="click_capture"></div>
            <header class="header_area header_relative header_blue">
                <nav class="navbar navbar-expand-lg menu_one menu_white" id="header">
                    <div class="container">
                        <a class="navbar-brand sticky_logo" href="home">
                            <img src="assets/img/home/logo-white.svg" alt="logo" />
                            <img src="assets/img/home/logo-dark.svg" alt="logo" />
                        </a>
                        <button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="menu_toggle">
                                <span class="hamburger">
                                    <span></span>
                                    <span></span>
                                    <span></span>
                                </span>
                                <span class="hamburger-cross">
                                    <span></span>
                                    <span></span>
                                </span>
                            </span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">
                            <ul class="navbar-nav menu w_menu ms-auto me-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="home">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="shop">Ebook Store</a>
                                </li>

                                <% if (isLoggedIn) { %>
                                <li class="nav-item dropdown submenu">
                                    <a class="nav-link dropdown-toggle" href="userprofile"   role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        My profile
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li class="nav-item"><a href="userprofile" class="nav-link">User profile</a></li>
                                        <li class="nav-item"><a href="userprofile?action=order_list" class="nav-link">My orders</a></li>
                                        <li class="nav-item"><a href="userprofile?action=book_list" class="nav-link">My library</a></li>
                                    </ul>
                                </li>
                                <% } %>
                                <li class="nav-item">
                                    <a class="nav-link" href="cart.jsp">My cart</a>
                                </li>
                            </ul>

                            <div class="alter_nav">
                                <ul class="navbar-nav search_cart menu">
                                    <li class="nav-item search">
                                        <a class="nav-link search-btn" href="javascript:void(0);"><i class="icon-search"></i></a>
                                        <form action="shop" method="get" class="menu-search-form">
                                            <input type="text" name="action" value="search" hidden="">
                                            <div class="input-group">
                                                <input type="text" name="search" class="form-control" placeholder="Search here.." />
                                                <button type="submit">
                                                    <i class="ti-arrow-right"></i>
                                                </button>
                                            </div>
                                        </form>
                                    </li>
                                    <li class="nav-item shpping-cart dropdown submenu">

                                        <a class="cart-btn nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> 
                                            <i class="ti-shopping-cart"></i>
                                            <div id="count">
                                                <span class="num total-cart-count">${sessionScope.size != null ? sessionScope.size : 0}</span>
                                            </div>
                                        </a>

                                        <div class="dropdown-menu">
                                            <ul id="sub_cart">
                                                <c:set var="list" value="${sessionScope.cart.getItems()}"/>
                                                <c:choose>
                                                    <c:when test="${list != null}">
                                                        <c:forEach items="${list}" var="b">
                                                            <li class="cart-single-item clearfix">
                                                                <div class="cart-img">
                                                                    <img width="50px" height="70px" src="${b.book.coverPics}" alt="styler" onerror="this.src='assets/img/book-single.jpg';" />
                                                                </div>
                                                                <div class="cart-content text-left">
                                                                    <p class="cart-title">
                                                                        <a href="bookdetail?bookid=${b.book.bookId}">${b.book.bookName}</a>
                                                                    </p>
                                                                    <p>${b.book.price}<sup>đ</sup></p>
                                                                </div>
                                                                <div class="cart-remove">
                                                                    <span onclick="remove('${b.book.bookId}')" class="ti-close"></span>
                                                                </div>
                                                            </li>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li>Empty List!</li> 
                                                        </c:otherwise>
                                                    </c:choose>
                                            </ul>
                                            <div class="cart_f">
                                                <div class="cart-pricing" id="subtotal">
                                                    <p class="total">Total price :<span class="p-total text-end">${sessionScope.total_money}<sup>đ</sup>
                                                    </p>
                                                </div>
                                                <div class="cart-button text-center">
                                                    <a href="cart.jsp" class="btn btn-cart get_btn pink">View cart</a>
                                                    <a href="checkout" class="btn btn-cart get_btn dark">Check out</a>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                            <% if (isLoggedIn) { %>
                            <a class="bj_theme_btn strock_btn hidden-sm hidden-xs" href="logout">
                                <i class="fa-regular fa-user"></i> Logout
                            </a>
                            <% } else { %>
                            <a class="bj_theme_btn strock_btn hidden-sm hidden-xs" href="login">
                                <i class="fa-regular fa-user"></i> Login
                            </a>
                            <% } %>
                        </div>
                    </div>
                </nav>
            </header>
            <!-- banner area  -->
            <section class="bj_banner_area banner_animation_03" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="bj_banner_content">

                                <h2 class="wow fadeInUp" data-wow-delay="0.2s">
                                    Reading books th
                                </h2>
                                <p class="wow fadeInUp" data-wow-delay="0.4s">
                                                 Unleash your imagination with epic fantasy sagas, mystical
                                    adventures, and tales of otherworldly realms. Embark on quests
                                    with heroes
                                </p>
                                <div class="d-flex">
                                    <a href="shop" class="bj_theme_btn wow fadeInLeft" data-wow-delay="0.2s">Shop now</a>
                                    <a href="#product_tab_showcase_id" class="bj_theme_btn strock_btn wow fadeInLeft" data-wow-delay="0.3s">Take a tour</a>
                                </div>
                                <div class="d-flex community_info_wrapper wow fadeInUp" data-wow-delay="0.4s">
                                    <div class="community_info">
                                        <h5>Our community</h5>
                                        <div class="people_img">
                                            <div class="avater_img">
                                                <img src="assets/img/home/avater_one.png" alt="" />
                                            </div>
                                            <div class="avater_img">
                                                <img src="assets/img/home/avater2.png" alt="" />
                                            </div>
                                            <div class="avater_img">
                                                <img src="assets/img/home/avater3.png" alt="" />
                                            </div>
                                            <div class="avater_img">
                                                <img src="assets/img/home/avater4.png" alt="" />
                                            </div>
                                            <div class="avater_img">
                                                <i class="fa-solid fa-plus"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="community_info_number">
                                        <div class="number"><span class="counter">100</span>k+</div>
                                        <p>Readers all over the world</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="bj_banner_img">
                                <img class="wow fadeInRight" data-wow-delay="0.4s" src="assets/img/home/girl.png" alt="" />
                                <div class="shape_one">
                                    <img class="layer" data-depth="-0.15" src="assets/img/home/star-one.png" alt="" />
                                </div>
                                <div class="shape_two">
                                    <img class="layer" data-depth="-0.25" src="assets/img/home/star-two.png" alt="" />
                                </div>
                                <div class="shape_three">
                                    <img class="layer" data-depth="-0.15" src="assets/img/home/round.png" alt="" />
                                </div>
                                <div class="shape_four">
                                    <img src="assets/img/home/dot.png" alt="" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- banner area  -->

            <!-- product tab showcase area  -->
            <section class="product_tab_showcase_area sec_padding" id="product_tab_showcase_id">
                <div class="container">
                    <div class="section_title wow fadeInUp">
                        <h2 class="title title_two">Book genres</h2>
                    </div>
                    <div class="row wow fadeInUp" data-wow-delay="0.2s">
                        <div class="col-lg-4">
                            <ul class="nav nav-pills tab_slider_thumb" id="pills-tab-one" role="tablist">
                                <c:forEach items="${sessionScope.listC}" var="c">
                                    <li role="presentation" class="nav-item">
                                        <a class="nav-link ${param.cid == c.getCategoryId() ? 'active' : ''}" 
                                           href="home?cid=${c.getCategoryId()}">
                                            <strong>${c.getCategoryName()}</strong>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                        <div class="col-lg-8">
                            <div class="tab-content" id="pills-tabContent-two">
                                <div class="tab-pane fade show active" role="tabpanel">
                                    <div class="tab_slider_content slick_slider_tab">
                                        <c:forEach items="${requestScope.listBooks}" var="b">
                                            <div class="item">
                                                <div class="bj_new_pr_item">
                                                    <a href="bookdetail?bookid=${b.getBookId()}" class="img">
                                                        <img src="${b.getCoverPics()}" alt="book" class="fixed-size-img" onerror="this.src='assets/img/book-single.jpg';"/>
                                                    </a>
                                                    <div class="bj_new_pr_content_two">
                                                        <div  class="d-flex justify-content-between" style="width: 345px; height: 90px;" >
                                                            <a href="bookdetail?bookid=${b.getBookId()}" ">
                                                                <h5>${b.getBookName()}</h5>
                                                            </a>
                                                            <div class="book_price">
                                                                <sup></sup>${b.getPrice()} <sup>đ</sup>
                                                            </div>
                                                        </div>
                                                        <div class="writer_name">
                                                            <i class="icon-user"></i> <a href="author-single.html">${b.getAuthor()}</a>
                                                        </div>
                                                        <a href="bookdetail?bookid=${b.bookId}" class="bj_theme_btn">View Details</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <div class="text-center mt-4">
                                <a href="shop" class="bj_theme_btn strock_btn blue_strock_btn wow fadeInUp" data-wow-delay="0.4s">View All</a>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- product tab showcase area  -->


            <!-- best selling product area  -->
            <section class="best_selling_pr_area sec_padding" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="section_title section_title_two text-center wow fadeInUp" data-wow-delay="0.2s">
                        <h2 class="title title_two">New Arrivals</h2>
                        <p>Reading books improves your communication skill</p>
                    </div>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-best" role="tabpanel" aria-labelledby="pills-best-tab">
                            <div class="best_slider">
                                <c:forEach items="${requestScope.newArrivals}" var="b">
                                    <div class="item">
                                        <div class="bj_new_pr_item">
                                            <a href="bookdetail?bookid=${b.getBookId()}" class="img">
                                                <img src="${b.getCoverPics()}" alt="book" class="fixed-size-img" onerror="this.src='assets/img/book-single.jpg';"/>
                                            </a>
                                            <div class="bj_new_pr_content_two">
                                                <div class="d-flex justify-content-between" style="width: 215px; height: 86px;">
                                                    <a href="bookdetail?bookid=${b.getBookId()}" ">
                                                        <h7>${b.getBookName()}</h7>
                                                    </a>
                                                    <div class="book_price">
                                                        <sup></sup>${b.getPrice()}<sup>đ</sup>
                                                    </div>
                                                </div>
                                                <div class="writer_name">
                                                    <i class="icon-user"></i> ${b.getAuthor()}
                                                </div>
                                                <a href="bookdetail?bookid=${b.bookId}" class="bj_theme_btn">View Details</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                    </div>
                    <div class="text-center mt-4">
                        <a href="shop" class="bj_theme_btn strock_btn blue_strock_btn wow fadeInUp" data-wow-delay="0.4s">View All</a>
                    </div>
                </div>
            </section>

            <section class="best_selling_pr_area sec_padding">
                <div class="container">
                    <div class="section_title section_title_two text-center wow fadeInUp" data-wow-delay="0.2s">
                        <h2 class="title title_two">BEST SELLING BOOKS</h2>
                        <p>Reading books improves your communication skill</p>
                    </div>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-best" role="tabpanel" aria-labelledby="pills-best-tab">
                            <div class="best_slider">

                                <c:forEach items="${requestScope.bestSellings}" var="b">
                                    <div class="item">
                                        <div class="bj_new_pr_item">
                                            <a href="bookdetail?bookid=${b.getBookId()}" class="img">
                                                <img src="${b.getCoverPics()}" alt="book" class="fixed-size-img" onerror="this.src='assets/img/book-single.jpg';"/>
                                            </a>
                                            <div class="bj_new_pr_content_two">
                                                <div class="d-flex justify-content-between" style="width: 215px; height: 86px;">
                                                    <a href="bookdetail?bookid=${b.getBookId()}" ">
                                                        <h7>${b.getBookName()}</h7>
                                                    </a>
                                                    <div class="book_price">
                                                        <sup></sup>${b.getPrice()}<sup>đ</sup>
                                                    </div>
                                                </div>
                                                <div class="writer_name">
                                                    <i class="icon-user"></i> ${b.getAuthor()}
                                                </div>
                                                <a href="bookdetail?bookid=${b.bookId}" class="bj_theme_btn">View Details</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>

                    </div>
                    <div class="text-center mt-4">
                        <a href="shop" class="bj_theme_btn strock_btn blue_strock_btn wow fadeInUp" data-wow-delay="0.4s">View All</a>
                    </div>
                </div>
            </section>
            <!-- best selling product area  -->
            <!-- footer area css  -->
            <footer class="bj_footer_area_two bj_footer_area_four" data-bg-color="#212833">
                <jsp:include page="common/footer.jsp" />
            </footer>
            <!-- footer area css  -->
        </div>
        <!-- Back to top button -->
        <a id="back-to-top" title="Back to Top"></a>
        <!-- Optional JavaScript; choose one of the two! -->
        <script src="assets/js/jquery-3.6.0.min.js"></script>

        <!-- Option 2: Separate Popper and Bootstrap JS -->

        <script src="assets/js/preloader.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/parallax/parallax.js"></script>
        <script src="assets/vendors/slick/slick.min.js"></script>
        <script src="assets/js/comming-soon.js"></script>
        <script src="assets/js/jquery.counterup.min.js"></script>
        <script src="assets/js/jquery.waypoints.min.js"></script>
        <script src="assets/vendors/swiper/swiper-bundle.min.js"></script>
        <script src="assets/vendors/wow/wow.min.js"></script>
        <script src="assets/js/custom.js"></script>
        <script>
                                                                        function  remove(id) {
                                                                            $.ajax({
                                                                                url: "/EbookCommerce/payment?action=delete_submenu",
                                                                                type: "post",
                                                                                data: {
                                                                                    book_id: id
                                                                                },

                                                                                success: function (response) {
                                                                                    var row = document.getElementById("sub_cart");
                                                                                    row.innerHTML = response;
                                                                                    count();
                                                                                    $.ajax({
                                                                                        url: "/EbookCommerce/payment?action=subtotal",
                                                                                        type: "post",
                                                                                        success: function (response) {
                                                                                            var row = document.getElementById("subtotal");
                                                                                            row.innerHTML = response;
                                                                                        },

                                                                                    });
                                                                                },
                                                                                error: function (xhr) {
                                                                                    alert("An error occurred while processing your request.");
                                                                                }
                                                                            });
                                                                        }
                                                                        function buy(id) {
                                                                            $.ajax({
                                                                                url: "/EbookCommerce/payment?action=add_submenu",
                                                                                type: "post",
                                                                                data: {
                                                                                    book_id: id
                                                                                },

                                                                                success: function (response) {

                                                                                    showToast();
                                                                                    var row = document.getElementById("sub_cart");
                                                                                    row.innerHTML = response;
                                                                                    count();
                                                                                    $.ajax({
                                                                                        url: "/EbookCommerce/payment?action=subtotal",
                                                                                        type: "post",
                                                                                        success: function (response) {
                                                                                            var row = document.getElementById("subtotal");
                                                                                            row.innerHTML = response;
                                                                                        },

                                                                                    });
                                                                                },
                                                                                error: function (xhr) {
                                                                                    alert("An error occurred while processing your request.");
                                                                                }
                                                                            });
                                                                        }
                                                                        function count() {
                                                                            $.ajax({
                                                                                url: "/EbookCommerce/payment?action=size",
                                                                                type: "post",
                                                                                success: function (response) {
                                                                                    var row = document.getElementById("count");
                                                                                    row.innerHTML = response;
                                                                                },
                                                                                error: function (xhr) {
                                                                                    alert("An error occurred while small cart.");
                                                                                }
                                                                            });
                                                                        }
                                                                        function showToast() {
                                                                            var toastEl = document.getElementById("cartToast");
                                                                            var toast = new bootstrap.Toast(toastEl);
                                                                            toast.show();
                                                                        }
        </script>
    </body>

</html>

