<%-- 
    Document   : userProfile
    Created on : Mar 10, 2025, 6:19:24 PM
    Author     : Phong vu
--%>
<%@page import="java.util.*, model.*" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">


    <!-- Mirrored from html-template.spider-themes.net/bookjar/my-account.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:19 GMT -->
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
         <%
            // Lấy thông tin người dùng từ session
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser == null) {
        %>
            <p class="error">Error: User information not found. Please log in again.</p>
            <a href="login_test.jsp" class="btn">Back to Login</a>
        <%
            } else {
        %>
        <div class="body_wrapper">

            <!-- Modal -->


            <header class="header_area header_relative">
                <jsp:include page="common/headerMain.jsp" />
            </header>

            <div class="cart-header-separator"></div>

            <!-- Dashboard area -->
            <section class="bj_account_dashboard" data-bg-color="#f5f5f5">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="account_dashboard_sidebar">
                                <div class="sidebar_widget_body d-flex account_dashboard_sidebar_profile">
                                    <div class="">
                                        <img src="${avatar}" onerror="this.src='assets/img/user.png';"  alt="account">
                                    </div>
                                    <div class="">
                                        <div class="greetings">Hello</div>
                                        <div class="name">${username}</div>

                                    </div>
                                </div>
                                <div class="sidebar_widget_body p-0">
                                    <ul class="sidebar_widget_menu">
                                        <li><a class="active " href="userprofile">My Profile</a></li>
                                        <li><a href="userprofile?action=order_list">My Orders</a></li>
                                        <li><a href="userprofile?action=book_list">My eBook Library </a></li>
                                    </ul>
                                </div>
                            </div>


                        </div>
                        <div class="col-lg-9">
                            <div class="account_dashboard_body">
                                <div class="account_dashboard_content">
                                    <div class="account_dashboard_content_header">
                                        Personal Information
                                    </div>
                                    <div class="content_body">
                                        <form action="#">
                                            <div class="row gy-4">
                                                <div class="col-12">
                                                    <div class="profile-picture-form">
                                                        <div class="preview"><img class="img-fluid" src="${avatar}" onerror="this.src='assets/img/user.png';" ></div>
                                                        <div class="upload_btn">
                                                             <a href="editCustomer.jsp" >Edit Information</a>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group ">
                                                        <input type="text" class="form-control" value="Full name: ${fullname}" readonly="">

                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group ">
                                                        <input type="text" class="form-control" value="Email: ${email}" readonly="">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group ">
                                                        <input type="text" class="form-control" value="Gender: ${gender}" readonly="">
                                                    </div>
                                                </div>
                                                <div class="col-lg-6">
                                                    <div class="form-group ">
                                                        <input type="text" class="form-control" value="SDT: ${phone}" readonly="">
                                                    </div>
                                                </div>


                                                
                                            </div>
                                           <a href="deleteCustomer.jsp" class="bj_theme_btn mt-3">Remove Account</a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>
            <!-- Dashboard area -->

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
        <script src="assets/vendors/wow/wow.min.js"></script>
        <script src="assets/js/custom.js"></script>
                <%
            }
        %>
    </body>


    <!-- Mirrored from html-template.spider-themes.net/bookjar/my-account.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:19 GMT -->
</html>