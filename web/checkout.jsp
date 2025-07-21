<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en">


    <!-- Mirrored from html-template.spider-themes.net/bookjar/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:17 GMT -->

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
        <link href="assets/vendors/nice-select/css/nice-select.css" rel="stylesheet">
        <link href="assets/vendors/icomoon/style.css" rel="stylesheet">
        <link href="assets/vendors/themify-icon/themify-icons.css" rel="stylesheet">
        <link href="assets/vendors/animation/animate.css" rel="stylesheet">
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

            <!-- Header area  -->
            <header class="header_area header_relative">
                <jsp:include page="common/headerMain.jsp" />

            </header>

            <div class="cart-header-separator"></div>


            <!-- Checkout area  -->
            <section class="bj_checkout_area" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="row justify-content-center gy-lg-0 gy-4">
                        <div class="col-lg-7">

                            <div class="bj_checkout_content">
                                <div class="content_header">
                                    Hallo ${username}

                                </div>
                                <div class="content_body">

                                    <form class=" row gy-3" action="#" method="post">
                                        <div class="col-md-12 form-group">
                                            <input type="text" class="form-control" id="name" readonly="">
                                            <label class="floating-label">Full name: ${fullname}</label>
                                        </div>
                                        <div class="col-md-12 form-group">
                                            <input type="text" class="form-control" id="phone_no" readonly="">
                                            <label class="floating-label">Email: ${email}</label>
                                        </div>

                                    </form>
                                </div>
                            </div>
                            <form action="checkout" method="post">
                                <div class="cart-happy-return-parent mt-4 mb-0">
                                    <button type="submit"class="bj_theme_btn"> Thanh toán </button>
                                </div>
                            </form>

                        </div>
                        <div class="col-lg-4">
                            <div class="bj_checkout_sidebar">
                                <div class="cart_checkout_summary border-bottom-radius-0">
                                    <div class="cart_checkout_header">
                                        <h5>Total money</h5>
                                    </div>
                                    <div class="cart_checkout_body">
                                        <div class="checkout_item">
                                            <span>Trong khi chuyển khoản nhớ điện vào nội dung nha bạn</span>

                                        </div>
                                        <div class="checkout_item">
                                           <span>Nội dung: AccountID  ${text}</span>

                                        </div>
                                        
                                        <div class="checkout_item">
                                            <span>Total</span>
                                            <span>${totalPrice} đ</span>
                                        </div>

                                    </div>
                                </div>
                                <div class="checkout_promo_apply">

                                    <div class="promo-success">
                                        <img src="assets/img/QR.png" alt="checkout">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <!-- Checkout area  -->



            <!-- footer area -->
            <footer class="bj_footer_area_two bj_footer_area_four" data-bg-color="#212833">
                <jsp:include page="common/footer.jsp" />
            </footer>
            <!-- Footer area  -->
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
        <script src="assets/vendors/nice-select/js/jquery.nice-select.min.js"></script>
        <script src="assets/vendors/parallax/jquery.parallax-scroll.js"></script>
        <script src="assets/vendors/wow/wow.min.js"></script>
        <script src="assets/js/custom.js"></script>

    </body>


    <!-- Mirrored from html-template.spider-themes.net/bookjar/checkout.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:19 GMT -->

</html>