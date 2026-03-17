FROM golang:tip-alpine3.23 AS builder

WORKDIR /usr/src/app/

# Copy dependency files
COPY go.mod go.sum ./

# Download all dependencies
RUN go mod download

# Copy the rest of the source code
COPY . .

RUN go build -o product-catalog .
