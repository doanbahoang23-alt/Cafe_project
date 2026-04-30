package com.example.cafe_project.service;

import org.springframework.stereotype.Service;

import com.example.cafe_project.domain.Role;
import com.example.cafe_project.domain.User;
import com.example.cafe_project.domain.dto.RegisterDTO;
import com.example.cafe_project.repository.RoleRepository;
import com.example.cafe_project.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public User handleSaveUser(User user) { // lưu thông tin user vào database
        return this.userRepository.save(user);
    }

    public boolean isUsernameExits(String username) {
        return this.userRepository.existsByUsername(username);
    }

    public User getUserByUsername(String username) {
        return this.userRepository.findByUsername(username);
    }

    public User registerDTOtoUser(RegisterDTO registerDto) { // mapper từ trang đăng nhập sang user
        User user = new User();

        user.setFullname(registerDto.getFirstName() + " " + registerDto.getLastName());
        user.setUsername(registerDto.getUserName());
        user.setPassword(registerDto.getPassword());
        return user;
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }
}
