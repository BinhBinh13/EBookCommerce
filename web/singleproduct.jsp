<%-- 
    Document   : test
    Created on : Mar 7, 2025, 5:25:43 PM
    Author     : Phong vu
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.*" %>
<!doctype html>
<html lang="en">
    

    <!-- Mirrored from html-template.spider-themes.net/bookjar/product-single.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:13 GMT -->
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
        <link href="assets/vendors/fancybox/jquery.fancybox.min.css" rel="stylesheet">
        <link href="assets/vendors/themify-icon/themify-icons.css" rel="stylesheet">
        <link href="assets/vendors/ui-fliter/jquery-ui.css" rel="stylesheet">
        <link href="assets/vendors/nice-select/css/nice-select.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="assets/css/responsive.css" rel="stylesheet">
        <title>Bookjar</title>
    </head>

    <body data-scroll-animation="true">
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

            <header class="header_area header_relative">
                <jsp:include page="common/headerMain.jsp"/>
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
                        <li class="active">Shop Single</li>
                    </ol>
                </div>
            </section>
            <!-- breadcrumb area  -->

            <section class="product_details_area sec_padding" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="row gy-xl-0 gy-3">
                        <div class="col-xl-9">
                            <div class="bj_book_single me-xl-3">
                                <div class="bj_book_img flip">

                                    <div class="back"><img width="336px" height="500px"class="img-fluid" src="${book.coverPics}" alt=""></div>

                                </div>
                                <div class="bj_book_details">
                                    <h2>${book.bookName}</h2>
                                    <ul class="list-unstyled book_meta">
                                        <li>By: ${book.author}</li>
                                        <li>Category: ${c.categoryName}</li>
                                    </ul>
                                    <div class="price">${book.price}<sup></sup><sup>đ</sup></div>

                                    <ul class="product_meta list-unstyled">
                                        <li><span>Publisher:</span>${s.supplierName}</li>

                                        <li><span>Language:</span>English</li>
                                    </ul>

                                </div>
                            </div>
                            <div class="bj_book_single_tab_area me-xl-3">
                                <ul class="nav nav-tabs bj_book_single_tab" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="nav-link active" id="product_description-tab" data-bs-toggle="tab" data-bs-target="#product_description" type="button" role="tab" aria-controls="product_description" aria-selected="true">Product
                                            Details</button>
                                    </li>
                                </ul>
                                <div class="tab-content bj_book_single_tab_content mt-4">
                                    <div class="tab-pane fade show active" id="product_description" role="tabpanel" aria-labelledby="product_description-tab">
                                        <div class="product_book_content_details">

                                            <div>
                                                <h5 class="content_header mb-2">Description</h5>
                                                <p class="content_text mb-2">${book.description}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3">
                            <div class="product_sidbar">
                                <div class="price_head">Buy new: <span class="price">${book.price}<sup></sup><sup>đ</sup></span></div>


                                <div class="d-flex flex-column gap-3">

                                    <button onclick="buy('${book.bookId}')" class="bj_theme_btn add-to-cart-automated" type="button" data-name="${book.bookName}" data-price="${book.price}" data-img="${book.coverPics}" > <i class="icon_cart_alt"></i>Add to
                                        cart</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <section class="best_selling_pr_area sec_padding" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="section_title section_title_two text-center wow fadeInUp" data-wow-delay="0.2s">
                        <h2 class="title title_two">Other books you may like</h2>
                        <p>Continues to choose other books at our book store</p>
                    </div>

                    <div class="text-center mt-4">
                        <a href="shop" class="bj_theme_btn strock_btn blue_strock_btn wow fadeInUp" data-wow-delay="0.4s">View All</a>
                    </div>
                </div>
            </section>

            <!-- footer area -->
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
        <script src="assets/vendors/slick/slick.min.js"></script>
        <script src="assets/js/comming-soon.js"></script>
        <script src="assets/vendors/isotope/imagesloaded.pkgd.min.js"></script>
        <script src="assets/vendors/isotope/isotope.pkgd.min.js"></script>
        <script src="assets/vendors/parallax/jquery.parallax-scroll.js"></script>
        <script src="assets/vendors/fancybox/jquery.fancybox.min.js"></script>
        <script src="assets/vendors/ui-fliter/jquery-ui.js"></script>
        <script src="assets/vendors/nice-select/js/jquery.nice-select.min.js"></script>
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


    <!-- Mirrored from html-template.spider-themes.net/bookjar/product-single.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:16 GMT -->
</html>