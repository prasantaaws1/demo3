# Use a Java base image
FROM openjdk:17-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the Spring Boot application JAR file into the Docker image
COPY target/demoapp-1.jar /app/
# Run the Spring Boot application when the container starts
CMD ["java", "-jar", "demoapp-1.jar"]
