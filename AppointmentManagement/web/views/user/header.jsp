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
        <style>
            /* Chat Widget Styles */
            #chat-widget {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
            }

            #chat-box {
                position: absolute;
                bottom: 80px;
                right: 0;
                width: 320px;
                height: 500px;
                background: #fff;
                border: 1px solid #ccc;
                border-radius: 12px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.3);
                overflow: hidden;
                display: none; /* Mặc định đóng */
                flex-direction: column;
                transition: all 0.3s ease;
            }

            #chat-box.open {
                display: flex;
            }

            #chat-box .header {
                background-color: #3FBBC0;
                color: white;
                padding: 10px;
                text-align: center;
                font-weight: bold;
                border-top-left-radius: 12px;
                border-top-right-radius: 12px;
                position: relative;
            }

            #chat-close {
                position: absolute;
                top: 5px;
                right: 10px;
                background: transparent;
                border: none;
                color: white;
                font-size: 18px;
                cursor: pointer;
            }

            #chat-messages {
                flex: 1;
                padding: 10px;
                overflow-y: auto;
                background-color: #f9f9f9;
                display: flex;
                flex-direction: column;
            }

            #chat-messages .message {
                margin-bottom: 8px;
                padding: 8px 12px;
                border-radius: 12px;
                max-width: 80%;
                word-wrap: break-word;
                clear: both;
            }

            .user-message {
                background-color: #DCF8C6;
                align-self: flex-end;
                margin-left: auto;
                text-align: right;
            }

            .ai-message {
                background-color: #F1F0F0;
                align-self: flex-start;
                margin-right: auto;
                text-align: left;
            }

            .ai-loading-message {
                background-color: #eee;
                align-self: flex-start;
                margin-right: auto;
                text-align: left;
                font-style: italic;
            }

            #chat-suggestions-inline {
                display: flex;
                flex-wrap: wrap;
                gap: 6px;
            }

            #chat-suggestions-inline .suggestion-btn {
                padding: 6px 12px;
                background-color: #e0f7fa;
                border: 1px solid #3FBBC0;
                border-radius: 20px;
                cursor: pointer;
                font-size: 14px;
            }

            #chat-input {
                width: 100%;
                height: 50px;
                resize: none;
                border-radius: 6px;
                border: 1px solid #ccc;
                padding: 5px;
            }

            #send-btn {
                margin-top: 5px;
                width: 100%;
                padding: 8px;
                background-color: #3FBBC0;
                color: #fff;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }

            #chat-toggle {
                width: 60px;
                height: 60px;
                background-color: #3FBBC0;
                color: #fff;
                border: none;
                border-radius: 50%;
                cursor: pointer;
                box-shadow: 0 4px 8px rgba(0,0,0,0.2);
                font-size: 28px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
        </style>
        <style>
            .pricing-item {
                padding: 30px;
                border: 1px solid #ddd;
                border-radius: 10px;
                text-align: center;
                transition: all 0.3s ease-in-out;
                background: #fff;
            }

            .pricing-item h3 {
                font-size: 24px;
                margin-bottom: 10px;
                color: #333;
            }

            .pricing-item h4 {
                font-size: 18px;
                margin-bottom: 15px;
                color: #555;
            }

            .pricing-item ul {
                list-style: none;
                padding: 0;
                margin: 0 0 20px 0;
            }

            .pricing-item ul li {
                margin-bottom: 10px;
                color: #555;
            }

            .pricing-item .btn-wrap {
                margin-top: 10px;
            }

            .pricing-item .btn-buy {
                display: inline-block;
                padding: 10px 25px;
                border-radius: 5px;
                background: #3fbbc0;
                color: #fff;
                text-decoration: none;
                border: 1px solid #3fbbc0;
                transition: all 0.3s ease-in-out;
            }

            .pricing-item .btn-buy:hover {
                background: #fff;
                color: #3fbbc0;
                border: 1px solid #3fbbc0;
            }

            /* Hover hiệu ứng nổi lên */
            .pricing-item:hover {
                background: #3fbbc0;
                box-shadow: 0px 0px 30px rgba(0, 131, 116, 0.3);
                border-color: #3fbbc0;
                color: #fff;
            }

            .pricing-item:hover h3,
            .pricing-item:hover h4,
            .pricing-item:hover ul li {
                color: #fff;
            }

            .pricing-item:hover .btn-buy {
                background: #fff;
                color: #3fbbc0;
                border-color: #fff;
            }
            /* Cho hàng row dùng flex để các cột cao bằng nhau */
            .row.gy-3 {
                display: flex;
                flex-wrap: wrap;
            }

            /* Cột mỗi bước */
            .row.gy-3 .col-xl-3,
            .row.gy-3 .col-lg-6 {
                display: flex;
            }

            /* Bên trong cột: khung .pricing-item set height 100% */
            .pricing-item {
                padding: 30px;
                border: 1px solid #ddd;
                border-radius: 10px;
                text-align: center;
                transition: all 0.3s ease-in-out;
                background: #fff;
                height: 100%; /* Quan trọng */
                display: flex;
                flex-direction: column;
                justify-content: space-between; /* Để nút "Tiếp tục" luôn ở dưới */
            }

        </style>

    </head>

    <body class="starter-page-page">
        <%@ include file="notification.jsp" %>

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
                            <li><a href="home#hero">Trang chủ</a></li>
                            <li><a href="home#about">Giới thiệu</a></li>
                            <li><a href="home#services">Dịch vụ</a></li>
                            <li><a href="home#doctors">Bác sỹ</a></li>

                            <li><a href="home#contact">Liênn hệ</a></li>
                        </ul>
                        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                    </nav>

                    <!-- Nút đặt lịch + avatar nhóm bên phải -->
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <a class="cta-btn" href="home#appointment">Đặt lịch khám</a>

                        <!-- Nếu chưa đăng nhập -->
                        <c:if test="${empty sessionScope.currentUser}">
                            <a class="cta-btn" href="login">Đăng nhập</a>
                        </c:if>

                        <!-- Nếu đã đăng nhập -->
                        <c:if test="${not empty sessionScope.currentUser}">
                            <!-- Avatar dropdown -->
                            <div class="avatar-dropdown" style="position: relative;">
                                <button id="avatar-btn" style="
                                        width: 40px; height: 40px;
                                        border-radius: 50%;
                                        border: none;
                                        cursor: pointer;
                                        overflow: hidden;
                                        background: #f0f0f0;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        ">
                                    <!-- Avatar image -->
                                    <img src="${sessionScope.user.avatar}" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover;">
                                </button>

                                <!-- Dropdown menu -->
                                <ul id="avatar-dropdown-menu" style="
                                    display: none;
                                    position: absolute;
                                    top: 50px;
                                    right: 0;
                                    background: #fff;
                                    border: 1px solid #ccc;
                                    border-radius: 8px;
                                    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                                    min-width: 150px;
                                    z-index: 1000;
                                    list-style: none;
                                    margin: 0;
                                    padding: 0;
                                    ">
                                    <li><a href="profile" style="display: block; padding: 10px; text-decoration: none; color: #333;">Hồ sơ cá nhân</a></li>
                                    <li><a href="logout" style="display: block; padding: 10px; text-decoration: none; color: #333;">Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:if>
                    </div>

                    <!-- JS để click mở / đóng dropdown -->
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            const avatarBtn = document.getElementById('avatar-btn');
                            const dropdownMenu = document.getElementById('avatar-dropdown-menu');

                            // Click avatar → toggle dropdown
                            avatarBtn.addEventListener('click', function (event) {
                                event.stopPropagation(); // Không cho click lan ra ngoài
                                if (dropdownMenu.style.display === 'block') {
                                    dropdownMenu.style.display = 'none';
                                } else {
                                    dropdownMenu.style.display = 'block';
                                }
                            });

                            // Click ra ngoài → đóng dropdown
                            document.addEventListener('click', function () {
                                dropdownMenu.style.display = 'none';
                            });
                        });
                    </script>




                </div>

            </div>

        </header>






    </body>

</html>