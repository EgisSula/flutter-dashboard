@echo off
setlocal EnableExtensions
title Dash checks - keep this window open
cd /d "%~dp0flutter_application_1"
if exist "pubspec.yaml" goto found
echo Could not find the Flutter project next to this file.
echo It should be in a folder called flutter_application_1 beside check_dashboard.bat.
pause
exit /b 1

:found
if not exist "_check" mkdir "_check"

rem The Flutter SDK this project was set up with. The flutter command on PATH
rem is a different copy on this PC and does not work, so it is only a fallback.
set "FLUTTER=%USERPROFILE%\Desktop\flutter\flutter\bin\flutter.bat"
if exist "%FLUTTER%" goto run
set "FLUTTER=flutter"
where flutter > nul 2> nul
if not errorlevel 1 goto run
> "_check\status.txt" echo flutter_not_found=1
> "_check\done.txt" echo flutter-not-found
echo.
echo Flutter was not found on this computer, so the checks could not run.
echo Nothing was changed. Please tell Claude that Flutter was not found.
pause
exit /b 1

:run
set "REQ=first-run"
if exist "_check\request.txt" (
  set /p REQ=<"_check\request.txt"
  del "_check\request.txt"
)
if exist "_check\done.txt" del "_check\done.txt"
echo.
echo ===== Running checks: %REQ% - %date% %time% =====
> "_check\status.txt" echo request=%REQ%
>> "_check\status.txt" echo started=%date% %time%
>> "_check\status.txt" echo flutter=%FLUTTER%
cmd /c ""%FLUTTER%" --version" > "_check\0_version.log" 2>&1

echo [1/4] flutter pub get
cmd /c ""%FLUTTER%" pub get" > "_check\1_pub_get.log" 2>&1
>> "_check\status.txt" echo pub_get_exit=%errorlevel%

echo [2/4] flutter analyze
cmd /c ""%FLUTTER%" analyze --no-pub" > "_check\2_analyze.log" 2>&1
>> "_check\status.txt" echo analyze_exit=%errorlevel%

echo [3/4] flutter test
cmd /c ""%FLUTTER%" test --no-pub" > "_check\3_test.log" 2>&1
>> "_check\status.txt" echo test_exit=%errorlevel%

echo [4/4] flutter build web - debug build used for browser testing
cmd /c ""%FLUTTER%" build web --debug --no-pub --no-web-resources-cdn --no-wasm-dry-run -o build\web_check" > "_check\4_build_web.log" 2>&1
>> "_check\status.txt" echo build_exit=%errorlevel%

>> "_check\status.txt" echo finished=%date% %time%
> "_check\done.txt" echo %REQ%
echo ===== Finished. Waiting for the next request. Close this window to stop. =====

:wait
timeout /t 3 /nobreak > nul
if exist "_check\request.txt" goto run
goto wait
