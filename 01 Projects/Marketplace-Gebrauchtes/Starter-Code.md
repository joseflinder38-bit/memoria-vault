# 💻 Starter-Code & Boilerplate

**Status:** 🔵 VORLAGE  
**Zweck:** Schnelle Setup & erste Functions

---

## 🚀 QUICK START (Option A: Next.js + Node.js)

### 1. Frontend (Next.js) Setup

```bash
# Projekt erstellen
npx create-next-app@latest marketplace --ts --tailwind

# In den Ordner gehen
cd marketplace

# Dev-Server starten
npm run dev
```

### 2. `.env.local` erstellen

```env
# API
NEXT_PUBLIC_API_URL=http://localhost:4000/api
NEXT_PUBLIC_APP_URL=http://localhost:3000

# Stripe (Test Keys)
NEXT_PUBLIC_STRIPE_PUBLIC_KEY=pk_test_xxx...
STRIPE_SECRET_KEY=sk_test_xxx...

# Cloudinary
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=xxx
CLOUDINARY_API_SECRET=xxx

# NextAuth (für Auth)
NEXTAUTH_SECRET=your_secret_key_here
NEXTAUTH_URL=http://localhost:3000
```

---

### 3. Backend (Node.js) Setup

```bash
# Ordner erstellen
mkdir marketplace-api
cd marketplace-api

# Node-Projekt
npm init -y

# Dependencies installieren
npm install express cors dotenv prisma @prisma/client bcryptjs jsonwebtoken stripe cloudinary multer
npm install -D typescript @types/express @types/node @types/bcryptjs ts-node nodemon
```

### 4. `tsconfig.json` (TypeScript)

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "declaration": true,
    "declarationMap": true,
    "sourceMap": true,
    "noImplicitAny": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

### 5. Backend `.env` erstellen

```env
# Server
PORT=4000
NODE_ENV=development

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/marketplace_db

# JWT
JWT_SECRET=your_super_secret_jwt_key_here
JWT_EXPIRE=7d

# Stripe
STRIPE_SECRET_KEY=sk_test_xxx...
STRIPE_WEBHOOK_SECRET=whsec_xxx...

# Cloudinary
CLOUDINARY_NAME=xxx
CLOUDINARY_API_KEY=xxx
CLOUDINARY_API_SECRET=xxx
```

---

## 🏗️ FOLDER STRUCTURE (Backend)

```
marketplace-api/
├── src/
│   ├── controllers/      # Business logic
│   │   ├── auth.ts
│   │   ├── products.ts
│   │   ├── sellers.ts
│   │   ├── messages.ts
│   │   └── transactions.ts
│   ├── routes/           # API routes
│   │   ├── auth.ts
│   │   ├── products.ts
│   │   ├── sellers.ts
│   │   ├── messages.ts
│   │   └── transactions.ts
│   ├── middleware/       # Auth, error handling
│   │   ├── auth.ts
│   │   └── errorHandler.ts
│   ├── types/            # TypeScript interfaces
│   │   ├── user.ts
│   │   ├── product.ts
│   │   └── transaction.ts
│   ├── utils/            # Helper functions
│   │   ├── jwt.ts
│   │   ├── cloudinary.ts
│   │   └── stripe.ts
│   ├── db/               # Database connection
│   │   └── prisma.ts
│   └── app.ts            # Express app setup
├── prisma/
│   └── schema.prisma     # Database schema
├── .env
├── .gitignore
├── package.json
├── tsconfig.json
└── server.ts             # Entry point
```

---

## 📝 CODE SNIPPETS

### Backend: `src/app.ts`

```typescript
import express, { Express, Request, Response, NextFunction } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import authRoutes from './routes/auth';
import productRoutes from './routes/products';
import sellerRoutes from './routes/sellers';

dotenv.config();

const app: Express = express();

// Middleware
app.use(cors({
  origin: process.env.NEXT_PUBLIC_APP_URL,
  credentials: true
}));
app.use(express.json());
app.use(express.urlencoded({ limit: '50mb', extended: true }));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api/products', productRoutes);
app.use('/api/sellers', sellerRoutes);

// Health check
app.get('/api/health', (req: Request, res: Response) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Error handler
app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
  console.error(err);
  res.status(500).json({ 
    error: process.env.NODE_ENV === 'production' 
      ? 'Internal server error' 
      : err.message 
  });
});

export default app;
```

