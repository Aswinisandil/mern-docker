# Step 1: Build React frontend
FROM node:18 AS build

WORKDIR /app

COPY frontend ./frontend
RUN cd frontend && npm install && npm run build

# Step 2: Build backend and serve frontend
FROM node:18

WORKDIR /app

# Copy backend code
COPY backend ./backend
COPY package*.json ./
RUN npm install

# Copy frontend build into backend's public folder
COPY --from=build /app/frontend/build ./backend/public

# Set working dir to backend
WORKDIR /app/backend

EXPOSE 8000

CMD ["node", "index.js"]
