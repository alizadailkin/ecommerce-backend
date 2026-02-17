# 🛒 E-Commerce Backend - API Dokumentasyon

## 📋 Proje Özeti

Bu proje, Spring Boot 3.2.5 ile geliştirilmiş, PostgreSQL veritabanı kullanan, JWT token tabanlı kimlik doğrulaması olan tam işlevli bir e-ticaret backend uygulamasıdır.

---

## 🏗️ Proje Mimarisi

```
com.ecommerce
├── controller/        → REST API Endpoint'leri
│   ├── AuthController       (Giriş/Kayıt)
│   ├── ProductController    (Ürün Yönetimi)
│   ├── CategoryController   (Kategori Yönetimi)
│   ├── CartController       (Sepet Yönetimi)
│   └── OrderController      (Sipariş Yönetimi)
├── service/          → Business Logic
│   ├── AuthService
│   ├── ProductService
│   ├── CategoryService
│   ├── CartService
│   └── OrderService
├── entity/           → Database Models
├── dto/              → Data Transfer Objects
│   ├── request/      (Gelen Veriler)
│   └── response/     (Çıkan Veriler)
├── repository/       → Data Access Layer
└── security/         → JWT & Spring Security
```

---

## 🔐 Kimlik Doğrulama (Authentication)

### 1️⃣ Kullanıcı Kaydı
```
POST /api/auth/register
Content-Type: application/json

{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "secure_password"
}

Response: 200 OK
{
  "message": "User registered successfully!"
}
```

### 2️⃣ Kullanıcı Girişi
```
POST /api/auth/login
Content-Type: application/json

{
  "username": "john_doe",
  "password": "secure_password"
}

Response: 200 OK
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "type": "Bearer",
  "username": "john_doe",
  "email": "john@example.com",
  "role": "ROLE_USER"
}
```

### 3️⃣ Token Kullanımı
Tüm korunan endpoint'lere token ile erişilir:
```
Authorization: Bearer <token>
```

---

## 📦 Ürün Yönetimi (Products)

### GET - Tüm Ürünleri Listele (Sayfalı)
```
GET /api/products?page=0&size=10

Response: 200 OK
{
  "content": [
    {
      "id": 1,
      "name": "Laptop",
      "description": "High-end gaming laptop",
      "price": 1299.99,
      "stock": 50,
      "imageUrl": "https://...",
      "categoryId": 1,
      "categoryName": "Electronics",
      "createdAt": "2026-02-16T10:30:00"
    }
  ],
  "totalElements": 100,
  "totalPages": 10,
  "currentPage": 0
}
```

### GET - Tüm Ürünleri Getir (Tüm Liste)
```
GET /api/products/all

Response: 200 OK
[...]
```

### GET - Ürünü ID ile Getir
```
GET /api/products/{id}

Response: 200 OK
{
  "id": 1,
  "name": "Laptop",
  ...
}
```

### GET - Kategoriye Göre Ürünleri Getir
```
GET /api/products/category/{categoryId}

Response: 200 OK
[...]
```

### GET - Ürün Ara
```
GET /api/products/search?keyword=laptop

Response: 200 OK
[...]
```

### POST - Yeni Ürün Oluştur (Admin)
```
POST /api/products
Authorization: Bearer <admin-token>
Content-Type: application/json

{
  "name": "Wireless Mouse",
  "description": "USB wireless mouse",
  "price": 25.99,
  "stock": 200,
  "imageUrl": "https://...",
  "categoryId": 1
}

Response: 201 Created
{
  "id": 5,
  "name": "Wireless Mouse",
  ...
}
```

### PUT - Ürün Güncelle (Admin)
```
PUT /api/products/{id}
Authorization: Bearer <admin-token>
Content-Type: application/json

{
  "name": "Updated Name",
  "price": 29.99,
  ...
}

Response: 200 OK
{...}
```

### DELETE - Ürün Sil (Admin)
```
DELETE /api/products/{id}
Authorization: Bearer <admin-token>

Response: 204 No Content
```

---

## 🏷️ Kategori Yönetimi (Categories)

