// app/auth/login/page.tsx
"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useAuthStore } from "@/lib/store";
import toast from "react-hot-toast";

export default function LoginPage() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const { login } = useAuthStore();
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);

    try {
      await login(email, password);
      toast.success("Login successful!");
      router.push("/");
    } catch (error: any) {
      toast.error(error.response?.data?.error || "Login failed");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h1 className="text-center text-4xl font-bold text-gray-900 mb-2">
            🛒 Marketplace
          </h1>
          <h2 className="text-center text-2xl font-bold text-gray-900">
            Login
          </h2>
          <p className="text-center text-gray-600 mt-2">
            Or{" "}
            <Link href="/auth/register" className="text-blue-600 hover:underline">
              create a new account
            </Link>
          </p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label className="block text-sm font-medium text-gray-900 mb-2">
              Email
            </label>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="you@example.com"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-900 mb-2">
              Password
            </label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              placeholder="••••••••"
            />
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-blue-600 text-white py-2 rounded-lg font-bold hover:bg-blue-700 disabled:opacity-50"
          >
            {loading ? "Logging in..." : "Login"}
          </button>
        </form>

        <div className="text-center">
          <a href="#" className="text-blue-600 hover:underline text-sm">
            Forgot your password?
          </a>
        </div>
      </div>
    </div>
  );
}

// ==========================================
// app/auth/register/page.tsx
// ==========================================
"use client";

// import { useState } from "react";
// import Link from "next/link";
// import { useRouter, useSearchParams } from "next/navigation";
// import { useAuthStore } from "@/lib/store";
// import toast from "react-hot-toast";
//
// export default function RegisterPage() {
//   const [formData, setFormData] = useState({
//     email: "",
//     password: "",
//     displayName: "",
//     userType: "BUYER",
//   });
//   const [loading, setLoading] = useState(false);
//   const { register } = useAuthStore();
//   const router = useRouter();
//   const searchParams = useSearchParams();
//   const typeParam = searchParams.get("type");
//
//   const handleChange = (
//     e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>
//   ) => {
//     const { name, value } = e.target;
//     setFormData((prev) => ({ ...prev, [name]: value }));
//   };
//
//   const handleSubmit = async (e: React.FormEvent) => {
//     e.preventDefault();
//     setLoading(true);
//
//     try {
//       await register(
//         formData.email,
//         formData.password,
//         formData.displayName,
//         formData.userType
//       );
//       toast.success("Account created!");
//       router.push(formData.userType === "SELLER" ? "/dashboard" : "/");
//     } catch (error: any) {
//       toast.error(error.response?.data?.error || "Registration failed");
//     } finally {
//       setLoading(false);
//     }
//   };
//
//   return (
//     <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4">
//       <div className="max-w-md w-full space-y-8">
//         <div>
//           <h1 className="text-center text-4xl font-bold text-gray-900 mb-2">
//             🛒 Marketplace
//           </h1>
//           <h2 className="text-center text-2xl font-bold text-gray-900">
//             Create Account
//           </h2>
//           <p className="text-center text-gray-600 mt-2">
//             Or{" "}
//             <Link href="/auth/login" className="text-blue-600 hover:underline">
//               login to your account
//             </Link>
//           </p>
//         </div>
//
//         <form onSubmit={handleSubmit} className="space-y-6">
//           <div>
//             <label className="block text-sm font-medium text-gray-900 mb-2">
//               Email
//             </label>
//             <input
//               type="email"
//               name="email"
//               value={formData.email}
//               onChange={handleChange}
//               required
//               className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
//               placeholder="you@example.com"
//             />
//           </div>
//
//           <div>
//             <label className="block text-sm font-medium text-gray-900 mb-2">
//               Display Name
//             </label>
//             <input
//               type="text"
//               name="displayName"
//               value={formData.displayName}
//               onChange={handleChange}
//               className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
//               placeholder="Your name"
//             />
//           </div>
//
//           <div>
//             <label className="block text-sm font-medium text-gray-900 mb-2">
//               Password
//             </label>
//             <input
//               type="password"
//               name="password"
//               value={formData.password}
//               onChange={handleChange}
//               required
//               className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
//               placeholder="••••••••"
//             />
//           </div>
//
//           <div>
//             <label className="block text-sm font-medium text-gray-900 mb-2">
//               I am a:
//             </label>
//             <select
//               name="userType"
//               value={formData.userType}
//               onChange={handleChange}
//               className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
//             >
//               <option value="BUYER">Buyer</option>
//               <option value="SELLER">Seller</option>
//             </select>
//           </div>
//
//           <button
//             type="submit"
//             disabled={loading}
//             className="w-full bg-blue-600 text-white py-2 rounded-lg font-bold hover:bg-blue-700 disabled:opacity-50"
//           >
//             {loading ? "Creating account..." : "Create Account"}
//           </button>
//         </form>
//       </div>
//     </div>
//   );
// }
