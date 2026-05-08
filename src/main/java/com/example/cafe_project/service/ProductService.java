package com.example.cafe_project.service;

import java.util.List;

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

}
