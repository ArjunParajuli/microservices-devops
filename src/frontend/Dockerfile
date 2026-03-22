FROM node:20-alpine

WORKDIR /app

# Install required tools
RUN apk add --no-cache protobuf-dev protoc

# Copy everything
COPY ./src/frontend ./
COPY ./pb ./pb

RUN npm install

# Generate gRPC + build
RUN npm run grpc:generate
RUN npm run build

ENV NODE_ENV=production
ENV PORT=8080

CMD ["npm", "start"]
