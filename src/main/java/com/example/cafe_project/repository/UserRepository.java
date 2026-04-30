package com.example.cafe_project.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.cafe_project.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    boolean existsByUsername(String username); // kiểm tra xem username đã tồn tại hay chưa;

    User findByUsername(String username); // tìm kiếm user theo username

}