### Backend: `src/utils/jwt.ts`

```typescript
import jwt from 'jsonwebtoken';

export interface TokenPayload {
  userId: string;
  email: string;
  userType: 'buyer' | 'seller' | 'admin';
}

export const generateToken = (payload: TokenPayload): string => {
  return jwt.sign(payload, process.env.JWT_SECRET!, {
    expiresIn: process.env.JWT_EXPIRE || '7d'
  });
};

export const verifyToken = (token: string): TokenPayload | null => {
  try {
    return jwt.verify(token, process.env.JWT_SECRET!) as TokenPayload;
  } catch (error) {
    return null;
  }
};
```

### Backend: `src/middleware/auth.ts`

```typescript
import { Request, Response, NextFunction } from 'express';
import { verifyToken, TokenPayload } from '../utils/jwt';

declare global {
  namespace Express {
    interface Request {
      user?: TokenPayload;
    }
  }
}

export const authenticateToken = (
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  const authHeader = req.headers['authorization'];
  const token = authHeader?.split(' ')[1]; // "Bearer TOKEN"

  if (!token) {
    res.status(401).json({ error: 'No token provided' });
    return;
  }

  const payload = verifyToken(token);
  if (!payload) {
    res.status(403).json({ error: 'Invalid token' });
    return;
  }

  req.user = payload;
  next();
};

export const authorizeRole = (...roles: string[]) => {
  return (req: Request, res: Response, next: NextFunction): void => {
    if (!req.user || !roles.includes(req.user.userType)) {
      res.status(403).json({ error: 'Forbidden' });
      return;
    }
    next();
  };
};
```

### Backend: `src/controllers/auth.ts`

```typescript
import { Request, Response } from 'express';
import bcryptjs from 'bcryptjs';
import { PrismaClient } from '@prisma/client';
import { generateToken } from '../utils/jwt';

const prisma = new PrismaClient();

export const register = async (req: Request, res: Response): Promise<void> => {
  try {
    const { email, password, displayName, userType } = req.body;

    // Validate input
    if (!email || !password) {
      res.status(400).json({ error: 'Email and password required' });
      return;
    }

    // Check if user exists
    const existingUser = await prisma.users.findUnique({ where: { email } });
    if (existingUser) {
      res.status(409).json({ error: 'Email already registered' });
      return;
    }

    // Hash password
    const passwordHash = await bcryptjs.hash(password, 10);

    // Create user
    const user = await prisma.users.create({
      data: {
        email,
        password_hash: passwordHash,
        display_name: displayName || email.split('@')[0],
        user_type: userType || 'buyer'
      }
    });

    // Generate token
    const token = generateToken({
      userId: user.id,
      email: user.email,
      userType: user.user_type
    });

    res.status(201).json({
      message: 'User registered successfully',
      token,
      user: {
        id: user.id,
        email: user.email,
        displayName: user.display_name,
        userType: user.user_type
      }
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({ error: 'Registration failed' });
  }
};

export const login = async (req: Request, res: Response): Promise<void> => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      res.status(400).json({ error: 'Email and password required' });
      return;
    }

    const user = await prisma.users.findUnique({ where: { email } });
    if (!user) {
      res.status(401).json({ error: 'Invalid credentials' });
      return;
    }

    const passwordMatch = await bcryptjs.compare(password, user.password_hash);
    if (!passwordMatch) {
      res.status(401).json({ error: 'Invalid credentials' });
      return;
    }

    const token = generateToken({
      userId: user.id,
      email: user.email,
      userType: user.user_type
    });

    res.json({
      message: 'Login successful',
      token,
      user: {
        id: user.id,
        email: user.email,
        displayName: user.display_name,
        userType: user.user_type
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Login failed' });
  }
};
```

### Frontend: `app/page.tsx` (Homepage)