### GET - Tüm Kategorileri Listele
```
GET /api/categories

Response: 200 OK
[
  {
    "id": 1,
    "name": "Electronics",
    "description": "Electronic devices",
    "productCount": 25
  }
]
```

### GET - Kategoriyi ID ile Getir
```
GET /api/categories/{id}

Response: 200 OK
{...}
```

### POST - Yeni Kategori Oluştur (Admin)
```
POST /api/categories
Authorization: Bearer <admin-token>
Content-Type: application/json

{
  "name": "Books",
  "description": "Books and publications"
}

Response: 201 Created
{...}
```

### PUT - Kategori Güncelle (Admin)
```
PUT /api/categories/{id}
Authorization: Bearer <admin-token>

{
  "name": "Updated Category",
  "description": "Updated description"
}

Response: 200 OK
{...}
```

### DELETE - Kategori Sil (Admin)
```
DELETE /api/categories/{id}
Authorization: Bearer <admin-token>

Response: 204 No Content
```

---

## 🛒 Sepet Yönetimi (Cart)

### GET - Sepeti Getir
```
GET /api/cart/{userId}
Authorization: Bearer <token>

Response: 200 OK
{
  "id": 1,
  "userId": 1,
  "totalPrice": 125.98,
  "cartItems": [
    {
      "id": 1,
      "productId": 5,
      "productName": "Wireless Mouse",
      "productImage": "https://...",
      "quantity": 2,
      "unitPrice": 25.99,
      "totalPrice": 51.98
    }
  ]
}
```

### POST - Sepete Ürün Ekle
```
POST /api/cart/{userId}/items
Authorization: Bearer <token>
Content-Type: application/json

{
  "productId": 5,
  "quantity": 2
}

Response: 200 OK
{...}
```

### PUT - Sepet Ürünü Miktarını Güncelle
```
PUT /api/cart/{userId}/items/{cartItemId}?quantity=3
Authorization: Bearer <token>

Response: 200 OK
{...}
```

### DELETE - Sepetten Ürün Çıkar
```
DELETE /api/cart/{userId}/items/{cartItemId}
Authorization: Bearer <token>

Response: 200 OK
{...}
```

### DELETE - Sepeti Temizle
```
DELETE /api/cart/{userId}
Authorization: Bearer <token>

Response: 204 No Content
```

---

## 📋 Sipariş Yönetimi (Orders)

### GET - Kullanıcının Siparişlerini Getir
```
GET /api/orders/user/{userId}
Authorization: Bearer <token>

Response: 200 OK
[
  {
    "id": 1,
    "userId": 1,
    "username": "john_doe",
    "orderDate": "2026-02-16T11:00:00",
    "status": "PENDING",
    "totalPrice": 125.98,
    "shippingAddress": "123 Main St, City, Country",
    "orderItems": [
      {
        "id": 1,
        "productId": 5,
        "productName": "Wireless Mouse",
        "productImage": "https://...",
        "quantity": 2,
        "unitPrice": 25.99,
        "totalPrice": 51.98
      }
    ]
  }
]
```

### GET - Sipariş Detayını Getir
```
GET /api/orders/{orderId}
Authorization: Bearer <token>

Response: 200 OK
{...}
```

### GET - Duruma Göre Siparişleri Getir (Admin)
```
GET /api/orders/status?status=PENDING
Authorization: Bearer <admin-token>

Response: 200 OK
[...]
```

### POST - Sepetten Sipariş Oluştur
```
POST /api/orders/user/{userId}
Authorization: Bearer <token>
Content-Type: application/json

{
  "shippingAddress": "123 Main St, City, Country"
}

Response: 201 Created
{
  "id": 1,
  "userId": 1,
  "username": "john_doe",
  "orderDate": "2026-02-16T11:00:00",
  "status": "PENDING",
  ...
}
```

### PUT - Sipariş Durumunu Güncelle (Admin)
```
PUT /api/orders/{orderId}/status?newStatus=SHIPPED
Authorization: Bearer <admin-token>

Response: 200 OK
{...}
```

### PUT - Sipariş İptal Et
```
PUT /api/orders/{orderId}/cancel
Authorization: Bearer <token>

Response: 200 OK
{...}
```

