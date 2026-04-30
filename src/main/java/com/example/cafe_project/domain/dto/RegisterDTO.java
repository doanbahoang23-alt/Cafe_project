package com.example.cafe_project.domain.dto;

import jakarta.validation.constraints.Size;

public class RegisterDTO {
    @Size(min = 3, message = "FirstName phải có tối thiểu 3 kí tự")
    private String firstName;
    @Size(min = 3, message = "FirstName phải có tối thiểu 3 kí tự")
    private String lastName;
    private String userName;
    private String password;
    private String confirmPassword;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

}
