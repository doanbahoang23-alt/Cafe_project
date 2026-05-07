package com.example.cafe_project.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RevenueReportController {
    @GetMapping("/employee/revenue_report")
    public String getProductDashboard() {
        return "admin/user/revenueReport";
    }
}
