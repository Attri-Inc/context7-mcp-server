# Stage 1: build your Node app
FROM node:lts-alpine AS builder
WORKDIR /app

COPY package.json bun.lock tsconfig.json ./
COPY src ./src

RUN npm install && npm run build

# Stage 2: use Supergateway as the runtime base
FROM ghcr.io/supercorp-ai/supergateway:v3.4.3 AS supergw

WORKDIR /app

# Copy in your compiled dist and install production deps
COPY --from=builder /app/dist ./dist
COPY package.json ./
RUN npm install --production --ignore-scripts

# Expose your Streamable HTTP port
EXPOSE 8080

# Entrypoint wraps your MCP server in Supergateway
ENTRYPOINT ["supergateway"]
CMD ["--stdio", "node dist/index.js", "--port", "8080", "--outputTransport", "streamableHttp", "--streamableHttpPath", "/mcp", "--cors"]