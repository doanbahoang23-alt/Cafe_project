<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Quản lý Nhân viên</title>

                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@300;400;500;600;700&display=swap"
                    rel="stylesheet">

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

                <link rel="stylesheet" href="/admin/css/App.css">
            </head>

            <body>
                <div class="d-flex w-100 overflow-hidden">

                    <c:set var="activeMenu" value="employees" scope="request" />

                    <jsp:include page="../layout/sidebar.jsp" />

                    <div class="flex-grow-1 bg-light overflow-auto" style="min-height: 100vh;">


                        <div class="container-fluid py-4">
                            <div
                                class="page-header d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                                <div>
                                    <h4 class="mb-0">Nhân Viên</h4>
                                    <span class="text-muted">Quản lý tài khoản & phân quyền</span>
                                </div>
                                <div>
                                    <button class="btn btn-outline-secondary" type="button">
                                        <i class="bi bi-arrow-clockwise me-1"></i> Làm mới
                                    </button>
                                </div>
                            </div>

                            <div class="row g-4">
                                <div class="col-lg-8">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="table-responsive">
                                                <table class="table table-hover align-middle">
                                                    <thead class="table-light">
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Tài khoản</th>
                                                            <th>Họ tên</th>
                                                            <th>Vai trò</th>
                                                            <th class="text-end">Thao tác</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td class="text-muted small">USR-001</td>
                                                            <td class="fw-semibold" style="color: var(--text-dark);">
                                                                admin_root
                                                            </td>
                                                            <td>Quản trị viên hệ thống</td>
                                                            <td>
                                                                <span class="badge bg-danger px-2 py-1">ADMIN</span>
                                                            </td>
                                                            <td class="text-end">
                                                                <div class="btn-group">
                                                                    <button type="button"
                                                                        class="btn btn-outline-primary px-2 py-1"
                                                                        title="Sửa">
                                                                        <i class="bi bi-pencil"></i>
                                                                    </button>
                                                                    <button type="button"
                                                                        class="btn btn-outline-danger px-2 py-1"
                                                                        title="Xóa">
                                                                        <i class="bi bi-trash"></i>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td class="text-muted small">USR-002</td>
                                                            <td class="fw-semibold" style="color: var(--text-dark);">
                                                                nguyenvana
                                                            </td>
                                                            <td>Nguyễn Văn A</td>
                                                            <td>
                                                                <span class="badge bg-primary px-2 py-1">USER</span>
                                                            </td>
                                                            <td class="text-end">
                                                                <div class="btn-group">
                                                                    <button type="button"
                                                                        class="btn btn-outline-primary px-2 py-1"
                                                                        title="Sửa">
                                                                        <i class="bi bi-pencil"></i>
                                                                    </button>
                                                                    <button type="button"
                                                                        class="btn btn-outline-danger px-2 py-1"
                                                                        title="Xóa">
                                                                        <i class="bi bi-trash"></i>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>

                                                        <tr class="table-active">
                                                            <td class="text-muted small">USR-003</td>
                                                            <td class="fw-semibold" style="color: var(--text-dark);">
                                                                tranb</td>
                                                            <td>
                                                                Trần Thị B
                                                                <span class="badge bg-warning text-dark ms-2">Đang
                                                                    sửa</span>
                                                            </td>
                                                            <td>
                                                                <span class="badge bg-primary px-2 py-1">USER</span>
                                                            </td>
                                                            <td class="text-end">
                                                                <div class="btn-group">
                                                                    <button type="button"
                                                                        class="btn btn-outline-primary px-2 py-1"
                                                                        title="Sửa">
                                                                        <i class="bi bi-pencil"></i>
                                                                    </button>
                                                                    <button type="button"
                                                                        class="btn btn-outline-danger px-2 py-1"
                                                                        title="Xóa">
                                                                        <i class="bi bi-trash"></i>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-4">
                                    <div class="card h-100">
                                        <div class="card-body d-flex flex-column">
                                            <div
                                                class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                                                <h5 class="mb-0 fw-bold" style="color: var(--text-dark);">Thêm nhân viên
                                                    mới
                                                </h5>
                                                <button class="btn btn-outline-secondary px-2 py-1" type="button">
                                                    <i class="bi bi-x-lg"></i> Hủy
                                                </button>
                                            </div>

                                            <form id="employee-form" class="flex-grow-1 d-flex flex-column">
                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Tài
                                                        khoản</label>
                                                    <input type="text" class="form-control" name="username" required
                                                        placeholder="Nhập tên đăng nhập" />
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Mật
                                                        khẩu</label>
                                                    <input type="password" class="form-control" name="password" required
                                                        placeholder="Nhập mật khẩu" />
                                                    <div class="form-text mt-1"
                                                        style="color: var(--text-gray); font-size: 0.85rem;">
                                                        (Để trống nếu không muốn đổi mật khẩu khi cập nhật)
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Họ
                                                        tên</label>
                                                    <input type="text" class="form-control" name="fullname"
                                                        placeholder="VD: Nguyễn Văn A" />
                                                </div>

                                                <div class="mb-4">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Vai
                                                        trò</label>
                                                    <select class="form-select" name="role">
                                                        <option value="USER">Nhân viên (USER)</option>
                                                        <option value="ADMIN">Quản trị viên (ADMIN)</option>
                                                    </select>
                                                </div>

                                                <div class="d-grid gap-2 mt-auto pt-3">
                                                    <button
                                                        class="btn btn-success py-2 d-flex justify-content-center align-items-center gap-2"
                                                        type="button">
                                                        <i class="bi bi-person-plus-fill"></i> Thêm người dùng
                                                    </button>
                                                </div>
                                            </form>
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