<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ocean Resort">
    <meta name="keywords" content="Ocean, Resort, Hotel">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ocean Resort</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Lora:400,700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Cabin:400,500,600,700&display=swap" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/elegant-icons.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/flaticon.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/owl.carousel.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/nice-select.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/jquery-ui.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/magnific-popup.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/slicknav.min.css">
    <link rel="stylesheet" href="<%=ctx%>/assets/customer/css/style.css">
</head>

<body>

<!-- Page Preloader -->
<div id="preloder">
    <div class="loader"></div>
</div>

<!-- Offcanvas Menu -->
<div class="offcanvas-menu-overlay"></div>
<div class="canvas-open">
    <i class="icon_menu"></i>
</div>

<div class="offcanvas-menu-wrapper">
    <div class="canvas-close">
        <i class="icon_close"></i>
    </div>

    <div class="header-configure-area">
        <div class="language-option">
            <img src="<%=ctx%>/assets/customer/img/flag.jpg" alt="">
            <span>EN <i class="fa fa-angle-down"></i></span>
        </div>
        <a href="#" class="bk-btn">Booking Now</a>
    </div>

    <nav class="mainmenu mobile-menu">
        <ul>
            <li><a href="<%=request.getContextPath()%>/views/customer/index.jsp">Home</a></li>
            <li><a href="<%=request.getContextPath()%>/views/customer/rooms.jsp">Rooms</a></li>
            <li><a href="<%=request.getContextPath()%>/views/customer/about-us.jsp">About</a></li>
            <li><a href="<%=request.getContextPath()%>/views/customer/blog.jsp">Blogs</a></li>
            <li><a href="<%=request.getContextPath()%>/views/customer/contact.jsp">Contact</a></li>
            <li><a href="<%=ctx%>/contact">Contact</a></li>
        </ul>
    </nav>
</div>

<!-- Header Section -->
<header class="header-section">

    <div class="top-nav">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <ul class="tn-left">
                        <li><i class="fa fa-phone"></i> (12) 345 67890</li>
                        <li><i class="fa fa-envelope"></i> info@oceanresort.com</li>
                    </ul>
                </div>

                <div class="col-lg-6">
                    <div class="tn-right">
                        <div class="top-social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                        </div>
                        <a href="#" class="bk-btn">Booking Now</a>
                        <div class="language-option">
                            <img src="<%=ctx%>/assets/customer/img/flag.jpg" alt="">
                            <span>EN</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Logo & Menu -->
    <div class="menu-item">
        <div class="container">
            <div class="row">
                <div class="col-lg-2">
                    <div class="logo">
                        <a href="<%=ctx%>/home">
                            <img src="<%=ctx%>/assets/customer/img/logo.png" alt="">
                        </a>
                    </div>
                </div>

                <div class="col-lg-10">
                    <div class="nav-menu">
                        <nav class="mainmenu">
                            <ul>
                                <li><a href="<%=request.getContextPath()%>/views/customer/index.jsp">Home</a></li>
                                <li><a href="<%=request.getContextPath()%>/views/customer/rooms.jsp">Rooms</a></li>
                                <li><a href="<%=request.getContextPath()%>/views/customer/about-us.jsp">About</a></li>
                                <li><a href="<%=request.getContextPath()%>/views/customer/blog.jsp">Blogs</a></li>
                                <li><a href="<%=request.getContextPath()%>/views/customer/contact.jsp">Contact</a></li>
                            </ul>
                        </nav>
                        <div class="nav-right search-switch">
                            <i class="icon_search"></i>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</header>
<!-- Header End -->
