package com.ecommerce.controller;

import com.ecommerce.dto.request.CreateOrderRequest;
import com.ecommerce.dto.response.OrderResponse;
import com.ecommerce.entity.OrderStatus;
import com.ecommerce.service.OrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/** 
 * Order Controller
 * Sipariş yönetimi endpoint'leri
 */
@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
@PreAuthorize("isAuthenticated()")
public class  OrderController {

    private final OrderService orderService;

    /**
     * GET /api/orders/user/{userId}
     * Kullanıcının tüm siparişlerini getir
     */
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<OrderResponse>> getUserOrders(@PathVariable Long userId) {
        List<OrderResponse> orders = orderService.getUserOrders(userId);
        return ResponseEntity.ok(orders);
    }

    /**
     * GET /api/orders/{orderId}
     * ID'ye göre sipariş getir
     */
    @GetMapping("/{orderId}")
    public ResponseEntity<OrderResponse> getOrderById(@PathVariable Long orderId) {
        OrderResponse order = orderService.getOrderById(orderId);
        return ResponseEntity.ok(order);
    }

    /**
     * GET /api/orders/status?status=...
     * Duruma göre siparişleri getir (Admin)
     */
    @GetMapping("/status")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<List<OrderResponse>> getOrdersByStatus(@RequestParam OrderStatus status) {
        List<OrderResponse> orders = orderService.getOrdersByStatus(status);
        return ResponseEntity.ok(orders);
    }

    /**
     * POST /api/orders/user/{userId}
     * Sepetten sipariş oluştur
     */
    @PostMapping("/user/{userId}")
    public ResponseEntity<OrderResponse> createOrder(
            @PathVariable Long userId,
            @Valid @RequestBody CreateOrderRequest request) {
        OrderResponse order = orderService.createOrderFromCart(userId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body(order);
    }

    /**
     * PUT /api/orders/{orderId}/status
     * Sipariş durumunu güncelle (Admin)
     */
    @PutMapping("/{orderId}/status")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<OrderResponse> updateOrderStatus(
            @PathVariable Long orderId,
            @RequestParam OrderStatus newStatus) {
        OrderResponse order = orderService.updateOrderStatus(orderId, newStatus);
        return ResponseEntity.ok(order);
    }

    /**
     * PUT /api/orders/{orderId}/cancel
     * Sipariş iptal et
     */
    @PutMapping("/{orderId}/cancel")
    public ResponseEntity<OrderResponse> cancelOrder(@PathVariable Long orderId) {
        OrderResponse order = orderService.cancelOrder(orderId);
        return ResponseEntity.ok(order);
    }
}

