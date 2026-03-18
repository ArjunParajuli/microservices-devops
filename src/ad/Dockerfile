FROM eclipse-temurin:21-jdk AS builder

WORKDIR /usr/src/app/

COPY gradlew* settings.gradle* build.gradle .

COPY ./gradle ./gradle

RUN chmod +x gradlew

RUN ./gradlew downloadRepos

COPY . .

COPY ./pb ./proto

RUN chmod +x ./gradlew

RUN ./gradlew installDist -PprotoSourceDir=./proto
