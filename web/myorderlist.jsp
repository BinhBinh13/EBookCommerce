<%-- 
    Document   : myorderlist
    Created on : Mar 17, 2025, 11:44:13 AM
    Author     : Phong vu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.Bill, model.BillDetail" %>
<!doctype html>
<html lang="en">


    <!-- Mirrored from html-template.spider-themes.net/bookjar/my-orders.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:19 GMT -->
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
        <link href="assets/vendors/nice-select/css/nice-select.css" rel="stylesheet">
        <link href="assets/vendors/animation/animate.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="assets/css/responsive.css" rel="stylesheet">
        <title>Bookjar</title>
        <style>
            .my_account_book_title {
                height: 40px;
                overflow: hidden;
            }
            .book_price {
                text-align: center;
                min-height: 30px;
            }
            .d-flex {
                align-items: flex-start;
            }
            .my_account_book {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: space-between;
                height: 100%;
            }
        </style>
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

            <!-- Header area -->
            <header class="header_area header_relative">
                <jsp:include page="common/headerMain.jsp" />
            </header>
            <!-- Header area -->
            <div class="cart-header-separator"></div>


            <!-- Account Dashboard area -->
            <section class="bj_account_dashboard" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="account_dashboard_sidebar">
                                <div class="sidebar_widget_body d-flex account_dashboard_sidebar_profile">
                                    <div class="">
                                        <img src="${avatar}" onerror="this.src='assets/img/people.png';" alt="account">
                                    </div>
                                    <div class="">
                                        <div class="greetings">Hello</div>
                                        <div class="name">${username}</div>

                                    </div>
                                </div>
                                <div class="sidebar_widget_body p-0">
                                    <ul class="sidebar_widget_menu">
                                        <li><a href="userprofile">My Profile</a></li>
                                        <li><a class="active" href="userprofile?action=order_list">My Orders</a></li>
                                        <li><a href="userprofile?action=book_list">My eBook Library </a></li>

                                    </ul>
                                </div>
                            </div>


                        </div>
                        <div class="col-lg-9">
                            <div class="account_dashboard_body">
                                <div class="account_dashboard_content">
                                    <div class="account_dashboard_content_header">
                                        My Orders 

                                    </div>
                                    <div class="content_body">

                                        <div class="my_order_list">
                                            <c:forEach var="bill" items="${billList}">
                                                <div class="single_order_block">
                                                    <div class="order_info">
                                                        Your Order ID: <span class="order_no"><em>${bill.billId}</em>  </span>
                                                        </br>
                                                        <div>Total Price: ${bill.getTotal_money()} đ</div>
                                                    </div>
                                                        
                                                    <div class="order_action">

                                                        <div class="order_status success">${bill.status == 1 ? 'Completed' : 'Checking'}</div>

                                                    </div>

                                                    <div class="d-flex flex-wrap gap-sm-5 justify-content-between justify-content-sm-start" style="text-align: center">
                                                        <c:forEach var="detail" items="${billDetailsMap[bill.billId]}">
                                                            <c:set var="book" value="${bookMap[detail.bookId]}"/>
                                                            <div class="my_account_book">
                                                                <div style="width: 149px; height: 217px" class="my_account_book_img">
                                                                    <img src="${book.coverPics}" alt="${book.bookName}">
                                                                </div>
                                                                <div class="my_account_book_content">
                                                                    <a href="product-single.html?bookId=${book.bookId}">
                                                                        <div class="my_account_book_title"><h6>${book.bookName}</h6></div>
                                                                    </a>
                                                                    <div class="book_price" >
                                                                        <span class="discount_amount">$${detail.price}</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </c:forEach>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>
            <!-- Account Dashboard area -->

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
        <script src="assets/vendors/nice-select/js/jquery.nice-select.min.js"></script>
        <script src="assets/vendors/wow/wow.min.js"></script>
        <script src="assets/js/custom.js"></script>

    </body>


    <!-- Mirrored from html-template.spider-themes.net/bookjar/my-orders.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:19 GMT -->
</html>
