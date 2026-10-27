@echo off
setlocal EnableExtensions
title Dash - keep this window open while you use the dashboard
cd /d "%~dp0flutter_application_1"
if exist "pubspec.yaml" goto found
echo Could not find the Flutter project next to this file.
echo It should be in a folder called flutter_application_1 beside run_dashboard.bat.
pause
exit /b 1

:found
rem The Flutter SDK this project was set up with. The flutter command on PATH
rem is a different copy on this PC and does not work, so it is only a fallback.
set "FLUTTER=%USERPROFILE%\Desktop\flutter\flutter\bin\flutter.bat"
if exist "%FLUTTER%" goto start
set "FLUTTER=flutter"
where flutter > nul 2> nul
if not errorlevel 1 goto start
echo Flutter was not found on this computer, so the dashboard could not start.
pause
exit /b 1

:start
set "PORT_ARG=--web-port=8080"
netstat -ano | findstr /r /c:":8080 .*LISTENING" > nul 2>&1
if not errorlevel 1 (
  echo Port 8080 is already in use, so Flutter will pick another free port.
  set "PORT_ARG="
)
echo Starting Dash in Chrome. The first start takes about a minute.
echo Keep this window open while you use the dashboard. Press q in this window to stop it.
echo.
cmd /c ""%FLUTTER%" run -d chrome %PORT_ARG%"
echo.
echo Dash has stopped.
pause
