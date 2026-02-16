package com.ecommerce.entity;

public enum OrderStatus {
    PENDING,        // Beklemede
    PROCESSING,     // İşleniyor
    SHIPPED,        // Kargoya verildi
    DELIVERED,      // Teslim edildi
    CANCELLED       // İptal edildi
}