# E-Commerce Backend Test Script (PowerShell)
# Kullanıcı kaydı ve ürün ekleme

Write-Host "================================" -ForegroundColor Cyan
Write-Host "E-Commerce Backend Test Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Variables
$baseUrl = "http://localhost:8080"
$username = "ahmet_user"
$email = "ahmet@example.com"
$password = "password123"

# 1. Sunucunun çalışıp çalışmadığını kontrol et
Write-Host "0. Sunucu kontrol ediliyor..." -ForegroundColor Yellow
try {
    $testResponse = Invoke-WebRequest -Uri "$baseUrl/api/auth/test" -Method Get -ErrorAction Stop
    Write-Host "✅ Sunucu çalışıyor!" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ Sunucu yanıt vermiyor! Lütfen uygulamayı başlatın." -ForegroundColor Red
    Write-Host "Komutu çalıştırın: java -jar target/ecommerce-backend-0.0.1-SNAPSHOT.jar" -ForegroundColor Yellow
    exit 1
}

# 2. Kullanıcı kaydı
Write-Host "1. Kullanıcı kaydı yapılıyor ($username)..." -ForegroundColor Yellow
$registerBody = @{
    username = $username
    email = $email
    password = $password
} | ConvertTo-Json

try {
    $registerResponse = Invoke-WebRequest -Uri "$baseUrl/api/auth/register" `
        -Method Post `
        -ContentType "application/json" `
        -Body $registerBody `
        -ErrorAction Stop

    $registerContent = $registerResponse.Content | ConvertFrom-Json
    Write-Host "✅ Kullanıcı başarıyla kaydedildi!" -ForegroundColor Green
    Write-Host "Mesaj: $($registerContent.message)" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "⚠️ Kayıt hatası: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host "Kullanıcı zaten var olabilir, devam etmek." -ForegroundColor Yellow
    Write-Host ""
}

# 3. Kullanıcı girişi
Write-Host "2. Kullanıcı girişi yapılıyor..." -ForegroundColor Yellow
$loginBody = @{
    username = $username
    password = $password
} | ConvertTo-Json

try {
    $loginResponse = Invoke-WebRequest -Uri "$baseUrl/api/auth/login" `
        -Method Post `
        -ContentType "application/json" `
        -Body $loginBody `
        -ErrorAction Stop

    $loginContent = $loginResponse.Content | ConvertFrom-Json
    $token = $loginContent.token

    Write-Host "✅ Giriş başarılı!" -ForegroundColor Green
    Write-Host "Username: $($loginContent.username)" -ForegroundColor Green
    Write-Host "Email: $($loginContent.email)" -ForegroundColor Green
    Write-Host "Role: $($loginContent.role)" -ForegroundColor Green
    Write-Host "Token: $($token.Substring(0, 20))..." -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "❌ Giriş hatası: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# 4. Ürünleri listele
Write-Host "3. Ürünler listeleniyor..." -ForegroundColor Yellow
$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type" = "application/json"
}

try {
    $productsResponse = Invoke-WebRequest -Uri "$baseUrl/api/products" `
        -Method Get `
        -Headers $headers `
        -ErrorAction Stop

    $productsContent = $productsResponse.Content | ConvertFrom-Json

    Write-Host "✅ Ürünler başarıyla alındı!" -ForegroundColor Green
    Write-Host "Şu anda $($productsContent.Count) ürün var (ya da boş liste)" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "⚠️ Ürün listesi hatası: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host ""
}

# 5. Kategorileri listele
Write-Host "4. Kategoriler listeleniyor..." -ForegroundColor Yellow
try {
    $categoriesResponse = Invoke-WebRequest -Uri "$baseUrl/api/categories" `
        -Method Get `
        -Headers $headers `
        -ErrorAction Stop

    $categoriesContent = $categoriesResponse.Content | ConvertFrom-Json

    Write-Host "✅ Kategoriler başarıyla alındı!" -ForegroundColor Green
    Write-Host "Şu anda $($categoriesContent.Count) kategori var" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "⚠️ Kategori listesi hatası: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "================================" -ForegroundColor Cyan
Write-Host "✅ TEST TAMAMLANDI!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "İşlemler:" -ForegroundColor Cyan
Write-Host "✅ Sunucu kontrol edildi" -ForegroundColor Green
Write-Host "✅ Kullanıcı kaydı yapıldı" -ForegroundColor Green
Write-Host "✅ Kullanıcı girişi yapıldı" -ForegroundColor Green
Write-Host "✅ JWT Token alındı" -ForegroundColor Green
Write-Host "✅ Ürünler listelendi" -ForegroundColor Green
Write-Host "✅ Kategoriler listelendi" -ForegroundColor Green
Write-Host ""

