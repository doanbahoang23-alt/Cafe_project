<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Quản lý Sản phẩm - Café Manager</title>

                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
                        rel="stylesheet">

                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

                    <style>
                        :root {
                            --primary-green: #10b981;
                            --dark-green: #065f46;
                            --bg-light: #f9fafb;
                            --text-dark: #1f2937;
                        }

                        /* Khóa cuộn toàn trang để tạo cảm giác App chuyên nghiệp */
                        body,
                        html {
                            height: 100%;
                            margin: 0;
                            overflow: hidden;
                            font-family: 'Be Vietnam Pro', sans-serif;
                            background-color: var(--bg-light);
                        }

                        .main-wrapper {
                            display: flex;
                            height: 100vh;
                            width: 100vw;
                        }

                        /* Vùng nội dung chính bên phải */
                        .main-content-wrapper {
                            flex-grow: 1;
                            overflow-y: auto;
                            /* Chỉ cuộn vùng này */
                            padding: 1.5rem;
                            display: flex;
                            flex-direction: column;
                        }

                        /* Header phong cách tinh tế */
                        .page-header h4 {
                            font-weight: 700;
                            color: var(--text-dark);
                        }

                        /* Card & Table */
                        .card {
                            border: none;
                            border-radius: 12px;
                            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                        }

                        .table thead th {
                            background-color: #f3f4f6;
                            color: #4b5563;
                            font-weight: 600;
                            text-transform: none;
                            border: none;
                            padding: 12px;
                        }

                        /* Container chứa danh mục - Giữ nguyên logic của bạn */
                        .category-scroll {
                            display: flex;
                            overflow-x: auto;
                            white-space: nowrap;
                            gap: 10px;
                            padding: 5px 0;
                            cursor: grab;
                            user-select: none;
                            scrollbar-width: none;
                            /* Firefox */
                        }

                        .category-scroll::-webkit-scrollbar {
                            display: none;
                        }

                        .category-scroll:active {
                            cursor: grabbing;
                        }

                        .btn-filter {
                            border: 1px solid #e5e7eb;
                            background: white;
                            padding: 6px 18px;
                            border-radius: 8px;
                            color: #374151;
                            font-weight: 500;
                            text-decoration: none;
                            transition: 0.2s;
                        }

                        .btn-filter.active {
                            background-color: var(--primary-green);
                            color: white;
                            border-color: var(--primary-green);
                        }

                        /* Style cho các nút chức năng theo ảnh của bạn */
                        .btn-highlands {
                            background-color: #ffb800;
                            color: #000;
                            font-weight: 600;
                            border: none;
                        }

                        .btn-reset {
                            border: 1px solid #ef4444;
                            color: #ef4444;
                            background: white;
                            font-weight: 500;
                        }

                        .btn-save {
                            background-color: var(--primary-green);
                            color: white;
                            font-weight: 600;
                            border: none;
                        }

                        .btn-save:hover {
                            background-color: #059669;
                        }

                        /* Preview Ảnh */
                        #ProductPreview {
                            border-radius: 8px;
                            margin-top: 10px;
                            border: 1px solid #e5e7eb;
                            max-width: 100%;
                        }

                        /* Khắc phục lỗi phình màn hình */
                        .row.g-4 {
                            margin: 0;
                            /* Đảm bảo row không gây ra cuộn ngang */
                            width: 100%;
                        }
                    </style>

                    <script>
                        $(document).ready(() => {
                            // Logic xem trước ảnh - GIỮ NGUYÊN
                            const ProductFile = $("#ProductImage");
                            ProductFile.change(function (e) {
                                if (e.target.files && e.target.files[0]) {
                                    const imgURL = URL.createObjectURL(e.target.files[0]);
                                    $("#ProductPreview").attr("src", imgURL).css({ "display": "block" });
                                }
                            });
                        }); 
                    </script>
                </head>

                <body>
                    <div class="main-wrapper">

                        <c:set var="activeMenu" value="products" scope="request" />
                        <jsp:include page="../layout/sidebar.jsp" />

                        <div class="main-content-wrapper">
                            <div
                                class="page-header d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                                <div>
                                    <h4 class="mb-0">Sản phẩm</h4>
                                    <span class="text-muted small">Quản lý danh mục & món uống</span>
                                </div>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-highlands btn-sm px-3 shadow-sm" type="button">
                                        <i class="bi bi-cloud-download me-1"></i> Lấy Menu Highlands
                                    </button>
                                    <button class="btn btn-reset btn-sm px-3 shadow-sm" type="button">
                                        <i class="bi bi-arrow-counterclockwise me-1"></i> Reset kho về 100
                                    </button>
                                    <button class="btn btn-outline-secondary btn-sm px-3 bg-white" type="button"
                                        onclick="location.reload()">
                                        <i class="bi bi-arrow-clockwise me-1"></i> Làm mới
                                    </button>
                                </div>
                            </div>

                            <div class="row g-4 flex-grow-1">
                                <div class="col-lg-8 h-100">
                                    <div class="card h-100 p-4">
                                        <div
                                            class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
                                            <div class="d-flex align-items-center gap-3 overflow-hidden">
                                                <span class="fw-bold text-secondary text-nowrap">Lọc theo danh
                                                    mục:</span>
                                                <div class="category-scroll" id="categoryScroll">
                                                    <a href="/admin/product"
                                                        class="btn-filter ${empty param.categoryId ? 'active' : ''}">Tất
                                                        cả</a>
                                                    <c:forEach var="cat" items="${categories}">
                                                        <a href="/admin/product?categoryId=${cat.categoryId}"
                                                            class="btn-filter ${param.categoryId == cat.categoryId ? 'active' : ''}">
                                                            ${cat.categoryName}
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <div class="text-muted small fst-italic">
                                                Kho sẽ tự động đặt lại về 100 mỗi ngày.
                                            </div>
                                        </div>

                                        <div class="table-responsive">
                                            <table class="table table-hover align-middle">
                                                <thead>
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
                                                                <img src="/images/product/${product.image}" alt="Ảnh"
                                                                    class="rounded shadow-sm"
                                                                    style="width: 48px; height: 48px; object-fit: cover;" />
                                                            </td>
                                                            <td class="fw-bold text-dark">${product.productName}</td>
                                                            <td>
                                                                <span
                                                                    class="badge bg-light text-secondary border px-2 py-1 fw-normal">${product.category.categoryName}</span>
                                                            </td>
                                                            <td class="text-end fw-bold text-success">
                                                                <fmt:formatNumber value="${product.price}" type="number"
                                                                    pattern="###,###" /> ₫
                                                            </td>
                                                            <td class="text-center">${product.amount}</td>
                                                            <td class="text-end">
                                                                <div class="btn-group border rounded bg-white">
                                                                    <a href="/admin/product/edit/${product.productId}"
                                                                        class="btn btn-sm btn-white border-0"
                                                                        title="Sửa">
                                                                        <i class="bi bi-pencil text-primary"></i>
                                                                    </a>
                                                                    <a href="/admin/product/delete/${product.productId}"
                                                                        class="btn btn-sm btn-white border-0"
                                                                        onclick="return confirm('Xóa món này?')"
                                                                        title="Xóa">
                                                                        <i class="bi bi-trash text-danger"></i>
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

                                <div class="col-lg-4">
                                    <div class="card p-3 shadow-sm">
                                        <h5 class="fw-bold mb-3" style="color: var(--text-dark); font-size: 1.1rem;">
                                            ${not empty newProduct.productId && newProduct.productId > 0 ? 'Cập nhật
                                            món' : 'Thêm sản phẩm mới'}
                                        </h5>

                                        <form:form id="product-form" method="POST" action="/admin/product"
                                            modelAttribute="newProduct" enctype="multipart/form-data">
                                            <form:hidden path="productId" />

                                            <div class="mb-2">
                                                <label class="form-label small fw-bold text-secondary mb-1">Tên sản
                                                    phẩm</label>
                                                <form:input type="text" class="form-control form-control-sm"
                                                    path="productName" placeholder="VD: Cà phê sữa đá" />
                                                <form:errors path="productName" cssClass="text-danger small mt-1" />
                                            </div>

                                            <div class="mb-2">
                                                <label class="form-label small fw-bold text-secondary mb-1">Danh
                                                    mục</label>
                                                <form:select class="form-select form-select-sm" path="category">
                                                    <form:option value="">-- Chọn danh mục --</form:option>
                                                    <form:options items="${categories}" itemValue="categoryId"
                                                        itemLabel="categoryName" />
                                                </form:select>
                                                <form:errors path="category" cssClass="text-danger small mt-1" />
                                            </div>

                                            <div class="row g-2 mb-2">
                                                <div class="col-7">
                                                    <label class="form-label small fw-bold text-secondary mb-1">Giá bán
                                                        (VNĐ)</label>
                                                    <form:input type="number" min="0"
                                                        class="form-control form-control-sm" path="price" />
                                                    <form:errors path="price" cssClass="text-danger small mt-1" />
                                                </div>
                                                <div class="col-5">
                                                    <label class="form-label small fw-bold text-secondary mb-1">Tồn
                                                        kho</label>
                                                    <form:input type="number" min="0"
                                                        class="form-control form-control-sm" path="amount" />
                                                    <form:errors path="amount" cssClass="text-danger small mt-1" />
                                                </div>
                                            </div>

                                            <div class="mb-3">
                                                <label class="form-label small fw-bold text-secondary mb-1">Hình
                                                    ảnh</label>
                                                <input class="form-control form-control-sm" type="file"
                                                    id="ProductImage" accept="image/*" name="ProductImage">

                                                <div class="text-center mt-2">
                                                    <img id="ProductPreview" style="max-height: 150px; display: none;"
                                                        class="rounded shadow-sm border">

                                                    <c:if test="${not empty newProduct.image}">
                                                        <img id="OldImage" src="/images/product/${newProduct.image}"
                                                            style="max-height: 150px;" class="rounded shadow-sm border">
                                                    </c:if>
                                                </div>
                                            </div>

                                            <div class="d-grid gap-2">
                                                <button class="btn btn-save py-2 shadow-sm" type="submit"
                                                    style="background-color: #10b981; color: white; border: none; font-weight: 600;">
                                                    <i
                                                        class="bi ${not empty newProduct.productId ? 'bi-save' : 'bi-plus-lg'} me-1"></i>
                                                    ${not empty newProduct.productId ? 'Cập nhật sản phẩm' : 'Thêm sản
                                                    phẩm'}
                                                </button>
                                                <a href="/admin/product"
                                                    class="btn btn-light border py-1 text-muted small">
                                                    <i class="bi bi-x-lg me-1 text-danger"></i> Hủy
                                                </a>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                    <script>
                        $(document).ready(() => {
                            const $scrollCanvas = $('.category-scroll');

                            // 1. Khôi phục vị trí cuộn khi trang vừa load xong
                            const savedScrollPos = localStorage.getItem('categoryScrollPos');
                            if (savedScrollPos && $scrollCanvas.length > 0) {
                                $scrollCanvas.scrollLeft(savedScrollPos);
                            }

                            // 2. Lưu vị trí cuộn khi nhấn vào các nút danh mục (thẻ <a>)
                            $scrollCanvas.find('a').on('click', function () {
                                localStorage.setItem('categoryScrollPos', $scrollCanvas.scrollLeft());
                            });

                            // --- Giữ nguyên Logic kéo chuột của bạn ---
                            let isDown = false;
                            let startX;
                            let scrollLeft;

                            $scrollCanvas.on('mousedown', function (e) {
                                isDown = true;
                                $(this).addClass('active');
                                startX = e.pageX - $scrollCanvas.offset().left;
                                scrollLeft = $scrollCanvas.scrollLeft();
                            });

                            $scrollCanvas.on('mouseleave mouseup', function () {
                                isDown = false;
                                $(this).removeClass('active');
                            });

                            $scrollCanvas.on('mousemove', function (e) {
                                if (!isDown) return;
                                e.preventDefault();
                                const x = e.pageX - $scrollCanvas.offset().left;
                                const walk = (x - startX) * 2;
                                $scrollCanvas.scrollLeft(scrollLeft - walk);
                            });

                            $('.category-scroll a').on('dragstart', function (e) {
                                e.preventDefault();
                            });
                        });
                    </script>
                </body>

                </html>