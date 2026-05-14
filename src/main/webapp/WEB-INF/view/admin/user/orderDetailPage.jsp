<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Chi tiết hóa đơn #${order.orderID} - POS</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

                <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/App.css">

                <style>
                    @media print {
                        .no-print {
                            display: none !important;
                        }

                        .card {
                            box-shadow: none !important;
                            border: 1px solid #dee2e6 !important;
                        }

                        body {
                            background-color: white !important;
                        }

                        .sidebar-custom {
                            display: none !important;
                        }
                    }
                </style>
            </head>

            <body class="bg-body">
                <div class="d-flex">

                    <c:set var="activeMenu" value="sales" scope="request" />
                    <div class="no-print">
                        <jsp:include page="../layout/sidebar.jsp" />
                    </div>

                    <div class="flex-grow-1 bg-light" style="min-height: 100vh;">
                        <div class="container-fluid py-4 px-lg-5">

                            <div
                                class="page-header d-flex justify-content-between align-items-center mb-4 no-print border-bottom pb-3">
                                <div>
                                    <h4 class="mb-1 d-flex align-items-center gap-2">
                                        Chi tiết hóa đơn #${order.orderID}
                                        <span
                                            class="badge ${order.status == 'COMPLETED' ? 'bg-success' : 'bg-secondary'} fs-6 py-1 px-2">
                                            ${order.status}
                                        </span>
                                    </h4>
                                    <span class="text-muted small">
                                        <i class="bi bi-clock me-1"></i>
                                        <fmt:parseDate value="${order.orderDate}" pattern="yyyy-MM-dd'T'HH:mm"
                                            var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="HH:mm - dd/MM/yyyy" value="${parsedDateTime}" />
                                    </span>
                                </div>
                                <div class="d-flex gap-2">
                                    <a href="/employee/product/sales"
                                        class="btn btn-outline-secondary bg-white text-dark">
                                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                                    </a>
                                    <button class="btn btn-success" onclick="window.print()">
                                        <i class="bi bi-printer me-1"></i> In hóa đơn
                                    </button>
                                </div>
                            </div>

                            <div class="row g-4">
                                <div class="col-lg-4 order-2 order-lg-1">
                                    <div class="card mb-4 border-0">
                                        <div class="card-header bg-white py-3 border-bottom">
                                            <h6 class="mb-0 fw-bold" style="color: var(--text-dark);">Thông tin chung
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <ul class="list-group list-group-flush">
                                                <li
                                                    class="list-group-item d-flex justify-content-between align-items-center px-0 py-3">
                                                    <span class="text-muted"><i class="bi bi-shop me-2"></i>Khu
                                                        vực/Bàn</span>
                                                    <span class="fw-bold fs-5 text-dark">Bàn
                                                        ${order.table.tableNumber}</span>
                                                </li>
                                                <li
                                                    class="list-group-item d-flex justify-content-between align-items-center px-0 py-3">
                                                    <span class="text-muted"><i class="bi bi-person-badge me-2"></i>Thu
                                                        ngân</span>
                                                    <span class="fw-semibold text-dark">${order.user.username}</span>
                                                </li>
                                                <li
                                                    class="list-group-item d-flex justify-content-between align-items-center px-0 py-3">
                                                    <span class="text-muted"><i class="bi bi-credit-card me-2"></i>Thanh
                                                        toán</span>
                                                    <span class="badge bg-light border text-dark">
                                                        <c:choose>
                                                            <c:when test="${order.paymentMethod.paymentMethodId == 1}">
                                                                Tiền mặt (Cash)</c:when>
                                                            <c:when test="${order.paymentMethod.paymentMethodId == 2}">
                                                                Chuyển khoản (Bank)</c:when>
                                                            <c:otherwise>${order.paymentMethod.name}</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <c:set var="generalNote" value="" />
                                    <c:forEach var="detail" items="${order.orderDetails}" begin="0" end="0">
                                        <c:set var="generalNote" value="${detail.notes}" />
                                    </c:forEach>

                                    <div class="card border-0">
                                        <div class="card-header bg-white py-3 border-bottom">
                                            <h6 class="mb-0 fw-bold" style="color: var(--text-dark);">Ghi chú đơn hàng
                                            </h6>
                                        </div>
                                        <div class="card-body">
                                            <c:choose>
                                                <c:when test="${not empty generalNote}">
                                                    <div class="p-3 bg-light rounded text-dark fst-italic">
                                                        ${generalNote}
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="text-muted small fst-italic text-center py-2">
                                                        Không có ghi chú nào cho đơn hàng này.
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-8 order-1 order-lg-2">
                                    <div class="card border-0 h-100">
                                        <div
                                            class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0 fw-bold" style="color: var(--text-dark);">Chi tiết món</h6>
                                            <span class="badge bg-primary-bg-subtle text-success border border-success">
                                                ${order.orderDetails.size()} món
                                            </span>
                                        </div>

                                        <div class="card-body p-0">
                                            <div class="table-responsive bill-section h-100">
                                                <table class="table table-hover align-middle mb-0 bill-table">
                                                    <thead class="bg-light">
                                                        <tr>
                                                            <th class="ps-4 py-3">Tên món</th>
                                                            <th class="text-center py-3">Ghi chú</th>
                                                            <th class="text-center py-3">Đơn giá</th>
                                                            <th class="text-center py-3">SL</th>
                                                            <th class="text-end pe-4 py-3">Thành tiền</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="detail" items="${order.orderDetails}">
                                                            <tr>
                                                                <td class="ps-4 py-3">
                                                                    <div class="fw-semibold text-dark">
                                                                        ${detail.productName != null ?
                                                                        detail.productName : detail.product.productName}
                                                                    </div>
                                                                </td>
                                                                <td
                                                                    class="text-center py-3 text-muted small fst-italic">
                                                                    ${not empty detail.notes ? detail.notes : '-'}
                                                                </td>
                                                                <td class="text-center py-3 text-muted small">
                                                                    <fmt:formatNumber value="${detail.product.price}"
                                                                        type="currency" currencySymbol="₫"
                                                                        maxFractionDigits="0" />
                                                                </td>
                                                                <td class="text-center py-3">
                                                                    <span
                                                                        class="badge bg-light text-dark border px-2 py-1">${detail.quantity}</span>
                                                                </td>
                                                                <td class="text-end pe-4 py-3 fw-bold"
                                                                    style="color: var(--text-dark);">
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
                                        </div>

                                        <div class="card-footer bg-white border-top p-4"
                                            style="border-radius: 0 0 var(--radius-lg) var(--radius-lg);">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="text-muted fw-semibold">Tổng tiền hàng:</span>
                                                <span class="fw-bold fs-5 text-dark">
                                                    <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                                        currencySymbol="₫" maxFractionDigits="0" />
                                                </span>
                                            </div>
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <span class="text-muted fw-semibold">Khuyến mãi / Giảm giá:</span>
                                                <span class="text-dark">0 ₫</span>
                                            </div>
                                            <hr class="border-light">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <span class="fs-5 fw-bold" style="color: var(--text-dark);">TỔNG
                                                    CỘNG:</span>
                                                <span class="fs-2 fw-bold text-success">
                                                    <fmt:formatNumber value="${order.totalAmount}" type="currency"
                                                        currencySymbol="₫" maxFractionDigits="0" />
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>