@echo off
setlocal enabledelayedexpansion

REM Look for any ZIP file in the parent directory
set "OTA_ZIP="
for %%f in ("%~dp0..\*.zip") do (
    set "OTA_ZIP=%%f"
    goto :found_zip
)

:found_zip
if "%OTA_ZIP%"=="" (
    echo No OTA ZIP file found in the parent directory.
    exit /b 1
)

echo Found OTA ZIP file: %OTA_ZIP%

set /p FORMAT_DATA="Do you want to format data? (Y/N): "
if /i "%FORMAT_DATA%"=="Y" (
    echo Formatting data...
    fastboot -w
) else (
    echo Skipping data format. Proceeding with flashing...
)


echo Rebooting device into recovery mode...
"%FASTBOOT%" reboot recovery

echo Waiting for device to enter ADB sideload mode...

:wait_for_sideload
REM Check if sideload is available (output includes 'sideload')
"%ADB%" devices | findstr "sideload" >nul
if %errorlevel% neq 0 (
    timeout /t 5 >nul
    goto wait_for_sideload
)

REM Start sideloading the ROM ZIP file
echo Device is in sideload mode. Starting sideload...
adb sideload "%OTA_ZIP%"

pause

