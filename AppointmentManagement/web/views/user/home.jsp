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


    </head>

    <body class="starter-page-page">

        <%@ include file="header.jsp" %>


        <main class="main">

            <section id="hero" class="hero section">

                <div id="hero-carousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="5000">

                    <div class="carousel-item active">
                        <img src="${pageContext.request.contextPath}/views/user/assets/img/hero-carousel/hero-carousel-1.jpg" alt="">
                        <div class="container">
                            <h2>Chào mừng bạn đến với hệ thống đặt lịch khám bệnh Medicio</h2>
                            <p>Chúng tôi cung cấp dịch vụ đặt lịch khám bệnh trực tuyến nhanh chóng, thuận tiện và an toàn. 
                                Hãy chọn bác sĩ, chuyên khoa phù hợp và đặt lịch hẹn ngay hôm nay để được phục vụ tốt nhất.</p>
                            <a href="#about" class="btn-get-started">Tìm hiểu thêm</a>
                        </div>

                    </div><!-- End Carousel Item -->

                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/views/user/assets/img/hero-carousel/hero-carousel-2.jpg" alt="">
                        <div class="container">
                            <h2>Đăng ký khám bệnh dễ dàng và tiện lợi</h2>
                            <p>Bạn có thể chủ động chọn bác sĩ, chuyên khoa và thời gian khám phù hợp. Hệ thống hỗ trợ đặt lịch nhanh chóng, giảm thiểu thời gian chờ đợi và tối ưu trải nghiệm chăm sóc sức khỏe cho bạn và gia đình.</p>
                            <a href="#about" class="btn-get-started">Tìm hiểu thêm</a>
                        </div>

                    </div><!-- End Carousel Item -->

                    <div class="carousel-item">
                        <img src="${pageContext.request.contextPath}/views/user/assets/img/hero-carousel/hero-carousel-3.jpg" alt="">
                        <div class="container">
                            <h2>Chăm sóc sức khỏe chủ động cùng bạn</h2>
                            <p>Chúng tôi cam kết mang đến trải nghiệm đặt lịch khám bệnh an toàn và tiện lợi. Dễ dàng lựa chọn bác sĩ, đặt lịch theo nhu cầu, theo dõi lịch sử khám và nhận thông báo nhắc lịch để bạn luôn chủ động trong việc chăm sóc sức khỏe bản thân và gia đình.</p>
                            <a href="#about" class="btn-get-started">Tìm hiểu thêm</a>
                        </div>

                    </div><!-- End Carousel Item -->

                    <a class="carousel-control-prev" href="#hero-carousel" role="button" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon bi bi-chevron-left" aria-hidden="true"></span>
                    </a>

                    <a class="carousel-control-next" href="#hero-carousel" role="button" data-bs-slide="next">
                        <span class="carousel-control-next-icon bi bi-chevron-right" aria-hidden="true"></span>
                    </a>

                    <ol class="carousel-indicators"></ol>

                </div>

            </section>

            <!-- Featured Services Section -->
            <section id="featured-services" class="featured-services section">

                <div class="container">

                    <div class="row gy-4">

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="100">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="fas fa-heartbeat icon"></i></div>
                                <h4><a href="#" class="stretched-link">Khám tổng quát</a></h4>
                                <p>Kiểm tra sức khỏe tổng quát định kỳ giúp phát hiện sớm các vấn đề sức khỏe và phòng ngừa bệnh hiệu quả.</p>
                            </div>

                        </div><!-- End Service Item -->

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="200">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="fas fa-pills icon"></i></div>
                                <h4><a href="#" class="stretched-link">Cấp phát thuốc & tư vấn điều trị</a></h4>
                                <p>Dịch vụ cấp phát thuốc theo đơn và tư vấn sử dụng thuốc an toàn, giúp người bệnh yên tâm trong quá trình điều trị.</p>
                            </div>

                        </div><!-- End Service Item -->

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="300">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="fas fa-thermometer icon"></i></div>
                                <h4><a href="#" class="stretched-link">Khám và theo dõi dấu hiệu sinh tồn</a></h4>
                                <p>Dịch vụ đo và theo dõi nhiệt độ, huyết áp, nhịp tim giúp đánh giá tình trạng sức khỏe hiện tại của người bệnh.</p>
                            </div>

                        </div><!-- End Service Item -->

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="400">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="fas fa-dna icon"></i></div>
                                <h4><a href="#" class="stretched-link">Xét nghiệm & chẩn đoán</a></h4>
                                <p>Dịch vụ xét nghiệm máu, sinh hóa, miễn dịch, di truyền giúp hỗ trợ chẩn đoán chính xác và theo dõi tình trạng bệnh.</p>
                            </div>

                        </div><!-- End Service Item -->

                    </div>

                </div>

            </section><!-- /Featured Services Section -->

            <!-- Call To Action Section -->
            <section id="call-to-action" class="call-to-action section accent-background">

                <div class="container">
                    <div class="row justify-content-center" data-aos="zoom-in" data-aos-delay="100">
                        <div class="col-xl-10">
                            <div class="text-center">
                                <h3>Trường hợp khẩn cấp? Cần hỗ trợ ngay?</h3>
                                <p>Nếu bạn cần hỗ trợ y tế khẩn cấp hoặc cần đặt lịch khám gấp, vui lòng liên hệ với chúng tôi hoặc đặt lịch trực tuyến ngay để được phục vụ kịp thời và tận tâm.</p>
                                <a class="cta-btn" href="#appointment">Đặt lịch khám ngay</a>
                            </div>

                        </div>
                    </div>
                </div>

            </section><!-- /Call To Action Section -->

            <!-- About Section -->
            <section id="about" class="about section">

                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Về chúng tôi<br></h2>
                    <p>Chúng tôi cam kết mang đến dịch vụ khám chữa bệnh chất lượng cao, đội ngũ bác sĩ chuyên môn giỏi, tận tâm và hệ thống đặt lịch khám trực tuyến thuận tiện cho mọi khách hàng.</p>
                </div><!-- End Section Title -->


                <div class="container">

                    <div class="row gy-4">
                        <div class="col-lg-6 position-relative align-self-start" data-aos="fade-up" data-aos-delay="100">
                            <img src="${pageContext.request.contextPath}/views/user/assets/img/about.jpg" class="img-fluid" alt="">
                            <a href="https://www.youtube.com/watch?v=JA_xgZ1wLn0" class="glightbox pulsating-play-btn"></a>
                        </div>
                        <div class="col-lg-6 content" data-aos="fade-up" data-aos-delay="200">
                            <h3>Dịch vụ khám chữa bệnh tận tâm và chuyên nghiệp</h3>
                            <p class="fst-italic">
                                Chúng tôi không ngừng nâng cao chất lượng dịch vụ, mang đến trải nghiệm khám chữa bệnh an toàn, hiệu quả và thuận tiện cho mọi khách hàng.
                            </p>
                            <ul>
                                <li><i class="bi bi-check2-all"></i> <span>Đặt lịch khám trực tuyến nhanh chóng, dễ dàng mọi lúc mọi nơi.</span></li>
                                <li><i class="bi bi-check2-all"></i> <span>Đội ngũ bác sĩ chuyên môn cao, giàu kinh nghiệm và tận tâm.</span></li>
                                <li><i class="bi bi-check2-all"></i> <span>Hệ thống quản lý thông tin khám chữa bệnh minh bạch, bảo mật và đồng bộ.</span></li>
                            </ul>
                            <p>
                                Chúng tôi cam kết đồng hành cùng khách hàng trong việc chăm sóc sức khỏe toàn diện, từ khâu đặt lịch khám đến theo dõi kết quả và điều trị. Sự hài lòng và an toàn của bạn chính là mục tiêu hàng đầu của chúng tôi.
                            </p>
                        </div>

                    </div>

                </div>

            </section><!-- /About Section -->

            <!-- Stats Section -->
            <section id="stats" class="stats section">

                <div class="container" data-aos="fade-up" data-aos-delay="100">

                    <div class="row gy-4">

                        <div class="col-lg-3 col-md-6">
                            <div class="stats-item d-flex align-items-center w-100 h-100">
                                <i class="fas fa-user-md flex-shrink-0"></i>
                                <div>
                                    <span data-purecounter-start="0" data-purecounter-end="25" data-purecounter-duration="1" class="purecounter"></span>
                                    <p>Bác sĩ</p>
                                </div>
                            </div>
                        </div><!-- End Stats Item -->

                        <div class="col-lg-3 col-md-6">
                            <div class="stats-item d-flex align-items-center w-100 h-100">
                                <i class="far fa-hospital flex-shrink-0"></i>
                                <div>
                                    <span data-purecounter-start="0" data-purecounter-end="15" data-purecounter-duration="1" class="purecounter"></span>
                                    <p>Chuyên khoa</p>
                                </div>
                            </div>
                        </div><!-- End Stats Item -->

                        <div class="col-lg-3 col-md-6">
                            <div class="stats-item d-flex align-items-center w-100 h-100">
                                <i class="fas fa-flask flex-shrink-0"></i>
                                <div>
                                    <span data-purecounter-start="0" data-purecounter-end="8" data-purecounter-duration="1" class="purecounter"></span>
                                    <p>Phòng xét nghiệm</p>

                                </div>
                            </div>
                        </div><!-- End Stats Item -->

                        <div class="col-lg-3 col-md-6">
                            <div class="stats-item d-flex align-items-center w-100 h-100">
                                <i class="fas fa-award flex-shrink-0"></i>
                                <div>
                                    <span data-purecounter-start="0" data-purecounter-end="150" data-purecounter-duration="1" class="purecounter"></span>
                                    <p>Giải thưởng</p>

                                </div>
                            </div>
                        </div><!-- End Stats Item -->

                    </div>

                </div>

            </section><!-- /Stats Section -->

            <!-- Features Section -->
            <section id="features" class="features section">

                <div class="container">

                    <div class="row justify-content-around gy-4">
                        <div class="features-image col-lg-6" data-aos="fade-up" data-aos-delay="100"><img src="${pageContext.request.contextPath}/views/user/assets/img/features.jpg" alt=""></div>

                        <div class="col-lg-5 d-flex flex-column justify-content-center" data-aos="fade-up" data-aos-delay="200">
                            <h3>Dịch vụ y tế chất lượng, tận tâm vì sức khỏe cộng đồng</h3>
                            <p>Chúng tôi không ngừng cải tiến và nâng cao chất lượng dịch vụ để mang đến trải nghiệm chăm sóc sức khỏe tốt nhất cho khách hàng. Đặt lịch khám thuận tiện, bác sĩ chuyên nghiệp, cơ sở vật chất hiện đại.</p>

                            <div class="icon-box d-flex position-relative" data-aos="fade-up" data-aos-delay="300">
                                <i class="fa-solid fa-hand-holding-medical flex-shrink-0"></i>
                                <div>
                                    <h4><a href="#" class="stretched-link">Đội ngũ bác sĩ giàu kinh nghiệm</a></h4>
                                    <p>Hội tụ các bác sĩ chuyên khoa hàng đầu, tận tâm trong chẩn đoán và điều trị cho từng khách hàng.</p>
                                </div>
                            </div><!-- End Icon Box -->

                            <div class="icon-box d-flex position-relative" data-aos="fade-up" data-aos-delay="400">
                                <i class="fa-solid fa-suitcase-medical flex-shrink-0"></i>
                                <div>
                                    <h4><a href="#" class="stretched-link">Trang thiết bị hiện đại</a></h4>
                                    <p>Ứng dụng công nghệ tiên tiến, trang thiết bị đạt chuẩn giúp hỗ trợ chẩn đoán chính xác và điều trị hiệu quả.</p>
                                </div>
                            </div><!-- End Icon Box -->

                            <div class="icon-box d-flex position-relative" data-aos="fade-up" data-aos-delay="500">
                                <i class="fa-solid fa-staff-snake flex-shrink-0"></i>
                                <div>
                                    <h4><a href="#" class="stretched-link">Quy trình khám chữa bệnh nhanh chóng</a></h4>
                                    <p>Đặt lịch khám trực tuyến, giảm thời gian chờ đợi, quy trình khép kín và thuận tiện cho người bệnh.</p>
                                </div>
                            </div><!-- End Icon Box -->

                            <div class="icon-box d-flex position-relative" data-aos="fade-up" data-aos-delay="600">
                                <i class="fa-solid fa-lungs flex-shrink-0"></i>
                                <div>
                                    <h4><a href="#" class="stretched-link">Chăm sóc toàn diện sau khám</a></h4>
                                    <p>Hỗ trợ tư vấn sau khám, theo dõi kết quả và đồng hành cùng khách hàng trong suốt quá trình chăm sóc sức khỏe.</p>
                                </div>
                            </div><!-- End Icon Box -->

                        </div>

                    </div>

                </div>

            </section><!-- /Features Section -->

            <!-- Services Section -->
            <section id="services" class="services section">

                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Dịch vụ</h2>
                    <p>Chúng tôi cung cấp đa dạng các dịch vụ khám chữa bệnh chất lượng cao, đáp ứng nhu cầu chăm sóc sức khỏe toàn diện cho bạn và gia đình.</p>
                </div>
                <!-- End Section Title -->


                <div class="container">

                    <div class="row gy-4">

                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="100">
                            <div class="service-item  position-relative">
                                <div class="icon">
                                    <i class="fas fa-heartbeat"></i>
                                </div>
                                <a href="#" class="stretched-link">
                                    <h3>Khám chuyên khoa sâu</h3>
                                </a>
                                <p>Đội ngũ bác sĩ chuyên khoa nhiều kinh nghiệm, trang thiết bị hiện đại giúp chẩn đoán chính xác và điều trị hiệu quả các bệnh lý phức tạp.</p>

                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="200">
                            <div class="service-item position-relative">
                                <div class="icon">
                                    <i class="fas fa-pills"></i>
                                </div>
                                <a href="#" class="stretched-link">
                                    <h3>Đặt lịch khám trực tuyến</h3>
                                </a>
                                <p>Hệ thống đặt lịch khám trực tuyến nhanh chóng, tiện lợi giúp bạn chủ động lựa chọn thời gian khám phù hợp, giảm thiểu thời gian chờ đợi.</p>

                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="300">
                            <div class="service-item position-relative">
                                <div class="icon">
                                    <i class="fas fa-hospital-user"></i>
                                </div>
                                <a href="#" class="stretched-link">
                                    <h3>Hỗ trợ bảo hiểm y tế</h3>
                                </a>
                                <p>Chấp nhận thanh toán qua các loại bảo hiểm y tế, giúp khách hàng an tâm hơn về chi phí khám chữa bệnh khi sử dụng dịch vụ tại phòng khám.</p>
                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="400">
                            <div class="service-item position-relative">
                                <div class="icon">
                                    <i class="fas fa-dna"></i>
                                </div>
                                <a href="#" class="stretched-link">
                                    <h3>Quản lý hồ sơ khám bệnh</h3>
                                </a>
                                <p>Hệ thống quản lý hồ sơ khám chữa bệnh đồng bộ, giúp khách hàng dễ dàng tra cứu lịch sử khám và theo dõi quá trình điều trị một cách hiệu quả và an toàn.</p>
                                <a href="#" class="stretched-link"></a>
                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="500">
                            <div class="service-item position-relative">
                                <div class="icon">
                                    <i class="fas fa-wheelchair"></i>
                                </div>
                                <a href="#" class="stretched-link">
                                    <h3>Chăm sóc sức khỏe sau khám</h3>
                                </a>
                                <p>Dịch vụ chăm sóc và tư vấn sau khám giúp khách hàng theo dõi tình trạng sức khỏe, hỗ trợ quá trình hồi phục và phòng ngừa tái phát bệnh.</p>
                                <a href="#" class="stretched-link"></a>
                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-lg-4 col-md-6" data-aos="fade-up" data-aos-delay="600">
                            <div class="service-item position-relative">
                                <div class="icon">
                                    <i class="fas fa-notes-medical"></i>
                                </div>
                                <a href="#" class="stretched-link">
                                    <h3>Hỗ trợ tư vấn trực tuyến</h3>
                                </a>
                                <p>Dịch vụ tư vấn sức khỏe trực tuyến giúp khách hàng được giải đáp thắc mắc và nhận lời khuyên từ bác sĩ mọi lúc, mọi nơi, trước khi đến khám trực tiếp.</p>
                                <a href="#" class="stretched-link"></a>
                            </div>
                        </div><!-- End Service Item -->

                    </div>

                </div>

            </section><!-- /Services Section -->

            <!-- Appointment Section -->
            <section id="appointment" class="appointment section light-background">

                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Đặt lịch khám</h2>
                    <p>Hệ thống đặt lịch khám trực tuyến nhanh chóng và tiện lợi, giúp bạn chủ động lựa chọn thời gian khám phù hợp với nhu cầu của mình.</p>

                </div><!-- End Section Title -->

                <div class="container" data-aos="fade-up" data-aos-delay="100">

                    <form action="forms/appointment.php" method="post" role="form" class="php-email-form">
                        <div class="row">
                            <div class="col-md-4 form-group">
                                <input type="text" name="name" class="form-control" id="name" placeholder="Your Name" required="">
                            </div>
                            <div class="col-md-4 form-group mt-3 mt-md-0">
                                <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" required="">
                            </div>
                            <div class="col-md-4 form-group mt-3 mt-md-0">
                                <input type="tel" class="form-control" name="phone" id="phone" placeholder="Your Phone" required="">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 form-group mt-3">
                                <input type="datetime-local" name="date" class="form-control datepicker" id="date" placeholder="Appointment Date" required="">
                            </div>
                            <div class="col-md-4 form-group mt-3">
                                <select name="department" id="department" class="form-select" required="">
                                    <option value="">Select Department</option>
                                    <option value="Department 1">Department 1</option>
                                    <option value="Department 2">Department 2</option>
                                    <option value="Department 3">Department 3</option>
                                </select>
                            </div>
                            <div class="col-md-4 form-group mt-3">
                                <select name="doctor" id="doctor" class="form-select" required="">
                                    <option value="">Select Doctor</option>
                                    <option value="Doctor 1">Doctor 1</option>
                                    <option value="Doctor 2">Doctor 2</option>
                                    <option value="Doctor 3">Doctor 3</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group mt-3">
                            <textarea class="form-control" name="message" rows="5" placeholder="Message (Optional)"></textarea>
                        </div>
                        <div class="mt-3">
                            <div class="loading">Loading</div>
                            <div class="error-message"></div>
                            <div class="sent-message">Your appointment request has been sent successfully. Thank you!</div>
                            <div class="text-center"><button type="submit">Make an Appointment</button></div>
                        </div>
                    </form>

                </div>

            </section><!-- /Appointment Section -->


            <!-- Doctors Section -->
            <section id="doctors" class="doctors section light-background">

                <!-- Tiêu đề phần -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Bác sĩ</h2>
                    <p>Chúng tôi có đội ngũ bác sĩ chuyên môn cao, tận tâm và giàu kinh nghiệm, luôn sẵn sàng phục vụ bạn.</p>
                </div>
                <!-- Kết thúc tiêu đề phần -->


                <div class="container">

                    <div class="row gy-4">

                        <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100">
                            <div class="team-member">
                                <div class="member-img">
                                    <img src="${pageContext.request.contextPath}/views/user/assets/img/doctors/doctors-1.jpg" class="img-fluid" alt="">
                                    <div class="social">
                                        <a href=""><i class="bi bi-twitter-x"></i></a>
                                        <a href=""><i class="bi bi-facebook"></i></a>
                                        <a href=""><i class="bi bi-instagram"></i></a>
                                        <a href=""><i class="bi bi-linkedin"></i></a>
                                    </div>
                                </div>
                                <div class="member-info">
                                    <h4>Walter White</h4>
                                    <span>Chief Medical Officer</span>
                                </div>
                            </div>
                        </div><!-- End Team Member -->

                        <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="200">
                            <div class="team-member">
                                <div class="member-img">
                                    <img src="${pageContext.request.contextPath}/views/user/assets/img/doctors/doctors-2.jpg" class="img-fluid" alt="">
                                    <div class="social">
                                        <a href=""><i class="bi bi-twitter-x"></i></a>
                                        <a href=""><i class="bi bi-facebook"></i></a>
                                        <a href=""><i class="bi bi-instagram"></i></a>
                                        <a href=""><i class="bi bi-linkedin"></i></a>
                                    </div>
                                </div>
                                <div class="member-info">
                                    <h4>Sarah Jhonson</h4>
                                    <span>Anesthesiologist</span>
                                </div>
                            </div>
                        </div><!-- End Team Member -->

                        <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="300">
                            <div class="team-member">
                                <div class="member-img">
                                    <img src="${pageContext.request.contextPath}/views/user/assets/img/doctors/doctors-3.jpg" class="img-fluid" alt="">
                                    <div class="social">
                                        <a href=""><i class="bi bi-twitter-x"></i></a>
                                        <a href=""><i class="bi bi-facebook"></i></a>
                                        <a href=""><i class="bi bi-instagram"></i></a>
                                        <a href=""><i class="bi bi-linkedin"></i></a>
                                    </div>
                                </div>
                                <div class="member-info">
                                    <h4>William Anderson</h4>
                                    <span>Cardiology</span>
                                </div>
                            </div>
                        </div><!-- End Team Member -->

                        <div class="col-lg-3 col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="400">
                            <div class="team-member">
                                <div class="member-img">
                                    <img src="${pageContext.request.contextPath}/views/user/assets/img/doctors/doctors-4.jpg" class="img-fluid" alt="">
                                    <div class="social">
                                        <a href=""><i class="bi bi-twitter-x"></i></a>
                                        <a href=""><i class="bi bi-facebook"></i></a>
                                        <a href=""><i class="bi bi-instagram"></i></a>
                                        <a href=""><i class="bi bi-linkedin"></i></a>
                                    </div>
                                </div>
                                <div class="member-info">
                                    <h4>Amanda Jepson</h4>
                                    <span>Neurosurgeon</span>
                                </div>
                            </div>
                        </div><!-- End Team Member -->

                    </div>

                </div>

            </section><!-- /Doctors Section -->



            <!-- Pricing Section -->
            <section id="pricing" class="pricing section">
                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Quy trình đặt lịch khám bệnh</h2>
                    <p>Hướng dẫn các bước đặt lịch khám bệnh nhanh chóng và thuận tiện</p>
                </div><!-- End Section Title -->

                <div class="container">

                    <div class="row gy-3">

                        <!-- Bước 1 -->
                        <div class="col-xl-3 col-lg-6" data-aos="fade-up" data-aos-delay="100">
                            <div class="pricing-item">
                                <h3>Bước 1</h3>
                                <h4>Đăng ký / Đăng nhập tài khoản</h4>
                                <ul>
                                    <li>Tạo tài khoản mới hoặc đăng nhập</li>
                                    <li>Nhập thông tin hồ sơ cá nhân</li>
                                    <li>Lưu thông tin để sử dụng cho các lần khám sau</li>
                                </ul>
                                <div class="btn-wrap">
                                    <a href="#" class="btn-buy">Tiếp tục</a>
                                </div>
                            </div>
                        </div><!-- End Step -->

                        <!-- Bước 2 -->
                        <div class="col-xl-3 col-lg-6" data-aos="fade-up" data-aos-delay="200">
                            <div class="pricing-item">
                                <h3>Bước 2</h3>
                                <h4>Chọn lịch khám</h4>
                                <ul>
                                    <li>Chọn ngày khám mong muốn</li>
                                    <li>Chọn bác sĩ theo chuyên khoa</li>
                                    <li>Chọn giờ khám phù hợp</li>
                                    <li>Chọn đối tượng bảo hiểm (nếu có)</li>
                                </ul>
                                <div class="btn-wrap">
                                    <a href="#" class="btn-buy">Tiếp tục</a>
                                </div>
                            </div>
                        </div><!-- End Step -->

                        <!-- Bước 3 -->
                        <div class="col-xl-3 col-lg-6" data-aos="fade-up" data-aos-delay="300">
                            <div class="pricing-item">
                                <h3>Bước 3</h3>
                                <h4>Xác nhận & In phiếu</h4>
                                <ul>
                                    <li>Xác nhận thông tin đặt lịch</li>
                                    <li>In phiếu lịch hẹn</li>
                                    <li>Nhận email/SMS xác nhận</li>
                                </ul>
                                <div class="btn-wrap">
                                    <a href="#" class="btn-buy">Tiếp tục</a>
                                </div>
                            </div>
                        </div><!-- End Step -->

                        <!-- Bước 4 -->
                        <div class="col-xl-3 col-lg-6" data-aos="fade-up" data-aos-delay="400">
                            <div class="pricing-item">
                                <h3>Bước 4</h3>
                                <h4>Khám bệnh & Tái khám</h4>
                                <ul>
                                    <li>Thực hiện khám bệnh tại cơ sở y tế</li>
                                    <li>Lưu thông tin vào lịch sử bệnh án</li>
                                    <li>Hỗ trợ đặt lịch tái khám nhanh</li>
                                    <li>Theo dõi lịch sử khám trên tài khoản</li>
                                </ul>
                                <div class="btn-wrap">
                                    <a href="#" class="btn-buy">Hoàn tất</a>
                                </div>
                            </div>
                        </div><!-- End Step -->

                    </div>

                </div>

                <!-- CSS cho hover hiệu ứng -->
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


            </section><!-- /Pricing Section -->

            <!-- Faq Section -->
            <section id="faq" class="faq section light-background">

                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Câu hỏi thường gặp</h2>
                    <p>Những thắc mắc phổ biến khi đặt lịch khám bệnh</p>
                </div><!-- End Section Title -->

                <div class="container">

                    <div class="row justify-content-center">

                        <div class="col-lg-10" data-aos="fade-up" data-aos-delay="100">

                            <div class="faq-container">

                                <div class="faq-item">
                                    <h3>Làm thế nào để đặt lịch khám bệnh trực tuyến?</h3>
                                    <div class="faq-content">
                                        <p>Bạn cần đăng ký tài khoản, sau đó chọn ngày khám, bác sĩ và giờ khám mong muốn. Sau khi xác nhận thông tin, bạn sẽ nhận được phiếu lịch hẹn qua email hoặc SMS.</p>
                                    </div>
                                    <i class="faq-toggle bi bi-chevron-right"></i>
                                </div><!-- End Faq item-->

                                <div class="faq-item">
                                    <h3>Tôi có thể chọn bác sĩ cụ thể để khám không?</h3>
                                    <div class="faq-content">
                                        <p>Có. Khi đặt lịch, bạn có thể lọc danh sách bác sĩ theo chuyên khoa và chọn bác sĩ mình mong muốn nếu còn lịch trống.</p>
                                    </div>
                                    <i class="faq-toggle bi bi-chevron-right"></i>
                                </div><!-- End Faq item-->

                                <div class="faq-item">
                                    <h3>Hình thức thanh toán như thế nào?</h3>
                                    <div class="faq-content">
                                        <p>Bạn có thể thanh toán online qua thẻ, ví điện tử hoặc chọn thanh toán trực tiếp tại cơ sở y tế khi đến khám.</p>
                                    </div>
                                    <i class="faq-toggle bi bi-chevron-right"></i>
                                </div><!-- End Faq item-->

                                <div class="faq-item">
                                    <h3>Nếu tôi không đến khám đúng lịch thì có được hoàn tiền không?</h3>
                                    <div class="faq-content">
                                        <p>Chính sách hoàn tiền tùy thuộc vào từng cơ sở y tế. Thông thường, nếu bạn hủy lịch trước 24h, bạn sẽ được hoàn tiền hoặc đổi lịch khám khác.</p>
                                    </div>
                                    <i class="faq-toggle bi bi-chevron-right"></i>
                                </div><!-- End Faq item-->

                                <div class="faq-item">
                                    <h3>Làm thế nào để xem lại lịch sử khám bệnh của tôi?</h3>
                                    <div class="faq-content">
                                        <p>Bạn có thể đăng nhập vào tài khoản, vào mục “Lịch sử khám” để xem thông tin các lần khám trước.</p>
                                    </div>
                                    <i class="faq-toggle bi bi-chevron-right"></i>
                                </div><!-- End Faq item-->

                            </div>

                        </div><!-- End Faq Column-->

                    </div>

                </div>


            </section><!-- /Faq Section -->

            <!-- Contact Section -->
            <section id="contact" class="contact section">

                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Liên hệ</h2>
                    <p>Nếu bạn có bất kỳ thắc mắc hoặc cần hỗ trợ về việc đặt lịch khám bệnh, vui lòng liên hệ với chúng tôi qua các kênh dưới đây.</p>
                </div><!-- End Section Title -->

                <div class="mb-5" data-aos="fade-up" data-aos-delay="200">

                    <iframe style="border:0; width: 100%; height: 370px;" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.5259546574757!2d105.52487005777711!3d21.011631190536296!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e0!3m2!1svi!2s!4v1748699508467!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>                </div><!-- End Google Maps -->

                <div class="container" data-aos="fade-up" data-aos-delay="100">

                    <div class="row gy-4">
                        <div class="col-lg-6 ">
                            <div class="row gy-4">

                                <div class="col-lg-12">
                                    <div class="info-item d-flex flex-column justify-content-center align-items-center" data-aos="fade-up" data-aos-delay="200">
                                        <i class="bi bi-geo-alt"></i>
                                        <h3>Địa chỉ</h3>
                                        <p>abc abc abc</p>
                                    </div>
                                </div><!-- End Info Item -->

                                <div class="col-md-6">
                                    <div class="info-item d-flex flex-column justify-content-center align-items-center" data-aos="fade-up" data-aos-delay="300">
                                        <i class="bi bi-telephone"></i>
                                        <h3>Liên hệ</h3>
                                        <p>+84 987 654 321</p>
                                    </div>
                                </div><!-- End Info Item -->

                                <div class="col-md-6">
                                    <div class="info-item d-flex flex-column justify-content-center align-items-center" data-aos="fade-up" data-aos-delay="400">
                                        <i class="bi bi-envelope"></i>
                                        <h3>Gửi mail về</h3>
                                        <p>info@example.com</p>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-lg-6">
                            <form action="forms/contact.php" method="post" class="php-email-form" data-aos="fade-up" data-aos-delay="500">
                                <div class="row gy-4">

                                    <div class="col-md-6">
                                        <input type="text" name="name" class="form-control" placeholder="Họ và tên" required="">
                                    </div>

                                    <div class="col-md-6 ">
                                        <input type="email" class="form-control" name="email" placeholder="Email của bạn" required="">
                                    </div>

                                    <div class="col-md-12">
                                        <input type="text" class="form-control" name="subject" placeholder="Tiêu đề" required="">
                                    </div>

                                    <div class="col-md-12">
                                        <textarea class="form-control" name="message" rows="4" placeholder="Nội dung liên hệ" required=""></textarea>
                                    </div>

                                    <div class="col-md-12 text-center">
                                        <div class="loading">Đang gửi...</div>
                                        <div class="error-message"></div>
                                        <div class="sent-message">Tin nhắn của bạn đã được gửi. Cảm ơn bạn!</div>

                                        <button type="submit">Gửi tin nhắn</button>
                                    </div>

                                </div>
                            </form>
                        </div><!-- End Contact Form -->


                    </div>

                </div>

            </section><!-- /Contact Section -->

        </main>

        <%@ include file="./footer.jsp" %>


        <!-- Scroll Top -->
        <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

        <!-- Preloader -->
        <div id="preloader"></div>

        <!-- Vendor JS Files -->
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/php-email-form/validate.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/aos/aos.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/glightbox/js/glightbox.min.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="${pageContext.request.contextPath}/views/user/assets/vendor/swiper/swiper-bundle.min.js"></script>

        <!-- Main JS File -->
        <script src="${pageContext.request.contextPath}/views/user/assets/js/main.js"></script>


    </body>

</html>