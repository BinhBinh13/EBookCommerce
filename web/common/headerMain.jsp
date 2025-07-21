<%-- 
    Document   : headerMain
    Created on : Mar 13, 2025, 11:59:19 AM
    Author     : Phong vu
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.List" %>


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
                    <a class="nav-link" href="shop">Ebook store</a>
                </li>

                <% if (isLoggedIn) { %>
                <li class="nav-item dropdown submenu">
                    <a class="nav-link dropdown-toggle" href="userprofile" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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

                        <div class="dropdown-menu">
                            <ul id="sub_cart">
                                <c:set var="list" value="${sessionScope.cart.getItems()}"/>
                                <c:choose>
                                    <c:when test="${list != null}">
                                        <c:forEach items="${list}" var="b">
                                            <li class="cart-single-item clearfix">
                                                <div class="cart-img">
                                                    <img width="50px" height="70px" src="${b.book.coverPics}" alt="styler" />
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
                                        <li>Cart Emptied!</li> 
                                        </c:otherwise>
                                    </c:choose>
                            </ul>
                            <div class="cart_f">
                                <div class="cart-pricing" id="subtotal">
                                    <p class="total">Total price :<span class="p-total text-end">${sessionScope.total_money}<sup>đ</sup>
                                    </p>
                                </div>
                                <div class="cart-button text-center">
                                    <a href="cart.jsp" class="btn btn-cart get_btn pink">View Cart</a>
                                    <a href="checkout" class="btn btn-cart get_btn dark">Checkout</a>
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
                <i class="fa-regular fa-user"></i>  Login
            </a>
            <% } %>
        </div>
    </div>
</nav>
