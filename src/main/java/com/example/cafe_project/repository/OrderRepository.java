package com.example.cafe_project.repository;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.cafe_project.domain.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    @Query("SELECT SUM(o.totalAmount) FROM Order o WHERE o.orderDate >= :startOfDay AND o.orderDate <= :endOfDay AND o.status = :status")
    BigDecimal sumRevenueBetweenDatesAndStatus(
            @Param("startOfDay") LocalDateTime startOfDay,
            @Param("endOfDay") LocalDateTime endOfDay,
            @Param("status") String status);

    @Query("SELECT COUNT(o) FROM Order o WHERE o.orderDate >= :startOfDay AND o.orderDate <= :endOfDay AND o.status = :status")
    long countOrdersBetweenDatesAndStatus(
            @Param("startOfDay") LocalDateTime startOfDay,
            @Param("endOfDay") LocalDateTime endOfDay,
            @Param("status") String status);

    @Query(value = "SELECT DATE(order_date) AS orderDate, SUM(total_amount) AS totalRevenue, COUNT(*) AS totalOrders " +
            "FROM orders " +
            "WHERE order_date >= :startDate AND order_date <= :endDate AND status = :status " +
            "GROUP BY DATE(order_date)", nativeQuery = true)
    List<Object[]> getRevenueAndCountByDate(
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate,
            @Param("status") String status);
}
