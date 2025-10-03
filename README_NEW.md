# 📧 Email List Application

> Jakarta EE 8 web application với JPA/Hibernate và MySQL - Dockerized & Cloud-Ready

[![Java](https://img.shields.io/badge/Java-21-orange.svg)](https://www.oracle.com/java/)
[![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-8-blue.svg)](https://jakarta.ee/)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED.svg?logo=docker)](https://www.docker.com/)
[![Tomcat](https://img.shields.io/badge/Tomcat-9-yellow.svg)](https://tomcat.apache.org/)

## ✨ Features

- ✅ Email list signup form với validation
- ✅ JPA entities với Hibernate ORM
- ✅ MySQL database integration (Google Cloud SQL)
- ✅ Servlet-based web interface  
- ✅ Responsive CSS styling
- ✅ Docker containerized deployment
- ✅ Production-ready configuration
- ✅ Multi-stage Docker build
- ✅ Health checks enabled

## 🚀 Quick Start

### Prerequisites

**Option 1: Docker (Recommended) 🐳**
- Docker Desktop installed
- Internet connection

**Option 2: Traditional ☕**
- Java 21+
- Apache Maven 3.9+
- MySQL 8.0+
- Apache Tomcat 9.0+

---

## 🐳 Docker Deployment (Recommended)

### ⚡ Quick Start
```bash
# Windows - One command start
docker-run.bat

# Linux/Mac
docker-compose up -d
```

### 📋 Manual Steps
```bash
# 1. Build image
docker-compose build

# 2. Start containers
docker-compose up -d

# 3. View logs
docker-compose logs -f

# 4. Check status
docker-compose ps

# 5. Stop containers
docker-compose down
```

### 🌐 Access Application
- **Main URL**: http://localhost:8080
- **Email Form**: http://localhost:8080/index.jsp
- **Test Servlet**: http://localhost:8080/test
- **Debug Page**: http://localhost:8080/debug.jsp

---

## ⚙️ Traditional Build & Deploy

### Build Steps

1. **Build project:**
   ```bash
   mvn clean package
   ```

2. **Deploy WAR:**
   ```bash
   # Copy to Tomcat
   copy target\Chap13_1-1.0-SNAPSHOT.war %CATALINA_HOME%\webapps\
   
   # Or deploy as ROOT
   copy target\Chap13_1-1.0-SNAPSHOT.war %CATALINA_HOME%\webapps\ROOT.war
   ```

3. **Start Tomcat:**
   ```bash
   %CATALINA_HOME%\bin\startup.bat
   ```

4. **Access:**
   - http://localhost:8080/Chap13_1-1.0-SNAPSHOT/
   - Or http://localhost:8080/ (if ROOT.war)

---

## 🗄️ Database Setup

### Google Cloud SQL Configuration

```yaml
Host: 34.9.114.182
Port: 3306
Database: murach
User: root
Password: Spk61392005@
```

### Create Database Table

```sql
USE murach;

CREATE TABLE IF NOT EXISTS users (
    userId BIGINT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    PRIMARY KEY (userId)
);
```

### 🛡️ DATA PROTECTION

**Application được cấu hình BẢO VỆ dữ liệu:**

- ✅ `hibernate.hbm2ddl.auto = validate` - CHỈ kiểm tra schema
- ✅ Dữ liệu hiện tại sẽ được **GIỮ NGUYÊN** khi redeploy
- ✅ An toàn để deploy nhiều lần
- ⚠️ Thay đổi schema phải update thủ công trong database

---

## 📁 Project Structure

```
├── 🐳 Docker Files
│   ├── Dockerfile                  # Multi-stage build
│   ├── docker-compose.yml          # Local dev setup
│   ├── .dockerignore               # Ignore patterns
│   ├── docker-run.bat              # Quick start script
│   └── docker-clean.bat            # Cleanup script
│
├── 🔧 Configuration
│   ├── pom.xml                     # Maven config
│   └── nb-configuration.xml        # NetBeans config
│
├── 📚 Documentation
│   ├── README.md                   # This file
│   └── DOCKER_GUIDE.md             # Deployment guide
│
├── 🛠️ Scripts
│   └── cleanup-files.bat           # Remove old files
│
└── 📂 src/
    ├── main/
    │   ├── java/
    │   │   ├── murach/             # Main package
    │   │   │   ├── business/
    │   │   │   │   └── User.java           # JPA Entity
    │   │   │   ├── data/
    │   │   │   │   ├── DBUtil.java         # DB utility
    │   │   │   │   └── UserDB.java         # Data access
    │   │   │   └── email/
    │   │   │       └── EmailListServlet.java
    │   │   └── com/mycompany/chap13_1/
    │   │       ├── EmailListServlet.java    # Main servlet
    │   │       ├── TestServlet.java         # Test servlet
    │   │       ├── JakartaRestConfiguration.java
    │   │       └── resources/
    │   │
    │   ├── resources/
    │   │   └── META-INF/
    │   │       └── persistence.xml          # JPA config
    │   │
    │   └── webapp/
    │       ├── index.jsp                    # Email form
    │       ├── thanks.jsp                   # Thank you page
    │       ├── test.jsp                     # Test page
    │       ├── debug.jsp                    # Debug info
    │       ├── styles/
    │       │   └── main.css                 # Styling
    │       ├── WEB-INF/
    │       │   ├── web.xml                  # Servlet config
    │       │   └── beans.xml                # CDI beans
    │       └── META-INF/
    │           └── context.xml              # Tomcat context
```

---

## 📖 Usage

### Step-by-Step

1. **Navigate** to application URL
2. **Fill form** with:
   - ✉️ Email (required, unique)
   - 👤 First Name (required)
   - 👥 Last Name (required)
3. **Submit** form
4. **View** confirmation page
5. **Check** MySQL database

### Example

```
Email: john.doe@example.com
First Name: John
Last Name: Doe
```

→ Redirects to `thanks.jsp` with confirmation

---

## 🔧 Configuration

### Environment Variables

```bash
# === Database ===
DB_HOST=34.9.114.182
DB_PORT=3306
DB_NAME=murach
DB_USER=root
DB_PASSWORD=Spk61392005@

# === Application ===
APP_ENV=production
LOG_LEVEL=INFO

# === JVM Settings ===
JAVA_OPTS=-Xmx512m -Xms256m -Djava.awt.headless=true
CATALINA_OPTS=-Djava.security.egd=file:/dev/./urandom

# === Connection Pool ===
HIKARI_MAX_POOL_SIZE=5
HIKARI_MIN_IDLE=1
HIKARI_CONNECTION_TIMEOUT=20000
HIKARI_IDLE_TIMEOUT=300000
```

### Docker Compose Override

Create `docker-compose.override.yml`:

```yaml
version: '3.8'
services:
  app:
    environment:
      DB_HOST: your_custom_host
      DB_PASSWORD: your_secure_password
```

---

## 🚀 Deploy to Render

### Quick Steps

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Add Docker support"
   git push origin main
   ```

2. **Create Web Service**
   - Go to [Render Dashboard](https://dashboard.render.com)
   - Click "New +" → "Web Service"
   - Connect GitHub repository
   - Select **Docker** environment

3. **Set Environment Variables**
   ```bash
   DB_HOST=34.9.114.182 (Plain Text)
   DB_PORT=3306 (Plain Text)
   DB_NAME=murach (Plain Text)
   DB_USER=root (Plain Text)
   DB_PASSWORD=Spk61392005@ (SECRET)
   ```

4. **Deploy** → Render auto-deploys from Dockerfile

📚 **Detailed Guide**: [DOCKER_GUIDE.md](DOCKER_GUIDE.md)

---

## 🧹 Cleanup

### Remove Unnecessary Files
```bash
# Windows
cleanup-files.bat

# Will delete:
# - Old documentation files
# - Build artifacts (target/)
# - IDE files (nb-configuration.xml)
# - Logs
```

### Docker Cleanup
```bash
# Windows
docker-clean.bat

# Linux/Mac
docker-compose down -v
docker system prune -a
```

### Maven Clean
```bash
mvn clean
```

---

## 🐛 Troubleshooting

### ❌ Application Won't Start

```bash
# Check Docker logs
docker-compose logs -f app

# Check if port 8080 is in use
netstat -ano | findstr :8080

# Kill process on port 8080 (Windows)
taskkill /F /PID <PID>
```

### ❌ Database Connection Error

```bash
# Verify environment variables
docker-compose exec app env | grep DB_

# Test database connection directly
mysql -h 34.9.114.182 -u root -p murach

# Check Google Cloud SQL firewall rules
```

### ❌ Build Fails

```bash
# Maven clean build
mvn clean package -U

# Docker clean build
docker-compose build --no-cache --pull

# Check Java version
java -version  # Should be 21+
```

### ❌ Form Returns 404

**Root Cause**: Jakarta EE 10 vs Tomcat 9 incompatibility

**Solution**: Already fixed! Using:
- Jakarta EE 8 (`javax.*` packages)
- Tomcat 9.0
- Compatible servlet annotations

### ❌ Health Check Fails

```bash
# Check if curl is installed in container
docker-compose exec app which curl

# Manual health check
curl http://localhost:8080/
```

---

## 📊 Monitoring

### View Logs

```bash
# All logs
docker-compose logs

# Follow logs
docker-compose logs -f app

# Last 100 lines
docker-compose logs --tail=100 app

# Specific time range
docker-compose logs --since 30m app
```

### Container Stats

```bash
# Real-time stats
docker stats

# Specific container
docker stats chap13_email_app
```

### Health Status

```bash
# Check health
docker ps

# Look for "healthy" status
docker inspect chap13_email_app | grep Health
```

---

## 📝 Technical Notes

### Architecture

- **Multi-stage Docker build**: Maven (builder) → Tomcat (runtime)
- **Layer caching**: Dependencies cached separately
- **Image size**: ~400MB (optimized from ~800MB)

### Security

- ✅ Non-root user (`tomcat`) in container
- ✅ Remove default Tomcat webapps
- ✅ SSL enabled for database connections
- ✅ Environment variables for secrets
- ✅ Health checks configured

### Performance

- ✅ HikariCP connection pooling
- ✅ JVM tuning (512MB max heap)
- ✅ Docker layer caching
- ✅ Alpine-based builder stage

### Compatibility

- ✅ Jakarta EE 8 (`javax.*` namespace)
- ✅ Tomcat 9.0 (supports Java EE 8)
- ✅ Java 21 (LTS version)
- ✅ MySQL 8.0+

---

## 📚 Additional Resources

### Documentation
- [DOCKER_GUIDE.md](DOCKER_GUIDE.md) - Complete deployment guide
- [pom.xml](pom.xml) - Maven dependencies
- [Dockerfile](Dockerfile) - Docker configuration
- [persistence.xml](src/main/resources/META-INF/persistence.xml) - JPA config

### Technologies Used
- [Jakarta EE 8](https://jakarta.ee/)
- [Hibernate ORM](https://hibernate.org/)
- [HikariCP](https://github.com/brettwooldridge/HikariCP)
- [Apache Tomcat](https://tomcat.apache.org/)
- [Docker](https://www.docker.com/)
- [MySQL](https://www.mysql.com/)

---

## 📄 License

MIT License - Free to use for learning purposes.

## 👨‍💻 Author

Created as part of **Murach's Java Servlets and JSP** course.

---

## 🎯 Quick Reference

| Command | Description |
|---------|-------------|
| `docker-run.bat` | Start application (Windows) |
| `docker-compose up -d` | Start in background |
| `docker-compose down` | Stop application |
| `docker-compose logs -f` | View logs |
| `docker-compose ps` | Check status |
| `docker-compose build` | Rebuild image |
| `cleanup-files.bat` | Remove old files |
| `docker-clean.bat` | Clean Docker artifacts |
| `mvn clean package` | Build WAR file |

---

**🚀 Happy Coding!**
