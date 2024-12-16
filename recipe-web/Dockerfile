# Stage 1: Build the Nuxt.js application
FROM node:20.5.1-slim AS builder

# Set environment variables
ENV NODE_OPTIONS=--openssl-legacy-provider

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies with legacy-peer-deps
RUN npm install --legacy-peer-deps

# Copy the rest of the application files
COPY . .

# Build the Nuxt.js static site
RUN npm run generate

# Stage 2: Serve the application using Nginx
FROM nginx:alpine

# Set environment variable for backend API base URL
ENV API_BASE_URL="http://localhost:3000"

# Copy the generated static files from the build stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy a custom Nginx configuration if needed
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
