package com.example.cafe_project.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Auth {
    @GetMapping("/login")
    public String getLoginPage() {
        return "/client/auth/loginPage";
    }

    @GetMapping("/register")
    public String getRegisterPage() {
        return "/client/auth/registerPage";
    }
}
