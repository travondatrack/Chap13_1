@echo off
REM ===================================
REM 🐳 DOCKER BUILD AND RUN SCRIPT
REM ===================================

echo.
echo ================================
echo   DOCKER BUILD AND DEPLOY
echo ================================
echo.

REM Check if Docker is running
docker info >nul 2>&1
if errorlevel 1 (
    echo ❌ ERROR: Docker is not running!
    echo Please start Docker Desktop first.
    pause
    exit /b 1
)

echo ✅ Docker is running
echo.

REM Stop existing containers
echo 📦 Stopping existing containers...
docker-compose down
echo.

REM Build image
echo 🏗️  Building Docker image...
docker-compose build --no-cache
if errorlevel 1 (
    echo ❌ Build failed!
    pause
    exit /b 1
)
echo.

echo ✅ Build successful!
echo.

REM Start containers
echo 🚀 Starting application...
docker-compose up -d
if errorlevel 1 (
    echo ❌ Failed to start containers!
    pause
    exit /b 1
)
echo.

echo ✅ Application started successfully!
echo.

REM Wait for application to be ready
echo ⏳ Waiting for application to be ready...
timeout /t 30 /nobreak >nul
echo.

REM Show logs
echo 📋 Application logs:
echo ================================
docker-compose logs --tail=50
echo ================================
echo.

REM Show status
echo 📊 Container status:
docker-compose ps
echo.

echo ================================
echo   🎉 DEPLOYMENT COMPLETE!
echo ================================
echo.
echo 🌐 Application URL: http://localhost:8080
echo 📝 Form URL: http://localhost:8080/index.jsp
echo 🧪 Test URL: http://localhost:8080/test
echo.
echo 📋 Commands:
echo   - View logs: docker-compose logs -f
echo   - Stop app: docker-compose down
echo   - Restart: docker-compose restart
echo.

pause
