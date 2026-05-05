package com.example.cafe_project.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cafe_project.domain.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

}
