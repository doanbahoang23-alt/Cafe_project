package com.example.cafe_project.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.cafe_project.domain.CafeTable;
import com.example.cafe_project.domain.Order;
import com.example.cafe_project.domain.dto.ChartDataDTO;
import com.example.cafe_project.domain.dto.RevenueDayDTO;
import com.example.cafe_project.domain.dto.TopProductDTO;
import com.example.cafe_project.repository.CafeTableRepository;
import com.example.cafe_project.repository.OrderDetailRepository;
import com.example.cafe_project.repository.OrderRepository;

@Service
@Transactional(readOnly = true)
public class DashboardService {

    private final OrderRepository orderRepository;
    private final CafeTableRepository cafeTableRepository;
    private final OrderDetailRepository orderDetailRepository;

    public DashboardService(OrderRepository orderRepository,
            CafeTableRepository cafeTableRepository,
            OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.cafeTableRepository = cafeTableRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public BigDecimal getRevenueToday() {
        LocalDate today = LocalDate.now();
        return orderRepository.findAll().stream() // lấy ra toàn bộ order
                .filter(order -> order != null && order.getOrderDate() != null
                        && order.getOrderDate().toLocalDate().isEqual(today)) // bộ lọc lấy ra order có thời gian là
                                                                              // today
                .filter(this::isCompleted) // order phải ở trạng thái hoàn thành
                .map(Order::getTotalAmount) // map lấy duy nhất giá trị tổng tiền từ stream
                .filter(Objects::nonNull)// order ko đc null
                .reduce(BigDecimal.ZERO, BigDecimal::add); // cộng dồn các giá trị đã được lọc
    }

    public long getTotalOrdersToday() {
        LocalDate today = LocalDate.now();
        return orderRepository.findAll().stream()
                .filter(order -> order != null && order.getOrderDate() != null
                        && order.getOrderDate().toLocalDate().isEqual(today))
                .filter(this::isCompleted)
                .count(); // đếm số lượng đơn hàng đã hoàn thành trong hôm nay
    }

    public long getActiveTableCount() {
        return cafeTableRepository.findAll().stream()
                .filter(table -> table != null && Integer.valueOf(1).equals(table.getStatus())) // lấy ra những bàn với
                                                                                                // status = 1
                .count();
    }

    public long getTotalTableCount() {
        return cafeTableRepository.count();
    }

    public List<TopProductDTO> getTopSellingProducts(int limit) {
        Map<String, Integer> salesByProduct = new HashMap<>();
        // lấy ra toàn bộ chi tiết đơn hàng
        orderDetailRepository.findAll().stream()
                // chi tiết đơn hàng, đơn hàng ko null và phải được hoàn thành
                .filter(detail -> detail != null && detail.getOrder() != null && isCompleted(detail.getOrder()))
                .forEach(detail -> {
                    // lấy tên sp nếu = null thì để chưa xác định
                    String productName = detail.getProductName() != null ? detail.getProductName() : "Chưa xác định";
                    // nếu null thì đặt = 0
                    int quantity = detail.getQuantity() != null ? detail.getQuantity() : 0;
                    // merge kiểm tra productname, nếu ko có thì thêm mới với số lượng = quantity
                    // nếu có thì cộng dồn tổng tiền
                    salesByProduct.merge(productName, quantity, Integer::sum);

                });

        return salesByProduct.entrySet().stream()
                .sorted(Map.Entry.<String, Integer>comparingByValue().reversed())
                .limit(limit)
                .map(entry -> new TopProductDTO(entry.getKey(), entry.getValue()))
                .collect(Collectors.toList());
    }

    public List<CafeTable> getAllTables() {
        return cafeTableRepository.findAll();
    }

    public List<RevenueDayDTO> getRevenueDetails(LocalDate fromDate, LocalDate toDate) {
        Map<LocalDate, RevenueDayDTO> revenueByDay = new LinkedHashMap<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        for (LocalDate date = fromDate; !date.isAfter(toDate); date = date.plusDays(1)) {
            revenueByDay.put(date, new RevenueDayDTO(date.format(formatter), BigDecimal.ZERO, 0));
        }

        orderRepository.findAll().stream()
                .filter(order -> order != null && order.getOrderDate() != null && isCompleted(order))
                .forEach(order -> {
                    LocalDate date = order.getOrderDate().toLocalDate();
                    if (!date.isBefore(fromDate) && !date.isAfter(toDate)) {
                        RevenueDayDTO summary = revenueByDay.get(date);
                        if (summary != null) {
                            BigDecimal amount = order.getTotalAmount() != null ? order.getTotalAmount()
                                    : BigDecimal.ZERO;
                            summary.setRevenue(summary.getRevenue().add(amount));
                            summary.setOrderCount(summary.getOrderCount() + 1);
                        }
                    }
                });

        return revenueByDay.values().stream().collect(Collectors.toList());
    }

    public List<ChartDataDTO> getRevenueChartData(LocalDate fromDate, LocalDate toDate) {
        return getRevenueDetails(fromDate, toDate).stream()
                .map(day -> new ChartDataDTO(day.getDate(), day.getRevenue().longValue()))
                .collect(Collectors.toList());
    }

    public List<ChartDataDTO> getWeeklyRevenueStats() {
        LocalDate today = LocalDate.now();
        LocalDate startDate = today.minusDays(6);
        Map<LocalDate, BigDecimal> revenueByDay = new LinkedHashMap<>();

        for (int i = 0; i < 7; i++) {
            revenueByDay.put(startDate.plusDays(i), BigDecimal.ZERO);
        }

        orderRepository.findAll().stream()
                .filter(order -> order != null && order.getOrderDate() != null && isCompleted(order))
                .forEach(order -> {
                    LocalDate date = order.getOrderDate().toLocalDate();
                    if (!date.isBefore(startDate) && !date.isAfter(today)) {
                        BigDecimal amount = order.getTotalAmount() != null ? order.getTotalAmount() : BigDecimal.ZERO;
                        revenueByDay.merge(date, amount, BigDecimal::add);
                    }
                });

        return revenueByDay.entrySet().stream()
                .map(entry -> new ChartDataDTO(
                        entry.getKey().format(java.time.format.DateTimeFormatter.ofPattern("dd/MM")),
                        entry.getValue().longValue()))
                .collect(Collectors.toList());
    }

    private boolean isCompleted(Order order) {
        return order != null && order.getStatus() != null && "COMPLETED".equalsIgnoreCase(order.getStatus());
    }
}
