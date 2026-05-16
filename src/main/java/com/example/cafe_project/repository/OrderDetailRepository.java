package com.example.cafe_project.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.cafe_project.domain.OrderDetail;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    @Query("SELECT COALESCE(od.productName, 'Chưa xác định'), SUM(od.quantity) " +
            "FROM OrderDetail od JOIN od.order o " +
            "WHERE o.status = :status " +
            "GROUP BY od.productName " +
            "ORDER BY SUM(od.quantity) DESC")
    List<Object[]> findTopSellingProductsData(
            @Param("status") String status,
            Pageable pageable);
}
