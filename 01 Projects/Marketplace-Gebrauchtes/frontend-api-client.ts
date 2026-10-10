import axios, { AxiosInstance } from "axios";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:4000/api";

class APIClient {
  private client: AxiosInstance;

  constructor() {
    this.client = axios.create({
      baseURL: API_URL,
      headers: {
        "Content-Type": "application/json",
      },
    });

    // Add token to requests
    this.client.interceptors.request.use((config) => {
      const token = typeof window !== "undefined" ? localStorage.getItem("token") : null;
      if (token) {
        config.headers.Authorization = `Bearer ${token}`;
      }
      return config;
    });

    // Handle 401 - logout
    this.client.interceptors.response.use(
      (response) => response,
      (error) => {
        if (error.response?.status === 401) {
          if (typeof window !== "undefined") {
            localStorage.removeItem("token");
            window.location.href = "/auth/login";
          }
        }
        return Promise.reject(error);
      }
    );
  }

  // ============= AUTH =============

  async register(email: string, password: string, displayName: string, userType: string) {
    const { data } = await this.client.post("/auth/register", {
      email,
      password,
      displayName,
      userType,
    });
    if (data.token) {
      localStorage.setItem("token", data.token);
    }
    return data;
  }

  async login(email: string, password: string) {
    const { data } = await this.client.post("/auth/login", {
      email,
      password,
    });
    if (data.token) {
      localStorage.setItem("token", data.token);
    }
    return data;
  }

  async getMe() {
    const { data } = await this.client.get("/auth/me");
    return data;
  }

  logout() {
    localStorage.removeItem("token");
  }

  // ============= PRODUCTS =============

  async getProducts(filters?: {
    q?: string;
    category?: string;
    minPrice?: number;
    maxPrice?: number;
    limit?: number;
    offset?: number;
  }) {
    const { data } = await this.client.get("/products", { params: filters });
    return data;
  }

  async getProduct(id: string) {
    const { data } = await this.client.get(`/products/${id}`);
    return data;
  }

  async createProduct(productData: any) {
    const { data } = await this.client.post("/products", productData);
    return data;
  }

  async updateProduct(id: string, productData: any) {
    const { data } = await this.client.put(`/products/${id}`, productData);
    return data;
  }

  async deleteProduct(id: string) {
    const { data } = await this.client.delete(`/products/${id}`);
    return data;
  }

  async uploadProductImages(productId: string, images: File[]) {
    const formData = new FormData();
    images.forEach((image) => formData.append("images", image));

    const { data } = await this.client.post(
      `/products/${productId}/images`,
      formData,
      {
        headers: { "Content-Type": "multipart/form-data" },
      }
    );
    return data;
  }

  // ============= SELLERS =============

  async getSeller(id: string) {
    const { data } = await this.client.get(`/sellers/${id}`);
    return data;
  }

  async getSellerProducts(id: string) {
    const { data } = await this.client.get(`/sellers/${id}/products`);
    return data;
  }

  async getSellerReviews(id: string) {
    const { data } = await this.client.get(`/sellers/${id}/reviews`);
    return data;
  }

  // ============= MESSAGES =============

  async getConversations() {
    const { data } = await this.client.get("/messages");
    return data;
  }

  async getConversation(id: string) {
    const { data } = await this.client.get(`/messages/${id}`);
    return data;
  }

  async sendMessage(conversationId: string, content: string) {
    const { data } = await this.client.post(`/messages/${conversationId}/messages`, {
      content,
    });
    return data;
  }

  // ============= TRANSACTIONS =============

  async createTransaction(productId: string) {
    const { data } = await this.client.post("/transactions", { productId });
    return data;
  }

  async getTransaction(id: string) {
    const { data } = await this.client.get(`/transactions/${id}`);
    return data;
  }
}

export const apiClient = new APIClient();
