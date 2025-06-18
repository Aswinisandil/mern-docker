# ---- Step 1: Build React frontend ----
FROM node:18 AS frontend-build

WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm install

COPY frontend/ ./
RUN npm run build


# ---- Step 2: Build backend and serve frontend ----
FROM node:18

WORKDIR /app

# Copy server files
COPY backend/package*.json ./
RUN npm install

COPY backend/ ./

# Copy built frontend from previous stage
COPY --from=frontend-build /app/frontend/build ./public

# Optional: expose backend port
EXPOSE 8000

CMD ["node", "index.js.js"]
