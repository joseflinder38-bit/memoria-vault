# ✅ MVP-Checkliste – 8-Wochen-Sprint

**Start-Datum:** [Zu bestätigen]  
**Status:** 🔵 PLANUNG  
**Ziel:** Funktionsfähiges Marketplace MVP

---

## 📅 WOCHENPLAN

### **WOCHE 1: Setup & Planung**

#### Montag–Dienstag: Entscheidungen
- [ ] **Tech-Stack wählen** (Option A/B/C?)
  - Option A: Next.js + Node.js + PostgreSQL (empfohlen)
  - Option B: Firebase + Next.js (schneller)
  - Option C: No-Code (Bubble/FlutterFlow)
  - **ENTSCHEIDUNG:** _________________

- [ ] **Repository setup**
  - [ ] GitHub Repo erstellen
  - [ ] `.env.example` template
  - [ ] `.gitignore` (Node, env-Dateien, etc.)
  - [ ] README mit Setup-Anleitung

- [ ] **Hosting-Accounts erstellen**
  - [ ] Vercel (Frontend)
  - [ ] Railway / Render (Backend)
  - [ ] Stripe Test Account
  - [ ] Cloudinary Account (Bilder)

#### Mittwoch–Donnerstag: Design
- [ ] **Figma-Wireframes** (25 Seiten, grobe Skizzen)
  - [ ] Homepage / Landingpage
  - [ ] Suchseite + Filter
  - [ ] Produktdetail
  - [ ] Seller-Profil
  - [ ] Käufer-Profil
  - [ ] Upload-Formular (5 Schritte)
  - [ ] Chat-Interface
  - [ ] Admin-Dashboard (Übersicht)
  - [ ] Checkout (Zahlungsseite)

- [ ] **User-Stories schreiben** (INVESTITURE-Format)
  ```
  Story: "Als Verkäufer möchte ich 5 Bilder hochladen..."
  → Acceptance Criteria:
     ✓ Drag & Drop oder File-Picker
     ✓ Reihenfolge verschiebbar
     ✓ Max. 5 Bilder
  ```

- [ ] **Database-Design final** (Auf README abgestimmt)

#### Freitag: Dokumentation
- [ ] **Entwickler-Guide schreiben**
  - [ ] Installation (npm install, .env setup)
  - [ ] Erste Schritte (local server starten)
  - [ ] API dokumentieren (OpenAPI/Swagger)
  - [ ] Commit-Konventionen

---

### **WOCHE 2: Backend Grundlagen**

#### Setup
- [ ] **Node.js + Express/Fastify Projekt**
  - [ ] `npm init -y` + Abhängigkeiten
  - [ ] TypeScript config (tsconfig.json)
  - [ ] ESLint + Prettier
  - [ ] Jest test setup

- [ ] **PostgreSQL Database**
  - [ ] Lokal oder Cloud (Railway/Supabase)?
  - [ ] Migrations-Tool (Prisma oder Knex)
  - [ ] Schema aus Architekturdokument implementieren

#### Authentication
- [ ] **User Registration Endpoint** `POST /api/auth/register`
  - [ ] Email validation
  - [ ] Password hashing (bcrypt)
  - [ ] Email verification (optional für MVP)

- [ ] **User Login** `POST /api/auth/login`
  - [ ] JWT Token generieren
  - [ ] HttpOnly Cookie setzen
  - [ ] Token refresh logic

- [ ] **Auth Middleware**
  - [ ] `protect()` für Protected Routes
  - [ ] Role-based access (buyer/seller/admin)

#### Testing
- [ ] **Unit Tests schreiben**
  - [ ] Auth functions
  - [ ] Password validation
  - [ ] Email utils

---

### **WOCHE 3: Core Features (Backend)**

#### Product Management
- [ ] **Product CRUD** 
  - [ ] `POST /api/products` (Create)
  - [ ] `GET /api/products` (List mit Filter)
  - [ ] `GET /api/products/:id` (Detail)
  - [ ] `PUT /api/products/:id` (Update)
  - [ ] `DELETE /api/products/:id` (Delete, nur Seller selbst)

- [ ] **Image Upload**
  - [ ] Cloudinary Integration
  - [ ] Multi-upload endpoint
  - [ ] Image validation (size, format)
  - [ ] Thumbnail generation (optional)

#### Search & Filter
- [ ] **Search Endpoint** `GET /api/products?q=...&category=...&maxPrice=...`
  - [ ] Text search (title + description)
  - [ ] Category filter
  - [ ] Price range
  - [ ] Location (radius filter?)
  - [ ] Sorting (newest, price low→high)

#### Seller Profile
- [ ] **GET /api/sellers/:id**
- [ ] **PUT /api/sellers/:id** (Update bio, shop name, etc.)
- [ ] **GET /api/sellers/:id/reviews** (Bewertungen anzeigen)

