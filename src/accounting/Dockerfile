# STAGE 1: Build
# Use the full SDK image to compile the code. 
# 'AS builder' lets us reference this stage later.
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder
WORKDIR /src

# Copy only the project file first to cache NuGet restore layers
# Replace 'MyApp' with your actual project name
COPY ["MyApp.csproj", "./"]
RUN dotnet restore

COPY . .

# Compile the application in Release mode
# The output is sent to the /app/build folder
RUN dotnet build "MyApp.csproj" -c Release -o /app/build

# -----------------------------------------------------------------------------

# STAGE 2: Publish
# This stage prepares the app for deployment by stripping debug symbols
FROM builder AS publish
RUN dotnet publish "MyApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# -----------------------------------------------------------------------------

# STAGE 3: Final Runtime
# Use the lightweight ASP.NET runtime image (no compiler included)
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Security: Run the app as a non-privileged user (built-in 'app' user)
USER app
WORKDIR /app

# Copy only the compiled files from the publish stage
COPY --from=publish /app/publish .

# Define the command to run the app
ENTRYPOINT ["dotnet", "MyApp.dll"]
