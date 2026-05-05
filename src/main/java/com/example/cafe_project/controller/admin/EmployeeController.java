package com.example.cafe_project.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class EmployeeController {
    @GetMapping("/admin/employee")
    public String getEmployeeManagerPage() {
        return "admin/user/employee";
    }
}
