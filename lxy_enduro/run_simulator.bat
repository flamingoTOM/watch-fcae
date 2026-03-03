@echo off
echo ========================================
echo LXY Enduro Watch Face - Quick Start
echo ========================================
echo.

set SDK_PATH=%APPDATA%\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-8.4.1-2026-02-03-e9f77eeaa
set PROJECT_PATH=%~dp0

echo Step 1: Compiling...
echo.
"%SDK_PATH%\bin\monkeyc.bat" -d enduro -f "%PROJECT_PATH%monkey.jungle" -o "%PROJECT_PATH%bin\lxy_enduro_test.prg" -y "%PROJECT_PATH%keys\developer_key" -t -w

if errorlevel 1 (
    echo.
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)

echo.
echo Build successful!
echo.
echo ========================================
echo NEXT STEPS:
echo ========================================
echo 1. Open the Connect IQ Simulator manually
echo 2. In the simulator menu: Simulation -^> Load App...
echo 3. Select: %PROJECT_PATH%bin\lxy_enduro_test.prg
echo 4. Click the app icon to activate it
echo ========================================
echo.
echo Or press any key to try opening VS Code...
pause

code "%PROJECT_PATH%"

echo.
echo In VS Code, press F5 to run the watch face!
echo.
pause
