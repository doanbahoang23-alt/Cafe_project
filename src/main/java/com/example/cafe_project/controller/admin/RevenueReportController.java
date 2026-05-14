package com.example.cafe_project.controller.admin;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Objects;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.cafe_project.domain.dto.RevenueDayDTO;
import com.example.cafe_project.service.DashboardService;

@Controller
public class RevenueReportController {

    private final DashboardService dashboardService;

    public RevenueReportController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/admin/revenue_report")
    public String getRevenueReportPage(Model model,
            @RequestParam(value = "range", required = false) String range,
            @RequestParam(value = "fromDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
            @RequestParam(value = "toDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate) {
        LocalDate today = LocalDate.now();
        if ("today".equals(range)) {
            fromDate = today;
            toDate = today;
        } else if ("week".equals(range)) {
            fromDate = today.minusDays(6);
            toDate = today;
        } else if ("month".equals(range)) {
            fromDate = today.withDayOfMonth(1);
            toDate = today;
        } else if (fromDate == null || toDate == null) {
            fromDate = today;
            toDate = today;
            range = "today";
        }

        if (fromDate.isAfter(toDate)) {
            LocalDate temp = fromDate;
            fromDate = toDate;
            toDate = temp;
        }

        List<RevenueDayDTO> revenueDetails = dashboardService.getRevenueDetails(fromDate, toDate);
        BigDecimal totalRevenue = revenueDetails.stream()
                .map(RevenueDayDTO::getRevenue)
                .filter(Objects::nonNull)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        long totalOrders = revenueDetails.stream().mapToLong(RevenueDayDTO::getOrderCount).sum();
        BigDecimal averageOrderValue = totalOrders > 0
                ? totalRevenue.divide(BigDecimal.valueOf(totalOrders), 0, RoundingMode.HALF_UP)
                : BigDecimal.ZERO;

        long maxRevenue = revenueDetails.stream()
                .mapToLong(day -> day.getRevenue() != null ? day.getRevenue().longValue() : 0L)
                .max()
                .orElse(1L);

        int maxHeightPx = 220;
        int revenueMax = maxRevenue == 0 ? 1 : (int) maxRevenue;
        for (RevenueDayDTO detail : revenueDetails) {
            long revenueValue = detail.getRevenue() != null ? detail.getRevenue().longValue() : 0L;
            detail.setBarHeightPercent(revenueMax > 0 ? (int) ((revenueValue * maxHeightPx) / revenueMax) : 0);
        }

        DateTimeFormatter isoFormatter = DateTimeFormatter.ISO_DATE;
        DateTimeFormatter labelFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        model.addAttribute("selectedRange", range != null ? range : "today");
        model.addAttribute("fromDate", fromDate.format(isoFormatter));
        model.addAttribute("toDate", toDate.format(isoFormatter));
        model.addAttribute("dateRangeLabel", fromDate.equals(toDate)
                ? fromDate.format(labelFormatter)
                : String.format("%s - %s", fromDate.format(labelFormatter), toDate.format(labelFormatter)));
        model.addAttribute("revenueTotal", totalRevenue);
        model.addAttribute("orderCount", totalOrders);
        model.addAttribute("averageOrderValue", averageOrderValue);
        model.addAttribute("details", revenueDetails);
        model.addAttribute("maxRevenue", maxRevenue == 0 ? 1 : maxRevenue);
        model.addAttribute("updatedAt", LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy")));

        return "admin/user/revenueReport";
    }
}
