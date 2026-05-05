<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <%-- Cải thiện active class: Thêm bo góc (rounded), lề 2 bên (mx-2) để menu trông gọn gàng dạng nút
                (button-like) --%>
                <c:set var="activeClass" value="active bg-white text-success fw-bold shadow-sm rounded mx-2 mb-1" />
                <c:set var="inactiveClass" value="text-white-75 nav-item-hover rounded mx-2 mb-1" />

                <aside class="d-flex flex-column flex-shrink-0 shadow-lg"
                    style="width: 250px; min-width: 250px; background-color: #046c4e; min-height: 100vh;">

                    <div class="p-3 border-bottom border-success-subtle mb-3">
                        <div class="d-flex align-items-center gap-3 px-2">
                            <div class="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold shadow-sm"
                                style="width: 45px; height: 45px; background-color: #03a66a; font-size: 1.1rem;">
                                CF
                            </div>
                            <div class="text-white">
                                <div class="fw-bold fs-6" style="letter-spacing: 0.5px;">Café Manager</div>
                                <small class="text-white-50" style="font-size: 0.8rem;">Admin dashboard</small>
                            </div>
                        </div>
                    </div>

                    <nav class="nav flex-column flex-grow-1">
                        <span class="text-uppercase text-white-50 px-4 mb-2 fw-semibold"
                            style="font-size: 0.75rem; letter-spacing: 1px;">
                            Main Menu
                        </span>

                        <a href="/admin"
                            class="nav-link d-flex align-items-center px-3 py-2 ${activeMenu == 'dasboard' ? activeClass : inactiveClass}">
                            <i class="me-3 fs-5 bi bi-house-door"></i> Trang chủ
                        </a>

                        <a href="/admin/product/sales"
                            class="nav-link d-flex align-items-center px-3 py-2 ${activeMenu == 'sales' ? activeClass : inactiveClass}">
                            <i class="me-3 fs-5 bi bi-cash-stack"></i> Bán hàng
                        </a>

                        <a href="/admin/revenue_report"
                            class="nav-link d-flex align-items-center px-3 py-2 ${activeMenu == 'revenueReport' ? activeClass : inactiveClass}">
                            <i class="me-3 fs-5 bi bi-graph-up"></i> Báo cáo doanh thu
                        </a>

                        <a href="/admin/category"
                            class="nav-link d-flex align-items-center px-3 py-2 ${activeMenu == 'categories' ? activeClass : inactiveClass}">
                            <i class="me-3 fs-5 bi bi-collection"></i> Danh mục
                        </a>

                        <a href="/admin/product"
                            class="nav-link d-flex align-items-center px-3 py-2 ${activeMenu == 'products' ? activeClass : inactiveClass}">
                            <i class="me-3 fs-5 bi bi-cup-hot"></i> Sản phẩm
                        </a>

                        <a href="/admin/employee"
                            class="nav-link d-flex align-items-center px-3 py-2 ${activeMenu == 'employees' ? activeClass : inactiveClass}">
                            <i class="me-3 fs-5 bi bi-people"></i> Nhân viên
                        </a>

                        <div class="mt-auto mb-4 border-top border-success-subtle pt-3">
                            <form action="${pageContext.request.contextPath}/logout" method="post" class="m-0 p-0">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <button type="submit"
                                    class="nav-link d-flex align-items-center px-3 py-2 w-100 text-start border-0 bg-transparent rounded mx-2 text-danger-hover">
                                    <i class="me-3 fs-5 bi bi-box-arrow-right"></i> Đăng xuất
                                </button>
                            </form>
                        </div>
                    </nav>
                </aside>

                <style>
                    /* Làm sáng màu chữ mặc định lên một chút để dễ đọc hơn */
                    .text-white-75 {
                        color: rgba(255, 255, 255, 0.8) !important;
                    }

                    /* Đảm bảo icon có độ rộng đều nhau, text sẽ được dóng thẳng tắp */
                    .nav-link i {
                        width: 24px;
                        text-align: center;
                    }

                    /* Hiệu ứng hover cho các menu chưa active */
                    .nav-item-hover {
                        transition: all 0.3s ease;
                    }

                    .nav-item-hover:hover {
                        color: #ffffff !important;
                        background-color: rgba(255, 255, 255, 0.1);
                        transform: translateX(5px);
                        /* Trượt nhẹ sang phải tạo cảm giác tương tác */
                    }

                    /* Hover riêng biệt cho nút Đăng xuất (Cảnh báo đỏ nhẹ) */
                    .text-danger-hover {
                        color: rgba(255, 255, 255, 0.6);
                        transition: all 0.3s ease;
                    }

                    .text-danger-hover:hover {
                        color: #ffb3b3 !important;
                        /* Đỏ nhạt */
                        background-color: rgba(220, 53, 69, 0.15);
                        /* Nền đỏ trong suốt */
                    }
                </style>