# Use Node.js image to build the app
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy files for build
COPY package*.json ./
COPY . .

# Run your custom build script
RUN chmod +x run.sh && ./run.sh

# Use Nginx to serve static content
FROM nginx:stable-alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy static site from builder
COPY --from=builder /app/out /var/www/out

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
