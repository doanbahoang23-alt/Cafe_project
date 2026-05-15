package com.example.cafe_project.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.cafe_project.domain.Product;
import com.example.cafe_project.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Product handleSaveProduct(Product product) {
        return this.productRepository.save(product);
    }

    public List<Product> getAllProduct() {
        return this.productRepository.findAll();
    }

    public Product getProductByProductId(long productId) {
        return this.productRepository.findById(productId).orElse(null);
    }

    public void deleteProductById(long productId) {
        this.productRepository.deleteById(productId);
    }

    public long countProductByCategory(Long categoryId) {
        return productRepository.countByCategory_CategoryId(categoryId);
    }

    public List<Product> getProductByCategoryId(int categoryId) {
        return this.productRepository.findByCategory_CategoryId(categoryId);
    }

    // điều phối, kiểm tra người dùng muốn làm gì
    public Page<Product> getProductsWithFilterAndPagination(Integer categoryId, String keyword, Pageable pageable) {
        boolean hasCategory = (categoryId != null);
        boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());

        if (hasCategory && hasKeyword) {
            return productRepository.findByCategory_CategoryIdAndProductNameContainingIgnoreCase(categoryId, keyword,
                    pageable);
        } else if (hasCategory) {
            return productRepository.findByCategory_CategoryId(categoryId, pageable);
        } else if (hasKeyword) {
            return productRepository.findByProductNameContainingIgnoreCase(keyword, pageable);
        } else {
            return productRepository.findAll(pageable);
        }
    }

}
