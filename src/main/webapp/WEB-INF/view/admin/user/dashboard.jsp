<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Tổng quan Dashboard - Preview</title>

                <!-- Bootstrap 5 CSS & Icons -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">


                <link rel="stylesheet" href="/admin/css/App.css">
            </head>

            <body>
                <div class="d-flex">

                    <c:set var="activeMenu" value="dasboard" scope="request" />

                    <jsp:include page="../layout/sidebar.jsp" />

                    <div class="flex-grow-1 bg-light" style="min-height: 100vh;">


                        <div class="container py-4">

                            <!-- Page Header -->
                            <div class="d-flex justify-content-between align-items-center mb-4 page-header">
                                <div>
                                    <h4 class="mb-0">Tổng quan</h4>
                                    <span class="text-muted small">Tình hình kinh doanh hôm nay</span>
                                </div>
                                <button class="btn btn-success btn-sm"><i
                                        class="bi bi-file-earmark-arrow-down me-1"></i> Xuất
                                    báo
                                    cáo</button>
                            </div>

                            <!-- Alert Đăng nhập -->
                            <div class="alert alert-success d-flex align-items-center gap-3 shadow-sm border-0 mb-4"
                                role="alert" style="background-color: #d1e7dd; color: #0f5132;">
                                <span class="bi bi-check-circle-fill" style="font-size: 1.5rem;"></span>
                                <div>
                                    <h6 class="alert-heading fw-bold mb-0">Đăng nhập thành công!</h6>
                                    <small>
                                        Chào mừng <strong>Đoàn Bá Hoàng</strong> quay trở lại. Vai trò: <span
                                            class="badge bg-success">ADMIN</span>
                                    </small>
                                </div>
                            </div>

                            <!-- Thẻ Thống kê (Stat Cards) -->
                            <div class="row g-3 mb-4">
                                <!-- Doanh thu hôm nay -->
                                <div class="col-md-4">
                                    <div class="card h-100 p-3">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h6 class="text-muted small mb-2">Doanh thu hôm nay</h6>
                                                <h4 class="fw-bold mb-1 text-dark">5.240.000 ₫</h4>
                                                <small class="text-muted">45 hóa đơn</small>
                                            </div>
                                            <div class="stat-card-icon">
                                                <i class="bi bi-cash-stack"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Số hóa đơn -->
                                <div class="col-md-4">
                                    <div class="card h-100 p-3">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h6 class="text-muted small mb-2">Số hóa đơn hôm nay</h6>
                                                <h4 class="fw-bold mb-1 text-dark">45 đơn</h4>
                                                <small class="text-muted">Tổng số đơn đã thanh toán</small>
                                            </div>
                                            <div class="stat-card-icon">
                                                <i class="bi bi-receipt"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Trạng thái công suất -->
                                <div class="col-md-4">
                                    <div class="card h-100 p-3">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <h6 class="text-muted small mb-2">Bàn đang phục vụ</h6>
                                                <h4 class="fw-bold mb-1 text-dark">8 / 20</h4>
                                                <small class="text-muted">40% công suất</small>
                                            </div>
                                            <div class="stat-card-icon">
                                                <i class="bi bi-shop"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Main Content Row -->
                            <div class="row g-3">
                                <!-- Cột trái: Biểu đồ doanh thu -->
                                <div class="col-md-8">
                                    <div class="card h-100">
                                        <div class="card-body">
                                            <div class="bg-light rounded p-3">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <span class="fw-semibold small">Biểu đồ doanh thu</span>
                                                    <span class="text-muted small">7 ngày gần nhất</span>
                                                </div>
                                                <!-- Vùng chứa biểu đồ SVG -->
                                                <div id="chartContainer" class="position-relative"
                                                    style="min-height: 260px;">
                                                    <!-- Sẽ được render bằng Vanilla JS bên dưới -->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Cột phải: Top Sản Phẩm & Trạng Thái Bàn -->
                                <div class="col-md-4">

                                    <!-- Top Sản Phẩm Bán Chạy -->
                                    <div class="card mb-3">
                                        <div class="card-body">
                                            <h6 class="mb-3 border-bottom pb-2 fw-bold">🔥 Top bán chạy</h6>
                                            <ul class="list-group list-group-flush small">
                                                <li
                                                    class="list-group-item d-flex justify-content-between px-0 align-items-center border-0">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span class="badge rounded-pill bg-warning text-dark">1</span>
                                                        <span class="fw-semibold text-truncate"
                                                            style="max-width: 140px;" title="Cà phê sữa đá">Cà phê sữa
                                                            đá</span>
                                                    </div>
                                                    <span class="text-success fw-bold">120 đã bán</span>
                                                </li>
                                                <li
                                                    class="list-group-item d-flex justify-content-between px-0 align-items-center border-0">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span
                                                            class="badge rounded-pill bg-light text-secondary border">2</span>
                                                        <span class="fw-semibold text-truncate"
                                                            style="max-width: 140px;" title="Trà đào cam sả">Trà đào cam
                                                            sả</span>
                                                    </div>
                                                    <span class="text-success fw-bold">85 đã bán</span>
                                                </li>
                                                <li
                                                    class="list-group-item d-flex justify-content-between px-0 align-items-center border-0">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span
                                                            class="badge rounded-pill bg-light text-secondary border">3</span>
                                                        <span class="fw-semibold text-truncate"
                                                            style="max-width: 140px;" title="Bạc xỉu">Bạc xỉu</span>
                                                    </div>
                                                    <span class="text-success fw-bold">64 đã bán</span>
                                                </li>
                                                <li
                                                    class="list-group-item d-flex justify-content-between px-0 align-items-center border-0">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span
                                                            class="badge rounded-pill bg-light text-secondary border">4</span>
                                                        <span class="fw-semibold text-truncate"
                                                            style="max-width: 140px;" title="Trà vải nhiệt đới">Trà vải
                                                            nhiệt đới</span>
                                                    </div>
                                                    <span class="text-success fw-bold">42 đã bán</span>
                                                </li>
                                                <li
                                                    class="list-group-item d-flex justify-content-between px-0 align-items-center border-0 pb-0">
                                                    <div class="d-flex align-items-center gap-2">
                                                        <span
                                                            class="badge rounded-pill bg-light text-secondary border">5</span>
                                                        <span class="fw-semibold text-truncate"
                                                            style="max-width: 140px;" title="Trà sen vàng">Trà sen
                                                            vàng</span>
                                                    </div>
                                                    <span class="text-success fw-bold">38 đã bán</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Trạng Thái Bàn -->
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <h6 class="mb-0 fw-bold">Trạng thái bàn</h6>
                                                <button class="btn border btn-sm text-muted"
                                                    onclick="window.location.reload()">
                                                    <i class="bi bi-arrow-clockwise"></i>
                                                </button>
                                            </div>
                                            <div class="d-flex flex-wrap gap-2">
                                                <!-- Bàn đang phục vụ (1) -->
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-secondary-subtle text-secondary">Bàn
                                                    01</span>
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-secondary-subtle text-secondary">Bàn
                                                    04</span>
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-secondary-subtle text-secondary">Bàn
                                                    05</span>
                                                <!-- Bàn trống (0) -->
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-success-subtle text-success">Bàn
                                                    02</span>
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-success-subtle text-success">Bàn
                                                    03</span>
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-success-subtle text-success">Bàn
                                                    06</span>
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-success-subtle text-success">Bàn
                                                    07</span>
                                                <!-- Bàn đang dọn / lỗi (2) -->
                                                <span
                                                    class="badge rounded-pill px-3 py-2 bg-warning-subtle text-warning">Bàn
                                                    08</span>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Script render biểu đồ SVG (Đã được escape \${} để chạy an toàn trên JSP) -->
                <script>
                    const formatCurrency = (value) =>
                        new Intl.NumberFormat("vi-VN", { style: "currency", currency: "VND" }).format(Number(value || 0));

                    // Dữ liệu mẫu (Mock Data) 7 ngày
                    const dailyStatsMockData = [
                        { key: "1", label: "01/05", value: 3500000 },
                        { key: "2", label: "02/05", value: 4200000 },
                        { key: "3", label: "03/05", value: 5400000 },
                        { key: "4", label: "04/05", value: 3800000 },
                        { key: "5", label: "05/05", value: 4500000 },
                        { key: "6", label: "06/05", value: 6700000 },
                        { key: "7", label: "07/05", value: 5240000 }
                    ];

                    function renderChart(data) {
                        const container = document.getElementById('chartContainer');
                        if (!data || data.length === 0 || data.every(d => d.value === 0)) {
                            container.innerHTML = '<div class="text-center text-muted small mt-5">Chưa có doanh thu trong 7 ngày qua</div>';
                            return;
                        }

                        const maxValue = Math.max(...data.map(d => d.value), 1);
                        const svgHeight = 260;
                        const margin = { top: 24, right: 24, bottom: 40, left: 80 };
                        const innerHeight = svgHeight - margin.top - margin.bottom;
                        const innerWidth = Math.max(data.length * 72, 320);
                        const svgWidth = innerWidth + margin.left + margin.right;
                        const step = innerWidth / Math.max(data.length, 1);
                        const barWidth = Math.min(30, step * 0.4);
                        const baselineY = margin.top + innerHeight;
                        const ticks = [0.25, 0.5, 0.75, 1];
                        const fontFamily = "'Be Vietnam Pro', system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif";

                        let ticksHtml = ticks.map(t => {
                            const value = maxValue * t;
                            const y = margin.top + innerHeight * (1 - value / maxValue);
                            return `
                    <g>
                        <line x1="\${margin.left}" y1="\${y}" x2="\${svgWidth - margin.right}" y2="\${y}" stroke="#e9ecef" stroke-width="1" stroke-dasharray="4 4" />
                        <text x="\${margin.left - 8}" y="\${y + 3}" text-anchor="end" font-size="10" fill="#6c757d" font-family="\${fontFamily}">\${formatCurrency(Math.round(value))}</text>
                    </g>
                `;
                        }).join('');

                        let barsHtml = data.map((day, idx) => {
                            const ratio = day.value / maxValue;
                            const barHeight = day.value ? innerHeight * ratio : 0;
                            const x = margin.left + idx * step + (step - barWidth) / 2;
                            const y = baselineY - barHeight;
                            const centerX = x + barWidth / 2;

                            let rectHtml = day.value > 0 ? `
                    <rect x="\${x}" y="\${y}" width="\${barWidth}" height="\${barHeight}" rx="4" fill="var(--primary-color, #10b981)">
                        <title>\${day.label}: \${formatCurrency(day.value)}</title>
                    </rect>
                    <text x="\${centerX}" y="\${y - 6}" text-anchor="middle" font-size="11" fill="#495057" font-family="\${fontFamily}">\${formatCurrency(day.value)}</text>
                ` : '';

                            return `
                    <g>
                        \${rectHtml}
                        <text x="\${centerX}" y="\${baselineY + 16}" text-anchor="middle" font-size="11" fill="#343a40" font-family="\${fontFamily}">\${day.label}</text>
                    </g>
                `;
                        }).join('');

                        container.innerHTML = `
                <svg width="100%" height="\${svgHeight}" viewBox="0 0 \${svgWidth} \${svgHeight}" preserveAspectRatio="none">
                    <line x1="\${margin.left}" y1="\${baselineY}" x2="\${svgWidth - margin.right}" y2="\${baselineY}" stroke="#dee2e6" stroke-width="1.5" />
                    <line x1="\${margin.left}" y1="\${margin.top}" x2="\${margin.left}" y2="\${baselineY}" stroke="#dee2e6" stroke-width="1.5" />
                    \${ticksHtml}
                    \${barsHtml}
                </svg>
            `;
                    }

                    renderChart(dailyStatsMockData);
                </script>
            </body>

            </html>