package com.example.cafe_project.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.cafe_project.domain.CafeTable;

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
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.atTime(LocalTime.MAX);

        String completedStatus = "COMPLETED";

        BigDecimal totalRevenue = orderRepository.sumRevenueBetweenDatesAndStatus(
                startOfDay,
                endOfDay,
                completedStatus);

        return totalRevenue != null ? totalRevenue : BigDecimal.ZERO;
    }

    public long getTotalOrdersToday() {
        LocalDate today = LocalDate.now();
        LocalDateTime startOfDay = today.atStartOfDay();
        LocalDateTime endOfDay = today.atTime(LocalTime.MAX);

        String completedStatus = "COMPLETED";

        return orderRepository.countOrdersBetweenDatesAndStatus(
                startOfDay,
                endOfDay,
                completedStatus);
    }

    public long getActiveTableCount() {
        Integer activeStatus = 1;
        return cafeTableRepository.countByStatus(activeStatus);
    }

    public long getTotalTableCount() {
        return cafeTableRepository.count();
    }

    public List<TopProductDTO> getTopSellingProducts(int limit) {
        String completedStatus = "COMPLETED";
        Pageable pageable = PageRequest.of(0, limit);
        List<Object[]> results = orderDetailRepository.findTopSellingProductsData(completedStatus, pageable);
        return results.stream()
                .map(row -> new TopProductDTO(
                        (String) row[0],
                        ((Number) row[1]).intValue()))
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

        LocalDateTime startOfDay = fromDate.atStartOfDay();
        LocalDateTime endOfDay = toDate.atTime(LocalTime.MAX);
        String completedStatus = "COMPLETED";

        List<Object[]> results = orderRepository.getRevenueAndCountByDate(startOfDay, endOfDay, completedStatus);

        for (Object[] row : results) {
            LocalDate date = parseDate(row[0]);
            BigDecimal totalRevenue = parseRevenue(row[1]);
            int totalOrders = parseOrderCount(row[2]);

            if (revenueByDay.containsKey(date)) {
                RevenueDayDTO dto = revenueByDay.get(date);
                dto.setRevenue(totalRevenue);
                dto.setOrderCount(totalOrders);
            }
        }

        return new ArrayList<>(revenueByDay.values());
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

        LocalDateTime startOfDay = startDate.atStartOfDay();
        LocalDateTime endOfDay = today.atTime(LocalTime.MAX);
        String completedStatus = "COMPLETED";

        List<Object[]> results = orderRepository.getRevenueAndCountByDate(startOfDay, endOfDay, completedStatus);

        for (Object[] row : results) {
            LocalDate date = parseDate(row[0]);
            BigDecimal revenue = parseRevenue(row[1]);

            if (revenueByDay.containsKey(date)) {
                revenueByDay.put(date, revenue);
            }
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");

        return revenueByDay.entrySet().stream()
                .map(entry -> new ChartDataDTO(
                        entry.getKey().format(formatter),
                        entry.getValue().longValue()))
                .collect(Collectors.toList());
    }

    private LocalDate parseDate(Object rawDate) {
        if (rawDate instanceof java.sql.Date) {
            return ((java.sql.Date) rawDate).toLocalDate();
        }
        return LocalDate.parse(rawDate.toString());
    }

    private BigDecimal parseRevenue(Object rawRevenue) {
        if (rawRevenue == null) {
            return BigDecimal.ZERO;
        }
        return new BigDecimal(rawRevenue.toString());
    }

    private int parseOrderCount(Object rawOrderCount) {
        if (rawOrderCount == null) {
            return 0;
        }
        return ((Number) rawOrderCount).intValue();
    }
}
