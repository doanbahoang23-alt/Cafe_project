package com.example.cafe_project.controller.client;

import com.example.cafe_project.service.ProductService;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.cafe_project.domain.Product;

@Controller
public class HomePageController {
    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        List<Product> products = this.productService.getAllProduct();
        model.addAttribute("products", products);
        return "client/homepage/homepage";
    }

}
