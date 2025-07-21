<%-- 
    Document   : shop
    Created on : Mar 3, 2025, 5:08:44 PM
    Author     : Phong vu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, model.*" %>
<!doctype html>
<html lang="en">


    <!-- Mirrored from html-template.spider-themes.net/bookjar/shop.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:06 GMT -->
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="assets/img/favicon.png">
        <!-- Bootstrap CSS -->
        <link href="assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendors/elagent-icon/style.css" rel="stylesheet">
        <link href="assets/vendors/font-awesome/css/all.min.css" rel="stylesheet">
        <link href="assets/vendors/icomoon/style.css" rel="stylesheet">
        <link href="assets/vendors/themify-icon/themify-icons.css" rel="stylesheet">
        <link href="assets/vendors/animation/animate.css" rel="stylesheet">
        <link href="assets/vendors/ui-fliter/jquery-ui.css" rel="stylesheet">
        <link href="assets/vendors/nice-select/css/nice-select.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="assets/css/responsive.css" rel="stylesheet">
        <title>Bookjar</title>
    </head>

    <body data-scroll-animation="true">
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


        <div class="body_wrapper">
            <div class="toast-container position-fixed p-3">
                <div id="cartToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="toast-header">
                        <strong class="me-auto">Cart Update</strong>
                        <small>just now</small>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                    <div class="toast-body">
                        Item added to the cart!
                    </div>
                </div>
            </div>

            <!-- Modal -->

            <header class="header_area header_relative">
                <jsp:include page="common/headerMain.jsp" />

            </header>
            <!-- breadcrumb area  -->
            <section class="bj_breadcrumb_area text-center banner_animation_03" data-bg-color="#f5f5f5">
                <div class="bg_one" data-bg-image="assets/img/breadcrumb/breadcrumb_banner_bg.png"></div>
                <div class="bd_shape one wow fadeInDown layer" data-wow-delay="0.3s" data-depth="0.5"><img data-parallax='{"y": -50}' src="assets/img/breadcrumb/book_left1.png" alt="">
                </div>
                <div class="bd_shape two wow fadeInUp layer" data-depth="0.6" data-wow-delay="0.4s"><img data-parallax='{"y": 30}' src="assets/img/breadcrumb/book-left2.png" alt="">
                </div>
                <div class="bd_shape three wow fadeInDown layer" data-wow-delay="0.3s" data-depth="0.5"><img data-parallax='{"y": -50}' src="assets/img/breadcrumb/plane-1.png" alt="">
                </div>
                <div class="bd_shape four wow fadeInUp layer" data-depth="0.6" data-wow-delay="0.4s"><img data-parallax='{"y": 30}' src="assets/img/breadcrumb/plan-3.png" alt="">
                </div>
                <div class="bd_shape five wow fadeInUp layer" data-depth="0.6" data-wow-delay="0.4s"><img data-parallax='{"y": 80}' src="assets/img/breadcrumb/plan-2.png" alt="">
                </div>
                <div class="bd_shape six wow fadeInDown layer" data-wow-delay="0.3s" data-depth="0.5"><img data-parallax='{"y": -60}' src="assets/img/breadcrumb/book-right.png" alt="">
                </div>
                <div class="bd_shape seven wow fadeInUp layer" data-depth="0.6" data-wow-delay="0.4s"><img data-parallax='{"x": 50}' src="assets/img/breadcrumb/book-right2.png" alt="">
                </div>
                <div class="container">
                    <h2 class="title wow fadeInUp" data-wow-delay="0.2s">Book Shope</h2>
                    <ol class="breadcrumb justify-content-center wow fadeInUp" data-wow-delay="0.3s">
                        <li><a href="index.html">Home</a></li>
                        <li class="active">Shop Sidebar</li>
                    </ol>
                </div>
            </section>
            <!-- breadcrumb area  -->


            <!-- shop area  -->
            <section class="bj_shop_area sec_padding" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="shop_sidebar">
                                <div class="widget filter_widget">
                                    <h3 class="shop_sidebar_title"><a href="#"><img src="assets/img/shop/filter.svg" alt=""></a>Filter</h3>
                                </div>
                                <div class="widget shop_category_widget">
                                    <h4 class="shop_sidebar_title_small"><i class="icon-category-icon"></i>Category</h4>

                                    <ul class="list-unstyled shop_category_list">
                                        <li><a href="shop">All categories</a></li>
                                            <c:forEach items="${sessionScope.cList}" var="c" begin="1" end="5">
                                            <li><a href="shop?action=category&cId=${c.categoryId}">${c.categoryName}</a></li>
                                            </c:forEach>
                                    </ul>

                                    <div class="collapse" id="categoryCollapse">
                                        <ul class="list-unstyled shop_category_list">
                                            <c:forEach items="${sessionScope.cList}" var="c" begin="6">
                                                <li><a href="shop?action=category&cId=${c.categoryId}">${c.categoryName}</a></li>
                                                </c:forEach>
                                        </ul>
                                    </div>

                                    <!-- Nút Show More -->
                                    <a class="btn btn-primary" data-bs-toggle="collapse" href="#categoryCollapse" role="button">
                                        Show more <i class="ti-angle-down"></i>
                                    </a>
                                </div>


                                <div class="widget author_widget">
                                    <h4 class="shop_sidebar_title_small"><i class="icon-pen"></i>Publishers</h4>
                                    <form action="shop" method="get">
                                        <input type="text" name="action" value="price_filter" hidden="">
                                        <div class="author_choose_list">
                                            <c:forEach items="${sessionScope.sList}" var="s">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" name="supplier" id="${s.supplierId}" value="${s.supplierId}"
                                                    <label for="${s.supplierId}" class="form-check-label">${s.supplierName}</label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                </div>
                                    <input type="text" name="action" value="price_filter" hidden="">
                                    <div class="widget price_widget">
                                        <h4 class="shop_sidebar_title_small"><i class="icon-price"></i>Price</h4>

                                        <div id="slider-range" data-price-min="${sessionScope.minPrice}" data-price-max="${sessionScope.maxPrice}"></div>

                                        <div class="price-filters d-flex justify-content-between">
                                            <div class="left">
                                                <label for="price-filter-min">đ</label>
                                                <input type="number" name="minPrice" id="price-filter-min" placeholder="${sessionScope.minPrice}" min="0">
                                            </div>
                                            <div class="right">
                                                <label for="price-filter-max">đ</label>
                                                <input type="number" name="maxPrice" id="price-filter-max" placeholder="${sessionScope.maxPrice}" min="0">
                                            </div>
                                        </div>

                                        <button type="submit" class="bj_theme_btn w-100 border-0 mt-2">Apply Filter</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-lg-9">
                            <form role="search" method="get" class="pr_search_form input-group" action="shop">
                                <input type="text" name="action" value="search" hidden="">
                                <input type="text" name="search" value="" class="form-control search-field" id="search" placeholder="Serach  off book store..">
                                <button type="submit"><i class="ti-search"></i></button>
                            </form>
                            <div class="shop_top d-flex align-items-center justify-content-between">
                                <div class="shop_menu_left"> ${sessionScope.title}</div>
                                <div class="shop_menu_right d-flex align-items-center justify-content-end">
                                    Sort by
                                    <form class="woocommerce-ordering" method="get">
                                        <select name="orderby" class="orderby selectpickers" onchange="this.form.submit()">
                                            <option value="menu_order" selected>None</option>
                                            <option  value="date">Sort by latest</option>
                                            <option  value="price">Sort by price: low to high</option>
                                            <option value="price-desc">Sort by price: high to low</option>
                                        </select>
                                        <input type="hidden" name="action" value="sort">
                                    </form>
                                </div>
                            </div>
                            <div class="row" id="bookList">
                                <c:forEach items="${sessionScope.listBooks}" var="b">
                                    <div class="col-xl-3 col-lg-4 col-sm-6 projects_item">
                                        <div class="best_product_item best_product_item_two shop_product">
                                            <div class="img">
                                                <a><img src="${b.coverPics}" width="222px" height="252px" onerror="this.src='assets/img/book-single.jpg';"></a>

                                                <button onclick="buy('${b.bookId}')" type="button" class="bj_theme_btn add-to-cart-automated" data-name="${b.bookName}" data-price="${b.price}" data-img="${b.coverPics}">
                                                    <i class="icon_cart_alt"></i>Add To Cart
                                                </button>

                                            </div>
                                            <div class="bj_new_pr_content">
                                                <a href="bookdetail?bookid=${b.bookId}">
                                                    <h4 class="bj_new_pr_title">${b.bookName}</h4>
                                                </a>
                                                <div class="bj_pr_meta d-flex">
                                                    <div class="book_price">${b.price}<sup>đ</sup></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="text-center">
                                <nav aria-label="...">
                                    <ul class="pagination pagi-content">
                                        <li class="page-item ${pageControl.page == 1? 'd-none': ''}" >
                                            <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page-1}"><i class="ti-angle-left"></i>Prev</a>
                                        </li>
                                        <c:forEach begin="1" end="${pageControl.totalPage}" var="pageNumber">
                                            <!-- <li class="page-item active" aria-current="page"><span class="page-link">1</span>
                                            </li> -->
                                            <li class="page-item"><a class="page-link" href="${pageControl.urlPattern}page=${pageNumber}">${pageNumber}</a></li>
                                            </c:forEach>
                                        <li class="page-item ${pageControl.page == pageControl.totalPage ? 'd-none': ''}">
                                            <a class="page-link" href="${pageControl.urlPattern}page=${pageControl.page+1}">Next<i class="ti-angle-right"></i></a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- shop area  -->

            <!-- footer area css  -->
            <footer class="bj_footer_area_two bj_footer_area_four" data-bg-color="#212833">
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
        <script src="assets/vendors/isotope/imagesloaded.pkgd.min.js"></script>
        <script src="assets/vendors/parallax/jquery.parallax-scroll.js"></script>
        <script src="assets/vendors/ui-fliter/jquery-ui.js"></script>
        <script src="assets/vendors/nice-select/js/jquery.nice-select.min.js"></script>
        <script src="assets/vendors/wow/wow.min.js"></script>
        <script src="assets/js/custom.js"></script>


    </body>


    <!-- Mirrored from html-template.spider-themes.net/bookjar/shop.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:13 GMT -->
</html>
