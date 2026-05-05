package com.example.cafe_project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.cafe_project.domain.Category;

import com.example.cafe_project.repository.CategoryRepository;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getAllCategory() {
        return this.categoryRepository.findAll();
    }

    public Category getCategoryByCategoryId(long categoryId) {
        return this.categoryRepository.findById(categoryId).orElse(null);
    }

    public Category handleSaveCategory(Category category) {
        return this.categoryRepository.save(category);
    }

    public void deleteCategoryById(long categoryId) {
        this.categoryRepository.deleteById(categoryId);
    }

}
