# Stage 1: Build React app (Frontend)
FROM node:18-alpine AS frontend-build

# Set working directory
WORKDIR /app/frontend

# Copy frontend dependencies
COPY frontend/package*.json ./

# Install frontend dependencies
RUN npm install

# Copy frontend source code
COPY frontend/ .

# Build the React app
RUN npm run build

# Stage 2: Setup backend (Express server)
FROM node:18-alpine

# Set working directory
WORKDIR /app/backend

# Copy backend dependencies
COPY backend/package*.json ./

# Install backend dependencies
RUN npm install --production

# Copy backend source code
COPY backend/ .

# Copy the built React app from the previous stage to the backend public directory
COPY --from=frontend-build /app/frontend/build ./public

# Expose the port (adjust if your backend uses a different port)
EXPOSE 5001

# Start the backend server
CMD ["node", "server.js"]