FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# Copy project files
COPY ./src/accounting/ ./Accounting/
COPY ./pb/demo.proto ./Accounting/proto/

WORKDIR /app/Accounting

# Restore + publish in one go
RUN dotnet publish -c Release -o /out

# -----------------------------

FROM mcr.microsoft.com/dotnet/aspnet:8.0

WORKDIR /app

# Copy published output
COPY --from=build /out .

# Setup OpenTelemetry logging dir
RUN mkdir -p /var/log/opentelemetry/dotnet

# Run app
ENTRYPOINT ["./instrument.sh", "dotnet", "Accounting.dll"]
