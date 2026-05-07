<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý Danh mục & Bàn - Café Manager</title>

                <link
                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                <link rel="stylesheet" href="/admin/css/App.css">

                <style>
                    .table-custom th {
                        font-size: 0.85rem;
                        text-transform: uppercase;
                        color: var(--text-gray);
                        font-weight: 600;
                        letter-spacing: 0.5px;
                        border-bottom-width: 1px;
                        background-color: var(--bg-body);
                    }

                    .table-custom td {
                        color: var(--text-dark);
                        vertical-align: middle;
                        font-weight: 500;
                    }

                    .btn-icon {
                        width: 32px;
                        height: 32px;
                        padding: 0;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        border-radius: 8px !important;
                        transition: all 0.2s ease;
                    }

                    .btn-icon:hover {
                        transform: translateY(-1px);
                    }

                    .section-divider {
                        border-top: 2px dashed #dee2e6;
                        margin: 2.5rem 0;
                    }
                </style>
            </head>

            <body class="bg-body">
                <div class="d-flex">
                    <c:set var="activeMenu" value="categories" scope="request" />
                    <jsp:include page="../layout/sidebar.jsp" />

                    <div class="flex-grow-1 p-4" style="min-height: 100vh;">

                        <div
                            class="page-header d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                            <div>
                                <h4 class="mb-1">Danh mục sản phẩm</h4>
                                <span class="text-muted small">Phân loại và tổ chức thực đơn đồ uống/đồ ăn</span>
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-lg-4">
                                <div class="card shadow-sm border-0">
                                    <div class="card-header bg-white py-3 border-bottom border-light">
                                        <h5 class="card-title mb-0 fs-6 fw-bold text-dark">
                                            <i class="bi bi-plus-circle text-success me-2"></i>Thêm danh mục mới
                                        </h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <form:form action="/employee/category" method="POST"
                                            modelAttribute="newCategory">
                                            <form:hidden path="categoryId" />

                                            <div class="mb-4">
                                                <label class="form-label fw-bold small text-muted">Tên danh mục <span
                                                        class="text-danger">*</span></label>
                                                <form:input type="text" class="form-control"
                                                    placeholder="Nhập tên danh mục (VD: Trà sữa, Cà phê...)"
                                                    path="categoryName" />
                                            </div>
                                            <div class="d-flex gap-2">
                                                <button type="submit" class="btn btn-success flex-grow-1">
                                                    <c:choose>
                                                        <c:when
                                                            test="${not empty newCategory.categoryId and newCategory.categoryId > 0}">
                                                            Cập nhật danh mục
                                                        </c:when>
                                                        <c:otherwise>
                                                            Thêm danh mục
                                                        </c:otherwise>
                                                    </c:choose>
                                                </button>
                                                <a href="/employee/category"
                                                    class="btn btn-light border fw-semibold">Hủy</a>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-8">
                                <div class="card mb-4 shadow-sm border-0">
                                    <div class="card-body p-3">
                                        <div class="row g-2 align-items-center">
                                            <div class="col-md-9">
                                                <div class="input-group">
                                                    <span class="input-group-text bg-white border-end-0 text-muted"
                                                        style="border-radius: 10px 0 0 10px;">
                                                        <i class="bi bi-search"></i>
                                                    </span>
                                                    <input type="text" id="searchCategory"
                                                        class="form-control border-start-0 ps-0"
                                                        placeholder="Nhập tên danh mục muốn tìm kiếm..."
                                                        style="border-radius: 0 10px 10px 0;">
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <a href="/employee/category" class="btn btn-primary w-100">Tải lại</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card shadow-sm border-0">
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-custom mb-0">
                                                <thead>
                                                    <tr>
                                                        <th class="ps-4" style="width: 15%;">ID</th>
                                                        <th style="width: 50%;">Tên danh mục</th>
                                                        <th style="width: 20%;">Số lượng sản phẩm</th>
                                                        <th class="text-end pe-4" style="width: 15%;">Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="category" items="${ListCategory}">
                                                        <tr>
                                                            <td class="ps-4 text-muted">${category.categoryId}</td>
                                                            <td><span
                                                                    class="fw-bold text-dark">${category.categoryName}</span>
                                                            </td>
                                                            <td>
                                                                <span
                                                                    class="badge bg-light text-success border px-2 py-1">
                                                                    ${productCountMap[category.categoryId]} món
                                                                </span>
                                                            </td>
                                                            <td class="text-end pe-4">
                                                                <a href="/employee/category/edit/${category.categoryId}"
                                                                    class="btn btn-light border btn-icon me-1"
                                                                    title="Sửa danh mục">
                                                                    <i class="bi bi-pencil-square text-primary"></i>
                                                                </a>
                                                                <a href="/employee/category/delete/${category.categoryId}"
                                                                    class="btn btn-light border btn-icon"
                                                                    title="Xóa danh mục">
                                                                    <i class="bi bi-trash text-danger"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="section-divider" id="quan-ly-ban"></div>

                        <div
                            class="page-header d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                            <div>
                                <h4 class="mb-1">Quản lý Bàn</h4>
                                <span class="text-muted small">Thiết lập và theo dõi trạng thái bàn tại quán</span>
                            </div>
                        </div>

                        <div class="row g-4">
                            <div class="col-lg-4">
                                <div class="card shadow-sm border-0">
                                    <div class="card-header bg-white py-3 border-bottom border-light">
                                        <h5 class="card-title mb-0 fs-6 fw-bold text-dark">
                                            <i class="bi bi-plus-circle text-primary me-2"></i>Thêm bàn mới
                                        </h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <form:form action="/employee/cafeTable" method="POST"
                                            modelAttribute="newCafeTable">
                                            <!-- Lấy id cũ để phân biệt thêm mới và cập nhật -->
                                            <form:hidden path="tableId" />

                                            <div class="mb-3">
                                                <label class="form-label fw-bold small text-muted">Tên bàn / Số
                                                    bàn <span class="text-danger">*</span></label>
                                                <form:input type="text" class="form-control" path="tableNumber"
                                                    placeholder="VD: Bàn 01, Bàn VIP..." />
                                            </div>

                                            <div class="mb-4">
                                                <label class="form-label fw-bold small text-muted">Sức chứa
                                                    (Người)</label>
                                                <form:input type="number" class="form-control" path="capacity"
                                                    placeholder="VD: 4" min="1" />
                                            </div>

                                            <div class="d-flex gap-2">

                                                <button type="submit" class="btn btn-primary flex-grow-1">
                                                    <!-- chỉnh nút xem khi nào thêm mới khi nào sửa -->
                                                    <c:choose>
                                                        <c:when
                                                            test="${not empty newCafeTable.tableId and newCafeTable.tableId > 0}">
                                                            Cập nhật bàn
                                                        </c:when>
                                                        <c:otherwise>
                                                            Thêm bàn mới
                                                        </c:otherwise>
                                                    </c:choose>
                                                </button>
                                                <a href="/employee/category"
                                                    class="btn btn-light border fw-semibold">Hủy</a>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-8">
                                <div class="card shadow-sm border-0 h-100">
                                    <div
                                        class="card-header bg-white py-3 border-bottom border-light d-flex justify-content-between align-items-center">
                                        <h5 class="card-title mb-0 fs-6 fw-bold text-dark">Danh sách bàn</h5>
                                        <span class="badge bg-primary rounded-pill px-3 py-2">Tổng: 5 bàn</span>
                                    </div>
                                    <div class="card-body p-0">
                                        <div class="table-responsive">
                                            <table class="table table-hover table-custom mb-0">
                                                <thead>
                                                    <tr>
                                                        <th class="ps-4" style="width: 10%;">ID</th>
                                                        <th style="width: 30%;">Tên bàn</th>
                                                        <th style="width: 20%;">Sức chứa</th>
                                                        <th style="width: 20%;">Trạng thái</th>
                                                        <th class="text-end pe-4" style="width: 20%;">Thao tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="cafeTable" items="${ListCafeTable}">
                                                        <tr>

                                                            <td class="ps-4 text-muted">1</td>
                                                            <td><span
                                                                    class="fw-bold text-dark">${cafeTable.tableNumber}</span>
                                                            </td>
                                                            <td><i class="bi bi-people-fill text-muted me-1"></i>
                                                                ${cafeTable.capacity}
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <%-- Nếu status=0 (Trống) --%>
                                                                        <c:when test="${cafeTable.status == 0}">
                                                                            <span
                                                                                class="badge bg-success bg-opacity-10 text-success border border-success">Trống</span>
                                                                        </c:when>

                                                                        <%-- Nếu status=1 (Đã sử dụng/Có khách) --%>
                                                                            <c:when test="${cafeTable.status == 1}">
                                                                                <span
                                                                                    class="badge bg-danger bg-opacity-10 text-danger border border-danger">Đã
                                                                                    sử dụng</span>
                                                                            </c:when>

                                                                            <%-- Nếu status=2 (Đang dọn dẹp hoặc bảo trì
                                                                                - Tuỳ chọn thêm) --%>
                                                                                <c:when test="${cafeTable.status == 2}">
                                                                                    <span
                                                                                        class="badge bg-secondary bg-opacity-10 text-secondary border border-secondary">Đang
                                                                                        dọn</span>
                                                                                </c:when>

                                                                                <%-- Trường hợp còn lại (phòng hờ lỗi dữ
                                                                                    liệu) --%>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="badge bg-dark text-white">Không
                                                                                            xác định</span>
                                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="text-end pe-4">
                                                                <a href="/employee/cafeTable/edit/${cafeTable.tableId}#quan-ly-ban"
                                                                    class="btn btn-light border btn-icon me-1"
                                                                    title="Sửa">
                                                                    <i class="bi bi-pencil-square text-primary"></i>
                                                                </a>
                                                                <a href="/employee/cafeTable/delete/${cafeTable.tableId}#quan-ly-ban"
                                                                    class="btn btn-light border btn-icon" title="Xóa">
                                                                    <i class="bi bi-trash text-danger"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                </tbody>
                                            </table>
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