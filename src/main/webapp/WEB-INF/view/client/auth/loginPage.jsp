<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Đăng Nhập | Cafe Manager</title>

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
                    rel="stylesheet">

                <link href="/client/css/login.css" rel="stylesheet">
            </head>

            <body>

                <div class="bg-wrapper">
                    <div class="bg-overlay"></div>

                    <div class="login-card">
                        <div class="text-center mb-4">
                            <div class="logo-icon">☕</div>
                            <h3 class="fw-bold" style="color: #5A3219;">CAFE MANAGER</h3>
                            <p class="text-muted" style="font-size: 0.9rem;">Hệ thống quản lý nội bộ</p>
                        </div>

                        <c:if test="${not empty param.error}">
                            <div class="alert alert-danger py-2 text-center" role="alert"
                                style="font-size: 0.9rem; border-radius: 10px;">
                                Sai tên đăng nhập hoặc mật khẩu!
                            </div>
                        </c:if>
                        <c:if test="${not empty param.logout}">
                            <div class="alert alert-success py-2 text-center" role="alert"
                                style="font-size: 0.9rem; border-radius: 10px;">
                                Đã đăng xuất an toàn.
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/login" method="POST">

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="username" name="username"
                                    placeholder="Tên đăng nhập" required autofocus>
                                <label for="username" class="text-muted">Tên đăng nhập</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="password" name="password"
                                    placeholder="Mật khẩu" required>
                                <label for="password" class="text-muted">Mật khẩu</label>
                            </div>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <div class="d-flex justify-content-between align-items-center mb-4 px-1"
                                style="font-size: 0.9rem;">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="rememberMe" name="remember-me"
                                        style="cursor: pointer;">
                                    <label class="form-check-label text-muted" for="rememberMe"
                                        style="cursor: pointer;">
                                        Ghi nhớ tôi
                                    </label>
                                </div>
                                <a href="#" class="text-decoration-none fw-semibold" style="color: #8E5431;">Quên mật
                                    khẩu?</a>
                            </div>

                            <div class="d-grid mt-2">
                                <button type="submit" class="btn btn-cafe btn-lg">ĐĂNG NHẬP</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>