FROM golang:tip-alpine3.23 AS builder

WORKDIR /usr/src/app/

# Copy dependency files
COPY go.mod go.sum ./

# Download all dependencies
RUN go mod download

# Copy the rest of the source code
COPY . .

RUN go build -o product-catalog .

####################################

FROM alpine AS release

COPY /products /products

# copy the compiled binary from the builder stage
COPY --from=builder /usr/src/app/product-catalog .

ENV PRODUCT_CATALOG_PORT=8088

ENTRYPOINT ["./product-catalog"]
