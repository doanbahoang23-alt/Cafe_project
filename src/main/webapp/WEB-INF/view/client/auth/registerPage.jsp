<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Đăng Ký Tài Khoản | Cafe Manager</title>

                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap"
                    rel="stylesheet">

                <link href="/client/css/login.css" rel="stylesheet">
            </head>

            <body>

                <div class="bg-wrapper">
                    <div class="bg-overlay"></div>

                    <div class="register-card">
                        <div class="text-center mb-4">
                            <div style="font-size: 2.5rem;">📝</div>
                            <h3 class="fw-bold text-cafe">TẠO TÀI KHOẢN</h3>
                            <p class="text-muted" style="font-size: 0.85rem;">Gia nhập đội ngũ Cafe Manager</p>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger py-2 text-center" role="alert"
                                style="font-size: 0.85rem; border-radius: 10px;">
                                ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/register" method="POST">

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="fullname" name="fullname"
                                    placeholder="Họ và tên" required autofocus>
                                <label for="fullname" class="text-muted">Họ và tên</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="username" name="username"
                                    placeholder="Tên đăng nhập" required>
                                <label for="username" class="text-muted">Tên đăng nhập (Username)</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" id="password" name="password"
                                    placeholder="Mật khẩu" required>
                                <label for="password" class="text-muted">Mật khẩu</label>
                            </div>

                            <div class="form-floating mb-4">
                                <input type="password" class="form-control" id="rePassword" name="rePassword"
                                    placeholder="Xác nhận mật khẩu" required>
                                <label for="rePassword" class="text-muted">Xác nhận mật khẩu</label>
                            </div>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-cafe btn-lg">ĐĂNG KÝ NGAY</button>
                                <a href="${pageContext.request.contextPath}/login"
                                    class="btn btn-link text-decoration-none text-muted mt-2"
                                    style="font-size: 0.9rem;">
                                    Đã có tài khoản? <span class="fw-bold" style="color: #8E5431;">Đăng nhập</span>
                                </a>
                            </div>
                        </form>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>