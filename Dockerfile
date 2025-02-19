# Use Maven to build the app and OpenJDK to run it
FROM maven:3.8.6-jdk-17-slim AS builder

# Set the working directory and copy necessary files
WORKDIR /app
COPY . /app/

# Build the app using mvn clean install
RUN mvn clean install -DskipTests

# Final image with OpenJDK runtime
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /app/target/java-mysql-example-1.0-SNAPSHOT.jar .

# Expose port 
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "java-mysql-example-1.0-SNAPSHOT.jar"]
