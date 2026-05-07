<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý Sản phẩm / Menu</title>

                <!-- Google Fonts: Be Vietnam Pro -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">

                <!-- Bootstrap 5 CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Bootstrap Icons -->
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

                <!-- Custom CSS của bạn (Điều chỉnh lại đường dẫn cho đúng với project của bạn) -->
                <!-- Ví dụ: href="${pageContext.request.contextPath}/assets/css/App.css" -->
                <link rel="stylesheet" href="/admin/css/App.css">

                <script>
                    $(document).ready(() => {
                        const ProductFile = $("#ProductImage"); // gọi vào id id="ProductImage"
                        ProductFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#ProductPreview").attr("src", imgURL);
                            $("#ProductPreview").css({ "display": "block" });
                        });
                    }); 
                </script>
            </head>

            <body>
                <div class="d-flex">

                    <c:set var="activeMenu" value="products" scope="request" />

                    <jsp:include page="../layout/sidebar.jsp" />

                    <div class="flex-grow-1 bg-light" style="min-height: 100vh;">

                        <div class="container-fluid py-4">
                            <!-- Page Header -->
                            <div
                                class="page-header d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                                <div>
                                    <h4 class="mb-0">Sản phẩm</h4>
                                    <span class="text-muted">Quản lý danh mục & món uống</span>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-warning text-dark" type="button">
                                        <i class="bi bi-cloud-download me-1"></i> Lấy Menu Highlands
                                    </button>
                                    <button class="btn btn-outline-danger" type="button">
                                        <i class="bi bi-arrow-counterclockwise me-1"></i> Reset kho về 100
                                    </button>
                                    <button class="btn btn-outline-secondary" type="button">
                                        <i class="bi bi-arrow-clockwise me-1"></i> Làm mới
                                    </button>
                                </div>
                            </div>

                            <div class="row g-4">
                                <!-- Cột hiển thị danh sách sản phẩm -->
                                <div class="col-lg-8">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <!-- Bộ lọc danh mục -->
                                            <div
                                                class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                                                <div class="d-flex align-items-center gap-2 flex-wrap">
                                                    <span class="fw-semibold mb-0" style="color: var(--text-dark);">Lọc
                                                        theo
                                                        danh
                                                        mục:</span>
                                                    <div class="d-flex flex-wrap gap-2">
                                                        <button type="button" class="btn btn-success">Tất cả</button>
                                                        <button type="button" class="btn btn-light border">Cà
                                                            phê</button>
                                                        <button type="button" class="btn btn-light border">Trà</button>
                                                        <button type="button" class="btn btn-light border">Bánh
                                                            ngọt</button>
                                                    </div>
                                                </div>

                                                <div class="text-muted small fst-italic">
                                                    Kho sản phẩm sẽ tự động đặt lại về 100 mỗi ngày.
                                                </div>
                                            </div>

                                            <!-- Bảng dữ liệu tĩnh -->
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th style="width: 70px;">Ảnh</th>
                                                            <th>Tên sản phẩm</th>
                                                            <th>Danh mục</th>
                                                            <th class="text-end">Giá bán</th>
                                                            <th class="text-center">Kho</th>
                                                            <th class="text-end">Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="product" items="${ListProduct}">

                                                            <tr>
                                                                <td>
                                                                    <div class="rounded bg-light d-flex align-items-center justify-content-center border"
                                                                        style="width: 48px; height: 48px; overflow: hidden;">
                                                                        <img src="/images/product/${product.image}"
                                                                            alt="Ảnh"
                                                                            class="w-100 h-100 object-fit-cover" />
                                                                    </div>
                                                                </td>
                                                                <td class="fw-semibold"
                                                                    style="color: var(--text-dark);">
                                                                    ${product.productName}</td>
                                                                <td>
                                                                    <span
                                                                        class="badge bg-light text-dark border px-2 py-1">${product.category.categoryName}</span>
                                                                </td>
                                                                <td class="text-end fw-bold text-success">
                                                                    ${product.price} ₫
                                                                </td>
                                                                <td class="text-center">${product.amount}</td>
                                                                <td class="text-end">
                                                                    <div class="btn-group">
                                                                        <a href="/employee/product/edit/${product.productId}"
                                                                            class="btn btn-outline-primary px-2 py-1"
                                                                            title="Sửa">
                                                                            <i class="bi bi-pencil"></i>
                                                                        </a>
                                                                        <a href="/employee/product/delete/${product.productId}"
                                                                            class="btn btn-outline-danger px-2 py-1"
                                                                            title="Xóa"
                                                                            onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm: ${product.productName} không?');">
                                                                            <i class="bi bi-trash"></i>
                                                                        </a>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>



                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Cột Form Thêm/Sửa sản phẩm -->
                                <div class="col-lg-4">
                                    <div class="card h-100">
                                        <div class="card-body d-flex flex-column">
                                            <div
                                                class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                                                <h5 class="mb-0 fw-bold" style="color: var(--text-dark);">Thêm sản phẩm
                                                    mới</h5>

                                            </div>

                                            <form:form id="product-form" class="flex-grow-1 d-flex flex-column"
                                                method="POST" action="/employee/product" modelAttribute="newProduct"
                                                enctype="multipart/form-data">
                                                <form:hidden path="productId" id="form-product-id" />
                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Tên
                                                        sản
                                                        phẩm</label>
                                                    <form:input type="text" class="form-control" path="productName"
                                                        placeholder="VD: Cà phê sữa đá" />
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Danh
                                                        mục</label>
                                                    <form:select class="form-select" path="category">
                                                        <form:options items="${categories}" itemValue="categoryId"
                                                            itemLabel="categoryName" />
                                                    </form:select>
                                                </div>

                                                <div class="row g-3 mb-3">
                                                    <div class="col-6">
                                                        <label class="form-label fw-semibold"
                                                            style="color: var(--text-dark);">Giá bán
                                                            (VNĐ)</label>
                                                        <form:input type="number" min="0" class="form-control"
                                                            path="price" placeholder="0" />
                                                    </div>
                                                    <div class="col-6">
                                                        <label class="form-label fw-semibold"
                                                            style="color: var(--text-dark);">Tồn
                                                            kho</label>
                                                        <form:input type="number" min="0" class="form-control"
                                                            path="amount" placeholder="100" />
                                                    </div>
                                                </div>

                                                <div class="mb-4">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Hình
                                                        ảnh
                                                        (Link Online)</label>
                                                    <div class="col-12 mb-3 col-md-6">
                                                        <label for="avatarFile" class="form-label">Image:</label>
                                                        <input class="form-control" type="file" id="ProductImage"
                                                            accept=".png, .jpg, .jpeg" name="ProductImage">
                                                    </div>

                                                    <div class="col-12 mb-3">
                                                        <img style="max-height: 250px; display: none"
                                                            alt="Product.preview" id="ProductPreview">
                                                    </div>


                                                </div>
                                                <c:if test="${not empty newProduct.image}">
                                                    <div class="col-12 mb-3">
                                                        <label class="form-label text-muted small">Ảnh hiện tại:</label>
                                                        <br>
                                                        <img src="/images/product/${newProduct.image}"
                                                            style="max-height: 150px;" alt="Current Image">
                                                    </div>
                                                </c:if>
                                                <div class="d-grid gap-2 mt-auto pt-3">
                                                    <button
                                                        class="btn btn-success py-2 d-flex justify-content-center align-items-center gap-2"
                                                        type="submit">
                                                        <c:choose>
                                                            <c:when
                                                                test="${not empty newProduct.productId && newProduct.productId > 0}">
                                                                <i class="bi bi-save"></i> Cập nhật sản phẩm
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </button>

                                                    <a href="/employee/product" class="btn btn-outline-secondary">
                                                        <i class="bi bi-x-lg"></i> Hủy
                                                    </a>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Bootstrap 5 JS Bundle (bao gồm Popper để chạy dropdown/tooltip nếu cần) -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

            </body>

            </html>