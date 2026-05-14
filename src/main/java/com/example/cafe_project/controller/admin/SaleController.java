package com.example.cafe_project.controller.admin;

import com.example.cafe_project.domain.Order;
import com.example.cafe_project.domain.Product;
import com.example.cafe_project.domain.dto.CartItemDTO;
import com.example.cafe_project.domain.dto.CheckoutRequestDTO;
import com.example.cafe_project.repository.ProductRepository;
import com.example.cafe_project.service.CafeTableService;
import com.example.cafe_project.service.CategoryService;
import com.example.cafe_project.service.OrderService;
import com.example.cafe_project.service.PaymentMethodService;
import com.example.cafe_project.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/employee/product/sales")
public class SaleController {

    private final PaymentMethodService paymentMethodService;
    private final CafeTableService cafeTableService;
    private final CategoryService categoryService;
    private final ProductService productService;
    private final OrderService orderService;
    private final ProductRepository productRepository; // Lấy thông tin giá khi thêm món

    public SaleController(CafeTableService cafeTableService,
            CategoryService categoryService,
            ProductService productService,
            OrderService orderService,
            ProductRepository productRepository, PaymentMethodService paymentMethodService) {
        this.cafeTableService = cafeTableService;
        this.categoryService = categoryService;
        this.productService = productService;
        this.orderService = orderService;
        this.productRepository = productRepository;
        this.paymentMethodService = paymentMethodService;
    }

    @GetMapping
    public String getSalePage(@RequestParam(required = false) Integer categoryId,
            @RequestParam(required = false) Long selectedTableId,
            @RequestParam(required = false) String filterStatus,
            Model model, HttpSession session) {
        model.addAttribute("tables", cafeTableService.getAllCafeTable());
        model.addAttribute("categories", categoryService.getAllCategory());

        if (categoryId != null) {
            model.addAttribute("products", productService.getProductByCategoryId(categoryId));
        } else {
            model.addAttribute("products", productService.getAllProduct());
        }
        model.addAttribute("paymentMethods", paymentMethodService.getAllPaymentMethod());

        List<Order> allOrders = this.orderService.getAllOder();
        List<Order> filteredOrders = new ArrayList<>();

        String currentFilter = (filterStatus == null || filterStatus.isEmpty()) ? "OPEN" : filterStatus;

        for (Order order : allOrders) {
            if (currentFilter.equals(order.getStatus())) {
                filteredOrders.add(order);
            }
        }
        model.addAttribute("orders", filteredOrders); // Gửi danh sách đã lọc ra JSP

        if (selectedTableId != null) {
            Order selectedOrder = orderService.getOpenOrderByTableId(selectedTableId);
            model.addAttribute("selectedOrder", selectedOrder);
        }

        List<CartItemDTO> cart = getCartFromSession(session);
        BigDecimal total = BigDecimal.ZERO;
        for (CartItemDTO item : cart) {
            total = total.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
        }
        session.setAttribute("cart", cart);
        session.setAttribute("totalCartPrice", total);

        return "admin/user/salePage";
    }

    // 2. Click thêm món
    @GetMapping("/add-to-cart")
    public String addToCart(@RequestParam Long productId, @RequestParam(required = false) String openModal,
            HttpSession session) {
        List<CartItemDTO> cart = getCartFromSession(session);
        Product product = productRepository.findById(productId).orElse(null);

        if (product != null) {
            boolean found = false;
            for (CartItemDTO item : cart) {
                if (item.getProductId().equals(productId)) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }
            if (!found) {
                CartItemDTO newItem = new CartItemDTO();
                newItem.setProductId(product.getProductId()); // Chỉnh lại theo getter của entity Product
                newItem.setProductName(product.getProductName());
                newItem.setPrice(product.getPrice());
                newItem.setQuantity(1);
                newItem.setImage(product.getImage());
                cart.add(newItem);
            }
        }
        session.setAttribute("cart", cart);
        return "redirect:/employee/product/sales" + ("true".equals(openModal) ? "?openModal=true" : "");
    }

