import { create } from "zustand";
import { apiClient } from "./api-client";

interface User {
  id: string;
  email: string;
  displayName: string;
  userType: "BUYER" | "SELLER" | "ADMIN";
  profilePictureUrl?: string;
  bio?: string;
}

interface AuthStore {
  user: User | null;
  token: string | null;
  isLoading: boolean;
  isLoggedIn: boolean;

  // Actions
  login: (email: string, password: string) => Promise<void>;
  register: (email: string, password: string, displayName: string, userType: string) => Promise<void>;
  logout: () => void;
  loadUser: () => Promise<void>;
  setUser: (user: User) => void;
}

export const useAuthStore = create<AuthStore>((set) => ({
  user: null,
  token: typeof window !== "undefined" ? localStorage.getItem("token") : null,
  isLoading: false,
  isLoggedIn: typeof window !== "undefined" ? !!localStorage.getItem("token") : false,

  login: async (email, password) => {
    set({ isLoading: true });
    try {
      const response = await apiClient.login(email, password);
      set({
        user: response.user,
        token: response.token,
        isLoggedIn: true,
        isLoading: false,
      });
    } catch (error) {
      set({ isLoading: false });
      throw error;
    }
  },

  register: async (email, password, displayName, userType) => {
    set({ isLoading: true });
    try {
      const response = await apiClient.register(email, password, displayName, userType);
      set({
        user: response.user,
        token: response.token,
        isLoggedIn: true,
        isLoading: false,
      });
    } catch (error) {
      set({ isLoading: false });
      throw error;
    }
  },

  logout: () => {
    apiClient.logout();
    set({
      user: null,
      token: null,
      isLoggedIn: false,
    });
  },

  loadUser: async () => {
    set({ isLoading: true });
    try {
      const user = await apiClient.getMe();
      set({
        user,
        isLoading: false,
      });
    } catch (error) {
      set({ isLoading: false });
      // User not logged in or token expired
    }
  },

  setUser: (user) => set({ user }),
}));

// Product Store
interface Product {
  id: string;
  title: string;
  price: number;
  images: string[];
  condition: string;
  sellerId: string;
}

interface ProductStore {
  products: Product[];
  isLoading: boolean;
  error: string | null;

  // Actions
  fetchProducts: (filters?: any) => Promise<void>;
  setProducts: (products: Product[]) => void;
  setLoading: (loading: boolean) => void;
  setError: (error: string | null) => void;
}

export const useProductStore = create<ProductStore>((set) => ({
  products: [],
  isLoading: false,
  error: null,

  fetchProducts: async (filters) => {
    set({ isLoading: true, error: null });
    try {
      const response = await apiClient.getProducts(filters);
      set({
        products: response.products || [],
        isLoading: false,
      });
    } catch (error: any) {
      set({
        error: error.message || "Failed to fetch products",
        isLoading: false,
      });
    }
  },

  setProducts: (products) => set({ products }),
  setLoading: (loading) => set({ isLoading: loading }),
  setError: (error) => set({ error }),
}));
