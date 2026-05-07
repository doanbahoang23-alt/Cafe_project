<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Truy cập bị từ chối - 403</title>

        <!-- Nhúng Bootstrap 5 CSS qua CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Nhúng Bootstrap Icons để lấy icon ổ khóa và mũi tên -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    </head>

    <!-- vh-100: chiều cao 100% màn hình, bg-light: nền xám nhạt -->

    <body class="bg-light d-flex align-items-center justify-content-center vh-100">

        <div class="container text-center">
            <div class="row justify-content-center">
                <!-- Form chiếm 6 cột trên màn hình vừa, 5 cột trên màn hình lớn -->
                <div class="col-12 col-md-8 col-lg-5">

                    <!-- Card của Bootstrap, thêm shadow-lg để đổ bóng, border-0 để bỏ viền -->
                    <div class="card shadow-lg border-0 rounded-4">
                        <div class="card-body p-5">

                            <!-- Icon cảnh báo -->
                            <i class="bi bi-shield-slash text-danger" style="font-size: 4rem;"></i>

                            <!-- Chữ 403 siêu to khổng lồ -->
                            <h1 class="display-1 fw-bold text-danger mt-3">403</h1>

                            <h4 class="mb-3 text-dark">Truy cập bị từ chối!</h4>
                            <p class="text-muted mb-4">Xin lỗi, bạn không có quyền (roles/permissions) để xem nội dung
                                của trang này.</p>

                            <!-- Nút bấm Bootstrap -->
                            <button class="btn btn-primary btn-lg px-4 rounded-pill" onclick="window.history.back()">
                                <i class="bi bi-arrow-left me-2"></i> Quay lại trang trước
                            </button>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- Nhúng JS của Bootstrap (Tùy chọn, cần thiết nếu dùng Modal/Dropdown) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>