package com.example.cafe_project.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.cafe_project.domain.CafeTable;
import com.example.cafe_project.domain.Category;
import com.example.cafe_project.service.CafeTableService;
import com.example.cafe_project.service.CategoryService;
import com.example.cafe_project.service.ProductService;

import jakarta.validation.Valid;

@Controller
public class CafeTableController {
    private final CafeTableService cafeTableService;
    private final CategoryService categoryService;
    private final ProductService productService;

    public CafeTableController(CafeTableService cafeTableService, CategoryService categoryService,
            ProductService productService) {
        this.cafeTableService = cafeTableService;
        this.categoryService = categoryService;
        this.productService = productService;
    }

    @PostMapping("/employee/cafeTable")
    public String CafeTableAction(Model model, @ModelAttribute("newCafeTable") @Valid CafeTable cafeTable,
            BindingResult bindingResult) {

        // kiểm tra validate
        if (bindingResult.hasErrors()) {

            // 1. Lấy lại danh sách Bàn để hiển thị bảng
            List<CafeTable> cafeTables = this.cafeTableService.getAllCafeTable();
            model.addAttribute("ListCafeTable", cafeTables);

            // giữ lại đối tượng bị lỗi
            model.addAttribute("newCafeTable", cafeTable);

            // gọi lại danh mục để ko bị mất
            List<Category> categories = this.categoryService.getAllCategory();
            Map<Long, Long> productCountMap = new HashMap<>();

            for (Category c : categories) {
                long count = productService.countProductByCategory(c.getCategoryId());
                productCountMap.put(c.getCategoryId(), count);
            }

            model.addAttribute("ListCategory", categories);
            model.addAttribute("productCountMap", productCountMap);

            // Thêm một Category rỗng để form Danh mục không bị gãy
            model.addAttribute("newCategory", new Category());

            return "admin/user/category";
        }

        if (cafeTable.getTableId() == null) {
            // Thêm mới: status mặc định là 0 (Trống)
            cafeTable.setStatus(0);
        } else {
            // Cập nhật: Lấy lại status cũ tránh bị ghi đè
            CafeTable existingTable = this.cafeTableService.getCafeTableByCafeTableId(cafeTable.getTableId());
            if (existingTable != null) {
                cafeTable.setStatus(existingTable.getStatus());
            }
        }

        this.cafeTableService.handleSaveCafeTable(cafeTable);

        return "redirect:/employee/category#quan-ly-ban";
    }

    @GetMapping("/employee/cafeTable/edit/{id}")
    public String editCafeTablePage(@PathVariable("id") int id, Model model) {
        // 1. Lấy dữ liệu của Bàn
        CafeTable existingCafeTable = this.cafeTableService.getCafeTableByCafeTableId(id);
        List<CafeTable> cafeTables = this.cafeTableService.getAllCafeTable();

        // 2. lấy dữ liệu danh mục
        List<Category> categories = this.categoryService.getAllCategory();
        Map<Long, Long> productCountMap = new HashMap<>();
        for (Category c : categories) {
            long count = productService.countProductByCategory(c.getCategoryId());
            productCountMap.put(c.getCategoryId(), count);
        }

        // --- Model của Bàn ---
        model.addAttribute("newCafeTable", existingCafeTable);
        model.addAttribute("ListCafeTable", cafeTables);

        // --- Model của Danh mục ---
        model.addAttribute("newCategory", new Category());
        model.addAttribute("ListCategory", categories);
        model.addAttribute("productCountMap", productCountMap);

        return "admin/user/category";
    }

    @GetMapping("/employee/cafeTable/delete/{id}")
    public String deleteCafeTable(@PathVariable("id") int id) {
        this.cafeTableService.deleteCafeTableById(id);
        return "redirect:/employee/category#quan-ly-ban"; // Nên thêm anchor để nhảy đúng vị trí
    }

}
