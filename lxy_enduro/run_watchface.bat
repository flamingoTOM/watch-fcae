@echo off
echo Starting LXY Enduro Watch Face...
echo.

set CIQ_SDK=%APPDATA%\Garmin\ConnectIQ\Sdks\connectiq-sdk-win-8.4.1-2026-02-03-e9f77eeaa

echo Step 1: Compiling...
"%CIQ_SDK%\bin\monkeyc.bat" -d enduro -f monkey.jungle -o bin\lxy_enduro.prg -y keys\developer_key -w

if errorlevel 1 (
    echo.
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Starting simulator...
start "" "%CIQ_SDK%\bin\simulator.exe"

echo Waiting for simulator to start...
timeout /t 5 /nobreak > nul

echo.
echo Step 3: Loading watch face...
"%CIQ_SDK%\bin\monkeydo.bat" bin\lxy_enduro.prg enduro

echo.
echo Watch face loaded!
pause
