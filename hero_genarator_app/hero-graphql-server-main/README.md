# 🚀 Hero GraphQL Server

Bu loyiha sizga GraphQL orqali super qahramonlar ro‘yxatini yaratish, ko‘rish, yangilash va o‘chirish imkonini beradi. Rasm yuklash uchun REST endpoint ham mavjud.

---

## 💡 Talablar:

- Node.js (v18+ tavsiya etiladi)
- NPM yoki Yarn

---

## ⚙️ O‘rnatish:

```bash
git clone https://github.com/YOUR_USERNAME/hero-graphql-server.git
cd hero-graphql-server
npm install
mkdir uploads

🟢 Ishga tushirish:
```bash
node index.js

Server quyidagi URLlarda ishlaydi:

🔗 GraphQL: http://localhost:4000/graphql

📤 File Upload (REST): http://localhost:4000/upload

🖼 Yuklangan fayllar: http://localhost:4000/uploads/filename.png

✅ Test qilish
📌 GraphiQL orqali quyidagi so‘rovni sinab ko‘ring:
```graphql
query {
  heroes {
    id
    name
    universe
    image
  }
}

📌 Fayl yuklash uchun:
Postman oching

POST method tanlang: http://localhost:4000/upload

form-data → key: image, type: File, va rasm tanlang

Javobda quyidagiga o‘xshash imageUrl keladi:
```json
{
  "imageUrl": "http://localhost:4000/uploads/superman.png"
}
