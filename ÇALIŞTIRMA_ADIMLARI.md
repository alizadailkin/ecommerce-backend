# 🚀 ADIM ADIM ÇALIŞMA REHBERI

## 1️⃣ SUNUCUYU BAŞLAT

### Komut:
```bash
cd C:\Users\user\Desktop\proje\ecommerce-backend
java -jar target/ecommerce-backend-0.0.1-SNAPSHOT.jar
```

### Beklenen Çıktı:
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_|\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v3.2.5)

ecommerce-backend : Started EcommerceBackendApplication in 8.234 seconds
```

✅ **Sunucu başarıyla başladı!**

---

## 2️⃣ YENİ TERMİNAL AÇIN VE SUNUCUYU TEST ET

### Komut:
```bash
curl http://localhost:8080/api/auth/test
```

### Beklenen Yanıt:
```json
{"message":"Auth endpoints are working!"}
```

✅ **Sunucu cevap veriyor!**

---

## 3️⃣ KULLANICI KAYDINI YAP

### Komut:
```bash
curl -X POST http://localhost:8080/api/auth/register ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"ahmet_user\",\"email\":\"ahmet@example.com\",\"password\":\"password123\"}"
```

### Beklenen Yanıt:
```json
{"message":"User registered successfully!"}
```

✅ **Kullanıcı başarıyla kaydedildi!**

**Kullanıcı Bilgileri:**
- Username: `ahmet_user`
- Email: `ahmet@example.com`
- Password: `password123`

---

## 4️⃣ KULLANICI GİRİŞİ YAP VE TOKEN AL

### Komut:
```bash
curl -X POST http://localhost:8080/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"ahmet_user\",\"password\":\"password123\"}"
```

### Beklenen Yanıt:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhaG1ldF91c2VyIiwiaWF0IjoxNzM5NzA1MDAwLCJleHAiOjE3Mzk3OTE0MDB9.xxxxx",
  "type": "Bearer",
  "username": "ahmet_user",
  "email": "ahmet@example.com",
  "role": "ROLE_USER"
}
```

### 🔑 TOKEN'ı KAYDET:
Çıktıda gelen `token` değerini bir text dosyasına kopyala. Sonraki isteklerde kullanacaksın.

Örnek:
```
Token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhaG1ldF91c2VyIiwiaWF0IjoxNzM5NzA1MDAwLCJleHAiOjE3Mzk3OTE0MDB9.xxxxx
```

✅ **Token başarıyla alındı!**

---

## 5️⃣ ÜRÜNLERI LİSTELE (Token Kullanarak)

### Komut (TOKEN'ı değiştir):
```bash
curl -X GET "http://localhost:8080/api/products?page=0&size=10" ^
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Örnek (Gerçek Token ile):
```bash
curl -X GET "http://localhost:8080/api/products?page=0&size=10" ^
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhaG1ldF91c2VyIiwiaWF0IjoxNzM5NzA1MDAwLCJleHAiOjE3Mzk3OTE0MDB9.xxxxx"
```

### Beklenen Yanıt:
```json
{
  "content": [],
  "empty": true,
  "first": true,
  "last": true,
  "number": 0,
  "numberOfElements": 0,
  "pageable": {...},
  "size": 10,
  "sort": {...},
  "totalElements": 0,
  "totalPages": 0
}
```

✅ **Ürün listesi başarıyla alındı! (Şu anda boş)**

---

## 6️⃣ KATEGORİ LİSTELE

### Komut:
```bash
curl -X GET "http://localhost:8080/api/categories" ^
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Beklenen Yanıt:
```json
[]
```

✅ **Kategori listesi başarıyla alındı! (Şu anda boş)**

---

## 7️⃣ SEPETİ KONTROL ET

### Komut (USER_ID yerine 1 koy):
```bash
curl -X GET "http://localhost:8080/api/cart/1" ^
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

### Beklenen Yanıt:
```json
{
  "id": 1,
  "userId": 1,
  "totalPrice": 0.00,
  "cartItems": []
}
```

✅ **Sepet başarıyla alındı!**

---

## 📊 ÖZETİ

Tamamladığımız işlemler:

✅ Sunucu başlatıldı (port 8080)
✅ Sunucu test edildi
✅ Kullanıcı kaydı yapıldı (ahmet_user)
✅ Kullanıcı girişi yapıldı
✅ JWT Token alındı
✅ Ürünler listelendi
✅ Kategoriler listelendi
✅ Sepet kontrol edildi

---

## 📝 POSTMAN İLE TEST ET

Daha kolay bir şekilde test etmek için:

1. Postman uygulamasını aç
2. File → Import
3. `Postman_Collection.json` dosyasını seç
4. Tüm endpoint'ler otomatik yüklenecek
5. İstediğin endpoint'i seç ve "Send" tıkla

---

## 🎯 SONRAKI ADIMLAR

Şimdi yapabileceğiniz işlemler:

1. **Ürün Oluştur** (Admin olarak)
2. **Kategori Oluştur** (Admin olarak)
3. **Sepete Ürün Ekle**
4. **Sipariş Oluştur**
5. **Siparişleri Takip Et**

---

## 📞 YARDIM

Sorunlar için:
- `API_DOCUMENTATION.md` dosyasını oku
- `README_TR.md` dosyasını oku
- `BAŞLATMA_REHBERI.html` dosyasını browser'da aç

---

**Başarılar!** 🎉

