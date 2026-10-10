import { Response } from "express";
import { PrismaClient } from "@prisma/client";
import { generateToken, hashPassword, comparePassword } from "../utils/jwt.js";
import { AuthenticatedRequest } from "../middleware/auth.js";

const prisma = new PrismaClient();

export const register = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  try {
    const { email, password, displayName, userType } = req.body;

    // Validation
    if (!email || !password) {
      res.status(400).json({ error: "Email and password required" });
      return;
    }

    if (password.length < 6) {
      res.status(400).json({ error: "Password must be at least 6 characters" });
      return;
    }

    // Check if user already exists
    const existingUser = await prisma.user.findUnique({
      where: { email },
    });

    if (existingUser) {
      res.status(409).json({ error: "Email already registered" });
      return;
    }

    // Hash password
    const passwordHash = await hashPassword(password);

    // Create user
    const user = await prisma.user.create({
      data: {
        email,
        passwordHash,
        displayName: displayName || email.split("@")[0],
        userType: userType || "BUYER",
      },
    });

    // Generate token
    const token = generateToken({
      userId: user.id,
      email: user.email,
      userType: user.userType as "BUYER" | "SELLER" | "ADMIN",
    });

    res.status(201).json({
      message: "User registered successfully",
      token,
      user: {
        id: user.id,
        email: user.email,
        displayName: user.displayName,
        userType: user.userType,
      },
    });
  } catch (error) {
    console.error("Registration error:", error);
    res.status(500).json({ error: "Registration failed" });
  }
};

export const login = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      res.status(400).json({ error: "Email and password required" });
      return;
    }

    // Find user
    const user = await prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      res.status(401).json({ error: "Invalid credentials" });
      return;
    }

    // Check password
    const passwordMatch = await comparePassword(password, user.passwordHash);

    if (!passwordMatch) {
      res.status(401).json({ error: "Invalid credentials" });
      return;
    }

    // Generate token
    const token = generateToken({
      userId: user.id,
      email: user.email,
      userType: user.userType as "BUYER" | "SELLER" | "ADMIN",
    });

    res.json({
      message: "Login successful",
      token,
      user: {
        id: user.id,
        email: user.email,
        displayName: user.displayName,
        userType: user.userType,
      },
    });
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ error: "Login failed" });
  }
};

export const me = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  try {
    if (!req.user) {
      res.status(401).json({ error: "Not authenticated" });
      return;
    }

    const user = await prisma.user.findUnique({
      where: { id: req.user.userId },
      select: {
        id: true,
        email: true,
        displayName: true,
        userType: true,
        profilePictureUrl: true,
        bio: true,
        createdAt: true,
      },
    });

    if (!user) {
      res.status(404).json({ error: "User not found" });
      return;
    }

    res.json(user);
  } catch (error) {
    console.error("Get user error:", error);
    res.status(500).json({ error: "Failed to get user" });
  }
};
