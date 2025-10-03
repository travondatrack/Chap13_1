# 🐳 DOCKER DEPLOYMENT GUIDE

## 📋 Prerequisites

- Docker Desktop installed
- Docker Compose installed
- Internet connection (để pull base images)

## 🏗️ BUILD IMAGE

### Option 1: Docker Build
```bash
# Build image
docker build -t chap13-email-app:latest .

# Check image size
docker images | grep chap13-email-app
```

### Option 2: Docker Compose Build
```bash
# Build with docker-compose
docker-compose build

# Build without cache (nếu cần rebuild hoàn toàn)
docker-compose build --no-cache
```

## 🚀 RUN LOCALLY

### Start Application
```bash
# Start in background
docker-compose up -d

# View logs
docker-compose logs -f

# Check status
docker-compose ps
```

### Access Application
- URL: http://localhost:8080
- Form: http://localhost:8080/index.jsp
- Test Servlet: http://localhost:8080/test

### Stop Application
```bash
# Stop containers
docker-compose down

# Stop and remove volumes
docker-compose down -v
```

## 🔍 DEBUGGING

### View Logs
```bash
# All logs
docker-compose logs

# Follow logs
docker-compose logs -f app

# Last 100 lines
docker-compose logs --tail=100 app
```

### Enter Container
```bash
# Bash shell
docker-compose exec app bash

# Check environment variables
docker-compose exec app env | grep DB_

# Check Tomcat logs
docker-compose exec app cat /usr/local/tomcat/logs/catalina.out
```

### Check Database Connection
```bash
# From within container
docker-compose exec app bash
curl -f http://localhost:8080/test
```

## 📦 DEPLOY TO RENDER

### 1. Push to GitHub
```bash
git add .
git commit -m "Add Docker support"
git push origin main
```

### 2. Create Web Service in Render

- **Environment**: Docker
- **Build Command**: (auto-detected from Dockerfile)
- **Start Command**: (auto-detected)

### 3. Set Environment Variables

Add these in Render Dashboard:

```bash
DB_HOST=34.9.114.182
DB_PORT=3306
DB_NAME=murach
DB_USER=root
DB_PASSWORD=Spk61392005@  # Set as SECRET

JAVA_OPTS=-Xmx512m -Xms256m
CATALINA_OPTS=-Djava.security.egd=file:/dev/./urandom
APP_ENV=production
LOG_LEVEL=INFO
```

### 4. Deploy
Render will automatically:
- Detect Dockerfile
- Build image
- Deploy container
- Assign public URL

## 🔧 TROUBLESHOOTING

### Build Fails
```bash
# Clean Docker cache
docker system prune -a

# Rebuild without cache
docker-compose build --no-cache
```

### Application Won't Start
```bash
# Check logs
docker-compose logs app

# Check if port is already in use
netstat -ano | findstr :8080  # Windows
lsof -i :8080                 # Linux/Mac
```

### Database Connection Error
```bash
# Verify environment variables
docker-compose exec app env | grep DB_

# Test database from host
mysql -h 34.9.114.182 -u root -p murach
```

## 📊 MONITORING

### Health Check
```bash
# Manual health check
curl http://localhost:8080/

# Check Docker health status
docker-compose ps
```

### Resource Usage
```bash
# Container stats
docker stats

# Specific container
docker stats chap13_email_app
```

## 🧹 CLEANUP

### Remove Containers
```bash
# Stop and remove
docker-compose down

# Remove with volumes
docker-compose down -v
```

### Remove Images
```bash
# Remove app image
docker rmi chap13-email-app:latest

# Remove unused images
docker image prune -a
```

### Complete Cleanup
```bash
# Remove everything (CAREFUL!)
docker system prune -a --volumes
```

## 📝 NOTES

### Multi-stage Build
- Stage 1: Maven build (tạo WAR file)
- Stage 2: Tomcat runtime (chạy WAR)
- Giảm kích thước image từ ~800MB xuống ~400MB

### Security
- Chạy as non-root user (`tomcat`)
- Remove default Tomcat webapps
- Environment variables cho sensitive data

### Performance
- Layer caching cho dependencies
- Alpine base image cho builder
- Health checks enabled
