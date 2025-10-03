# ===================================
# 🏗️  STAGE 1: BUILD APPLICATION
# ===================================
FROM maven:3.9.9-eclipse-temurin-21-alpine AS builder

# Set working directory
WORKDIR /build

# Copy pom.xml và download dependencies trước (layer caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build application (skip tests for faster build)
RUN mvn clean package -DskipTests -B

# Verify WAR file was created
RUN ls -lh /build/target/*.war

# ===================================
# 🚀  STAGE 2: PRODUCTION RUNTIME
# ===================================
# Tomcat 9 for Jakarta EE 8 compatibility
FROM tomcat:9.0-jdk21-temurin-jammy

# Metadata
LABEL maintainer="your-email@example.com"
LABEL description="Email List Application - Jakarta EE 8 + Tomcat 9"
LABEL version="1.0"

# Remove default Tomcat webapps (không cần thiết cho production)
RUN rm -rf /usr/local/tomcat/webapps/* && \
    rm -rf /usr/local/tomcat/temp/* && \
    rm -rf /usr/local/tomcat/work/*

# Copy WAR file từ builder stage và deploy as ROOT app
COPY --from=builder /build/target/Chap13_1-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Tạo thư mục logs nếu chưa có
RUN mkdir -p /usr/local/tomcat/logs

# Set environment variables cho production
ENV CATALINA_OPTS="-Djava.security.egd=file:/dev/./urandom -Xmx512m -Xms256m"
ENV JAVA_OPTS="-Djava.awt.headless=true -Djava.net.preferIPv4Stack=true"

# Database connection (sẽ override bằng Render environment variables)
ENV DB_HOST="localhost"
ENV DB_PORT="3306"
ENV DB_NAME="murach"
ENV DB_USER="root"
ENV DB_PASSWORD=""

# Application settings
ENV APP_ENV="production"
ENV LOG_LEVEL="INFO"

# Expose Tomcat port
EXPOSE 8080

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Run as non-root user for security
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat && \
    chown -R tomcat:tomcat /usr/local/tomcat
USER tomcat

# Start Tomcat
CMD ["catalina.sh", "run"]