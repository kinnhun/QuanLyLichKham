<%@page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Đặt lịch khám bệnh</title>
        <meta name="description" content="">
        <meta name="keywords" content="">

        <!-- Favicons -->
        <link href="${pageContext.request.contextPath}/views/user/assets/img/favicon.png" rel="icon">
        <link href="${pageContext.request.contextPath}/views/user/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/views/user/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

        <!-- Main CSS File -->
        <link href="${pageContext.request.contextPath}/views/user/assets/css/main.css" rel="stylesheet">
        <style>
            .scroll-top {
                margin-right: 4rem;
                margin-bottom: 0.75rem;
                /* các style khác nữa */
            }
        </style>

    </head>

    <body class="starter-page-page">

        <header id="header" class="header sticky-top">

            <div class="topbar d-flex align-items-center">
                <div class="container d-flex justify-content-center justify-content-md-between">
                    <div class="d-none d-md-flex align-items-center">
                        <i class="bi bi-clock me-1"></i>
                        <fmt:formatDate value="${now}" pattern="EEEE, 'ngày' dd/MM/yyyy" />
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="bi bi-phone me-1"></i> Liên hệ:0987654321
                    </div>
                </div>
            </div><!-- End Top Bar -->

            <div class="branding d-flex align-items-center">

                <div class="container position-relative d-flex align-items-center justify-content-end">
                    <a href="index.html" class="logo d-flex align-items-center me-auto">
                        <img src="${pageContext.request.contextPath}/views/user/assets/img/logo.png" alt="">
                        <!-- Uncomment the line below if you also wish to use a text logo -->
                        <!-- <h1 class="sitename">Medicio</h1>  -->
                    </a>

                    <nav id="navmenu" class="navmenu">
                        <ul>
                            <li><a href="#hero">Home</a></li>
                            <li><a href="#about">About</a></li>
                            <li><a href="#services">Services</a></li>
                            <li><a href="#departments">Departments</a></li>
                            <li><a href="#doctors">Doctors</a></li>
                            <li class="dropdown"><a href="#"><span>Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                                <ul>
                                    <li><a href="#">Dropdown 1</a></li>
                                    <li class="dropdown"><a href="#"><span>Deep Dropdown</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                                        <ul>
                                            <li><a href="#">Deep Dropdown 1</a></li>
                                            <li><a href="#">Deep Dropdown 2</a></li>
                                            <li><a href="#">Deep Dropdown 3</a></li>
                                            <li><a href="#">Deep Dropdown 4</a></li>
                                            <li><a href="#">Deep Dropdown 5</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="#">Dropdown 2</a></li>
                                    <li><a href="#">Dropdown 3</a></li>
                                    <li><a href="#">Dropdown 4</a></li>
                                </ul>
                            </li>
                            <li><a href="#contact">Contact</a></li>
                        </ul>
                        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                    </nav>

                    <a class="cta-btn" href="index.html#appointment">Make an Appointment</a>

                </div>

            </div>

        </header>






    </body>

</html>