---

### **WOCHE 4: Messaging & Transactions**

#### Messaging System
- [ ] **Conversation Model**
  - [ ] `GET /api/conversations` (Meine Chats)
  - [ ] `POST /api/conversations` (Neue Unterhaltung starten)
  - [ ] `GET /api/conversations/:id` (Chat-Details)
  - [ ] Pagination für lange Chats

- [ ] **Messages**
  - [ ] `POST /api/conversations/:id/messages` (Nachricht senden)
  - [ ] `PATCH /api/messages/:id/read` (Als gelesen markieren)
  - [ ] Real-time-Benachrichtigungen? (Optional für MVP → WebSockets später)

#### Transactions (Zahlungen)
- [ ] **Stripe Integration** (Test Mode)
  - [ ] Stripe API Key setup
  - [ ] Product→Stripe-Price mapping

- [ ] **Payment Flow**
  - [ ] `POST /api/transactions` (Create → Stripe Session)
  - [ ] `GET /api/transactions/:id` (Status abrufen)
  - [ ] Webhook: `POST /api/webhooks/stripe` (Payment confirmed)
  - [ ] Automatically update product status to "sold"

- [ ] **Payouts** (Monatliche Auszahlung an Seller)
  - [ ] Simpel MVP: Seller gibt IBAN, wir machen Überweisung (manuell)
  - [ ] Später: Stripe Connects für automatische Payouts

#### Reviews
- [ ] **POST /api/reviews** (Bewertung schreiben)
- [ ] **GET /api/users/:id/reviews** (Bewertungen anzeigen)
- [ ] **PATCH /api/reviews/:id** (Response schreiben)

---

### **WOCHE 5–6: Frontend (React/Next.js)**

#### Pages/Layout
- [ ] **_app.tsx** (Global layout, header/footer)
- [ ] **_document.tsx** (Metadata, fonts)
- [ ] **pages/index.tsx** (Homepage)

#### Core Pages
- [ ] **pages/browse.tsx** (Suchseite)
  - [ ] Search form (Text, Filter, Sortierung)
  - [ ] Product grid (Responsive)
  - [ ] Infinite scroll oder Pagination

- [ ] **pages/products/[id].tsx** (Produktdetail)
  - [ ] Image gallery (Lightbox)
  - [ ] Seller-Info
  - [ ] "Message Seller" Button → Chat
  - [ ] "Buy Now" Button → Checkout

- [ ] **pages/sellers/[id].tsx** (Seller-Profil)
  - [ ] Shop name + Bio
  - [ ] Star rating
  - [ ] Alle Produkte auflisten
  - [ ] Reviews

#### Auth Pages
- [ ] **pages/auth/register.tsx** (Signup)
- [ ] **pages/auth/login.tsx** (Login)
- [ ] **pages/profile.tsx** (User dashboard)

#### Seller Pages
- [ ] **pages/dashboard.tsx** (Seller dashboard)
  - [ ] Meine Produkte (Tabelle)
  - [ ] Stats (Views, Sales, Umsatz)
  - [ ] "Upload neues Produkt" Button

- [ ] **pages/products/upload.tsx** (5-Schritt Upload)
  1. Kategorie + Titel
  2. Beschreibung + Zustand
  3. Bilder (Cloudinary)
  4. Preis + Versand
  5. Review + Publish

#### Buyer Pages
- [ ] **pages/messages.tsx** (Chat-Übersicht)
  - [ ] Conversation list
  - [ ] Search/Filter conversations

- [ ] **pages/messages/[conversationId].tsx** (Chat-Detail)
  - [ ] Message history
  - [ ] Send message form

#### Payment
- [ ] **pages/checkout.tsx** (Stripe Checkout)
  - [ ] Product summary
  - [ ] Stripe-Element
  - [ ] "Pay" Button → Stripe Payment

#### Admin
- [ ] **pages/admin/index.tsx** (Dashboard)
  - [ ] Stats (Users, Products, Revenue)
  - [ ] Recent transactions
  - [ ] Flagged products

- [ ] **pages/admin/products.tsx** (Moderation)
  - [ ] Alle Produkte mit Status
  - [ ] Approve/Reject Buttons
  - [ ] Flag für Spam

---

### **WOCHE 7: UI/UX Polishing & Testing**

#### Styling
- [ ] **TailwindCSS** (Alle Komponenten)
- [ ] **Responsive Design** (Mobile first!)
- [ ] **Dark Mode** (Optional but nice to have)
- [ ] **Accessibility** (WCAG 2.1 AA)
  - [ ] Keyboard navigation
  - [ ] ARIA labels
  - [ ] Color contrast

