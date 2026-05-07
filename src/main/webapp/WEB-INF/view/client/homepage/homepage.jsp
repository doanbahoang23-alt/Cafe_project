<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- Thêm thư viện format số -->
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Trang chủ - Cafe Manager</title>

                    <!-- Bootstrap 5 CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Bootstrap Icons -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

                    <!-- Custom CSS -->
                    <link rel="stylesheet" href="/client/css/homepage.css">
                </head>

                <body>

                    <!-- Header / Navbar -->
                    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
                        <div class="container">
                            <a class="navbar-brand fw-bold" href="#">☕ Cafe Manager</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item"><a class="nav-link active" href="#">Trang chủ</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#about">Giới thiệu</a></li>
                                    <li class="nav-item"><a class="nav-link" href="#menu">Thực đơn</a></li>
                                    <!-- Có thể thêm link tới Giỏ hàng ở đây -->
                                    <li class="nav-item"><a class="nav-link text-warning" href="/login"><i
                                                class="bi bi-box-arrow-in-right"></i> Quản lý</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>

                    <!-- Banner Giới thiệu quán (Hero Section) -->
                    <section class="hero-section text-center">
                        <div class="container">
                            <h1 class="display-3 fw-bold mb-4">Chào mừng đến với không gian của chúng tôi</h1>
                            <p class="lead mb-4">Nơi tận hưởng hương vị cà phê nguyên bản và những phút giây thư giãn
                                tuyệt vời nhất. Khởi đầu ngày mới tràn đầy năng lượng cùng Cafe Manager!</p>
                            <a href="#menu" class="btn btn-warning btn-lg px-4 rounded-pill">Xem Thực Đơn</a>
                        </div>
                    </section>

                    <!-- Section Giới thiệu tĩnh -->
                    <section id="about" class="py-5">
                        <div class="container">
                            <div class="row align-items-center">
                                <div class="col-md-6 mb-4 mb-md-0">
                                    <img src="https://images.unsplash.com/photo-1554118811-1e0d58224f24?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80"
                                        class="img-fluid rounded-4 shadow" alt="Không gian quán">
                                </div>
                                <div class="col-md-6 px-md-5">
                                    <h2 class="fw-bold text-cafe mb-3">Về Chúng Tôi</h2>
                                    <p class="text-muted">Với mong muốn mang lại một không gian làm việc và trò chuyện
                                        lý tưởng, chúng tôi không ngừng cải thiện chất lượng dịch vụ và không gian quán.
                                        Từng hạt cà phê đều được tuyển chọn kỹ lưỡng, rang mộc 100% để giữ trọn vẹn
                                        hương vị tự nhiên nhất.</p>
                                    <p class="text-muted">Đội ngũ nhân viên thân thiện, không gian yên tĩnh và tiếng
                                        nhạc du dương chắc chắn sẽ làm bạn hài lòng.</p>
                                    <ul class="list-unstyled mt-4">
                                        <li><i class="bi bi-check-circle-fill text-success me-2"></i> Không gian rộng
                                            rãi, thoáng mát</li>
                                        <li><i class="bi bi-check-circle-fill text-success me-2"></i> Đồ uống đa dạng,
                                            pha chế chuyên nghiệp</li>
                                        <li><i class="bi bi-check-circle-fill text-success me-2"></i> Wifi tốc độ cao
                                            miễn phí</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Section Sản phẩm nổi bật (Load động từ DB) -->
                    <section id="menu" class="py-5 bg-light">
                        <div class="container">
                            <div class="text-center mb-5">
                                <h2 class="fw-bold text-cafe">Danh sách các sản phẩm của quán</h2>
                                <p class="text-muted">Những thức uống được khách hàng yêu thích nhất</p>
                            </div>

                            <div class="row g-4">

                                <!-- Bắt đầu vòng lặp lấy danh sách sản phẩm từ Controller -->
                                <!-- Đảm bảo Controller của bạn có model.addAttribute("products", danhSachSanPham) -->
                                <c:forEach var="product" items="${products}">
                                    <div class="col-12 col-md-6 col-lg-3">
                                        <div class="card product-card shadow-sm h-100">
                                            <!-- Link ảnh sản phẩm -->
                                            <img src="/images/product/${product.image}" class="card-img-top"
                                                alt="${product.productName}"
                                                onerror="this.src='https://via.placeholder.com/500x500?text=No+Image'">

                                            <div class="card-body text-center">
                                                <!-- Tên sản phẩm -->
                                                <h5 class="card-title fw-bold">${product.productName}</h5>

                                                <!-- Giá sản phẩm (Đã format có dấu phẩy) -->
                                                <h5 class="text-danger fw-bold">
                                                    <fmt:formatNumber value="${product.price}" type="number"
                                                        pattern="###,###" /> VNĐ
                                                </h5>
                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>
                                <!-- Kết thúc vòng lặp -->

                                <!-- Hiển thị thông báo nếu không có sản phẩm nào -->
                                <c:if test="${empty products}">
                                    <div class="col-12 text-center text-muted">
                                        <p>Hiện tại quán chưa có sản phẩm nào được hiển thị.</p>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </section>

                    <!-- Footer -->
                    <footer class="bg-dark text-white py-4">
                        <div class="container text-center">
                            <p class="mb-1">&copy; 2026 Hệ thống quản lý Cafe Manager.</p>
                            <p class="text-muted small">Hotline: 0123.456.789 | Địa chỉ: Nhổn, Bắc Từ Liêm, Hà Nội</p>
                        </div>
                    </footer>

                    <!-- Bootstrap 5 JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>