# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

# Install required tools
RUN apk add --no-cache protobuf-dev protoc

# Install dependencies
COPY ./src/frontend/package*.json ./
RUN npm ci

# Copy src code
COPY ./src/frontend ./
COPY ./pb ./pb

# Generate gRPC + build
RUN npm run grpc:generate
RUN npm run build

# Stage 2: Run
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080

# Copy built app
COPY --from=builder /app ./

CMD ["npm", "start"]
