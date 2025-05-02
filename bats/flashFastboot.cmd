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
    "%~dp0..\bin\payload-dumper-go.exe" -o "%TEMP_DIR%" "%OTA_ZIP%"

REM Flashing images using  fastboot
    echo Flashing images using  fastboot...
    cd "%TEMP_DIR%"

     fastboot flash boot boot.img
 
     fastboot flash vbmeta vbmeta.img

     fastboot flash vbmeta_system vbmeta_system.img

     fastboot flash vendor_boot vendor_boot.img

     fastboot reboot  fastboot

     fastboot flash product product.img

     fastboot flash system system.img

     fastboot flash system_ext system_ext.img

     fastboot flash vendor vendor.img

     fastboot flash vendor_dlkm vendor_dlkm.img

set /p FORMAT_DATA="Do you want to format data? (Y/N): "
if /i "%FORMAT_DATA%"=="Y" (
    echo Formatting data...
    fastboot -w
) else (
    echo Skipping data format. Proceeding with flashing...
)


echo Flashing complete.
    pause
