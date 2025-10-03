@echo off
REM ===================================
REM 🗑️  DELETE UNNECESSARY FILES
REM ===================================

echo.
echo ================================
echo   DELETING UNNECESSARY FILES
echo ================================
echo.

set "DELETED_COUNT=0"

REM Delete old documentation files
echo 📄 Deleting old documentation...
if exist "DEPLOYMENT_SUCCESS.md" (
    del /f "DEPLOYMENT_SUCCESS.md"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted DEPLOYMENT_SUCCESS.md
)

if exist "DEPLOY_TO_RENDER.md" (
    del /f "DEPLOY_TO_RENDER.md"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted DEPLOY_TO_RENDER.md
)

if exist "DOCKER_RENDER_DEPLOY.md" (
    del /f "DOCKER_RENDER_DEPLOY.md"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted DOCKER_RENDER_DEPLOY.md
)

if exist "FINAL_SIMPLIFIED_SUMMARY.md" (
    del /f "FINAL_SIMPLIFIED_SUMMARY.md"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted FINAL_SIMPLIFIED_SUMMARY.md
)

if exist "RENDER_ENV_GUIDE.md" (
    del /f "RENDER_ENV_GUIDE.md"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted RENDER_ENV_GUIDE.md
)

REM Delete old deployment scripts
echo.
echo 🚀 Deleting old deployment scripts...
if exist "deploy_simplified.bat" (
    del /f "deploy_simplified.bat"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted deploy_simplified.bat
)

if exist "render.yaml" (
    del /f "render.yaml"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted render.yaml
)

REM Delete build artifacts
echo.
echo 🏗️  Deleting build artifacts...
if exist "target\" (
    rd /s /q target
    set /a DELETED_COUNT+=1
    echo ✅ Deleted target/
)

REM Delete logs
if exist "logs\" (
    rd /s /q logs
    set /a DELETED_COUNT+=1
    echo ✅ Deleted logs/
)

REM Delete IDE files
echo.
echo 💻 Deleting IDE files...
if exist "nb-configuration.xml" (
    del /f "nb-configuration.xml"
    set /a DELETED_COUNT+=1
    echo ✅ Deleted nb-configuration.xml
)

if exist "nbproject\" (
    rd /s /q nbproject
    set /a DELETED_COUNT+=1
    echo ✅ Deleted nbproject/
)

if exist ".netbeans\" (
    rd /s /q .netbeans
    set /a DELETED_COUNT+=1
    echo ✅ Deleted .netbeans/
)

echo.
echo ================================
echo   ✅ CLEANUP COMPLETE!
echo ================================
echo.
echo 📊 Total items deleted: %DELETED_COUNT%
echo.
echo 📁 Remaining important files:
echo   - Dockerfile
echo   - docker-compose.yml
echo   - pom.xml
echo   - src/
echo   - README.md
echo   - DOCKER_GUIDE.md
echo.

pause
