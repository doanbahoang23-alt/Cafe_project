package com.example.cafe_project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.cafe_project.domain.Role;
import com.example.cafe_project.repository.RoleRepository;

@Service
public class RoleService {
    private final RoleRepository roleRepository;

    public RoleService(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public List<Role> getAllRoles() {
        return this.roleRepository.findAll();
    }

    public Role getRoleById(long roleId) {
        return this.roleRepository.findById(roleId).orElse(null);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public Role handleSaveRole(Role role) {
        return this.roleRepository.save(role);
    }

    public void deleteRoleById(long roleId) {
        this.roleRepository.deleteById(roleId);
    }
}