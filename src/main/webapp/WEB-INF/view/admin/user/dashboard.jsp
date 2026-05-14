<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                    <!DOCTYPE html>
                    <html lang="vi">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Tổng quan Dashboard - Preview</title>

                        <!-- Bootstrap 5 CSS & Icons -->
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                            rel="stylesheet">
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">


                        <link rel="stylesheet" href="/admin/css/App.css">
                    </head>

                    <body>
                        <div class="d-flex">

                            <c:set var="activeMenu" value="dasboard" scope="request" />

                            <jsp:include page="../layout/sidebar.jsp" />

                            <div class="flex-grow-1 bg-light" style="min-height: 100vh;">


                                <div class="container py-4">

                                    <!-- Page Header -->
                                    <div class="d-flex justify-content-between align-items-center mb-4 page-header">
                                        <div>
                                            <h4 class="mb-0">Tổng quan</h4>
                                            <span class="text-muted small">Tình hình kinh doanh hôm nay</span>
                                        </div>
                                        <button class="btn btn-success btn-sm"><i
                                                class="bi bi-file-earmark-arrow-down me-1"></i> Xuất
                                            báo
                                            cáo</button>
                                    </div>

                                    <!-- Alert Đăng nhập -->
                                    <div class="alert alert-success d-flex align-items-center gap-3 shadow-sm border-0 mb-4"
                                        role="alert" style="background-color: #d1e7dd; color: #0f5132;">
                                        <span class="bi bi-check-circle-fill" style="font-size: 1.5rem;"></span>
                                        <div>
                                            <h6 class="alert-heading fw-bold mb-0">Đăng nhập thành công!</h6>
                                            <small>
                                                Chào mừng <strong>
                                                    <c:out value="${loggedUserName}" />
                                                </strong> quay trở lại. Vai trò:
                                                <span class="badge bg-success">
                                                    <c:out value="${userRole}" />
                                                </span>
                                            </small>
                                        </div>
                                    </div>

                                    <!-- Thẻ Thống kê (Stat Cards) -->
                                    <div class="row g-3 mb-4">
                                        <!-- Doanh thu hôm nay -->
                                        <div class="col-md-4">
                                            <div class="card h-100 p-3">
                                                <div class="d-flex justify-content-between">
                                                    <div>
                                                        <h6 class="text-muted small mb-2">Doanh thu hôm nay</h6>
                                                        <h4 class="fw-bold mb-1 text-dark">
                                                            <fmt:formatNumber value="${revenueToday}" type="currency"
                                                                currencyCode="VND" maxFractionDigits="0" />
                                                        </h4>
                                                        <small class="text-muted">
                                                            <c:out value="${totalOrdersToday}" /> hóa đơn
                                                        </small>
                                                    </div>
                                                    <div class="stat-card-icon">
                                                        <i class="bi bi-cash-stack"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Số hóa đơn -->
                                        <div class="col-md-4">
                                            <div class="card h-100 p-3">
                                                <div class="d-flex justify-content-between">
                                                    <div>
                                                        <h6 class="text-muted small mb-2">Số hóa đơn hôm nay</h6>
                                                        <h4 class="fw-bold mb-1 text-dark">
                                                            <c:out value="${totalOrdersToday}" /> đơn
                                                        </h4>
                                                        <small class="text-muted">Tổng số đơn đã thanh toán</small>
                                                    </div>
                                                    <div class="stat-card-icon">
                                                        <i class="bi bi-receipt"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Trạng thái công suất -->
                                        <div class="col-md-4">
                                            <div class="card h-100 p-3">
                                                <div class="d-flex justify-content-between">
                                                    <div>
                                                        <h6 class="text-muted small mb-2">Bàn đang phục vụ</h6>
                                                        <h4 class="fw-bold mb-1 text-dark">
                                                            <c:out value="${activeTables}" /> /
                                                            <c:out value="${totalTables}" />
                                                        </h4>
                                                        <small class="text-muted">
                                                            <c:choose>
                                                                <c:when test="${totalTables > 0}">
                                                                    <c:out
                                                                        value="${(activeTables * 100) / totalTables}" />
                                                                    %
                                                                    công suất
                                                                </c:when>
                                                                <c:otherwise>
                                                                    0% công suất
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </small>
                                                    </div>
                                                    <div class="stat-card-icon">
                                                        <i class="bi bi-shop"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Main Content Row -->
                                    <div class="row g-3">
                                        <!-- Cột trái: Biểu đồ doanh thu -->
                                        <div class="col-md-8">
                                            <div class="card h-100">
                                                <div class="card-body">
                                                    <div class="bg-light rounded p-3">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-2">
                                                            <span class="fw-semibold small">Biểu đồ doanh thu</span>
                                                            <span class="text-muted small">7 ngày gần nhất</span>
                                                        </div>
                                                        <!-- Vùng chứa biểu đồ SVG -->
                                                        <div id="chartContainer" class="position-relative"
                                                            style="min-height: 260px;">
                                                            <!-- Sẽ được render bằng Vanilla JS bên dưới -->
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Cột phải: Top Sản Phẩm & Trạng Thái Bàn -->
                                        <div class="col-md-4">

                                            <!-- Top Sản Phẩm Bán Chạy -->
                                            <div class="card mb-3">
                                                <div class="card-body">
                                                    <h6 class="mb-3 border-bottom pb-2 fw-bold">🔥 Top bán chạy</h6>
                                                    <ul class="list-group list-group-flush small">
                                                        <c:forEach items="${topProducts}" var="product"
                                                            varStatus="status">
                                                            <li
                                                                class="list-group-item d-flex justify-content-between px-0 align-items-center border-0">
                                                                <div class="d-flex align-items-center gap-2">
                                                                    <span
                                                                        class="badge rounded-pill ${status.index == 0 ? 'bg-warning text-dark' : 'bg-light text-secondary border'}">
                                                                        <c:out value="${status.index + 1}" />
                                                                    </span>
                                                                    <span class="fw-semibold text-truncate"
                                                                        style="max-width: 140px;"
                                                                        title="${product.productName}">
                                                                        <c:out value="${product.productName}" />
                                                                    </span>
                                                                </div>
                                                                <span class="text-success fw-bold">
                                                                    <c:out value="${product.quantitySold}" /> đã bán
                                                                </span>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>

                                            <!-- Trạng Thái Bàn -->
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                        <h6 class="mb-0 fw-bold">Trạng thái bàn</h6>
                                                        <button class="btn border btn-sm text-muted"
                                                            onclick="window.location.reload()">
                                                            <i class="bi bi-arrow-clockwise"></i>
                                                        </button>
                                                    </div>
                                                    <div class="d-flex flex-wrap gap-2">
                                                        <c:forEach items="${tableList}" var="table">
                                                            <c:choose>
                                                                <c:when test="${table.status == 1}">
                                                                    <span
                                                                        class="badge rounded-pill px-3 py-2 bg-secondary-subtle text-secondary">Bàn
                                                                        <c:out value="${table.tableNumber}" />
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${table.status == 0}">
                                                                    <span
                                                                        class="badge rounded-pill px-3 py-2 bg-success-subtle text-success">Bàn
                                                                        <c:out value="${table.tableNumber}" />
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge rounded-pill px-3 py-2 bg-warning-subtle text-warning">Bàn
                                                                        <c:out value="${table.tableNumber}" />
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Script render biểu đồ SVG -->
                        <script id="weeklyStatsJson" type="application/json">
                        [
                        <c:forEach items="${weeklyStats}" var="stat" varStatus="loop">
                            {"key":"${fn:escapeXml(stat.label)}","label":"${fn:escapeXml(stat.label)}","value":${stat.value}}<c:if test="${!loop.last}">,</c:if>
                        </c:forEach>
                        ]
                    </script>

                        <script>
                            const formatCurrency = (value) =>
                                new Intl.NumberFormat("vi-VN", { style: "currency", currency: "VND" }).format(Number(value || 0));

                            const weeklyStats = JSON.parse(document.getElementById('weeklyStatsJson').textContent.trim());
                            const maxRevenue = <c:out value="${maxRevenue}" escapeXml="false" />;

                            const chartContainer = document.getElementById("chartContainer");
                            const chartBars = weeklyStats.map(function (item) {
                                const heightPercent = maxRevenue > 0 ? (item.value / maxRevenue) * 100 : 0;
                                return '<div class="chart-bar">'
                                    + '<div class="chart-bar-fill" style="height: ' + Math.round(heightPercent) + '%;"></div>'
                                    + '<div class="chart-bar-label">' + item.label + '</div>'
                                    + '</div>';
                            }).join("");

                            chartContainer.innerHTML = '<div class="d-flex align-items-end justify-content-between h-100 gap-2">' + chartBars + '</div>';
                        </script>


                    </body>

                    </html>