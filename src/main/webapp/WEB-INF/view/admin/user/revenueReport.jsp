<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Báo Cáo Doanh Thu</title>

                <!-- Google Fonts: Be Vietnam Pro -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">

                <!-- Bootstrap 5 CSS & Icons -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

                <!-- Custom CSS (Emerald Modern) -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/App.css">
            </head>

            <body>

                <body class="bg-body">
                    <div class="d-flex">

                        <c:set var="activeMenu" value="revenueReport" scope="request" />

                        <jsp:include page="../layout/sidebar.jsp" />

                        <div class="flex-grow-1 bg-light" style="min-height: 100vh;">
                            <div class="container-fluid py-4">
                                <!-- Page Header -->
                                <div
                                    class="page-header d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                                    <div>
                                        <h4 class="mb-0">Báo cáo doanh thu</h4>
                                        <span class="text-muted">Xem tổng quan kinh doanh theo ngày, tuần, tháng hoặc
                                            khoảng thời
                                            gian tùy
                                            chọn</span>
                                    </div>
                                    <div>
                                        <button class="btn btn-outline-success" type="button">
                                            <i class="bi bi-arrow-repeat me-1"></i> Tải mới dữ liệu
                                        </button>
                                    </div>
                                </div>

                                <!-- Filter Card -->
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <div class="d-flex flex-wrap gap-2 mb-4">
                                            <button class="btn btn-success" type="button">Hôm nay</button>
                                            <button class="btn btn-outline-secondary" type="button">Tuần này</button>
                                            <button class="btn btn-outline-secondary" type="button">Tháng này</button>
                                            <button class="btn btn-outline-secondary" type="button">Tùy chọn</button>
                                        </div>

                                        <div class="row g-3 align-items-end">
                                            <div class="col-md-4">
                                                <label class="form-label fw-semibold"
                                                    style="color: var(--text-dark);">Ngày bắt
                                                    đầu</label>
                                                <input type="date" class="form-control" value="2026-05-05" />
                                            </div>
                                            <div class="col-md-4">
                                                <label class="form-label fw-semibold"
                                                    style="color: var(--text-dark);">Ngày kết
                                                    thúc</label>
                                                <input type="date" class="form-control" value="2026-05-05" />
                                            </div>
                                            <div class="col-md-4 d-flex align-items-end gap-2">
                                                <button class="btn btn-success flex-grow-1" type="button">
                                                    <i class="bi bi-funnel me-1"></i> Xem báo cáo
                                                </button>
                                                <button class="btn btn-outline-secondary" type="button"
                                                    title="Đặt lại về hôm nay">
                                                    <i class="bi bi-x-lg"></i>
                                                </button>
                                            </div>
                                        </div>

                                        <div class="text-muted small mt-3">
                                            Khoảng thời gian áp dụng: <strong>Ngày 05/05/2026</strong>. Chỉ tính các hóa
                                            đơn đã đóng
                                            (CLOSE).
                                        </div>
                                    </div>
                                </div>

                                <!-- Stat Cards -->
                                <div class="row g-4 mb-4">
                                    <!-- Tổng doanh thu -->
                                    <div class="col-md-4">
                                        <div class="card h-100">
                                            <div class="card-body d-flex flex-column">
                                                <div class="stat-card-icon mb-3 bg-success-subtle text-success d-inline-flex align-items-center justify-content-center"
                                                    style="width: 48px; height: 48px; border-radius: 12px;">
                                                    <i class="bi bi-cash-stack fs-4"></i>
                                                </div>
                                                <h6 class="text-muted mb-1">Tổng doanh thu</h6>
                                                <h3 class="fw-bold text-success mb-2">1.250.000 ₫</h3>
                                                <small class="text-muted mt-auto">Theo dữ liệu hệ thống</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Số hóa đơn -->
                                    <div class="col-md-4">
                                        <div class="card h-100">
                                            <div class="card-body d-flex flex-column">
                                                <div class="stat-card-icon mb-3 bg-primary-subtle text-primary d-inline-flex align-items-center justify-content-center"
                                                    style="width: 48px; height: 48px; border-radius: 12px;">
                                                    <i class="bi bi-receipt fs-4"></i>
                                                </div>
                                                <h6 class="text-muted mb-1">Số hóa đơn</h6>
                                                <h3 class="fw-bold mb-2" style="color: var(--text-dark);">45 đơn</h3>
                                                <small class="text-muted mt-auto">Đơn đã thanh toán trong khoảng thời
                                                    gian</small>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Giá trị trung bình -->
                                    <div class="col-md-4">
                                        <div class="card h-100">
                                            <div class="card-body d-flex flex-column">
                                                <div class="stat-card-icon mb-3 bg-warning-subtle text-warning d-inline-flex align-items-center justify-content-center"
                                                    style="width: 48px; height: 48px; border-radius: 12px;">
                                                    <i class="bi bi-graph-up-arrow fs-4"></i>
                                                </div>
                                                <h6 class="text-muted mb-1">Giá trị trung bình/đơn</h6>
                                                <h3 class="fw-bold mb-2 text-warning" style="filter: brightness(0.8);">
                                                    27.777 ₫</h3>
                                                <small class="text-muted mt-auto">Tổng doanh thu chia cho số đơn</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Charts and Tables -->
                                <div class="row g-4 mb-4">
                                    <!-- Chart Area -->
                                    <div class="col-lg-8">
                                        <div class="card h-100">
                                            <div class="card-body">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <div>
                                                        <h5 class="mb-0 fw-bold" style="color: var(--text-dark);">Biểu
                                                            đồ doanh thu
                                                        </h5>
                                                        <small class="text-muted">Ngày 05/05/2026</small>
                                                    </div>
                                                    <span class="badge bg-light text-muted border px-2 py-1">Cập nhật:
                                                        11:30
                                                        05/05/2026</span>
                                                </div>

                                                <!-- CSS Grid/Flexbox Chart (Thay thế SVG tĩnh) -->
                                                <div class="d-flex align-items-end justify-content-around mt-4 pt-3 border-bottom pb-2 position-relative"
                                                    style="height: 280px;">
                                                    <!-- Trục Y (Grid lines) -->
                                                    <div class="position-absolute w-100 h-100 d-flex flex-column justify-content-between"
                                                        style="z-index: 0;">
                                                        <div class="border-top border-dashed" style="opacity: 0.2;">
                                                        </div>
                                                        <div class="border-top border-dashed" style="opacity: 0.2;">
                                                        </div>
                                                        <div class="border-top border-dashed" style="opacity: 0.2;">
                                                        </div>
                                                        <div class="border-top border-dashed" style="opacity: 0.2;">
                                                        </div>
                                                        <div></div> <!-- Baseline -->
                                                    </div>

                                                    <!-- Cột biểu đồ tĩnh (Z-index cao hơn để đè lên Grid lines) -->
                                                    <div class="d-flex flex-column align-items-center"
                                                        style="z-index: 1;">
                                                        <span class="small mb-1"
                                                            style="color: var(--text-gray); font-size: 0.75rem;">1.2M
                                                            ₫</span>
                                                        <div class="bg-success rounded-top"
                                                            style="width: 34px; height: 180px; transition: height 0.3s;"
                                                            title="1.250.000đ (45 đơn)"></div>
                                                        <span class="small mt-2 fw-semibold"
                                                            style="color: var(--text-dark);">05/05</span>
                                                        <span class="small text-muted" style="font-size: 0.7rem;">45
                                                            đơn</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Table Area -->
                                    <div class="col-lg-4">
                                        <div class="card h-100">
                                            <div class="card-body d-flex flex-column">
                                                <div
                                                    class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                                                    <h5 class="mb-0 fw-bold" style="color: var(--text-dark);">Bảng chi
                                                        tiết</h5>
                                                    <span class="badge text-bg-success-subtle text-success px-2 py-1">1
                                                        ngày</span>
                                                </div>

                                                <div class="table-responsive flex-grow-1">
                                                    <table class="table align-middle mb-0">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th
                                                                    style="font-size: 0.85rem; color: var(--text-gray);">
                                                                    Ngày</th>
                                                                <th class="text-end"
                                                                    style="font-size: 0.85rem; color: var(--text-gray);">
                                                                    Doanh thu</th>
                                                                <th class="text-end"
                                                                    style="font-size: 0.85rem; color: var(--text-gray);">
                                                                    Số
                                                                    đơn</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td class="fw-semibold"
                                                                    style="color: var(--text-dark);">05/05/2026
                                                                </td>
                                                                <td class="text-end text-success fw-bold">1.250.000 ₫
                                                                </td>
                                                                <td class="text-end">
                                                                    <span
                                                                        class="badge bg-light text-dark border">45</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                        <tfoot class="table-light mt-2 border-top-2">
                                                            <tr>
                                                                <th class="fw-bold" style="color: var(--text-dark);">
                                                                    Tổng</th>
                                                                <th class="text-end fw-bold text-success">1.250.000 ₫
                                                                </th>
                                                                <th class="text-end fw-bold"
                                                                    style="color: var(--text-dark);">45 đơn
                                                                </th>
                                                            </tr>
                                                        </tfoot>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Bootstrap 5 JS Bundle -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                </body>

            </html>