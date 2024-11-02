@echo off
setlocal enabledelayedexpansion

set "FASTBOOT=%~dp0..\adb\fastboot.exe"  

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

     "%FASTBOOT%" flash boot boot.img
 
     "%FASTBOOT%" flash vbmeta vbmeta.img

     "%FASTBOOT%" flash vbmeta_system vbmeta_system.img

     "%FASTBOOT%" flash vendor_boot vendor_boot.img

     "%FASTBOOT%" reboot  fastboot

     "%FASTBOOT%" flash product product.img

     "%FASTBOOT%" flash system system.img

     "%FASTBOOT%" flash system_ext system_ext.img

     "%FASTBOOT%" flash vendor vendor.img

     "%FASTBOOT%" flash vendor_dlkm vendor_dlkm.img

    echo formatting data

     "%FASTBOOT%" -w


echo Flashing complete.
    pause
