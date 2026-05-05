package com.example.cafe_project.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.cafe_project.domain.Category;
import com.example.cafe_project.domain.Product;
import com.example.cafe_project.service.CategoryService;
import com.example.cafe_project.service.ProductService;

@Controller
public class CategoryController {
    private final CategoryService categoryService;
    private final ProductService productService;

    public CategoryController(CategoryService categoryService, ProductService productService) {
        this.categoryService = categoryService;
        this.productService = productService;
    }

    @GetMapping("/admin/category")
    public String getAdminCategoryPage(Model model, @ModelAttribute("newCategory") Category newCategory) {
        List<Category> categories = this.categoryService.getAllCategory();
        Map<Long, Long> productCountMap = new HashMap<>();

        for (Category c : categories) {
            long count = productService.countProductByCategory(c.getCategoryId());
            productCountMap.put(c.getCategoryId(), count);
        }
        model.addAttribute("newCategory", newCategory);
        model.addAttribute("productCountMap", productCountMap);
        model.addAttribute("ListCategory", categories);
        return "admin/user/category";
    }

    @PostMapping("/admin/category")
    public String CategoryAddAction(Model model, @ModelAttribute("newCategory") Category category) {
        this.categoryService.handleSaveCategory(category);
        return "redirect:/admin/category";
    }

    @GetMapping("admin/category/edit/{id}")
    public String editProductPage(@PathVariable("id") int id, Model model) {
        Category existingCategory = this.categoryService.getCategoryByCategoryId(id);
        List<Category> categories = this.categoryService.getAllCategory();

        model.addAttribute("newCategory", existingCategory);

        model.addAttribute("ListCategory", categories);

        return "admin/user/category";
    }

    @GetMapping("admin/category/delete/{id}")
    public String deleteProduct(@PathVariable("id") int id, Model model) {
        Category existingCategory = this.categoryService.getCategoryByCategoryId(id);
        this.categoryService.deleteCategoryById(id);
        List<Category> categories = this.categoryService.getAllCategory();

        model.addAttribute("newCategory", existingCategory);

        model.addAttribute("ListCategory", categories);

        return "redirect:/admin/category";
    }
}
