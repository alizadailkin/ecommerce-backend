#!/bin/bash

# E-Commerce Backend Test Script
# Kullanıcı kaydı ve ürün ekleme

echo "================================"
echo "E-Commerce Backend Test Script"
echo "================================"
echo ""

# Variables
BASE_URL="http://localhost:8080"
USERNAME="ahmet_user"
EMAIL="ahmet@example.com"
PASSWORD="password123"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}1. Kullanıcı kaydı yapılıyor...${NC}"
REGISTER_RESPONSE=$(curl -s -X POST "$BASE_URL/api/auth/register" \
  -H "Content-Type: application/json" \
  -d "{
    \"username\": \"$USERNAME\",
    \"email\": \"$EMAIL\",
    \"password\": \"$PASSWORD\"
  }")

echo -e "${GREEN}Yanıt:${NC} $REGISTER_RESPONSE"
echo ""

echo -e "${YELLOW}2. Kullanıcı girişi yapılıyor...${NC}"
LOGIN_RESPONSE=$(curl -s -X POST "$BASE_URL/api/auth/login" \
  -H "Content-Type: application/json" \
  -d "{
    \"username\": \"$USERNAME\",
    \"password\": \"$PASSWORD\"
  }")

echo -e "${GREEN}Yanıt:${NC}"
echo "$LOGIN_RESPONSE" | jq '.' 2>/dev/null || echo "$LOGIN_RESPONSE"
echo ""

# Token'ı çıkar
TOKEN=$(echo "$LOGIN_RESPONSE" | jq -r '.token' 2>/dev/null)

if [ -z "$TOKEN" ] || [ "$TOKEN" = "null" ]; then
  echo -e "${RED}Hata: Token alınamadı!${NC}"
  exit 1
fi

echo -e "${GREEN}Token başarıyla alındı!${NC}"
echo ""

echo -e "${YELLOW}3. Test endpoint'i çağrılıyor...${NC}"
TEST_RESPONSE=$(curl -s -X GET "$BASE_URL/api/auth/test")
echo -e "${GREEN}Yanıt:${NC} $TEST_RESPONSE"
echo ""

echo -e "${YELLOW}4. Ürünler listeleniyor...${NC}"
PRODUCTS_RESPONSE=$(curl -s -X GET "$BASE_URL/api/products" \
  -H "Authorization: Bearer $TOKEN")

echo -e "${GREEN}Yanıt:${NC}"
echo "$PRODUCTS_RESPONSE" | jq '.' 2>/dev/null || echo "$PRODUCTS_RESPONSE"
echo ""

echo -e "${GREEN}✅ Test tamamlandı!${NC}"

