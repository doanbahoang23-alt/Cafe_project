package com.example.cafe_project.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
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
    private final PasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, RoleRepository roleRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public User getUserById(long userId) {
        return this.userRepository.findById(userId).orElse(null);
    }

    public User handleSaveUser(User user) { // lưu thông tin user vào database
        // Encode password if it's not encoded and not empty
        if (user.getPassword() != null && !user.getPassword().isEmpty() && !user.getPassword().startsWith("$2a$")) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        }
        return this.userRepository.save(user);
    }

    public void deleteUserById(long userId) {
        this.userRepository.deleteById(userId);
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
