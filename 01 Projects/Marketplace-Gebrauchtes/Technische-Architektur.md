# 🏗️ Technische Architektur – Marketplace App

**Datum:** 2026-07-19  
**Status:** ⚙️ ENTWURF  

---

## 📐 SYSTEM-ÜBERSICHT

```
┌─────────────────────────────────────────────────────────────┐
│                      CLIENT (Browser)                       │
│  Next.js 14 + React + TailwindCSS                           │
│  • Homepage (Suche, Kategorien)                             │
│  • Produktdetail                                            │
│  • Seller-Profil                                            │
│  • Messaging                                                │
│  • User-Profil (Käufer/Verkäufer)                          │
└────────────────────┬────────────────────────────────────────┘
                     │ HTTP/REST (REST-API)
                     │
┌────────────────────▼────────────────────────────────────────┐
│                   API BACKEND (Node.js)                     │
│  Express/Fastify + TypeScript                              │
│  • User Management (Register, Login, KYC)                  │
│  • Product Management (CRUD)                               │
│  • Messaging System                                        │
│  • Transaction Handling                                    │
│  • Admin Dashboard                                         │
└────────────────────┬────────────────────────────────────────┘
                     │
       ┌─────────────┼─────────────┐
       │             │             │
       ▼             ▼             ▼
  ┌─────────┐  ┌─────────┐  ┌──────────┐
  │PostgreSQL│  │   S3    │  │  Stripe  │
  │ Database │  │  Bilder │  │ Payments │
  │          │  │ Storage │  │          │
  └─────────┘  └─────────┘  └──────────┘
```

---

## 🗄️ DATENBANKSCHEMA (PostgreSQL)

### 1. **USERS** (Benutzer)
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  display_name VARCHAR(100),
  profile_picture_url VARCHAR(500),
  user_type ENUM('buyer', 'seller', 'admin') DEFAULT 'buyer',
  kyc_verified BOOLEAN DEFAULT FALSE,
  kyc_verified_at TIMESTAMP,
  bio TEXT,
  phone VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 2. **SELLERS** (Verkäufer-Profile)
