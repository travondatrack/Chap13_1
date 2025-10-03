@echo off
REM ===================================
REM 🧹 CLEANUP SCRIPT
REM ===================================

echo.
echo ================================
echo   DOCKER CLEANUP
echo ================================
echo.

REM Stop containers
echo 🛑 Stopping containers...
docker-compose down -v
echo.

REM Remove images
echo 🗑️  Removing images...
docker rmi chap13-email-app:latest 2>nul
echo.

REM Clean build artifacts
echo 🧹 Cleaning build artifacts...
if exist "target\" (
    rd /s /q target
    echo ✅ Deleted target/
)

if exist "logs\" (
    rd /s /q logs
    echo ✅ Deleted logs/
)
echo.

echo ================================
echo   ✅ CLEANUP COMPLETE!
echo ================================
echo.

pause
