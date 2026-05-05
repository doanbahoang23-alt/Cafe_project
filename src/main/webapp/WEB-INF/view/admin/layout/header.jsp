<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <div class="container mt-5">

                <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">

                    <div>
                        <h4 class="mb-1 text-dark fw-bold">
                            ${not empty pageTitle ? pageTitle : 'Quản lý Người dùng'}
                        </h4>
                        <small class="text-muted">
                            ${not empty pageSubtitle ? pageSubtitle : 'Hiển thị danh sách và thông tin chi tiết của
                            người
                            dùng'}
                        </small>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-outline-secondary btn-sm">
                            <i class="bi bi-file-earmark-excel"></i> Xuất Excel
                        </button>
                        <button type="button" class="btn btn-primary btn-sm">
                            <i class="bi bi-plus-lg"></i> Thêm mới
                        </button>
                    </div>

                </div>
                <div class="card shadow-sm border-0">
                    <div class="card-body">
                        <p class="mb-0">Nội dung bảng dữ liệu hoặc form sẽ nằm ở đây...</p>
                    </div>
                </div>

            </div>