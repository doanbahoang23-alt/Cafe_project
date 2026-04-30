package com.example.cafe_project.controller.client;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.cafe_project.domain.User;
import com.example.cafe_project.domain.dto.RegisterDTO;
import com.example.cafe_project.service.UserService;

import jakarta.validation.Valid;

@Controller
public class AuthController {
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public AuthController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        return "client/auth/loginPage";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/registerPage";
    }

    @PostMapping("/register")
    public String registerAction(Model model, @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult registerUserBindingResult) {
        List<FieldError> errors = registerUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
        }

        if (registerUserBindingResult.hasErrors()) {
            return "client/auth/registerPage";
        }

        User user = this.userService.registerDTOtoUser(registerDTO);
        String hashPasscode = this.passwordEncoder.encode(registerDTO.getPassword());

        user.setPassword(hashPasscode);
        user.setRole(this.userService.getRoleByName("USER"));
        this.userService.handleSaveUser(user);

        return "redirect:/login";
    }

    @GetMapping("/deny")
    public String getDenyPage(Model model) {
        return "client/auth/deny";
    }

}
