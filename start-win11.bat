@echo off
setlocal

REM Always run from repository root (the folder where this file is located)
cd /d "%~dp0"

REM Launch via PowerShell script; bypass policy only for this process
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start-win11.ps1"
set "EXIT_CODE=%ERRORLEVEL%"

if not "%EXIT_CODE%"=="0" (
  echo.
  echo Startup failed. Exit code: %EXIT_CODE%
  pause
)

endlocal
exit /b %EXIT_CODE%