---

## 🔐 Rol ve Yetkilendirme

### Roller:
- **ROLE_USER**: Standart kullanıcı (varsayılan)
- **ROLE_ADMIN**: Yönetici (ürün/kategori yönetimi için gerekli)

### Koruma Seviyeleri:
- **Public**: `/api/auth/**` - Herkes erişebilir
- **Authenticated**: `/api/cart/**`, `/api/orders/**` - Login gerekli
- **Admin**: POST/PUT/DELETE `/api/products/**`, `/api/categories/**` - Admin gerekli

---

## 🗂️ Database Schema

### Users Tablosu
```sql
CREATE TABLE users (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('ROLE_USER', 'ROLE_ADMIN') DEFAULT 'ROLE_USER',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Products Tablosu
```sql
CREATE TABLE products (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(200) NOT NULL,
  description VARCHAR(1000),
  price DECIMAL(10, 2) NOT NULL,
  stock INT DEFAULT 0,
  image_url VARCHAR(500),
  category_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);
```

### Categories Tablosu
```sql
CREATE TABLE categories (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) UNIQUE NOT NULL,
  description VARCHAR(500)
);
```

### Orders Tablosu
```sql
CREATE TABLE orders (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  status ENUM('PENDING', 'SHIPPED', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
  total_price DECIMAL(10, 2) NOT NULL,
  shipping_address VARCHAR(500),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### Carts Tablosu
```sql
CREATE TABLE carts (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT UNIQUE NOT NULL,
  total_price DECIMAL(10, 2) DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## 🚀 Başlangıç

### 1️⃣ Database Bağlantısını Konfigüre Et
```properties
# application.properties
spring.datasource.url=jdbc:postgresql://localhost:5432/ecommerce_db
spring.datasource.username=postgres
spring.datasource.password=your_password
```

### 2️⃣ JWT Secret'ı Ayarla
```properties
jwt.secret=your-256-bit-secret-key
jwt.expiration=86400000  # 24 saat
```

### 3️⃣ Uygulamayı Başlat
```bash
mvn spring-boot:run
```

### 4️⃣ Test Et
```bash
curl http://localhost:8080/api/auth/test
```

---

## 📊 Teknoloji Stack

| Teknoloji | Versiyon | Amaç |
|-----------|----------|------|
| Java | 17 | Programlama Dili |
| Spring Boot | 3.2.5 | Framework |
| Spring Security | 6.x | Kimlik Doğrulama |
| Spring Data JPA | 6.x | ORM |
| PostgreSQL | 13+ | Veritabanı |
| JWT (JJWT) | 0.12.5 | Token Yönetimi |
| Lombok | 1.18 | Boilerplate Azaltma |
| Maven | 3.9+ | Build Tool |

---

## ⚠️ Hata Kodları

| Kod | Anlamı |
|-----|--------|
| 200 | OK - Başarılı |
| 201 | Created - Oluşturuldu |
| 204 | No Content - İçerik yok |
| 400 | Bad Request - Hatalı istek |
| 401 | Unauthorized - Yetkisiz |
| 403 | Forbidden - Yasak |
| 404 | Not Found - Bulunamadı |
| 500 | Server Error - Sunucu hatası |

---

## 📝 Notlar

- Tüm ürün oluşturma/güncelleme/silme işlemleri ADMIN rolü gerektirir
- Sepet işlemleri çift kontrole tabi (stok ve fiyat)
- Siparişler oluşturulduktan sonra ürün stoku otomatik azalır
- Siparişler iptal edildiğinde stok geri eklenir
- JWT token 24 saat geçerliliğe sahiptir

---

## 🎯 Gelecek İmprovement'lar

- [ ] Email doğrulama ekle
- [ ] İşlem hataları için exception handling iyileştir
- [ ] Logging sistemi ekle
- [ ] Unit test ve integration test ekle
- [ ] API rate limiting ekle
- [ ] Caching mekanizması (Redis) ekle
- [ ] Payment integration (Stripe/PayPal)
- [ ] Notification sistemi (Email/SMS)
- [ ] Admin panel oluştur

---

Generated: 2026-02-16

