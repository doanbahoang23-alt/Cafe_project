package com.example.cafe_project.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cafe_project.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    long countByCategory_CategoryId(Long categoryId);
}