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
                                                        <c:forEach var="user" items="${users}">
                                                            <tr>
                                                                <td class="text-muted small">USR-${user.id}</td>
                                                                <td class="fw-semibold"
                                                                    style="color: var(--text-dark);">
                                                                    ${user.username}
                                                                </td>
                                                                <td>${user.fullname}</td>
                                                                <td>
                                                                    <c:choose>
                                                                        <c:when test="${user.role.name == 'ADMIN'}">
                                                                            <span
                                                                                class="badge bg-danger px-2 py-1">ADMIN</span>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <span
                                                                                class="badge bg-primary px-2 py-1">USER</span>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </td>
                                                                <td class="text-end">
                                                                    <div class="btn-group">
                                                                        <a href="/admin/employee/edit/${user.id}"
                                                                            class="btn btn-outline-primary px-2 py-1"
                                                                            title="Sửa">
                                                                            <i class="bi bi-pencil"></i>
                                                                        </a>
                                                                        <a href="/admin/employee/delete/${user.id}"
                                                                            class="btn btn-outline-danger px-2 py-1"
                                                                            title="Xóa"
                                                                            onclick="return confirm('Bạn có chắc muốn xóa nhân viên này?')">
                                                                            <i class="bi bi-trash"></i>
                                                                        </a>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        <c:if test="${empty users}">
                                                            <tr>
                                                                <td colspan="5" class="text-center text-muted py-4">
                                                                    <i class="bi bi-person-x fs-1 d-block mb-2"></i>
                                                                    Chưa có nhân viên nào
                                                                </td>
                                                            </tr>
                                                        </c:if>
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
                                                <h5 class="mb-0 fw-bold" style="color: var(--text-dark);">
                                                    <c:choose>
                                                        <c:when test="${user != null}">Chỉnh sửa nhân viên</c:when>
                                                        <c:otherwise>Thêm nhân viên mới</c:otherwise>
                                                    </c:choose>
                                                </h5>
                                                <c:if test="${user != null}">
                                                    <a href="/admin/employee"
                                                        class="btn btn-outline-secondary px-2 py-1">
                                                        <i class="bi bi-x-lg"></i> Hủy
                                                    </a>
                                                </c:if>
                                            </div>

                                            <!-- Success/Error Messages -->
                                            <c:if test="${not empty successMessage}">
                                                <div class="alert alert-success alert-dismissible fade show mb-3"
                                                    role="alert">
                                                    <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
                                                    <button type="button" class="btn-close"
                                                        data-bs-dismiss="alert"></button>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty errorMessage}">
                                                <div class="alert alert-danger alert-dismissible fade show mb-3"
                                                    role="alert">
                                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                                                    <button type="button" class="btn-close"
                                                        data-bs-dismiss="alert"></button>
                                                </div>
                                            </c:if>

                                            <form:form modelAttribute="user" method="post"
                                                action="${user != null && user.id != null ? '/admin/employee/edit/' : '/admin/employee'}"
                                                class="flex-grow-1 d-flex flex-column">
                                                <c:if test="${user != null && user.id != null}">
                                                    <form:hidden path="id" value="${user.id}" />
                                                </c:if>

                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Tài
                                                        khoản</label>
                                                    <form:input path="username" type="text" class="form-control"
                                                        placeholder="Nhập tên đăng nhập" required="true" />
                                                    <form:errors path="username" cssClass="text-danger small" />
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Mật
                                                        khẩu</label>
                                                    <form:password path="password" class="form-control"
                                                        placeholder="${user != null && user.id != null ? 'Để trống nếu không đổi' : 'Nhập mật khẩu'}"
                                                        required="${user == null || user.id == null}" />
                                                    <form:errors path="password" cssClass="text-danger small" />
                                                    <div class="form-text mt-1"
                                                        style="color: var(--text-gray); font-size: 0.85rem;">
                                                        ${user != null && user.id != null ? '(Để trống nếu không muốn
                                                        đổi mật khẩu)' : '(Bắt buộc nhập)'}
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Họ
                                                        tên</label>
                                                    <form:input path="fullname" type="text" class="form-control"
                                                        placeholder="VD: Nguyễn Văn A" />
                                                    <form:errors path="fullname" cssClass="text-danger small" />
                                                </div>

                                                <div class="mb-4">
                                                    <label class="form-label fw-semibold"
                                                        style="color: var(--text-dark);">Vai
                                                        trò</label>
                                                    <select class="form-select" name="roleId" required>
                                                        <c:forEach var="role" items="${roles}">
                                                            <option value="${role.id}" ${user !=null &&
                                                                user.role.id==role.id ? 'selected' : '' }>
                                                                ${role.name == 'ADMIN' ? 'Quản trị viên (ADMIN)' : 'Nhân
                                                                viên (USER)'}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="d-grid gap-2 mt-auto pt-3">
                                                    <button type="submit"
                                                        class="btn ${user != null ? 'btn-warning' : 'btn-success'} py-2 d-flex justify-content-center align-items-center gap-2">
                                                        <i
                                                            class="bi ${user != null ? 'bi-pencil-square' : 'bi-person-plus-fill'}"></i>
                                                        ${user != null ? 'Cập nhật' : 'Thêm người dùng'}
                                                    </button>
                                                </div>
                                            </form:form>
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