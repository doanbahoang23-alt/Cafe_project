package com.example.cafe_project.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.cafe_project.domain.Category;
import com.example.cafe_project.domain.Product;
import com.example.cafe_project.service.CategoryService;
import com.example.cafe_project.service.ProductService;
import com.example.cafe_project.service.UploadService;

import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class ProductController {
    private final ProductService productService;
    private final CategoryService categoryService;
    private final UploadService uploadService;

    public ProductController(ProductService productService, CategoryService categoryService,
            UploadService uploadService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product")
    public String getAdminProductPage(Model model, @ModelAttribute("newProduct") Product newProduct,
            @RequestParam(value = "categoryId", required = false) Integer categoryId) {
        List<Category> categories = this.categoryService.getAllCategory();
        List<Product> products;
        if (categoryId != null) {
            products = this.productService.getProductByCategoryId(categoryId);
        } else {
            products = this.productService.getAllProduct();
        }
        model.addAttribute("ListProduct", products);
        model.addAttribute("categories", categories);
        model.addAttribute("newProduct", newProduct);
        return "admin/user/product";
    }

    @PostMapping("/admin/product")
    public String handleSaveProduct(@ModelAttribute("newProduct") Product product,
            @RequestParam("ProductImage") MultipartFile file) {

        if (!file.isEmpty()) {
            // Có file mới được upload
            String newImageName = this.uploadService.handleSaveUploadFile(file, "product");
            if (!newImageName.isEmpty()) {
                product.setImage(newImageName);
            }
        } else {
            // Không có file mới, kiểm tra xem có đang cập nhật không
            if (product.getProductId() != null && product.getProductId() > 0) {
                // Đang cập nhật và không chọn ảnh mới, giữ nguyên ảnh cũ
                Product existingProduct = this.productService.getProductByProductId(product.getProductId().intValue());
                product.setImage(existingProduct.getImage());
            }
            // Nếu là tạo mới và không có ảnh, để trống (sẽ xử lý ở service hoặc validation)
        }

        this.productService.handleSaveProduct(product);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/edit/{id}")
    public String editProductPage(@PathVariable("id") int id, Model model) {
        Product existingProduct = this.productService.getProductByProductId(id);
        List<Category> categories = this.categoryService.getAllCategory();
        List<Product> products = this.productService.getAllProduct();
        model.addAttribute("newProduct", existingProduct);
        model.addAttribute("ListProduct", products);
        model.addAttribute("categories", categories);

        return "admin/user/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") int id, Model model) {
        Product existingProduct = this.productService.getProductByProductId(id);
        this.productService.deleteProductById(id);
        List<Category> categories = this.categoryService.getAllCategory();
        List<Product> products = this.productService.getAllProduct();
        model.addAttribute("newProduct", existingProduct);
        model.addAttribute("ListProduct", products);
        model.addAttribute("categories", categories);

        return "redirect:/admin/product";
    }

    @GetMapping("/employee/dashboard")
    public String getDashboardPage() {
        return "admin/user/dashboard";
    }

    @GetMapping("/employee/product/sales")
    public String getProductSales() {
        return "admin/user/salePage";
    }

}
