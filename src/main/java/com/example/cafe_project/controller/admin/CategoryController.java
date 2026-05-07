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

import com.example.cafe_project.domain.CafeTable;
import com.example.cafe_project.domain.Category;
import com.example.cafe_project.service.CafeTableService;
import com.example.cafe_project.service.CategoryService;
import com.example.cafe_project.service.ProductService;

@Controller
public class CategoryController {
    private final CategoryService categoryService;
    private final ProductService productService;
    private final CafeTableService cafeTableService;

    public CategoryController(CategoryService categoryService, ProductService productService,
            CafeTableService cafeTableService) {
        this.categoryService = categoryService;
        this.productService = productService;
        this.cafeTableService = cafeTableService;
    }

    @GetMapping("/employee/category")
    public String getAdminCategoryPage(Model model, @ModelAttribute("newCategory") Category newCategory,
            @ModelAttribute("newCafeTable") CafeTable newCafeTable) {
        List<Category> categories = this.categoryService.getAllCategory();
        List<CafeTable> cafeTables = this.cafeTableService.getAllCafeTable();
        Map<Long, Long> productCountMap = new HashMap<>();

        for (Category c : categories) {
            long count = productService.countProductByCategory(c.getCategoryId());
            productCountMap.put(c.getCategoryId(), count);
        }

        model.addAttribute("productCountMap", productCountMap);
        model.addAttribute("ListCategory", categories);

        model.addAttribute("ListCafeTable", cafeTables);
        return "admin/user/category";
    }

    @PostMapping("/employee/category")
    public String CategoryAddAction(Model model, @ModelAttribute("newCategory") Category category) {
        this.categoryService.handleSaveCategory(category);

        return "redirect:/employee/category";
    }

    @GetMapping("/employee/category/edit/{id}")
    public String editCategoryPage(@PathVariable("id") int id, Model model) {
        Category existingCategory = this.categoryService.getCategoryByCategoryId(id);
        List<Category> categories = this.categoryService.getAllCategory();

        model.addAttribute("newCategory", existingCategory);

        model.addAttribute("ListCategory", categories);

        return "admin/user/category";
    }

    @GetMapping("/employee/category/delete/{id}")
    public String deleteCategory(@PathVariable("id") int id, Model model) {
        Category existingCategory = this.categoryService.getCategoryByCategoryId(id);
        this.categoryService.deleteCategoryById(id);
        List<Category> categories = this.categoryService.getAllCategory();

        model.addAttribute("newCategory", existingCategory);

        model.addAttribute("ListCategory", categories);

        return "redirect:/employee/category";
    }

}
