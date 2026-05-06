<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Bán hàng - POS</title>

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

                <!-- Custom CSS -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/App.css">

                <style>
                    /* Tùy chỉnh thanh cuộn cho màn hình POS để gọn gàng hơn */
                    .pos-scroll {
                        scrollbar-width: thin;
                        scrollbar-color: #cbd5e1 transparent;
                    }

                    .pos-scroll::-webkit-scrollbar {
                        width: 6px;
                        height: 6px;
                    }

                    .pos-scroll::-webkit-scrollbar-thumb {
                        background-color: #cbd5e1;
                        border-radius: 10px;
                    }
                </style>
            </head>

            <body class="bg-body">
                <div class="d-flex">

                    <c:set var="activeMenu" value="sales" scope="request" />

                    <jsp:include page="../layout/sidebar.jsp" />

                    <div class="flex-grow-1 bg-light" style="min-height: 100vh;">
                        <div class="container-fluid py-3">
                            <!-- Page Header -->
                            <div
                                class="page-header d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                                <div>
                                    <h4 class="mb-0">Bán hàng</h4>
                                    <span class="text-muted">POS & Quản lý đơn hàng</span>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-outline-secondary" type="button">
                                        <i class="bi bi-arrow-clockwise me-1"></i> Tải lại
                                    </button>
                                    <!-- Nút kích hoạt Modal Tạo Đơn -->
                                    <button class="btn btn-success" type="button" data-bs-toggle="modal"
                                        data-bs-target="#createOrderModal">
                                        <i class="bi bi-plus-lg me-1"></i> Tạo đơn mới
                                    </button>
                                </div>
                            </div>

                            <div class="row g-3">
                                <!-- 1. DANH SÁCH HÓA ĐƠN -->
                                <div class="col-xl-3 col-lg-4">
                                    <div class="card h-100">
                                        <div class="card-header bg-white border-bottom py-3">
                                            <h6 class="mb-0 fw-bold" style="color: var(--text-dark);">Hóa đơn (3)</h6>
                                        </div>
                                        <div class="p-2 bg-light border-bottom">
                                            <input type="date" class="form-control" value="2026-05-05" />
                                        </div>
                                        <div class="list-group list-group-flush pos-scroll overflow-auto"
                                            style="height: 65vh;">

                                            <!-- Đơn đang chọn (Active) -->
                                            <button type="button"
                                                class="list-group-item list-group-item-action active bg-success text-white border-success">
                                                <div
                                                    class="d-flex w-100 justify-content-between align-items-center mb-1">
                                                    <span class="fw-bold">Bàn 05</span>
                                                    <span class="badge bg-white text-success border-0">103.000 ₫</span>
                                                </div>
                                                <div class="d-flex justify-content-between align-items-center mt-1">
                                                    <small class="text-white-50">10:45 05/05/2026</small>
                                                    <small class="badge bg-light text-success border-0">OPEN</small>
                                                </div>
                                            </button>

                                            <!-- Đơn chưa đóng -->
                                            <button type="button" class="list-group-item list-group-item-action">
                                                <div
                                                    class="d-flex w-100 justify-content-between align-items-center mb-1">
                                                    <span class="fw-bold" style="color: var(--text-dark);">Bàn 12</span>
                                                    <span class="badge bg-light text-dark border">45.000 ₫</span>
                                                </div>
                                                <div class="d-flex justify-content-between align-items-center mt-1">
                                                    <small class="text-muted">11:15 05/05/2026</small>
                                                    <small class="badge bg-success">OPEN</small>
                                                </div>
                                            </button>

                                            <!-- Đơn đã đóng -->
                                            <button type="button"
                                                class="list-group-item list-group-item-action bg-light">
                                                <div
                                                    class="d-flex w-100 justify-content-between align-items-center mb-1">
                                                    <span class="fw-bold text-muted">Bàn 02</span>
                                                    <span class="badge bg-white text-muted border">68.000 ₫</span>
                                                </div>
                                                <div class="d-flex justify-content-between align-items-center mt-1">
                                                    <small class="text-muted">09:30 05/05/2026</small>
                                                    <small class="badge bg-secondary">CLOSE</small>
                                                </div>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- 2. MENU SẢN PHẨM -->
                                <div class="col-xl-5 col-lg-4">
                                    <div class="card h-100">
                                        <div class="card-body d-flex flex-column p-3">
                                            <h6 class="mb-3 fw-bold" style="color: var(--text-dark);">Thực đơn</h6>

                                            <!-- Bộ lọc danh mục -->
                                            <div class="d-flex flex-nowrap overflow-auto gap-2 mb-3 pb-2 pos-scroll">
                                                <button class="btn btn-success flex-shrink-0">Tất cả</button>
                                                <button class="btn btn-light border flex-shrink-0">Cà phê</button>
                                                <button class="btn btn-light border flex-shrink-0">Trà</button>
                                                <button class="btn btn-light border flex-shrink-0">Bánh ngọt</button>
                                            </div>

                                            <!-- Lưới sản phẩm -->
                                            <div class="row g-2 overflow-auto pos-scroll align-content-start"
                                                style="flex-grow: 1; max-height: 60vh;">

                                                <!-- Cà phê sữa đá -->
                                                <div class="col-6">
                                                    <div
                                                        class="border rounded p-2 d-flex gap-2 align-items-center bg-white h-100 product-card">
                                                        <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                            style="width: 48px; height: 48px; overflow: hidden;">
                                                            <img src="https://placehold.co/48x48"
                                                                class="w-100 h-100 object-fit-cover" alt="CF" />
                                                        </div>
                                                        <div class="overflow-hidden">
                                                            <div class="fw-bold small text-truncate"
                                                                style="color: var(--text-dark);">Cà
                                                                phê sữa đá</div>
                                                            <div class="text-success small fw-bold">29.000 ₫</div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Trà sen vàng -->
                                                <div class="col-6">
                                                    <div
                                                        class="border rounded p-2 d-flex gap-2 align-items-center bg-white h-100 product-card">
                                                        <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                            style="width: 48px; height: 48px;">
                                                            <i class="bi bi-cup-hot text-muted fs-4"></i>
                                                        </div>
                                                        <div class="overflow-hidden">
                                                            <div class="fw-bold small text-truncate"
                                                                style="color: var(--text-dark);">
                                                                Trà sen vàng</div>
                                                            <div class="text-success small fw-bold">45.000 ₫</div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Bánh sừng bò -->
                                                <div class="col-6">
                                                    <div
                                                        class="border rounded p-2 d-flex gap-2 align-items-center bg-white h-100 product-card">
                                                        <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                            style="width: 48px; height: 48px;">
                                                            <i class="bi bi-box-seam text-muted fs-4"></i>
                                                        </div>
                                                        <div class="overflow-hidden">
                                                            <div class="fw-bold small text-truncate"
                                                                style="color: var(--text-dark);">
                                                                Bánh sừng bò</div>
                                                            <div class="text-success small fw-bold">29.000 ₫</div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 3. CHI TIẾT HÓA ĐƠN -->
                                <div class="col-xl-4 col-lg-4">
                                    <div class="card h-100 border-success">
                                        <div class="card-body d-flex flex-column p-3">
                                            <div
                                                class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3">
                                                <h6 class="mb-0 fw-bold">
                                                    Chi tiết bàn: <span class="text-success fs-5 ms-1">Bàn 05</span>
                                                </h6>
                                                <button class="btn btn-sm btn-outline-secondary" type="button"
                                                    data-bs-toggle="modal" data-bs-target="#selectTableModal">
                                                    <i class="bi bi-grid-3x3-gap-fill me-1"></i> Chọn bàn
                                                </button>
                                            </div>

                                            <!-- Bảng món ăn -->
                                            <div class="table-responsive flex-grow-1 mb-3 pos-scroll">
                                                <table class="table table-sm table-borderless align-middle small">
                                                    <thead class="bg-light text-secondary border-bottom">
                                                        <tr>
                                                            <th class="py-2">Món</th>
                                                            <th class="text-center py-2">SL x Giá</th>
                                                            <th class="text-end py-2">Thành tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="border-bottom border-light">
                                                            <td style="width: 45%;">
                                                                <div class="fw-semibold"
                                                                    style="color: var(--text-dark);">Cà phê
                                                                    sữa đá
                                                                </div>
                                                                <div class="text-muted fst-italic"
                                                                    style="font-size: 0.8em;">(Ít
                                                                    đá, ít
                                                                    ngọt)</div>
                                                            </td>
                                                            <td class="text-center text-muted">
                                                                <div
                                                                    class="d-flex justify-content-center align-items-center gap-1">
                                                                    <button
                                                                        class="btn btn-outline-danger p-0 d-flex align-items-center justify-content-center"
                                                                        style="width: 20px; height: 20px; border-radius: 4px;"
                                                                        title="Giảm">
                                                                        <i class="bi bi-dash"></i>
                                                                    </button>
                                                                    <span class="text-nowrap mx-1">2 x 29k</span>
                                                                </div>
                                                            </td>
                                                            <td class="text-end fw-bold text-dark">58.000 ₫</td>
                                                        </tr>

                                                        <tr class="border-bottom border-light">
                                                            <td style="width: 45%;">
                                                                <div class="fw-semibold"
                                                                    style="color: var(--text-dark);">Trà
                                                                    sen vàng
                                                                </div>
                                                            </td>
                                                            <td class="text-center text-muted">
                                                                <div
                                                                    class="d-flex justify-content-center align-items-center gap-1">
                                                                    <button
                                                                        class="btn btn-outline-danger p-0 d-flex align-items-center justify-content-center"
                                                                        style="width: 20px; height: 20px; border-radius: 4px;">
                                                                        <i class="bi bi-dash"></i>
                                                                    </button>
                                                                    <span class="text-nowrap mx-1">1 x 45k</span>
                                                                </div>
                                                            </td>
                                                            <td class="text-end fw-bold text-dark">45.000 ₫</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <!-- Form thêm món -->
                                            <form class="border rounded p-2 mb-3 bg-light">
                                                <div class="row g-2 align-items-end">
                                                    <div class="col-6">
                                                        <label class="form-label small mb-1 fw-semibold text-muted">Chọn
                                                            món</label>
                                                        <select class="form-select px-2 py-1"
                                                            style="font-size: 0.9rem;">
                                                            <option value="">-- Chọn món --</option>
                                                            <option value="CF">Cà phê sữa đá</option>
                                                            <option value="TS">Trà sen vàng</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-3">
                                                        <label
                                                            class="form-label small mb-1 fw-semibold text-muted">SL</label>
                                                        <input type="number" min="1" value="1"
                                                            class="form-control px-2 py-1 text-center"
                                                            style="font-size: 0.9rem;" />
                                                    </div>
                                                    <div class="col-3 d-grid">
                                                        <button type="button" class="btn btn-success py-1 px-0"
                                                            style="font-size: 0.9rem;">+ Thêm</button>
                                                    </div>
                                                    <div class="col-12 mt-2">
                                                        <input type="text" class="form-control py-1 px-2"
                                                            placeholder="Ghi chú (tuỳ chọn)..."
                                                            style="font-size: 0.85rem;" />
                                                    </div>
                                                </div>
                                            </form>

                                            <!-- Footer Hóa Đơn -->
                                            <div class="mt-auto pt-3 border-top">
                                                <div class="d-flex justify-content-between align-items-center mb-3">
                                                    <div>
                                                        <div class="text-muted fw-semibold">Tổng cộng:</div>
                                                        <div class="small text-secondary mt-1">
                                                            Thanh toán: <span
                                                                class="badge bg-light text-dark border">Bank
                                                                (Chuyển
                                                                khoản)</span>
                                                        </div>
                                                    </div>
                                                    <span class="fs-3 fw-bold text-success">103.000 ₫</span>
                                                </div>
                                                <div class="d-grid gap-2">
                                                    <!-- Nút Đóng Đơn gọi QR Modal -->
                                                    <button class="btn btn-success py-2 fw-bold text-uppercase"
                                                        type="button" data-bs-toggle="modal" data-bs-target="#qrModal">
                                                        <i class="bi bi-check-circle me-1"></i> Đóng đơn (Thanh toán)
                                                    </button>
                                                    <button class="btn btn-light border py-2 text-muted fw-semibold"
                                                        type="button">
                                                        Cập nhật trạng thái bàn
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ========================================== -->
                <!-- MODAL: QR THANH TOÁN (Bank) -->
                <!-- ========================================== -->
                <div class="modal fade" id="qrModal" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
                    <div class="modal-dialog modal-dialog-centered modal-sm">
                        <div class="modal-content border-0 shadow-lg">
                            <div class="modal-header bg-success text-white py-2">
                                <h5 class="modal-title fs-6 fw-bold">Thanh toán Bank</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body text-center p-4">
                                <div class="small text-muted mb-3">Quét mã QR để chuyển khoản</div>

                                <!-- Khung chứa QR -->
                                <div class="border rounded p-2 mb-3 bg-light d-inline-block shadow-sm">
                                    <img src="https://placehold.co/200x200?text=QR+CODE" alt="QR Pay"
                                        class="img-fluid rounded"
                                        style="max-height: 200px; width: 200px; object-fit: cover;" />
                                </div>

                                <div class="small text-muted mb-4 fst-italic">
                                    Vui lòng bấm xác nhận sau khi khách hàng chuyển khoản thành công.
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="button" class="btn btn-success fw-bold" data-bs-dismiss="modal">
                                        Chuyển khoản thành công
                                    </button>
                                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                                        Hủy bỏ
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- ========================================== -->
                <!-- MODAL: TẠO ĐƠN MỚI -->
                <!-- ========================================== -->
                <div class="modal fade" id="createOrderModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-xl modal-dialog-centered">
                        <!-- Set height 90vh cho modal content -->
                        <div class="modal-content border-0 shadow-lg d-flex flex-column" style="height: 90vh;">

                            <div class="modal-header bg-success text-white py-3 flex-shrink-0">
                                <h5 class="modal-title fs-5 fw-bold"><i class="bi bi-cart-plus me-2"></i> Tạo Đơn Mới
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>

                            <div class="modal-body p-0 flex-grow-1 overflow-hidden bg-body">
                                <div class="row g-0 h-100">

                                    <!-- CỘT 1: CẤU HÌNH (Bàn, Thanh toán) -->
                                    <div
                                        class="col-md-3 bg-white border-end d-flex flex-column p-4 h-100 pos-scroll overflow-auto">
                                        <div class="mb-4">
                                            <label class="form-label fw-bold" style="color: var(--text-dark);">Chọn Bàn
                                                (Trống)</label>
                                            <select class="form-select mb-3">
                                                <option value="">-- Chọn bàn --</option>
                                                <option value="1">Bàn 01</option>
                                                <option value="2">Bàn 02</option>
                                                <option value="3">Bàn 03</option>
                                            </select>

                                            <!-- Lưới chọn bàn nhanh -->
                                            <div class="d-flex flex-wrap gap-2">
                                                <button class="btn btn-outline-secondary py-1 px-2"
                                                    style="min-width: 45px;">01</button>
                                                <button class="btn btn-success py-1 px-2"
                                                    style="min-width: 45px;">02</button>
                                                <button class="btn btn-outline-secondary py-1 px-2"
                                                    style="min-width: 45px;">03</button>
                                                <button class="btn btn-outline-secondary py-1 px-2"
                                                    style="min-width: 45px;">04</button>
                                            </div>
                                        </div>

                                        <div class="mb-4">
                                            <label class="form-label fw-bold" style="color: var(--text-dark);">Thanh
                                                toán</label>
                                            <select class="form-select">
                                                <option value="">-- Chọn phương thức --</option>
                                                <option value="CASH">Tiền mặt (Cash)</option>
                                                <option value="BANK" selected>Chuyển khoản (Bank)</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- CỘT 2: THỰC ĐƠN (Lưới sản phẩm) -->
                                    <div class="col-md-5 bg-white border-end d-flex flex-column h-100">
                                        <div class="p-3 border-bottom flex-shrink-0 bg-light">
                                            <label class="fw-bold mb-2 d-block" style="color: var(--text-dark);">Thực
                                                đơn</label>
                                            <div class="d-flex gap-2 overflow-auto pb-1 pos-scroll">
                                                <button class="btn btn-dark text-nowrap py-1">Tất cả</button>
                                                <button class="btn btn-outline-dark text-nowrap py-1">Cà phê</button>
                                                <button class="btn btn-outline-dark text-nowrap py-1">Trà</button>
                                            </div>
                                        </div>

                                        <div class="flex-grow-1 overflow-auto p-3 pos-scroll bg-body">
                                            <div class="row g-3">
                                                <!-- Sản phẩm Modal -->
                                                <div class="col-6 col-lg-4">
                                                    <div class="card h-100 border-0 shadow-sm product-card"
                                                        style="cursor: pointer;">
                                                        <div class="card-body p-2 d-flex flex-column">
                                                            <div class="d-flex align-items-center mb-2">
                                                                <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                                    style="width: 40px; height: 40px; overflow: hidden;">
                                                                    <img src="https://placehold.co/40x40"
                                                                        class="w-100 h-100 object-fit-cover" alt="" />
                                                                </div>
                                                                <div class="ms-2 small fw-bold text-truncate w-100"
                                                                    style="color: var(--text-dark);">Cà phê sữa đá</div>
                                                            </div>
                                                            <div class="mt-auto fw-bold text-success small">29.000 ₫
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-6 col-lg-4">
                                                    <div class="card h-100 border-0 shadow-sm product-card"
                                                        style="cursor: pointer;">
                                                        <div class="card-body p-2 d-flex flex-column">
                                                            <div class="d-flex align-items-center mb-2">
                                                                <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                                    style="width: 40px; height: 40px;">
                                                                    <i class="bi bi-cup-hot text-muted"></i>
                                                                </div>
                                                                <div class="ms-2 small fw-bold text-truncate w-100"
                                                                    style="color: var(--text-dark);">Trà đào</div>
                                                            </div>
                                                            <div class="mt-auto fw-bold text-success small">35.000 ₫
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- CỘT 3: ĐÃ CHỌN (Giỏ hàng) -->
                                    <div class="col-md-4 bg-white d-flex flex-column h-100">
                                        <div
                                            class="p-3 border-bottom d-flex justify-content-between align-items-center flex-shrink-0">
                                            <label class="fw-bold mb-0 fs-5" style="color: var(--text-dark);">Giỏ
                                                hàng</label>
                                            <span class="badge bg-success fs-6 px-2 py-1 rounded-pill">1 món</span>
                                        </div>

                                        <div class="flex-grow-1 overflow-auto p-3 pos-scroll">
                                            <!-- Danh sách item -->
                                            <div class="d-flex flex-column gap-3">
                                                <div class="border rounded p-3 bg-light shadow-sm">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <span class="fw-bold fs-6" style="color: var(--text-dark);">Cà
                                                            phê sữa
                                                            đá</span>
                                                        <button type="button" class="btn-close" title="Xóa"></button>
                                                    </div>
                                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                                        <!-- Bộ điều chỉnh SL -->
                                                        <div class="input-group" style="width: 110px;">
                                                            <button
                                                                class="btn btn-outline-secondary bg-white fw-bold px-2"
                                                                type="button">-</button>
                                                            <input type="text"
                                                                class="form-control text-center bg-white px-0 fw-bold"
                                                                value="1" readonly />
                                                            <button
                                                                class="btn btn-outline-secondary bg-white fw-bold px-2"
                                                                type="button">+</button>
                                                        </div>
                                                        <span class="fw-bold text-success fs-6">29.000 ₫</span>
                                                    </div>
                                                    <input type="text" class="form-control bg-white"
                                                        placeholder="Ghi chú (ít đường, nhiều đá...)" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="p-4 border-top bg-light mt-auto flex-shrink-0 shadow-lg"
                                            style="border-radius: 0 0 16px 0;">
                                            <div class="d-flex justify-content-between align-items-end mb-3">
                                                <span class="text-muted fw-semibold">Tổng tiền thanh toán:</span>
                                                <span class="fs-2 fw-bold text-success" style="line-height: 1;">29.000
                                                    ₫</span>
                                            </div>
                                            <button
                                                class="btn btn-success w-100 py-3 fw-bold text-uppercase fs-6 shadow-sm"
                                                type="button" data-bs-dismiss="modal">
                                                <i class="bi bi-printer me-2"></i> Hoàn tất & In hóa đơn
                                            </button>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="selectTableModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content border-0 shadow-lg">
                            <div class="modal-header bg-success text-white py-2">
                                <h5 class="modal-title fs-6 fw-bold"><i class="bi bi-grid-3x3-gap-fill me-2"></i>Chọn /
                                    Đổi Bàn</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <div class="modal-body p-4">
                                <label class="form-label fw-bold" style="color: var(--text-dark);">Sơ đồ bàn
                                    nhanh</label>

                                <div class="row g-2">
                                    <div class="col-3"><button class="btn btn-outline-secondary w-100 py-2">Bàn
                                            01</button></div>
                                    <div class="col-3"><button class="btn btn-secondary w-100 py-2" disabled>Bàn
                                            02</button></div>
                                    <div class="col-3"><button class="btn btn-outline-secondary w-100 py-2">Bàn
                                            03</button></div>
                                    <div class="col-3"><button class="btn btn-outline-secondary w-100 py-2">Bàn
                                            04</button></div>
                                    <div class="col-3"><button class="btn btn-success w-100 py-2 shadow-sm">Bàn
                                            05</button></div>
                                    <div class="col-3"><button class="btn btn-outline-secondary w-100 py-2">Bàn
                                            06</button></div>
                                    <div class="col-3"><button class="btn btn-outline-secondary w-100 py-2">Bàn
                                            07</button></div>
                                    <div class="col-3"><button class="btn btn-outline-secondary w-100 py-2">Bàn
                                            08</button></div>
                                </div>

                                <div class="mt-4 pt-3 border-top text-muted small d-flex justify-content-center gap-3">
                                    <div><span class="badge bg-white border text-dark me-1"
                                            style="width: 15px; height: 15px; display: inline-block;"></span> Trống
                                    </div>
                                    <div><span class="badge bg-secondary me-1"
                                            style="width: 15px; height: 15px; display: inline-block;"></span> Có khách
                                    </div>
                                    <div><span class="badge bg-success me-1"
                                            style="width: 15px; height: 15px; display: inline-block;"></span> Đang chọn
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer py-2 bg-light">
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Hủy
                                    bỏ</button>
                                <button type="button" class="btn btn-success px-4">Xác nhận</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bootstrap 5 JS Bundle -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>