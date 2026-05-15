<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Bán hàng - POS</title>

                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
                        rel="stylesheet">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/App.css">
                    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

                    <style>
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

                        .product-card {
                            transition: transform 0.2s;
                            text-decoration: none;
                            color: inherit;
                        }

                        .product-card:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1) !important;
                        }

                        .category-scroll {
                            cursor: grab;
                            user-select: none;
                        }

                        .category-scroll:active {
                            cursor: grabbing;
                        }
                    </style>
                </head>

                <body class="bg-body">
                    <div class="d-flex">

                        <c:set var="activeMenu" value="sales" scope="request" />
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div class="flex-grow-1 bg-light" style="min-height: 100vh;">
                            <div class="container-fluid py-3">

                                <!-- HEADER & CÁC NÚT CŨ -->
                                <div
                                    class="page-header d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                                    <div>
                                        <h4 class="mb-0">Bán hàng</h4>
                                        <span class="text-muted">POS & Quản lý đơn hàng</span>
                                    </div>
                                    <div class="d-flex gap-2">
                                        <a href="/employee/product/sales" class="btn btn-outline-secondary bg-white">
                                            <i class="bi bi-arrow-clockwise me-1"></i> Tải lại
                                        </a>
                                        <button class="btn btn-success" type="button" data-bs-toggle="modal"
                                            data-bs-target="#createOrderModal">
                                            <i class="bi bi-plus-lg me-1"></i> Đăng ký bàn
                                        </button>
                                    </div>
                                </div>

                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show py-2" role="alert">
                                        <i class="bi bi-check-circle-fill me-1"></i> ${successMessage}
                                        <button type="button" class="btn-close pb-2" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-1"></i> ${errorMessage}
                                        <button type="button" class="btn-close pb-2" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <div class="row g-3">

                                    <!-- CỘT 1: DANH SÁCH HÓA ĐƠN (Đã khôi phục logic cũ) -->
                                    <div class="col-xl-3 col-lg-4">
                                        <div class="card h-100 border-0 shadow-sm">
                                            <div class="card-header bg-white border-bottom py-3">
                                                <h6 class="mb-0 fw-bold" style="color: var(--text-dark);">
                                                    Hóa đơn (${not empty orders ? orders.size() : 0})
                                                </h6>
                                            </div>
                                            <div class="p-2 bg-light border-bottom">
                                                <form action="/employee/product/sales" method="GET" class="mb-0">

                                                    <!-- Giữ lại các tham số đang có trên URL (tránh bị mất khi ấn lọc) -->
                                                    <c:if test="${not empty param.categoryId}">
                                                        <input type="hidden" name="categoryId"
                                                            value="${param.categoryId}" />
                                                    </c:if>
                                                    <c:if test="${not empty param.selectedTableId}">
                                                        <input type="hidden" name="selectedTableId"
                                                            value="${param.selectedTableId}" />
                                                    </c:if>

                                                    <input type="date" class="form-control mb-2" name="filterDate" />

                                                    <!-- Chỉ còn 2 nút: Chưa TT và Đã TT -->
                                                    <div class="btn-group w-100 shadow-sm" role="group">
                                                        <button type="submit" name="filterStatus" value="OPEN"
                                                            class="btn btn-outline-success btn-sm fw-bold ${empty param.filterStatus or param.filterStatus == 'OPEN' ? 'active' : ''}">
                                                            Chưa TT
                                                        </button>
                                                        <button type="submit" name="filterStatus" value="COMPLETED"
                                                            class="btn btn-outline-dark btn-sm fw-bold ${param.filterStatus == 'COMPLETED' ? 'active' : ''}">
                                                            Đã TT
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="list-group list-group-flush pos-scroll overflow-auto"
                                                style="height: 65vh;">
                                                <c:choose>
                                                    <c:when test="${empty orders}">
                                                        <div class="p-3 text-center text-muted small">Không có hóa đơn
                                                            nào</div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:forEach var="order" items="${orders}">
                                                            <a href="/employee/product/sales/order-detail/${order.orderID}"
                                                                class="list-group-item list-group-item-action text-decoration-none order-item ${order.status == 'OPEN' ? 'active bg-success text-white border-success' : ''}"
                                                                data-status="${order.status}">
                                                                <div
                                                                    class="d-flex w-100 justify-content-between align-items-center mb-1">
                                                                    <span class="fw-bold">Bàn
                                                                        ${order.table.tableNumber}</span>
                                                                    <span
                                                                        class="badge ${order.status == 'OPEN' ? 'bg-white text-success' : 'bg-light text-dark'} border-0">
                                                                        <fmt:formatNumber value="${order.totalAmount}"
                                                                            type="currency" currencySymbol="₫"
                                                                            maxFractionDigits="0" />
                                                                    </span>
                                                                </div>
                                                                <div
                                                                    class="d-flex justify-content-between align-items-center mt-1">
                                                                    <small
                                                                        class="${order.status == 'OPEN' ? 'text-white-50' : 'text-muted'}">
                                                                        <fmt:parseDate value="${order.orderDate}"
                                                                            pattern="yyyy-MM-dd'T'HH:mm"
                                                                            var="parsedDateTime" type="both" />
                                                                        <fmt:formatDate pattern="HH:mm dd/MM"
                                                                            value="${parsedDateTime}" />
                                                                    </small>
                                                                    <small
                                                                        class="badge ${order.status == 'OPEN' ? 'bg-light text-success' : 'bg-secondary text-white'} border-0">
                                                                        ${order.status}
                                                                    </small>
                                                                </div>
                                                            </a>
                                                        </c:forEach>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- CỘT 2: THỰC ĐƠN BÊN NGOÀI (Đã khôi phục logic cũ, khóa click để dùng Modal) -->
                                    <div class="col-xl-5 col-lg-4">
                                        <div class="card h-100 border-0 shadow-sm">
                                            <div class="card-body d-flex flex-column p-3">
                                                <h6 class="mb-3 fw-bold" style="color: var(--text-dark);">Thực đơn</h6>
                                                <div
                                                    class="d-flex flex-nowrap overflow-auto gap-2 mb-3 pb-2 pos-scroll">
                                                    <button class="btn btn-success flex-shrink-0">Tất cả</button>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <button
                                                            class="btn btn-light border flex-shrink-0">${cat.categoryName}</button>
                                                    </c:forEach>
                                                </div>
                                                <div class="row g-2 overflow-auto pos-scroll align-content-start"
                                                    style="flex-grow: 1; max-height: 60vh;">
                                                    <c:forEach var="product" items="${products}">
                                                        <div class="col-6">
                                                            <div
                                                                class="border rounded p-2 d-flex gap-2 align-items-center bg-white h-100 product-card">
                                                                <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                                    style="width: 48px; height: 48px; overflow: hidden;">
                                                                    <c:choose>
                                                                        <c:when test="${not empty product.image}">
                                                                            <img src="/images/product/${product.image}"
                                                                                class="w-100 h-100 object-fit-cover"
                                                                                alt="IMG" />
                                                                        </c:when>
                                                                        <c:otherwise><i
                                                                                class="bi bi-cup-hot text-muted fs-4"></i>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                                <div class="overflow-hidden">
                                                                    <div class="fw-bold small text-truncate"
                                                                        style="color: var(--text-dark);">
                                                                        ${product.productName}</div>
                                                                    <div class="text-success small fw-bold">
                                                                        <fmt:formatNumber value="${product.price}"
                                                                            type="currency" currencySymbol="₫"
                                                                            maxFractionDigits="0" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                    <c:if test="${totalPages > 1}">
                                                        <div class="d-flex justify-content-center mt-3">
                                                            <nav aria-label="Menu navigation">
                                                                <ul class="pagination pagination-sm mb-0">
                                                                    <li
                                                                        class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                        <a class="page-link"
                                                                            href="?page=${currentPage - 1}&categoryId=${categoryId}&keyword=${keyword}">
                                                                            <i class="bi bi-chevron-left"></i>
                                                                        </a>
                                                                    </li>
                                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                                        <li
                                                                            class="page-item ${currentPage == i ? 'active' : ''}">
                                                                            <a class="page-link ${currentPage == i ? 'bg-success border-success' : ''}"
                                                                                href="?page=${i}&categoryId=${categoryId}&keyword=${keyword}">${i}</a>
                                                                        </li>
                                                                    </c:forEach>
                                                                    <li
                                                                        class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                        <a class="page-link"
                                                                            href="?page=${currentPage + 1}&categoryId=${categoryId}&keyword=${keyword}">
                                                                            <i class="bi bi-chevron-right"></i>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </nav>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- CỘT 3: CHI TIẾT BÀN & THANH TOÁN -->
                                    <div class="col-xl-4 col-lg-4">
                                        <div class="card h-100 border-0 shadow-sm d-flex flex-column">

                                            <!-- Đã thiết kế lại y hệt hình ảnh bạn cung cấp -->
                                            <div class="card-header bg-white border-bottom p-3 pb-4 flex-shrink-0">
                                                <h5 class="mb-3 fw-bold" style="color: var(--text-dark);">
                                                    Chi tiết bàn
                                                    <c:if test="${not empty selectedOrder}">
                                                        <span class="text-success ms-1">Bàn
                                                            ${selectedOrder.table.tableNumber}</span>
                                                    </c:if>
                                                </h5>

                                                <form action="/employee/product/sales" method="GET"
                                                    class="d-flex gap-2 mb-0">
                                                    <c:if test="${not empty param.categoryId}">
                                                        <input type="hidden" name="categoryId"
                                                            value="${param.categoryId}">
                                                    </c:if>

                                                    <!-- Select hiển thị những bàn đang hoạt động (có khách) -->
                                                    <select name="selectedTableId"
                                                        class="form-select border-success shadow-sm fw-bold text-dark rounded-3"
                                                        style="border-width: 1px;" required>
                                                        <option value="" class="text-muted">-- Chọn bàn --</option>
                                                        <c:forEach var="table" items="${tables}">
                                                            <c:if test="${table.status == 1}">
                                                                <option value="${table.tableId}"
                                                                    ${param.selectedTableId==table.tableId ? 'selected'
                                                                    : '' }>
                                                                    Bàn ${table.tableNumber}
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                    <button type="submit"
                                                        class="btn btn-outline-success px-4 fw-bold rounded-3 bg-white shadow-sm">Xem</button>
                                                </form>
                                            </div>

                                            <c:choose>
                                                <c:when test="${empty selectedOrder}">
                                                    <div
                                                        class="card-body d-flex flex-column justify-content-center align-items-center text-muted p-4">
                                                        <i class="bi bi-receipt display-1 mb-3 text-light"></i>
                                                        <h5 class="fw-bold text-secondary">Chưa chọn bàn</h5>
                                                        <p class="text-center small">Vui lòng chọn bàn ở ô Menu bên trên
                                                            và nhấn "Xem" để tải chi tiết hóa đơn.</p>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <form id="checkoutForm" action="/employee/product/sales/pay-order"
                                                        method="POST" class="card-body p-3 d-flex flex-column mb-0">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <input type="hidden" name="orderId"
                                                            value="${selectedOrder.orderID}" />

                                                        <div class="table-responsive flex-grow-1 mb-3 pos-scroll">
                                                            <table
                                                                class="table table-sm table-borderless align-middle small">
                                                                <thead class="bg-light text-secondary border-bottom">
                                                                    <tr>
                                                                        <th class="py-2">Món</th>
                                                                        <th class="text-center py-2">SL x Giá</th>
                                                                        <th class="text-end py-2">Thành tiền</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach var="detail"
                                                                        items="${selectedOrder.orderDetails}">
                                                                        <tr class="border-bottom border-light">
                                                                            <td style="width: 45%;">
                                                                                <div
                                                                                    class="d-flex gap-2 align-items-center">
                                                                                    <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                                                        style="width: 40px; height: 40px; overflow: hidden;">
                                                                                        <c:choose>
                                                                                            <c:when
                                                                                                test="${not empty detail.product.image}">
                                                                                                <img src="/images/product/${detail.product.image}"
                                                                                                    class="w-100 h-100 object-fit-cover" />
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <i
                                                                                                    class="bi bi-cup-hot text-muted fs-5"></i>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                    <div class="fw-semibold small"
                                                                                        style="color: var(--text-dark);">
                                                                                        ${detail.productName}</div>
                                                                                </div>
                                                                            </td>
                                                                            <!-- Giao diện số lượng x giá gọn gàng (Không có nút +/-) -->
                                                                            <td
                                                                                class="text-center text-muted align-middle">
                                                                                <span class="text-nowrap fw-semibold">
                                                                                    ${detail.quantity} x
                                                                                    <fmt:formatNumber
                                                                                        value="${detail.product.price}"
                                                                                        pattern="#,###" />k
                                                                                </span>
                                                                            </td>
                                                                            <td
                                                                                class="text-end fw-bold text-dark align-middle">
                                                                                <fmt:formatNumber
                                                                                    value="${detail.product.price * detail.quantity}"
                                                                                    type="currency" currencySymbol="₫"
                                                                                    maxFractionDigits="0" />
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>

                                                        <div class="mt-auto pt-3 border-top flex-shrink-0">
                                                            <div
                                                                class="d-flex justify-content-between align-items-end mb-3">
                                                                <div>
                                                                    <div class="text-muted fw-semibold mb-1">Tổng cộng:
                                                                    </div>
                                                                    <div class="d-flex align-items-center gap-2">
                                                                        <span
                                                                            class="small text-secondary text-nowrap">Thanh
                                                                            toán:</span>
                                                                        <select id="paymentSelect"
                                                                            name="paymentMethodId"
                                                                            class="form-select form-select-sm fw-bold border-secondary shadow-sm"
                                                                            style="min-width: 130px;" required>
                                                                            <option value="1">Cash (Tiền mặt)</option>
                                                                            <option value="2">Bank (Chuyển khoản)
                                                                            </option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <span class="fs-3 fw-bold text-success text-end"
                                                                    style="line-height: 1;">
                                                                    <fmt:formatNumber
                                                                        value="${selectedOrder.totalAmount}"
                                                                        type="currency" currencySymbol="₫"
                                                                        maxFractionDigits="0" />
                                                                </span>
                                                            </div>

                                                            <div class="d-grid gap-2 mt-3">
                                                                <button
                                                                    class="btn btn-success py-2 fw-bold text-uppercase shadow-sm"
                                                                    type="button" data-bs-toggle="modal"
                                                                    data-bs-target="#qrModal">
                                                                    <i class="bi bi-check-circle me-1"></i> Đóng đơn
                                                                    (Thanh toán)
                                                                </button>
                                                                <button
                                                                    class="btn btn-light border py-2 text-muted fw-semibold"
                                                                    type="button">
                                                                    Cập nhật trạng thái bàn
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal QR Code -->
                    <div class="modal fade" id="qrModal" tabindex="-1" aria-hidden="true" style="z-index: 1060;">
                        <div class="modal-dialog modal-dialog-centered modal-sm">
                            <div class="modal-content border-0 shadow-lg">
                                <div class="modal-header bg-success text-white py-2">
                                    <h5 class="modal-title fs-6 fw-bold">Xác nhận thanh toán</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body text-center p-4">
                                    <div class="small text-muted mb-3">Chuyển khoản ngân hàng</div>
                                    <div class="border rounded p-2 mb-3 bg-light d-inline-block shadow-sm">
                                        <img src="https://placehold.co/200x200?text=QR+CODE" alt="QR Pay"
                                            class="img-fluid rounded"
                                            style="max-height: 200px; width: 200px; object-fit: cover;" />
                                    </div>
                                    <div class="small text-muted mb-4 fst-italic">Vui lòng bấm xác nhận sau khi khách
                                        hàng thanh toán thành công.</div>
                                    <div class="d-grid gap-2">
                                        <button type="submit" form="checkoutForm" class="btn btn-success fw-bold">Hoàn
                                            Tất Thanh Toán</button>
                                        <button type="button" class="btn btn-outline-secondary"
                                            data-bs-dismiss="modal">Hủy bỏ</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal Tạo Đơn Mới (Đặt Bàn) -->
                    <form id="createOrderModal" name="createOrderModalForm" action="/employee/product/sales/book-table"
                        method="POST" class="modal fade" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-xl modal-dialog-centered">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <div class="modal-content border-0 shadow-lg d-flex flex-column" style="height: 90vh;">
                                <div class="modal-header bg-success text-white py-3 flex-shrink-0">
                                    <h5 class="modal-title fs-5 fw-bold"><i class="bi bi-cart-plus me-2"></i> Tạo Đơn
                                        Mới</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>

                                <div class="modal-body p-0 flex-grow-1 overflow-hidden bg-body">
                                    <div class="row g-0 h-100">
                                        <div
                                            class="col-md-3 bg-white border-end d-flex flex-column p-4 h-100 pos-scroll overflow-auto">
                                            <div class="mb-4">
                                                <label class="form-label fw-bold" style="color: var(--text-dark);">Chọn
                                                    Bàn (Trống)</label>
                                                <select id="modalTableSelect" name="tableId" class="form-select mb-3"
                                                    required>
                                                    <option value="">-- Chọn bàn --</option>
                                                    <c:forEach var="table" items="${tables}">
                                                        <c:if test="${table.status == 0}">
                                                            <option value="${table.tableId}">Bàn ${table.tableNumber}
                                                            </option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="mb-4">
                                                <label class="form-label small fw-semibold text-muted mb-1">Ghi chú hóa
                                                    đơn</label>
                                                <textarea name="notes" class="form-control flex-grow-1 py-2 px-2"
                                                    placeholder="Nhập ghi chú hoặc yêu cầu đặc biệt tại đây..."
                                                    style="font-size: 0.85rem; resize: none; min-height: 100px;"></textarea>
                                            </div>
                                        </div>

                                        <div class="col-md-5 bg-white border-end d-flex flex-column h-100">
                                            <div class="p-3 border-bottom flex-shrink-0 bg-light">
                                                <label class="fw-bold mb-2 d-block"
                                                    style="color: var(--text-dark);">Thực đơn</label>
                                                <div class="d-flex gap-2 overflow-auto pb-1 pos-scroll category-scroll"
                                                    id="modalCategoryScroll">
                                                    <a href="/employee/product/sales?openModal=true"
                                                        class="btn ${empty param.categoryId ? 'btn-success' : 'btn-outline-dark'} text-nowrap py-1">Tất
                                                        cả</a>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <a href="/employee/product/sales?categoryId=${cat.categoryId}&openModal=true"
                                                            class="btn ${param.categoryId == cat.categoryId ? 'btn-success' : 'btn-outline-dark'} text-nowrap py-1">
                                                            ${cat.categoryName}
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                            </div>

                                            <div class="flex-grow-1 overflow-auto p-3 pos-scroll bg-body">
                                                <div class="row g-3">
                                                    <c:forEach var="product" items="${products}">
                                                        <div class="col-6 col-lg-4">
                                                            <a href="/employee/product/sales/add-to-cart?productId=${product.productId}&openModal=true"
                                                                class="card h-100 border-0 shadow-sm product-card"
                                                                style="cursor: pointer; text-decoration: none;">
                                                                <div class="card-body p-2 d-flex flex-column">
                                                                    <div class="d-flex align-items-center mb-2">
                                                                        <div class="rounded bg-light border d-flex align-items-center justify-content-center flex-shrink-0"
                                                                            style="width: 40px; height: 40px; overflow: hidden;">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${not empty product.image}">
                                                                                    <img src="/images/product/${product.image}"
                                                                                        class="w-100 h-100 object-fit-cover"
                                                                                        alt="IMG" />
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <i
                                                                                        class="bi bi-cup-hot text-muted"></i>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div class="ms-2 small fw-bold text-truncate w-100"
                                                                            style="color: var(--text-dark);">
                                                                            ${product.productName}</div>
                                                                    </div>
                                                                    <div class="mt-auto fw-bold text-success small">
                                                                        <fmt:formatNumber value="${product.price}"
                                                                            type="currency" currencySymbol="₫"
                                                                            maxFractionDigits="0" />
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <c:if test="${totalPages > 1}">
                                                    <div class="d-flex justify-content-center mt-4 mb-2">
                                                        <nav aria-label="Modal product navigation">
                                                            <ul class="pagination pagination-sm mb-0">
                                                                <li
                                                                    class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                                    <a class="page-link text-success"
                                                                        href="?page=${currentPage - 1}&categoryId=${categoryId}&keyword=${keyword}&openModal=true">
                                                                        <i class="bi bi-chevron-left"></i>
                                                                    </a>
                                                                </li>

                                                                <c:forEach begin="1" end="${totalPages}" var="i">
                                                                    <li
                                                                        class="page-item ${currentPage == i ? 'active' : ''}">
                                                                        <a class="page-link ${currentPage == i ? 'bg-success border-success text-white' : 'text-success'}"
                                                                            href="?page=${i}&categoryId=${categoryId}&keyword=${keyword}&openModal=true">
                                                                            ${i}
                                                                        </a>
                                                                    </li>
                                                                </c:forEach>

                                                                <li
                                                                    class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                                    <a class="page-link text-success"
                                                                        href="?page=${currentPage + 1}&categoryId=${categoryId}&keyword=${keyword}&openModal=true">
                                                                        <i class="bi bi-chevron-right"></i>
                                                                    </a>
                                                                </li>
                                                            </ul>
                                                        </nav>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>

                                        <div class="col-md-4 bg-white d-flex flex-column h-100">
                                            <div
                                                class="p-3 border-bottom d-flex justify-content-between align-items-center flex-shrink-0">
                                                <label class="fw-bold mb-0 fs-5" style="color: var(--text-dark);">Giỏ
                                                    hàng</label>
                                                <span class="badge bg-success fs-6 px-2 py-1 rounded-pill">
                                                    ${sessionScope.cart != null ? sessionScope.cart.size() : 0} món
                                                </span>
                                            </div>

                                            <div class="flex-grow-1 overflow-auto p-3 pos-scroll">
                                                <div class="d-flex flex-column gap-3">
                                                    <c:choose>
                                                        <c:when test="${empty sessionScope.cart}">
                                                            <div class="text-center text-muted py-4">Giỏ hàng trống
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach var="item" items="${sessionScope.cart}">
                                                                <div class="border rounded p-3 bg-light shadow-sm">
                                                                    <div class="mb-2">
                                                                        <div class="rounded bg-white border d-flex align-items-center justify-content-center mb-2"
                                                                            style="width: 100%; height: 100px; overflow: hidden;">
                                                                            <c:choose>
                                                                                <c:when test="${not empty item.image}">
                                                                                    <img src="/images/product/${item.image}"
                                                                                        class="w-100 h-100 object-fit-cover"
                                                                                        alt="${item.productName}" />
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <i
                                                                                        class="bi bi-cup-hot text-muted fs-2"></i>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                        <div
                                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                                            <span class="fw-bold fs-6 flex-grow-1"
                                                                                style="color: var(--text-dark);">${item.productName}</span>
                                                                            <a href="/employee/product/sales/remove-cart?productId=${item.productId}&openModal=true"
                                                                                class="btn-close text-decoration-none"
                                                                                title="Xóa"></a>
                                                                        </div>
                                                                    </div>
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-center mb-2">
                                                                        <div class="input-group" style="width: 110px;">
                                                                            <a href="/employee/product/sales/update-cart?productId=${item.productId}&action=decrease&openModal=true"
                                                                                class="btn btn-outline-secondary bg-white fw-bold px-2 text-decoration-none">-</a>
                                                                            <input type="text"
                                                                                class="form-control text-center bg-white px-0 fw-bold"
                                                                                value="${item.quantity}" readonly />
                                                                            <a href="/employee/product/sales/update-cart?productId=${item.productId}&action=increase&openModal=true"
                                                                                class="btn btn-outline-success bg-white fw-bold px-2 text-decoration-none">+</a>
                                                                        </div>
                                                                        <span class="fw-bold text-success fs-6">
                                                                            <fmt:formatNumber
                                                                                value="${item.price * item.quantity}"
                                                                                type="currency" currencySymbol="₫"
                                                                                maxFractionDigits="0" />
                                                                        </span>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="p-4 border-top bg-light mt-auto flex-shrink-0 shadow-lg"
                                                style="border-radius: 0 0 16px 0;">
                                                <div class="d-flex justify-content-between align-items-end mb-3">
                                                    <span class="text-muted fw-semibold">Tổng tạm tính:</span>
                                                    <span class="fs-2 fw-bold text-success" style="line-height: 1;">
                                                        <fmt:formatNumber
                                                            value="${sessionScope.totalCartPrice != null ? sessionScope.totalCartPrice : 0}"
                                                            type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                                    </span>
                                                </div>
                                                <button type="submit"
                                                    class="btn btn-success w-100 py-3 fw-bold text-uppercase fs-6 shadow-sm"
                                                    ${empty sessionScope.cart ? 'disabled' : '' }>
                                                    <i class="bi bi-calendar-check me-2"></i> Hoàn tất đặt bàn
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                    <c:if test="${param.openModal == 'true'}">
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                var myModal = new bootstrap.Modal(document.getElementById('createOrderModal'));
                                myModal.show();
                            });
                        </script>
                    </c:if>

                    <script>
                        $(document).ready(() => {
                            $('.category-scroll').each(function () {
                                const $scrollCanvas = $(this);
                                const scrollId = $scrollCanvas.attr('id');
                                const storageKey = 'categoryScrollPos_' + scrollId;

                                const savedScrollPos = localStorage.getItem(storageKey);
                                if (savedScrollPos && $scrollCanvas.length > 0) {
                                    $scrollCanvas.scrollLeft(savedScrollPos);
                                }

                                $scrollCanvas.find('a').on('click', function () {
                                    localStorage.setItem(storageKey, $scrollCanvas.scrollLeft());
                                });

                                let isDown = false;
                                let startX;
                                let scrollLeft;

                                $scrollCanvas.on('mousedown', function (e) {
                                    isDown = true;
                                    $scrollCanvas.css('cursor', 'grabbing');
                                    startX = e.pageX - $scrollCanvas.offset().left;
                                    scrollLeft = $scrollCanvas.scrollLeft();
                                });

                                $scrollCanvas.on('mouseleave mouseup', function () {
                                    isDown = false;
                                    $scrollCanvas.css('cursor', 'grab');
                                });

                                $scrollCanvas.on('mousemove', function (e) {
                                    if (!isDown) return;
                                    e.preventDefault();
                                    const x = e.pageX - $scrollCanvas.offset().left;
                                    const walk = (x - startX) * 2;
                                    $scrollCanvas.scrollLeft(scrollLeft - walk);
                                });

                                $scrollCanvas.find('a').on('dragstart', function (e) {
                                    e.preventDefault();
                                });
                            });
                        });
                    </script>
                </body>

                </html>