```typescript
'use client';

import Link from 'next/link';
import { useState, useEffect } from 'react';

export default function Home() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const response = await fetch(
          `${process.env.NEXT_PUBLIC_API_URL}/products?limit=12`
        );
        const data = await response.json();
        setProducts(data.products || []);
      } catch (error) {
        console.error('Failed to fetch products:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  return (
    <div className="min-h-screen bg-white">
      {/* Header */}
      <header className="bg-blue-600 text-white py-8">
        <div className="max-w-7xl mx-auto px-4">
          <h1 className="text-4xl font-bold mb-4">
            🛒 Second-Hand Marketplace
          </h1>
          <p className="text-xl mb-6">
            Buy & Sell gebrauchte Technologie und Schmuck
          </p>
          <div className="flex gap-4">
            <Link href="/browse" className="bg-white text-blue-600 px-6 py-2 rounded font-bold hover:bg-gray-100">
              Browse Products
            </Link>
            <Link href="/products/upload" className="bg-green-500 text-white px-6 py-2 rounded font-bold hover:bg-green-600">
              Sell Now
            </Link>
          </div>
        </div>
      </header>

      {/* Search Bar */}
      <div className="bg-gray-100 py-6">
        <div className="max-w-7xl mx-auto px-4">
          <input
            type="text"
            placeholder="Search for products..."
            className="w-full px-4 py-3 rounded border"
          />
        </div>
      </div>

      {/* Featured Products */}
      <section className="max-w-7xl mx-auto px-4 py-12">
        <h2 className="text-3xl font-bold mb-8">Featured Listings</h2>
        
        {loading ? (
          <p>Loading...</p>
        ) : (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {products.map((product: any) => (
              <Link key={product.id} href={`/products/${product.id}`}>
                <div className="border rounded p-4 hover:shadow-lg transition cursor-pointer">
                  <div className="bg-gray-200 h-48 mb-4 rounded flex items-center justify-center">
                    {product.image_url ? (
                      <img src={product.image_url} alt={product.title} className="h-full object-cover" />
                    ) : (
                      <span className="text-gray-400">No image</span>
                    )}
                  </div>
                  <h3 className="font-bold mb-2">{product.title}</h3>
                  <p className="text-2xl font-bold text-green-600">
                    €{product.price}
                  </p>
                  <p className="text-sm text-gray-500">{product.condition}</p>
                </div>
              </Link>
            ))}
          </div>
        )}
      </section>
    </div>
  );
}
```

### Frontend: `app/auth/register/page.tsx` (Signup)

```typescript
'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function RegisterPage() {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    displayName: '',
    userType: 'buyer'
  });
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    const { name, value } = e.target;
    setFormData(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/auth/register`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || 'Registration failed');
        return;
      }

      // Save token to localStorage
      localStorage.setItem('token', data.token);

      // Redirect to dashboard
      if (formData.userType === 'seller') {
        router.push('/dashboard');
      } else {
        router.push('/browse');
      }
    } catch (err) {
      setError('Network error');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="max-w-md mx-auto py-12 px-4">
      <h1 className="text-3xl font-bold mb-8">Create Account</h1>

      {error && <div className="bg-red-100 text-red-700 p-4 rounded mb-4">{error}</div>}

      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block mb-2 font-bold">Email</label>
          <input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleChange}
            required
            className="w-full px-4 py-2 border rounded"
          />
        </div>

        <div>
          <label className="block mb-2 font-bold">Password</label>
          <input
            type="password"
            name="password"
            value={formData.password}
            onChange={handleChange}
            required
            className="w-full px-4 py-2 border rounded"
          />
        </div>

        <div>
          <label className="block mb-2 font-bold">Display Name</label>
          <input
            type="text"
            name="displayName"
            value={formData.displayName}
            onChange={handleChange}
            className="w-full px-4 py-2 border rounded"
          />
        </div>

        <div>
          <label className="block mb-2 font-bold">I am a:</label>
          <select
            name="userType"
            value={formData.userType}
            onChange={handleChange}
            className="w-full px-4 py-2 border rounded"
          >
            <option value="buyer">Buyer</option>
            <option value="seller">Seller</option>
          </select>
        </div>

        <button
          type="submit"
          disabled={loading}
          className="w-full bg-blue-600 text-white py-2 rounded font-bold hover:bg-blue-700 disabled:opacity-50"
        >
          {loading ? 'Creating account...' : 'Create Account'}
        </button>
      </form>

      <p className="mt-4 text-center">
        Already have an account?{' '}
        <a href="/auth/login" className="text-blue-600 font-bold hover:underline">
          Login
        </a>
      </p>
    </div>
  );
}
```

---

## 📦 PRISMA SCHEMA (Auszug)

**`prisma/schema.prisma`**

```prisma
// This is your Prisma schema file,
// learn more about it in the docs: https://pris.ly/d/prisma-schema

generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model Users {
  id String @id @default(cuid())
  email String @unique
  password_hash String
  display_name String?
  profile_picture_url String?
  user_type String @default("buyer") // buyer, seller, admin
  kyc_verified Boolean @default(false)
  kyc_verified_at DateTime?
  bio String?
  phone String?
  created_at DateTime @default(now())
  updated_at DateTime @updatedAt

  products Product[]
  seller_profile Sellers?
  conversations_as_buyer Conversations[] @relation("buyer")
  conversations_as_seller Conversations[] @relation("seller")
  messages Messages[] @relation("sender")
  messages_received Messages[] @relation("receiver")
  transactions_as_buyer Transactions[] @relation("buyer")
  transactions_as_seller Transactions[] @relation("seller")
  reviews_written Reviews[] @relation("reviewer")
  reviews_received Reviews[] @relation("reviewed")
}

model Sellers {
  id String @id @default(cuid())
  user_id String @unique
  user Users @relation(fields: [user_id], references: [id], onDelete: Cascade)
  shop_name String @unique
  description String?
  rating Decimal @default(0) @db.Decimal(3, 2)
  total_reviews Int @default(0)
  response_time_hours Int?
  verified_badge Boolean @default(false)
  business_type String @default("private") // private, company
  company_name String?
  tax_id String?
  bank_account String?
  created_at DateTime @default(now())

  products Product[]
}

model Product {
  id String @id @default(cuid())
  seller_id String
  seller Sellers @relation(fields: [seller_id], references: [id], onDelete: Cascade)
  title String
  description String?
  category String
  subcategory String?
  condition String @default("good") // new, like_new, good, fair, poor
  price Decimal @db.Decimal(10, 2)
  currency String @default("EUR")
  location String?
  latitude Decimal? @db.Decimal(10, 8)
  longitude Decimal? @db.Decimal(11, 8)
  views Int @default(0)
  status String @default("active") // active, sold, hidden, flagged
  created_at DateTime @default(now())
  updated_at DateTime @updatedAt
  expires_at DateTime?

  images ProductImage[]
  messages Messages[]
  transactions Transactions[]
}

model ProductImage {
  id String @id @default(cuid())
  product_id String
  product Product @relation(fields: [product_id], references: [id], onDelete: Cascade)
  image_url String
  display_order Int @default(0)
  uploaded_at DateTime @default(now())
}

// ... Rest der Schema (Messages, Transactions, Reviews, etc.)
```

---

## 🔄 PACKAGE.JSON (Start-Script)

```json
{
  "name": "marketplace-api",
  "version": "1.0.0",
  "main": "dist/server.js",
  "scripts": {
    "dev": "nodemon --exec ts-node src/server.ts",
    "build": "tsc",
    "start": "node dist/server.js",
    "test": "jest",
    "lint": "eslint src/**/*.ts",
    "db:push": "prisma db push",
    "db:generate": "prisma generate",
    "db:seed": "ts-node prisma/seed.ts"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "dotenv": "^16.0.3",
    "prisma": "^5.0.0",
    "@prisma/client": "^5.0.0",
    "bcryptjs": "^2.4.3",
    "jsonwebtoken": "^9.0.0",
    "stripe": "^12.0.0",
    "cloudinary": "^1.32.0",
    "multer": "^1.4.5"
  },
  "devDependencies": {
    "typescript": "^5.0.0",
    "@types/express": "^4.17.17",
    "@types/node": "^20.0.0",
    "@types/bcryptjs": "^2.4.2",
    "ts-node": "^10.9.1",
    "nodemon": "^3.0.1",
    "@types/jest": "^29.5.0",
    "jest": "^29.5.0",
    "ts-jest": "^29.1.0"
  }
}
```

---

## 🚀 ERSTE BEFEHLE (Zum Starten)

```bash
# Backend
cd marketplace-api
npm install
npm run dev

# Frontend (in anderem Terminal)
cd marketplace
npm run dev
```

Dann öffne `http://localhost:3000` im Browser! 🎉

---

**Hinweis:** Dies sind Vorlagen/Beispiele. Anpassungen je nach deinen Anforderungen nötig!
