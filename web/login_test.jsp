<%-- 
    Document   : login_test
    Created on : Mar 10, 2025, 4:28:53 PM
    Author     : Phong vu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">


    <!-- Mirrored from html-template.spider-themes.net/bookjar/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:25 GMT -->
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" href="assets/img/favicon.png">
        <!-- Bootstrap CSS -->
        <link href="assets/vendors/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendors/elagent-icon/style.css" rel="stylesheet">
        <link href="assets/vendors/font-awesome/css/all.min.css" rel="stylesheet">
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
            <div class="login-area">
                <div class="bg-shapes">
                    <img class="wow fadeIn" src="assets/img/login/heart-shape-01.png" alt="Image">
                    <img class="wow fadeInLeft" src="assets/img/login/heart-shape-02.png" alt="Image">
                    <img class="wow fadeInLeft" src="assets/img/login/heart-shape-03.png" alt="Image">
                    <img class="wow " src="assets/img/login/heart-shape-04.png" alt="Image">
                </div>
                <div class="login-wrapper">
                    <div class="login-left">
                        <a style="font-weight: "bold"; font-size: 25px" href="home" class="logo"><img src="assets/img/home/logo-dark.svg" alt="Image">  BACK TO HOME</a>
                        <h2 class="title">Login to Your Account</h2>
                        <div class="sibtitle">Welcome Back!</div>
                        <% String errorMessage = (String) request.getAttribute("error"); %>
                        <% if (errorMessage != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= errorMessage %>
                        </div>
                        <% } %>
                        <form action="login" method="post">
                            <div class="input-field">
                                <input type="text" name ="username" class="form-control" placeholder="Enter username">
                            </div>
                            <div class="input-field pass-field-with-icon">
                                <input type="password" name = "password" class="form-control" id="toggle_passowrd_field" placeholder="Password">
                                <i data-toggleTarget="#toggle_passowrd_field" class="icon fas fa-eye toggle-password"></i>
                            </div>
                            <div class="d-flex justify-content-between input-field">

                                <a href="forgotpassword.jsp" class="forget-password">Forgot Password?</a>
                            </div>
                            <button type="submit" class="bj_theme_btn w-100 border-0">Log In</button>
                        </form>
                        <div class="new-user">
                            New user?<a href="register.jsp"> Create an account</a>
                        </div>
                    </div>
                    <div class="login-right">
                        <img src="assets/img/login/login-img.png" alt="Image">
                    </div>
                </div>
            </div>
        </div>
        <!-- Optional JavaScript; choose one of the two! -->
        <script src="assets/js/jquery-3.6.0.min.js"></script>

        <!-- Option 2: Separate Popper and Bootstrap JS -->

        <script src="assets/js/preloader.js"></script>
        <script src="assets/vendors/bootstrap/js/popper.min.js"></script>
        <script src="assets/vendors/bootstrap/js/bootstrap.min.js"></script>
        <script src="assets/vendors/wow/wow.min.js"></script>
        <script src="assets/js/custom.js"></script>

    </body>


    <!-- Mirrored from html-template.spider-themes.net/bookjar/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 26 Feb 2025 08:13:28 GMT -->
</html>