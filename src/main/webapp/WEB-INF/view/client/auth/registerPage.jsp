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

                        <form:form action="/register" method="POST" modelAttribute="registerUser">
                            <c:set var="errorFirstName">
                                <form:errors path="firstName" />
                            </c:set>
                            <c:set var="errorLastName">
                                <form:errors path="lastName" />
                            </c:set>
                            <c:set var="errorUsername">
                                <form:errors path="userName" />
                            </c:set>
                            <c:set var="errorConfirmPassword">
                                <form:errors path="confirmPassword" />
                            </c:set>

                            <!-- Dòng 1: Họ và Tên -->
                            <div class="row g-2 mb-3">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <form:input type="text"
                                            class="form-control ${not empty errorFirstName ? 'is-invalid' : ''}"
                                            id="lastName" name="lastName" placeholder="Họ đệm" required="required"
                                            autofocus="autofocus" path="lastName" />
                                        ${errorFirstName}
                                        <label for="lastName" class="text-muted">Họ đệm</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <form:input type="text"
                                            class="form-control ${not empty errorLastName ? 'is-invalid' : ''}"
                                            id="firstName" name="firstName" placeholder="Tên" required="required"
                                            path="firstName" />
                                        ${errorLastName}
                                        <label for="firstName" class="text-muted">Tên</label>
                                    </div>
                                </div>
                            </div>

                            <!-- Dòng 2: Username -->
                            <div class="form-floating mb-3">
                                <form:input type="text"
                                    class="form-control ${not empty errorUserName ? 'is-invalid' : ''}" id="username"
                                    name="username" placeholder="Tên đăng nhập" required="required" path="userName" />
                                ${errorUsername}
                                <label for="username" class="text-muted">Tên đăng nhập (Username)</label>
                            </div>

                            <!-- Dòng 3: Mật khẩu & Xác nhận mật khẩu -->
                            <div class="row g-2 mb-4">
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <form:input type="password"
                                            class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                            id="password" name="password" placeholder="Mật khẩu" required="required"
                                            path="password" />
                                        ${errorConfirmPassword}
                                        <label for="password" class="text-muted">Mật khẩu</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-floating">
                                        <form:input type="password"
                                            class="form-control ${not empty errorPassword ? 'is-invalid' : ''}"
                                            id="rePassword" name="rePassword" placeholder="Xác nhận mật khẩu"
                                            required="required" path="confirmPassword" />
                                        ${errorConfirmPassword}
                                        <label for="rePassword" class="text-muted">Xác nhận mật khẩu</label>
                                    </div>
                                </div>
                            </div>


                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-cafe btn-lg">ĐĂNG KÝ NGAY</button>
                                <a href="/login" class="btn btn-link text-decoration-none text-muted mt-2"
                                    style="font-size: 0.9rem;">
                                    Đã có tài khoản? <span class="fw-bold" style="color: #8E5431;">Đăng nhập</span>
                                </a>
                            </div>
                        </form:form>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>