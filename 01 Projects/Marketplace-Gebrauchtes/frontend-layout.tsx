// app/layout.tsx
"use client";

import type { Metadata } from "next";
import { Toaster } from "react-hot-toast";
import { useAuthStore } from "@/lib/store";
import { useEffect } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import "./globals.css";

// Metadata only works in server components, remove for client component
// export const metadata: Metadata = {
//   title: "Marketplace – Buy & Sell Used Tech & Jewelry",
//   description: "Second-hand marketplace for technology and jewelry",
// };

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const { user, loadUser, logout, isLoggedIn } = useAuthStore();
  const pathname = usePathname();

  useEffect(() => {
    loadUser();
  }, [loadUser]);

  const isAuthPage = pathname?.startsWith("/auth");

  return (
    <html lang="en">
      <body className="bg-white">
        {/* Navigation */}
        {!isAuthPage && (
          <nav className="bg-white border-b border-gray-200 sticky top-0 z-50">
            <div className="max-w-7xl mx-auto px-4 py-4 flex justify-between items-center">
              {/* Logo */}
              <Link href="/" className="text-2xl font-bold text-blue-600">
                🛒 Marketplace
              </Link>

              {/* Search Bar (Center) */}
              <div className="hidden md:block flex-1 mx-8">
                <input
                  type="text"
                  placeholder="Search products..."
                  className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
              </div>

              {/* Right Menu */}
              <div className="flex gap-4 items-center">
                <Link href="/browse" className="text-gray-700 hover:text-blue-600">
                  Browse
                </Link>

                {isLoggedIn ? (
                  <>
                    <Link href="/messages" className="text-gray-700 hover:text-blue-600">
                      Messages
                    </Link>
                    <Link href="/profile" className="text-gray-700 hover:text-blue-600">
                      Profile
                    </Link>
                    {user?.userType === "SELLER" && (
                      <Link href="/dashboard" className="text-gray-700 hover:text-blue-600">
                        Dashboard
                      </Link>
                    )}
                    <button
                      onClick={logout}
                      className="text-gray-700 hover:text-red-600"
                    >
                      Logout
                    </button>
                  </>
                ) : (
                  <>
                    <Link
                      href="/auth/login"
                      className="text-gray-700 hover:text-blue-600"
                    >
                      Login
                    </Link>
                    <Link
                      href="/auth/register"
                      className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
                    >
                      Sign Up
                    </Link>
                  </>
                )}

                {isLoggedIn && user?.userType === "SELLER" && (
                  <Link
                    href="/products/upload"
                    className="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
                  >
                    + Sell
                  </Link>
                )}
              </div>
            </div>
          </nav>
        )}

        {/* Main Content */}
        <main>{children}</main>

        {/* Footer */}
        {!isAuthPage && (
          <footer className="bg-gray-900 text-white py-12 mt-16">
            <div className="max-w-7xl mx-auto px-4 grid grid-cols-4 gap-8">
              <div>
                <h3 className="font-bold mb-4">About</h3>
                <ul className="text-gray-400 space-y-2">
                  <li><a href="#" className="hover:text-white">About Us</a></li>
                  <li><a href="#" className="hover:text-white">Blog</a></li>
                  <li><a href="#" className="hover:text-white">Careers</a></li>
                </ul>
              </div>
              <div>
                <h3 className="font-bold mb-4">Support</h3>
                <ul className="text-gray-400 space-y-2">
                  <li><a href="#" className="hover:text-white">Help Center</a></li>
                  <li><a href="#" className="hover:text-white">Contact Us</a></li>
                  <li><a href="#" className="hover:text-white">Safety</a></li>
                </ul>
              </div>
              <div>
                <h3 className="font-bold mb-4">Legal</h3>
                <ul className="text-gray-400 space-y-2">
                  <li><a href="#" className="hover:text-white">Terms</a></li>
                  <li><a href="#" className="hover:text-white">Privacy</a></li>
                  <li><a href="#" className="hover:text-white">Cookies</a></li>
                </ul>
              </div>
              <div>
                <h3 className="font-bold mb-4">Follow</h3>
                <ul className="text-gray-400 space-y-2">
                  <li><a href="#" className="hover:text-white">Twitter</a></li>
                  <li><a href="#" className="hover:text-white">Facebook</a></li>
                  <li><a href="#" className="hover:text-white">Instagram</a></li>
                </ul>
              </div>
            </div>
            <div className="border-t border-gray-800 mt-8 pt-8 text-center text-gray-400">
              <p>&copy; 2026 Marketplace. All rights reserved.</p>
            </div>
          </footer>
        )}

        {/* Toast Notifications */}
        <Toaster />
      </body>
    </html>
  );
}
