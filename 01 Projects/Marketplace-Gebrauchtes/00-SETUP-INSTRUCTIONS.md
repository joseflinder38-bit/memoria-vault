# 🚀 SETUP INSTRUCTIONS – Marketplace MVP

**Status:** 🔴 START (22.07.2026)  
**Ziel:** Lokales Setup & erste Tests  
**Zeit:** ~30 Minuten

---

## 📦 VORAUSSETZUNGEN

Installiert haben?

```
✅ Node.js 18+ (npm/yarn)
✅ PostgreSQL (lokal ODER cloud)
✅ Git
✅ Code-Editor (VS Code, etc.)
```

---

## 1️⃣ REPO KLONEN / ERSTELLEN

### Option A: GitHub Repo (empfohlen)

```bash
# Repo erstellen (https://github.com/new)
# Name: marketplace-mvp
# Public oder Private?

# Dann klonen:
git clone https://github.com/YOUR-USERNAME/marketplace-mvp.git
cd marketplace-mvp
```

### Option B: Lokal (ohne GitHub)

```bash
mkdir marketplace-mvp
cd marketplace-mvp
git init
```

---

## 2️⃣ STRUKTUR AUFBAUEN

```bash
# Root-Level Dateien
touch .gitignore README.md package.json

# Backend Ordner
mkdir -p backend/src/{controllers,routes,middleware,utils,types,db}
touch backend/.env.example backend/.gitignore

# Frontend Ordner
mkdir -p frontend/app/{auth,products,sellers,messages,admin,components}
touch frontend/.env.local.example frontend/.gitignore

# Dokumentation
mkdir -p docs
```

---

## 3️⃣ BACKEND SETUP

```bash
cd backend

# Node-Projekt initialisieren
npm init -y

# Dependencies installieren
npm install express cors dotenv prisma @prisma/client bcryptjs jsonwebtoken stripe cloudinary multer
npm install -D typescript @types/express @types/node @types/bcryptjs ts-node nodemon

# TypeScript Config
touch tsconfig.json

# Prisma Setup
npx prisma init
```

### `.env` (Backend)
```env
PORT=4000
NODE_ENV=development

# PostgreSQL
DATABASE_URL=postgresql://postgres:password@localhost:5432/marketplace_db

# JWT
JWT_SECRET=your_super_secret_key_change_in_production
JWT_EXPIRE=7d

# Stripe (Test Keys von https://dashboard.stripe.com)
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Cloudinary (von https://cloudinary.com)
CLOUDINARY_NAME=your_name
CLOUDINARY_API_KEY=your_key
CLOUDINARY_API_SECRET=your_secret
```

---

## 4️⃣ FRONTEND SETUP

```bash
cd ../frontend

# Next.js erstellen
npx create-next-app@latest . --ts --tailwind --eslint --app

# Dependencies hinzufügen
npm install axios zustand react-hot-toast stripe @stripe/react-js

# Environment
cp .env.local.example .env.local
```

### `.env.local` (Frontend)
```env
NEXT_PUBLIC_API_URL=http://localhost:4000/api
NEXT_PUBLIC_APP_URL=http://localhost:3000

# Stripe Public Key (von Dashboard)
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=pk_test_...

# Cloudinary
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=your_name
```

---

## 5️⃣ DATABASE SETUP

### Lokal (PostgreSQL)

```bash
# Wenn PostgreSQL läuft:
createdb marketplace_db

# Oder mit Docker:
docker run --name marketplace-postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=marketplace_db \
  -p 5432:5432 \
  -d postgres:15
```

### Cloud (Supabase/Railway)
- Registrieren bei https://supabase.com oder https://railway.app
- Database erstellen
- Connection String in `.env` eintragen

---

## 6️⃣ ERSTE MIGRATION

```bash
cd backend

# Prisma Schema überprüfen
cat prisma/schema.prisma

# Migration erstellen
npx prisma migrate dev --name init

# Prisma Studio (optional, zum Daten browsen)
npx prisma studio
```

---

## 7️⃣ SERVERS STARTEN

### Terminal 1: Backend

```bash
cd backend
npm run dev

# Output sollte sein:
# ✓ Server running on http://localhost:4000
```

### Terminal 2: Frontend

```bash
cd frontend
npm run dev

# Output sollte sein:
# ✓ Ready on http://localhost:3000
```

---

## ✅ TEST: Alles funktioniert?

### Backend Health Check

```bash
curl http://localhost:4000/api/health
# Response: { "status": "OK", "timestamp": "..." }
```

### Frontend Check

```
Öffne: http://localhost:3000
Sollte sehen: Homepage mit Search Bar
```

---

## 📝 CHECKLISTE VOLLSTÄNDIG?

```
✅ Node.js / npm installiert
✅ PostgreSQL läuft (lokal oder Cloud)
✅ Repo-Struktur erstellt
✅ Backend Dependencies: npm install ✓
✅ Frontend: npx create-next-app ✓
✅ .env Dateien erstellt
✅ Database migrations: npx prisma migrate ✓
✅ Backend läuft auf :4000
✅ Frontend läuft auf :3000
✅ Health Check OK
```

**WENN JA:** Du bist ready! Geh zu nächster Phase.  
**WENN NEIN:** Schreib mir welcher Punkt nicht funktioniert.

---

## 🐛 TROUBLESHOOTING

### "PORT 4000 in use"
```bash
# Finde Prozess
lsof -i :4000

# Oder nutze anderen Port:
PORT=5000 npm run dev
```

### "DATABASE_URL Error"
```bash
# Check PostgreSQL läuft
psql -U postgres

# Oder Supabase Connection String checken
```

### "npm install fails"
```bash
rm -rf node_modules package-lock.json
npm install
```

---

**Nächster Schritt:** Wenn alles läuft → mir Bescheid geben → Ich baue erste Features!

---

**Status:** 🚀 READY TO BUILD  
**Kontakt:** Falls Fehler → schreib mir
