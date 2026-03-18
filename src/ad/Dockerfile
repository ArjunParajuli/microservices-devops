FROM eclipse-temurin:21-jdk AS builder

# Set working directory inside the container for the build stage
WORKDIR /usr/src/app/

# files needed for dependencies
COPY gradlew* settings.gradle* build.gradle .

COPY ./gradle ./gradle

# gradlew is a shell script → Linux containers need the executable bit set
RUN chmod +x gradlew

# downloads & installs the correct Gradle version
RUN ./gradlew

# downloads large files or pre-fetches dependencies
RUN ./gradlew downloadRepos

# Now bring in ALL source code (src/, test/, everything else) -> diff layer
COPY . .

COPY ./pb ./proto

RUN chmod +x ./gradlew

# The real build: compile Java, generate code from .proto files, create distributable package
# -PprotoSourceDir=... tells the protobuf plugin where to find .proto files
RUN ./gradlew installDist -PprotoSourceDir=./proto

############################### Runtime ############################################
# Final image uses only the JRE → ~150–250 MB smaller than the builder image
FROM eclipse-temurin:21-jre

# Same working directory as builder for consistency
WORKDIR /usr/src/app/

# Copy **only** the finished application + runtime dependencies from builder
# (the installDist task puts everything under build/install/<app-name>/ )
COPY --from=builder /usr/src/app/ ./

# Default port the service listens on (can be overridden with -e AD_PORT=xxxx)
ENV AD_PORT=9099

# What actually runs when someone does docker run / kubernetes starts the pod
# Uses the shell wrapper script created by installDist
ENTRYPOINT ["./build/install/opentelemetry-demo-ad/bin/Ad"]

