@echo off
REM Gwern.net Quick Start Script
REM Description: Builds and runs Gwern.net locally

echo ========================================
echo Gwern.net Local Server
echo ========================================
echo.

REM Check if we're in the right directory
if not exist "gwernnet.cabal" (
    echo ERROR: Not in the build directory!
    echo Please run this script from: gwern.net\build\
    pause
    exit /b 1
)

echo [1/3] Checking Cabal...
where cabal >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Cabal not found! Please install GHCup first.
    echo Visit: https://www.haskell.org/ghcup/
    pause
    exit /b 1
)

echo [2/3] Building Hakyll (this may take a while on first run)...
cabal build hakyll
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Build failed!
    pause
    exit /b 1
)

echo [3/3] Starting local server...
echo.
echo Server will be available at: http://localhost:8000
echo Press Ctrl+C to stop the server
echo.

cabal run hakyll -- watch

pause
