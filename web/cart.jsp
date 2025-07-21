<%-- 
    Document   : cart
    Created on : Mar 11, 2025, 1:30:03 PM
    Author     : Phong vu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.*"%>
<!doctype html>
<html lang="en">


    <!-- Mirrored from html-template.spider-themes.net/bookjar/cart.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:16 GMT -->
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="assets/img/favicon.png">
        <!-- Bootstrap CSS -->
        <link href="assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendors/slick/slick.css" rel="stylesheet">
        <link href="assets/vendors/slick/slick-theme.css" rel="stylesheet">
        <link href="assets/vendors/elagent-icon/style.css" rel="stylesheet">
        <link href="assets/vendors/font-awesome/css/all.min.css" rel="stylesheet">
        <link href="assets/vendors/icomoon/style.css" rel="stylesheet">
        <link href="assets/vendors/themify-icon/themify-icons.css" rel="stylesheet">
        <link href="assets/vendors/animation/animate.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="assets/css/responsive.css" rel="stylesheet">
        <title>Bookjar</title>
    </head>

    <body data-scroll-animation="true">
        <script>
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


            function big_remove(id) {
                if (confirm("Do you want to delete?")) {
                    $.ajax({
                        url: "/EbookCommerce/payment?action=delete",
                        type: "post",
                        data: {
                            book_id: id
                        },
                        success: function (response) {
                            var row = document.getElementById("content");
                            row.innerHTML = response;
                            count();
                            $.ajax({
                                url: "/EbookCommerce/payment?action=total",
                                type: "post",
                                success: function (response) {
                                    var row = document.getElementById("total_money");
                                    row.innerHTML = response;
                                },

                            });
                        },
                    });
                }
            }
        </script>
        <div id="preloader">
            <div id="ctn-preloader" class="ctn-preloader">
                <div class="round_spinner">
                    <div class="spinner"></div>
                    <div class="text">
                        <img src="assets/img/favicon.png" alt="Image">
                        <h4><span>Bookjar</span></h4>
                    </div>
                </div>
                <h2 class="head">Did You Know?</h2>
                <p></p>
            </div>
        </div>

        <!-- Header area  -->
        <nav class="navbar navbar-expand-lg menu_one" id="header">
            <div class="container">
                <a class="navbar-brand" href="home"><img src="assets/img/home/logo-dark.svg" alt="logo"></a>
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
                <% 
                    // Lấy thông tin user từ session
                    User currentUser = (User) session.getAttribute("currentUser");
                    boolean isLoggedIn = (currentUser != null);
                %>

                <div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">
                    <ul class="navbar-nav menu w_menu ms-auto me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="shop">EbookStore</a>
                        </li>

                        <% if (isLoggedIn) { %>
                        <li class="nav-item dropdown submenu">
                            <a class="nav-link dropdown-toggle" href="userprofile"  role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                My profile
                            </a>
                            <ul class="dropdown-menu">
                                <li class="nav-item"><a href="userprofile" class="nav-link">User profile</a></li>
                                <li class="nav-item"><a href="userprofile?action=order_list" class="nav-link">Orders</a></li>
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
                                <form action="search" method="get" class="menu-search-form">
                                    <div class="input-group">
                                        <input type="search" class="form-control" placeholder="Search here.." />
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
                                        <span class="num total-cart-count">${sessionScope.size == null ? 0 : sessionScope.size}</span>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <% if (isLoggedIn) { %>
                    <a class="bj_theme_btn strock_btn hidden-sm hidden-xs" href="logout">
                        <i class="fa-regular fa-user"></i> Logout
                    </a>
                    <% } else { %>
                    <a class="bj_theme_btn strock_btn hidden-sm hidden-xs" href="login">
                        <i class="fa-regular fa-user"></i>  Login
                    </a>
                    <% } %>
                </div>
            </div>
        </nav>
        <div class="cart-header-separator"></div>


        <!-- Cart area  -->
        <div class="cart-header-alert pt-3" data-bg-color="#f5f5f5">
            <div class="container">
                <div class="alert alert-warning alert-dismissible fade show  mb-0" role="alert">
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    <h6>Dear customer,</h6>

                    <p>
                        Thank you for your trust and support! We truly appreciate your loyalty and patience. 
                        Your satisfaction is our top priority, and we are committed to providing you with the best service possible. If you have any questions or need assistance,
                                            please don't hesitate to reach out.
                        Once again, thank you for choosing us! </p>

                </div>

            </div>
        </div>

        <section class="bj_cart_area" data-bg-color="#f5f5f5">
            <div class="container">
                <div class="row gy-lg-0 gy-3">
                    <div class="col-lg-8">
                        <div id="your_total" class="bj_cart_content_header">
                            <div>
                                Hallo
                            </div>
                        </div>
                        <div id="content" class="cart_item_wrapper">
                            <c:set var="list" value="${sessionScope.cart.getItems()}"/>
                            <c:forEach items="${list}" var="b">
                                <div class="single_cart_item">
                                    <div >
                                        <img width="100px" height="120px" src="${b.book.coverPics}" alt="cart">
                                    </div>
                                    <div class="cart_item_content">
                                        <a href="product-single.html" class="book_name">${b.book.bookName}</a>
                                        <div class="author_name">${b.book.author}</div>
                                        <div class="cart_action">
                                            <button onclick="big_remove('${b.book.bookId}')" class="cart_remove"><i class="ti-trash"></i></button>
                                        </div>
                                    </div>
                                    <div class="cart_quantity">

                                    </div>


                                    <div class="cart_item_price">
                                        <div class="cart_item_price_discount">${b.book.price}</div>
                                        <div class="cart_item_price_mrp"></div>
                                    </div>

                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="cart_checkout_summary">
                            <div class="cart_checkout_header">
                                <h5>Checkout Summary</h5>
                            </div>
                            <div id="sum" class="cart_checkout_body">
                                <div id="total_money" class="checkout_item strong">
                                    <span>Total money</span>
                                    <span id="total"><sup></sup>${total_money} <sup>đ</sup></span>
                                </div>
                            </div>
                        </div>

                        <div class="cart_proceed_checkout mt-3">


                            <a href="checkout" class="bj_theme_btn w-100 border-0 mt-2">Proceed to Checkout <i class="arrow_right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Cart area  -->





    <!-- footer area -->
    <footer  class="bj_footer_area_two bj_footer_area_four" data-bg-color="#212833">
        <jsp:include page="common/footer.jsp" />
    </footer>
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
<script src="assets/vendors/isotope/imagesloaded.pkgd.min.js"></script>
<script src="assets/vendors/parallax/jquery.parallax-scroll.js"></script>
<script src="assets/vendors/wow/wow.min.js"></script>
<script src="assets/js/custom.js"></script>

</body>


<!-- Mirrored from html-template.spider-themes.net/bookjar/cart.jsp by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:17 GMT -->
</html>