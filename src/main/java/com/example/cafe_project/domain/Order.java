package com.example.cafe_project.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "orders")
public class Order {
    @Id
    private String orderID;
    private LocalDateTime orderDate;
    private String status;
    private BigDecimal totalAmount;

    @ManyToOne
    @JoinColumn(name = "paymentMethodID")
    private PaymentMethod paymentMethod;

    @ManyToOne
    @JoinColumn(name = "tableID")
    private CafeTable table;

    @ManyToOne
    @JoinColumn(name = "userID")
    private User user;

    @OneToMany(mappedBy = "order")
    private List<OrderDetail> orderDetails;

    // getters and setters
    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

}
