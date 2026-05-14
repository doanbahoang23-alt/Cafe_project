package com.example.cafe_project.service;

import com.example.cafe_project.domain.*;
import com.example.cafe_project.domain.dto.CartItemDTO;
import com.example.cafe_project.domain.dto.CheckoutRequestDTO;
import com.example.cafe_project.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final CafeTableRepository cafeTableRepository;
    private final UserRepository userRepository;
    private final PaymentMethodRepository paymentMethodRepository;

    public OrderService(OrderRepository orderRepository,
            ProductRepository productRepository,
            CafeTableRepository cafeTableRepository,
            UserRepository userRepository,
            PaymentMethodRepository paymentMethodRepository) {
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.cafeTableRepository = cafeTableRepository;
        this.userRepository = userRepository;
        this.paymentMethodRepository = paymentMethodRepository;
    }

    @Transactional
    public Order createOpenOrder(CheckoutRequestDTO request, String username) {
        if (request.getItems() == null || request.getItems().isEmpty()) {
            throw new RuntimeException("Giỏ hàng đang trống!");
        }

        User user = userRepository.findByUsername(username);
        CafeTable table = cafeTableRepository.findById(request.getTableId())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy bàn có ID: " + request.getTableId()));

        // Cập nhật trạng thái bàn thành Đang có khách (1)
        table.setStatus(1);
        cafeTableRepository.save(table);

        // Khởi tạo Đơn hàng trạng thái OPEN (Chưa thanh toán)
        Order order = new Order();
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("OPEN");
        order.setTable(table);
        order.setUser(user);
        // order.setPaymentMethod(null); // Chưa thanh toán nên để trống

        BigDecimal totalAmount = BigDecimal.ZERO;

        for (CartItemDTO item : request.getItems()) {
            if (item.getProductId() == null || item.getQuantity() == null || item.getQuantity() <= 0)
                continue;

            Product product = productRepository.findById(item.getProductId())
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(product);
            orderDetail.setQuantity(item.getQuantity());
            orderDetail.setNotes(request.getNotes());
            orderDetail.setProductName(product.getProductName());

            BigDecimal itemTotal = product.getPrice().multiply(new BigDecimal(item.getQuantity()));
            totalAmount = totalAmount.add(itemTotal);

            order.getOrderDetails().add(orderDetail);
        }

        order.setTotalAmount(totalAmount);
        return orderRepository.save(order);
    }

    // 2. Thêm hàm Xử lý Thanh toán chốt đơn
    @Transactional
    public void payOrder(Long orderId, Long paymentMethodId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
        PaymentMethod paymentMethod = paymentMethodRepository.findById(paymentMethodId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy phương thức thanh toán"));

        // Cập nhật trạng thái và phương thức thanh toán
        order.setStatus("COMPLETED");
        order.setPaymentMethod(paymentMethod);

        // Giải phóng bàn (Trở về trạng thái trống 0)
        CafeTable table = order.getTable();
        table.setStatus(0);
        cafeTableRepository.save(table);

        orderRepository.save(order);
    }

    @Transactional(readOnly = true)
    public Order getOpenOrderByTableId(Long tableId) {
        List<Order> orders = orderRepository.findAll();
        for (Order order : orders) {

            if ("OPEN".equals(order.getStatus()) && order.getTable() != null
                    && order.getTable().getTableId().equals(tableId)) {

                order.getOrderDetails().size();
                return order;
            }
        }
        return null;
    }

    public List<Order> getAllOder() {
        return this.orderRepository.findAll();
    }

    public Order getOrderById(Long orderId) {
        return this.orderRepository.findById(orderId).orElse(null);
    }

}