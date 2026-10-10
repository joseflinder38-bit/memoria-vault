// app/page.tsx
"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { apiClient } from "@/lib/api-client";
import { useAuthStore } from "@/lib/store";

export default function HomePage() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);
  const { user } = useAuthStore();

  useEffect(() => {
    const loadProducts = async () => {
      try {
        const data = await apiClient.getProducts({ limit: 12 });
        setProducts(data.products || []);
      } catch (error) {
        console.error("Failed to fetch products:", error);
      } finally {
        setLoading(false);
      }
    };

    loadProducts();
  }, []);

  return (
    <div>
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-blue-600 to-blue-800 text-white py-16">
        <div className="max-w-7xl mx-auto px-4">
          <h1 className="text-5xl font-bold mb-4">
            🛒 Buy & Sell Used Tech & Jewelry
          </h1>
          <p className="text-xl mb-8 text-blue-100">
            Trusted marketplace for second-hand technology and jewelry. Safe,
            secure, and simple.
          </p>
          <div className="flex gap-4">
            <Link
              href="/browse"
              className="bg-white text-blue-600 px-6 py-3 rounded-lg font-bold hover:bg-blue-50"
            >
              Browse Products
            </Link>
            {user?.userType === "SELLER" ? (
              <Link
                href="/products/upload"
                className="bg-green-500 text-white px-6 py-3 rounded-lg font-bold hover:bg-green-600"
              >
                List a Product
              </Link>
            ) : (
              <Link
                href="/auth/register?type=seller"
                className="bg-green-500 text-white px-6 py-3 rounded-lg font-bold hover:bg-green-600"
              >
                Start Selling
              </Link>
            )}
          </div>
        </div>
      </section>

      {/* Search Section */}
      <section className="bg-gray-50 py-8">
        <div className="max-w-7xl mx-auto px-4">
          <div className="flex gap-4">
            <input
              type="text"
              placeholder="Search products, brands..."
              className="flex-1 px-4 py-3 border border-gray-300 rounded-lg"
            />
            <button className="bg-blue-600 text-white px-6 py-3 rounded-lg font-bold hover:bg-blue-700">
              Search
            </button>
          </div>
        </div>
      </section>

      {/* Categories */}
      <section className="py-12">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8">Popular Categories</h2>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {[
              { name: "Smartphones", emoji: "📱" },
              { name: "Laptops", emoji: "💻" },
              { name: "Jewelry", emoji: "💎" },
              { name: "Tablets", emoji: "📊" },
            ].map((cat) => (
              <Link
                key={cat.name}
                href={`/browse?category=${cat.name.toLowerCase()}`}
                className="border border-gray-300 rounded-lg p-6 text-center hover:shadow-lg transition cursor-pointer"
              >
                <div className="text-4xl mb-2">{cat.emoji}</div>
                <p className="font-bold text-gray-900">{cat.name}</p>
              </Link>
            ))}
          </div>
        </div>
      </section>

      {/* Featured Products */}
      <section className="py-12 bg-gray-50">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8">Latest Listings</h2>

          {loading ? (
            <div className="text-center py-12">
              <p className="text-gray-500">Loading products...</p>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              {products.length > 0 ? (
                products.map((product: any) => (
                  <Link
                    key={product.id}
                    href={`/products/${product.id}`}
                    className="bg-white border border-gray-200 rounded-lg overflow-hidden hover:shadow-lg transition"
                  >
                    <div className="bg-gray-300 h-48 flex items-center justify-center">
                      {product.images?.[0] ? (
                        <img
                          src={product.images[0]}
                          alt={product.title}
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <span className="text-gray-500">No image</span>
                      )}
                    </div>
                    <div className="p-4">
                      <h3 className="font-bold text-gray-900 truncate mb-2">
                        {product.title}
                      </h3>
                      <p className="text-2xl font-bold text-green-600 mb-2">
                        €{product.price}
                      </p>
                      <div className="flex justify-between text-sm text-gray-500">
                        <span className="bg-gray-100 px-2 py-1 rounded">
                          {product.condition}
                        </span>
                        <span>{product.location}</span>
                      </div>
                    </div>
                  </Link>
                ))
              ) : (
                <div className="col-span-4 text-center py-12">
                  <p className="text-gray-500">No products found</p>
                </div>
              )}
            </div>
          )}

          <div className="text-center mt-12">
            <Link
              href="/browse"
              className="inline-block bg-blue-600 text-white px-8 py-3 rounded-lg font-bold hover:bg-blue-700"
            >
              View All Products
            </Link>
          </div>
        </div>
      </section>

      {/* How It Works */}
      <section className="py-12">
        <div className="max-w-7xl mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8 text-center">How It Works</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="text-center">
              <div className="bg-blue-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">🔍</span>
              </div>
              <h3 className="font-bold text-lg mb-2">Browse & Search</h3>
              <p className="text-gray-600">
                Find thousands of listings for electronics, jewelry, and more.
              </p>
            </div>
            <div className="text-center">
              <div className="bg-green-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">💬</span>
              </div>
              <h3 className="font-bold text-lg mb-2">Message Sellers</h3>
              <p className="text-gray-600">
                Connect directly with sellers to ask questions or negotiate.
              </p>
            </div>
            <div className="text-center">
              <div className="bg-purple-100 w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4">
                <span className="text-2xl">✅</span>
              </div>
              <h3 className="font-bold text-lg mb-2">Buy Safely</h3>
              <p className="text-gray-600">
                Secure payments and seller ratings ensure a safe transaction.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  );
}
