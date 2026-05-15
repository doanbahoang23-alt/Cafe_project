package com.example.cafe_project.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cafe_project.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    long countByCategory_CategoryId(Long categoryId);

    List<Product> findByCategory_CategoryId(int categoryId);

    // 1. Phân trang toàn bộ
    Page<Product> findAll(Pageable pageable);

    // 2. Lọc theo danh mục + Phân trang
    Page<Product> findByCategory_CategoryId(Integer categoryId, Pageable pageable);

    // 3. Tìm kiếm theo tên + Phân trang
    Page<Product> findByProductNameContainingIgnoreCase(String keyword, Pageable pageable);

    // 4. Lọc danh mục + Tìm kiếm + Phân trang
    Page<Product> findByCategory_CategoryIdAndProductNameContainingIgnoreCase(Integer categoryId, String keyword,
            Pageable pageable);
}