#### Components (Reusable)
- [ ] Button (Primary, Secondary, Danger)
- [ ] Card (Product, Review)
- [ ] Form Input (Text, Textarea, Select)
- [ ] Modal / Dialog
- [ ] Toast Notifications
- [ ] Loading spinner
- [ ] Pagination / Infinite scroll

#### Testing
- [ ] **Unit Tests** (Jest)
  - [ ] Utility functions
  - [ ] Components (React Testing Library)

- [ ] **Integration Tests**
  - [ ] Auth flow (login → upload → buy)
  - [ ] Search + filter
  - [ ] Messaging

- [ ] **E2E Tests** (Playwright/Cypress)
  - [ ] Complete user flow
  - [ ] Payment flow (Stripe test)
  - [ ] Admin moderation

---

### **WOCHE 8: Launch & Marketing Prep**

#### Final Checks
- [ ] **Performance**
  - [ ] Lighthouse audit (>90 score)
  - [ ] Database queries optimized
  - [ ] Image optimization
  - [ ] Minification + compression

- [ ] **Security**
  - [ ] HTTPS everywhere
  - [ ] OWASP Top 10 checks
  - [ ] Rate limiting
  - [ ] SQL injection prevention

- [ ] **SEO**
  - [ ] Meta tags
  - [ ] og: tags (for social sharing)
  - [ ] robots.txt + sitemap.xml

#### Launch Prep
- [ ] **Deploy to Production**
  - [ ] Frontend → Vercel
  - [ ] Backend → Railway
  - [ ] Database → PostgreSQL Cloud

- [ ] **Domain + Email**
  - [ ] Custom domain (marketplace.example.com)
  - [ ] Email setup (no-reply@, support@)

- [ ] **Documentation**
  - [ ] User guide (seller, buyer, admin)
  - [ ] FAQ
  - [ ] Terms of Service (ToS)
  - [ ] Privacy Policy

- [ ] **Monitoring**
  - [ ] Sentry (error tracking)
  - [ ] Google Analytics
  - [ ] Uptime monitoring

#### First Users (Beta)
- [ ] Invite 10–20 early adopters
- [ ] Gather feedback
- [ ] Fix critical bugs
- [ ] Iterate on UX

---

## 🎯 KRITISCHE METRIKEN (pro Woche)

| Woche | Ziel | Checkpoint |
|-------|------|------------|
| 1–2 | Setup + Design fertig | GitHub + Figma ready |
| 3 | Backend teilweise functional | Unit tests green |
| 4 | Core Features done | E2E tests laufen |
| 5–6 | Frontend 80% done | Pages in production |
| 7 | Alles poliert | Tests pass, no critical bugs |
| 8 | Launch! | First real transactions |

---

## 🚨 RISK MITIGATION

### Zeitdruck
- **Risk:** 8 Wochen ist tight, wenn allein entwickelt
- **Mitigation:** 
  - Fokus auf MVP (keine Premium-Features!)
  - Cut scope wenn nötig (z.B. Real-time chat → Polling)
  - Nutze Templates/Boilerplates (create-next-app, etc.)

### Payment Issues
- **Risk:** Stripe Integration könnte tricky sein
- **Mitigation:**
  - Stripe Sandbox viel testen
  - Webhook testing (Stripe CLI)
  - Error handling für alle payment scenarios

### Scaling
- **Risk:** DB könnte slow werden bei many users
- **Mitigation:**
  - Caching (Redis) later
  - Database indexing on key fields
  - Monitor performance weekly

---

## 📊 SUCCESS DEFINITION

**Nach 8 Wochen ist die App erfolgreich, wenn:**

```
✅ Registrierung funktioniert (Email + Password)
✅ Seller können Produkte hochladen (mit Bildern)
✅ Käufer können suchen & Produkte sehen
✅ Messaging funktioniert (Käufer ↔ Seller)
✅ Zahlungen mit Stripe funktionieren
✅ Admin-Moderation aktiv
✅ <5 critical bugs
✅ Lighthouse >90
✅ Keine unerwarteten downtime
✅ 10–20 Early Adopter aktiv
```

---

## 💡 POST-MVP ROADMAP (Monat 2–3)

- [ ] Real-time messaging (WebSockets)
- [ ] Seller Analytics (Traffic, Conversion)
- [ ] Marketing Tools (Email campaigns, Analytics)
- [ ] Mobile App (React Native)
- [ ] Gefahrstoff-Integration (mit deinem Freelance-Geschäft)
- [ ] Internationalization (DE, EN, FR)
- [ ] Bulk Upload (CSV für Großhändler)
- [ ] Escrow Payments (Stripe Connect)

---

**Erstellt:** 2026-07-19  
**Letzte Änderung:** Laufend  
**Owner:** Josef Linder