```sql
CREATE TABLE sellers (
  id UUID PRIMARY KEY REFERENCES users(id),
  shop_name VARCHAR(150) UNIQUE NOT NULL,
  description TEXT,
  rating DECIMAL(3,2) DEFAULT 0,
  total_reviews INT DEFAULT 0,
  response_time_hours INT,
  verified_badge BOOLEAN DEFAULT FALSE,
  business_type ENUM('private', 'company') DEFAULT 'private',
  company_name VARCHAR(200),
  tax_id VARCHAR(50),
  bank_account VARCHAR(100), -- Encrypted in production!
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3. **PRODUCTS** (Inserate)
```sql
CREATE TABLE products (
  id UUID PRIMARY KEY,
  seller_id UUID NOT NULL REFERENCES sellers(id) ON DELETE CASCADE,
  title VARCHAR(200) NOT NULL,
  description TEXT,
  category VARCHAR(50) NOT NULL, -- electronics, jewelry, furniture, etc.
  subcategory VARCHAR(50),
  condition ENUM('new', 'like_new', 'good', 'fair', 'poor') DEFAULT 'good',
  price DECIMAL(10,2) NOT NULL,
  currency VARCHAR(3) DEFAULT 'EUR',
  location VARCHAR(150),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  views INT DEFAULT 0,
  status ENUM('active', 'sold', 'hidden', 'flagged') DEFAULT 'active',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP
);
```

### 4. **PRODUCT_IMAGES** (Bilder)
```sql
CREATE TABLE product_images (
  id UUID PRIMARY KEY,
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  image_url VARCHAR(500) NOT NULL, -- S3/Cloudinary URL
  display_order INT DEFAULT 0,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 5. **MESSAGES** (Nachrichten zwischen Käufern & Verkäufern)
```sql
CREATE TABLE messages (
  id UUID PRIMARY KEY,
  conversation_id UUID NOT NULL,
  sender_id UUID NOT NULL REFERENCES users(id),
  receiver_id UUID NOT NULL REFERENCES users(id),
  product_id UUID REFERENCES products(id),
  content TEXT NOT NULL,
  is_read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conversations (
  id UUID PRIMARY KEY,
  buyer_id UUID NOT NULL REFERENCES users(id),
  seller_id UUID NOT NULL REFERENCES users(id),
  product_id UUID REFERENCES products(id),
  last_message_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 6. **TRANSACTIONS** (Käufe)
```sql
CREATE TABLE transactions (
  id UUID PRIMARY KEY,
  product_id UUID NOT NULL REFERENCES products(id),
  buyer_id UUID NOT NULL REFERENCES users(id),
  seller_id UUID NOT NULL REFERENCES users(id),
  amount DECIMAL(10,2) NOT NULL,
  marketplace_fee DECIMAL(10,2) NOT NULL, -- 10% of amount
  seller_payout DECIMAL(10,2) NOT NULL,
  status ENUM('pending', 'completed', 'refunded', 'disputed') DEFAULT 'pending',
  payment_method VARCHAR(50), -- 'stripe', 'paypal'
  stripe_payment_id VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  completed_at TIMESTAMP
);
```

### 7. **REVIEWS** (Bewertungen)
```sql
CREATE TABLE reviews (
  id UUID PRIMARY KEY,
  transaction_id UUID NOT NULL REFERENCES transactions(id),
  reviewer_id UUID NOT NULL REFERENCES users(id),
  reviewed_user_id UUID NOT NULL REFERENCES users(id),
  rating INT CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  response TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 🔌 API ENDPOINTS (REST)

### **Auth**
```
POST   /api/auth/register
POST   /api/auth/login
POST   /api/auth/logout
POST   /api/auth/refresh-token
```

### **Products**
```
GET    /api/products                 (Liste mit Filter)
GET    /api/products/:id             (Detail)
POST   /api/products                 (Create)
PUT    /api/products/:id             (Update)
DELETE /api/products/:id             (Delete)
GET    /api/products/seller/:id      (Seller's Produkte)
POST   /api/products/:id/images      (Upload Bilder)
```

### **Sellers**
```
GET    /api/sellers/:id              (Seller-Profil)
PUT    /api/sellers/:id              (Update)
GET    /api/sellers/:id/reviews      (Bewertungen)
```

### **Messaging**
```
GET    /api/conversations            (Meine Chats)
GET    /api/conversations/:id        (Chat-Details)
POST   /api/conversations/:id/messages (Nachricht senden)
```

### **Transactions**
```
POST   /api/transactions             (Create Transaktion)
GET    /api/transactions/:id         (Status)
POST   /api/transactions/:id/review  (Bewertung schreiben)
```

### **Admin**
```
GET    /api/admin/users              (Alle Nutzer)
GET    /api/admin/products           (Alle Produkte)
PUT    /api/admin/products/:id       (Approve/Reject)
GET    /api/admin/analytics          (Stats)
```

---

## 🔐 SICHERHEIT

### Authentication
```
→ JWT Token (HttpOnly Cookies)
→ NextAuth.js für Session Management
→ 2FA für Admin-Accounts (optional)
```

### Data Protection
```
→ Passwords: bcrypt (10 salts)
→ Sensitive fields: Encryption at rest
→ HTTPS everywhere
→ Rate limiting on auth endpoints
→ CSRF protection
```

### Payment Security
```
→ Stripe Webhook Verification
→ PCI-DSS Compliance (Stripe handles CC data)
→ No direct payment info storage
→ Escrow-like flow: User pays → We hold → Seller confirms
```

---

## 📦 DEPLOYMENT

### Development
```
npm run dev              # Local server :3000
npm run test            # Jest + Playwright
npm run lint            # ESLint + Prettier
```

### Production
```
Vercel (Frontend)       → https://marketplace.example.com
Railway/Render (API)    → https://api.marketplace.example.com
PostgreSQL Cloud        → AWS RDS / Railway / Supabase
S3 / Cloudinary         → Image storage
Stripe                  → Payment processing
```

### CI/CD
```
GitHub Actions
→ On push to main: run tests
→ If tests pass: deploy to production
→ Automatic rollback on failure
```

---

## 💾 FILE STORAGE (Bilder)

### Option 1: AWS S3
```
- Speicher: €0.023 / GB/Monat
- Bandbreite: €0.09 / GB
- Best for: High-volume, professional
```

### Option 2: Cloudinary
```
- Free Tier: 25k uploads/Monat, 1 GB storage
- Paid: €99+/Monat
- Best for: Beginners, image optimization built-in
```

### Option 3: Firebase Storage
```
- Free Tier: 5 GB, 1 GB/Tag download
- Pay-as-you-go
- Best for: Rapid prototyping
```

**Empfehlung für MVP:** Cloudinary (einfach, kostenlos bis Skalierung)

---

## 🔄 WORKFLOW: Produkt verkaufen

```
1. Seller uploaded Produkt
   ↓ (Bilder zu S3/Cloudinary)
   ↓ (Daten zu PostgreSQL)
   
2. Admin/Auto-Moderation prüft
   ↓ (Spamfilter, Kategorisierung)
   
3. Listing wird "active"
   ↓ (Käufer sehen es)
   
4. Käufer schreibt Nachricht
   ↓ (Conversation erstellt)
   
5. Käufer "kauft" Produkt
   ↓ (Stripe Payment)
   
6. Zahlung erfolgreich
   ↓ (Status: "pending confirmation")
   
7. Seller bestätigt Versand
   ↓ (Käufer erhält Tracking)
   
8. Käufer erhält Produkt
   ↓ (Status: "completed")
   
9. Beide schreiben Reviews
   ↓ (Ratings updated)
```

---

**Nächster Schritt:** Figma-Wireframes erstellen (UI/UX Design)
