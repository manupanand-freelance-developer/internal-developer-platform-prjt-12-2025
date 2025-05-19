# # -------- Stage 1: Build --------
#     FROM docker.io/redhat/ubi9-minimal:latest AS builder

#     # Install required tools
#     RUN  microdnf install tar xz -y
    
#     # Install Node.js manually
#     RUN cd /opt && curl -L https://nodejs.org/dist/v22.14.0/node-v22.14.0-linux-x64.tar.xz | tar -xJ
#     ENV PATH="/opt/node-v22.14.0-linux-x64/bin:$PATH"
    
#     # Set working directory
#     WORKDIR /app
    
#     # Copy dependencies and install
#     COPY package*.json ./
#     RUN npm install
    
#     # Copy the rest of the app and build
#     COPY . .
#     ENV NEXT_DISABLE_APP_TOOLBAR=1
#     RUN npm run build
   
    
#     # # -------- Stage 2: Runtime --------
#     FROM docker.io/redhat/ubi9-minimal:latest
#     RUN  microdnf install tar xz -y
    
#     # Install Node.js again or copy from builder
#     RUN cd /opt && curl -L https://nodejs.org/dist/v22.14.0/node-v22.14.0-linux-x64.tar.xz | tar -xJ
#     ENV PATH="/opt/node-v22.14.0-linux-x64/bin:$PATH"
    
#     # Set workdir
#     WORKDIR /app
    
#     # Copy only production build from builder stage
#     COPY --from=builder /app/.next .next
#     COPY --from=builder /app/public public
#     COPY --from=builder /app/package.json package.json
#     COPY --from=builder /app/node_modules node_modules
#     COPY --from=builder /app/next.config.ts next.config.ts
    
     
#     EXPOSE 3000
    
#     CMD ["npm", "run", "start"]

# alpine build
# -------- Stage 1: Build --------
    FROM alpine:latest AS builder

    # Install required packages
    RUN apk add --no-cache curl tar xz nodejs npm
    
    # Set working directory
    WORKDIR /app
    
    # Copy dependencies and install
    COPY package*.json ./
    RUN npm install
    
    # Copy rest of app and build
    COPY . .
    ENV NEXT_DISABLE_APP_TOOLBAR=1
    RUN npm run build
    
    # -------- Stage 2: Runtime --------
    FROM alpine:latest
    
    # Install runtime dependencies (nodejs, npm)
    RUN apk add --no-cache nodejs npm
    
    # Set working directory
    WORKDIR /app
    
    # Copy built app from builder
    COPY --from=builder /app/.next .next
    COPY --from=builder /app/public public
    COPY --from=builder /app/package.json package.json
    COPY --from=builder /app/node_modules node_modules
    COPY --from=builder /app/next.config.ts next.config.ts
    
    EXPOSE 3000
    
    CMD ["npm", "run", "start"]
    
    