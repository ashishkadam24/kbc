# Use OpenJDK 11 base image
FROM openjdk:11-jdk-slim

# Install necessary packages including X11 libraries
RUN apt-get update && apt-get install -y \
    build-essential \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxtst6 \
    libxi6 \
    libxt-dev \
    libxrandr2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the entire project directory into the container
COPY . /app

# Create the bin directory if it doesn't exist
RUN mkdir -p bin

# Compile all Java source files in src/kbc
RUN javac -d bin src/kbc/*.java

# Set the entry point for the container
ENTRYPOINT ["java", "-cp", "bin", "kbc.KBC"]
