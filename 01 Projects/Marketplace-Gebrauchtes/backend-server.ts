import app from "./app.js";

const PORT = process.env.PORT || 4000;

app.listen(PORT, () => {
  console.log(`✓ Server running on http://localhost:${PORT}`);
  console.log(`✓ API base: http://localhost:${PORT}/api`);
  console.log(`✓ Health check: http://localhost:${PORT}/api/health`);
  console.log(`✓ Environment: ${process.env.NODE_ENV}`);
});
