package com.example.cafe_project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.cafe_project.domain.PaymentMethod;

import com.example.cafe_project.repository.PaymentMethodRepository;

@Service
public class PaymentMethodService {
    private final PaymentMethodRepository paymentMethodRepository;

    public PaymentMethodService(PaymentMethodRepository paymentMethodRepository) {
        this.paymentMethodRepository = paymentMethodRepository;
    }

    public List<PaymentMethod> getAllPaymentMethod() {
        return this.paymentMethodRepository.findAll();
    }

}
