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

REM Create a temporary directory for extraction
    set "TEMP_DIR=%~dp0extracted"
    mkdir "%TEMP_DIR%"


REM Extract OTA ZIP using payload-dumper-go
    echo Extracting OTA ZIP file...
    "%~dp0..\bin\payload-dumper-go.exe" -p vendor_boot -o "%TEMP_DIR%" "%OTA_ZIP%"

REM Move boot.img to main folder
if exist "%TEMP_DIR%\vendor_boot.img" (
    move "%TEMP_DIR%\vendor_boot.img" "%~dp0"
    echo Moved vendor_boot.img to the main folder.
) else (
    echo vendor_boot.img not found in the extracted files.
)
