import express from "express";
import { register, login, me } from "../controllers/auth.js";
import { authenticateToken, errorHandler } from "../middleware/auth.js";

const router = express.Router();

// Public routes
router.post("/register", errorHandler(register));
router.post("/login", errorHandler(login));

// Protected routes
router.get("/me", authenticateToken, errorHandler(me));

export default router;