    // 3. Click nút [+] [-] tăng giảm số lượng
    @GetMapping("/update-cart")
    public String updateCart(@RequestParam Long productId, @RequestParam String action,
            @RequestParam(required = false) String openModal, HttpSession session) {
        List<CartItemDTO> cart = getCartFromSession(session);
        cart.removeIf(item -> {
            if (item.getProductId().equals(productId)) {
                if ("increase".equals(action))
                    item.setQuantity(item.getQuantity() + 1);
                if ("decrease".equals(action))
                    item.setQuantity(item.getQuantity() - 1);
                return item.getQuantity() <= 0; // Xóa luôn món nếu số lượng về 0
            }
            return false;
        });
        session.setAttribute("cart", cart);
        return "redirect:/employee/product/sales" + ("true".equals(openModal) ? "?openModal=true" : "");
    }

    // 4. Click nút [X] xóa món
    @GetMapping("/remove-cart")
    public String removeCart(@RequestParam Long productId, @RequestParam(required = false) String openModal,
            HttpSession session) {
        List<CartItemDTO> cart = getCartFromSession(session);
        cart.removeIf(item -> item.getProductId().equals(productId));
        session.setAttribute("cart", cart);
        return "redirect:/employee/product/sales" + ("true".equals(openModal) ? "?openModal=true" : "");
    }

    // 5. Hàm mới: Xử lý Đặt Bàn (Tương tác từ Modal)
    @PostMapping("/book-table")
    public String bookTable(@RequestParam Long tableId,
            @RequestParam(required = false) String notes,
            HttpSession session,
            Principal principal,
            RedirectAttributes redirectAttributes) {
        try {
            List<CartItemDTO> cart = getCartFromSession(session);
            CheckoutRequestDTO request = new CheckoutRequestDTO();
            request.setTableId(tableId);
            request.setNotes(notes);
            request.setItems(cart);

            String username = (principal != null) ? principal.getName() : "admin";

            // Gọi hàm tạo Hóa đơn OPEN
            Order newOrder = orderService.createOpenOrder(request, username);

            // Xóa session giỏ hàng
            session.removeAttribute("cart");
            session.removeAttribute("totalCartPrice");

            redirectAttributes.addFlashAttribute("successMessage", "Đặt bàn thành công!");
            // Redirect về trang chủ và focus luôn vào đơn hàng vừa tạo
            return "redirect:/employee/product/sales?selectedOrderId=" + newOrder.getOrderID();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
            return "redirect:/employee/product/sales?openModal=true";
        }
    }

    // 3. Hàm mới: Xử lý Thanh Toán (Tương tác từ màn hình bên phải)
    @PostMapping("/pay-order")
    public String payOrder(@RequestParam Long orderId,
            @RequestParam Long paymentMethodId,
            RedirectAttributes redirectAttributes) {
        try {
            orderService.payOrder(orderId, paymentMethodId);
            redirectAttributes.addFlashAttribute("successMessage", "Thanh toán thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi thanh toán: " + e.getMessage());
        }
        return "redirect:/employee/product/sales";
    }

    // 6. Xem chi tiết đơn hàng
    @GetMapping("/order-detail/{orderId}")
    public String getOrderDetail(@PathVariable Long orderId, Model model) {
        // Giả sử bạn đã có hàm getOrderById trong OrderService
        Order order = orderService.getOrderById(orderId);
        model.addAttribute("order", order);
        return "admin/user/orderDetailPage"; // Tạo một file orderDetailPage.jsp riêng để thiết kế giao diện chi tiết
    }

    // Hàm phụ trợ tạo mới list nếu Session chưa có
    @SuppressWarnings("unchecked")
    private List<CartItemDTO> getCartFromSession(HttpSession session) {
        List<CartItemDTO> cart = (List<CartItemDTO>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        return cart;
    }
}