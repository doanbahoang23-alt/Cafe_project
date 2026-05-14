package com.example.cafe_project.controller.admin;

import java.security.Principal;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.cafe_project.domain.dto.ChartDataDTO;
import com.example.cafe_project.service.DashboardService;

@Controller
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/employee/dashboard")
    public String getDashboardPage(Model model, Principal principal) {
        model.addAttribute("revenueToday", dashboardService.getRevenueToday());
        model.addAttribute("totalOrdersToday", dashboardService.getTotalOrdersToday());
        model.addAttribute("activeTables", dashboardService.getActiveTableCount());
        model.addAttribute("totalTables", dashboardService.getTotalTableCount());

        model.addAttribute("topProducts", dashboardService.getTopSellingProducts(5));
        model.addAttribute("tableList", dashboardService.getAllTables());

        List<ChartDataDTO> weeklyStats = dashboardService.getWeeklyRevenueStats();
        model.addAttribute("weeklyStats", weeklyStats);

        long maxRevenue = weeklyStats.stream()
                .mapToLong(ChartDataDTO::getValue)
                .max()
                .orElse(1L);
        model.addAttribute("maxRevenue", maxRevenue == 0 ? 1 : maxRevenue);

        String loggedUserName = principal != null ? principal.getName() : "Admin";
        model.addAttribute("loggedUserName", loggedUserName);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String userRole = "ADMIN";
        if (authentication != null && authentication.getAuthorities() != null) {
            userRole = authentication.getAuthorities().stream()
                    .map(GrantedAuthority::getAuthority)
                    .filter(authority -> authority.startsWith("ROLE_"))
                    .findFirst()
                    .map(role -> role.substring(5))
                    .orElse("ADMIN");
        }
        model.addAttribute("userRole", userRole);

        return "admin/user/dashboard";
    }
}
