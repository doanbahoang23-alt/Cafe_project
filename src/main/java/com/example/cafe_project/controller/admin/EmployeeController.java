package com.example.cafe_project.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.cafe_project.domain.Role;
import com.example.cafe_project.domain.User;
import com.example.cafe_project.service.RoleService;
import com.example.cafe_project.service.UserService;

import jakarta.validation.Valid;

@Controller
public class EmployeeController {

    private final UserService userService;
    private final RoleService roleService;

    public EmployeeController(UserService userService, RoleService roleService) {
        this.userService = userService;
        this.roleService = roleService;
    }

    @ModelAttribute("user")
    public User user() {
        return new User();
    }

    @GetMapping("/admin/employee")
    public String getEmployeeManagerPage(Model model,
            @RequestParam(value = "successMessage", required = false) String successMessage,
            @RequestParam(value = "errorMessage", required = false) String errorMessage) {

        List<User> users = userService.getAllUsers();
        List<Role> roles = roleService.getAllRoles();

        model.addAttribute("users", users);
        model.addAttribute("roles", roles);

        if (successMessage != null) {
            model.addAttribute("successMessage", successMessage);
        }
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
        }

        return "admin/user/employee";
    }

    @PostMapping("/admin/employee")
    public String createEmployee(@Valid @ModelAttribute("user") User user, BindingResult bindingResult,
            @RequestParam("roleId") Long roleId, Model model, RedirectAttributes redirectAttributes) {

        // Check validation errors
        if (bindingResult.hasErrors()) {
            List<User> users = userService.getAllUsers();
            List<Role> roles = roleService.getAllRoles();
            model.addAttribute("users", users);
            model.addAttribute("roles", roles);
            return "admin/user/employee";
        }

        try {
            // Check if username already exists
            if (userService.isUsernameExits(user.getUsername())) {
                bindingResult.rejectValue("username", "error.user", "Tên đăng nhập đã tồn tại!");
                List<User> users = userService.getAllUsers();
                List<Role> roles = roleService.getAllRoles();
                model.addAttribute("users", users);
                model.addAttribute("roles", roles);
                return "admin/user/employee";
            }

            // Set role
            Role role = roleService.getRoleById(roleId);
            if (role != null) {
                user.setRole(role);
            }

            userService.handleSaveUser(user);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm nhân viên thành công!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi thêm nhân viên!");
            redirectAttributes.addFlashAttribute("user", user);
        }

        return "redirect:/admin/employee";
    }

    @GetMapping("/admin/employee/edit/{id}")
    public String editEmployeePage(@PathVariable("id") long id, Model model) {
        User user = userService.getUserById(id);
        if (user == null) {
            return "redirect:/admin/employee";
        }

        List<User> users = userService.getAllUsers();
        List<Role> roles = roleService.getAllRoles();

        model.addAttribute("users", users);
        model.addAttribute("roles", roles);
        model.addAttribute("user", user);

        return "admin/user/employee";
    }

    @PostMapping("/admin/employee/edit/{id}")
    public String updateEmployee(@PathVariable("id") long id,
            @Valid @ModelAttribute("user") User user, BindingResult bindingResult,
            @RequestParam("roleId") Long roleId,
            @RequestParam(value = "password", required = false) String password,
            Model model, RedirectAttributes redirectAttributes) {

        // Check validation errors
        if (bindingResult.hasErrors()) {
            List<User> users = userService.getAllUsers();
            List<Role> roles = roleService.getAllRoles();
            model.addAttribute("users", users);
            model.addAttribute("roles", roles);
            return "admin/user/employee";
        }

        try {
            User existingUser = userService.getUserById(id);
            if (existingUser == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên!");
                return "redirect:/admin/employee";
            }

            // Check username uniqueness (exclude current user)
            if (!existingUser.getUsername().equals(user.getUsername()) &&
                    userService.isUsernameExits(user.getUsername())) {
                bindingResult.rejectValue("username", "error.user", "Tên đăng nhập đã tồn tại!");
                List<User> users = userService.getAllUsers();
                List<Role> roles = roleService.getAllRoles();
                model.addAttribute("users", users);
                model.addAttribute("roles", roles);
                return "admin/user/employee";
            }

            // Update fields
            existingUser.setUsername(user.getUsername());
            existingUser.setFullname(user.getFullname());

            // Update password only if provided
            if (password != null && !password.trim().isEmpty()) {
                existingUser.setPassword(password);
            }

            // Update role
            Role role = roleService.getRoleById(roleId);
            if (role != null) {
                existingUser.setRole(role);
            }

            userService.handleSaveUser(existingUser);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật nhân viên thành công!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật nhân viên!");
        }

        return "redirect:/admin/employee";
    }

    @GetMapping("/admin/employee/delete/{id}")
    public String deleteEmployee(@PathVariable("id") long id, RedirectAttributes redirectAttributes) {
        try {
            User user = userService.getUserById(id);
            if (user == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên!");
                return "redirect:/admin/employee";
            }

            userService.deleteUserById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa nhân viên thành công!");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa nhân viên!");
        }

        return "redirect:/admin/employee";
    }
}
