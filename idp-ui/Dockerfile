# ---------- Stage 1: Build ----------
FROM docker.io/redhat/ubi9-minimal:latest AS builder

# Install necessary tools
RUN microdnf install -y tar xz  bash && microdnf clean all

# Install Node.js v22.14.0
RUN cd /opt && \
    curl -LO https://nodejs.org/dist/v22.16.0/node-v22.16.0-linux-arm64.tar.xz && \
    tar -xJf node-v22.16.0-linux-arm64.tar.xz && \
    rm node-v22.16.0-linux-arm64.tar.xz

RUN     microdnf module disable nginx  -y && \
        microdnf module enable nginx:1.28 -y && \
        microdnf install  -y  nginx

# Add Node.js to PATH
ENV PATH="/opt/node-v22.16.0-linux-arm64/bin:$PATH"
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy app source and build
COPY . .
ENV NEXT_DISABLE_APP_TOOLBAR=1
RUN npm run build

# ---------- Stage 2: Runtime ----------
FROM docker.io/redhat/ubi9-minimal:latest

# Install necessary tools
RUN microdnf install -y tar xz  bash && microdnf clean all

# Install Node.js v22.14.0
RUN cd /opt && \
    curl -LO https://nodejs.org/dist/v22.16.0/node-v22.16.0-linux-arm64.tar.xz && \
    tar -xJf node-v22.16.0-linux-arm64.tar.xz && \
    rm node-v22.16.0-linux-arm64.tar.xz

RUN     microdnf module disable nginx  -y && \
        microdnf module enable nginx:1.28 -y && \
        microdnf install  -y  nginx

# Add Node.js to PATH
ENV PATH="/opt/node-v22.16.0-linux-arm64/bin:$PATH"

WORKDIR /app

# Copy necessary files from builder
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/next.config.ts ./next.config.ts 
COPY --from=builder /app/nginx.conf /etc/nginx/nginx.conf

# Optional: define port (Next.js uses 3000 by default)

RUN npm run start
# ENV PORT=3000
EXPOSE 80

# CMD ["node_modules/.bin/next", "start"]
CMD [ "nginx","-g","daemon off" ]

# FROM node:22-alpine

# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# EXPOSE 3000
# CMD npm run dev