package com.example.cafe_project.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.example.cafe_project.service.CustomUserDetailsService;
import com.example.cafe_project.service.UserService;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfiguration {
    @Bean
    public PasswordEncoder passwordEncoder() { // mã hóa mk với thuật toán bCrypt
        return new BCryptPasswordEncoder();
    }

    @Bean
    public UserDetailsService userDetailsService(UserService userService) { // lấy user từ CustomUserDetailsService
        return new CustomUserDetailsService(userService);
    }

    @Bean
    public DaoAuthenticationProvider authProvider(
            PasswordEncoder passwordEncoder,
            UserDetailsService userDetailsService) {

        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder);
        authProvider.setHideUserNotFoundExceptions(false);

        return authProvider;
    }

    @Bean
    public AuthenticationSuccessHandler myAuthenticationSuccessHandler() {
        return new CustomSuccessHandler();
    }

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        // 1. Cho phép các loại Dispatcher để tránh lỗi khi forward sang view
                        // (JSP/Thymeleaf)
                        .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.INCLUDE).permitAll()

                        // 2. Cho phép tất cả tài nguyên tĩnh và các trang công khai
                        .requestMatchers(
                                "/",
                                "/login",
                                "/register", // Nếu có trang đăng ký
                                "/product/**",
                                "/client/**",
                                "/css/**",
                                "/js/**",
                                "/images/**",
                                "/admin/css/**",
                                "/admin/js/**",
                                "/admin/images/**",
                                "/error",
                                "/favicon.ico" // Rất quan trọng, trình duyệt luôn gọi cái này
                        ).permitAll()

                        // 3. Phân quyền admin quản lý nhân viên
                        .requestMatchers("/admin/employee").hasRole("ADMIN")

                        // 4. Phân quyền employee và admin cho các trang nội bộ
                        .requestMatchers("/employee/**").hasAnyRole("USER", "ADMIN")

                        // 5. Tất cả các request khác đều phải đăng nhập
                        .anyRequest().authenticated())
                .formLogin(formLogin -> formLogin
                        .loginPage("/login")
                        .failureUrl("/login?error")
                        .successHandler(myAuthenticationSuccessHandler())
                        .permitAll())
                .exceptionHandling(ex -> ex.accessDeniedPage("/deny"));

        return http.build();
    }
}
