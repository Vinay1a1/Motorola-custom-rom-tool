@echo off
setlocal enabledelayedexpansion

REM Set the path for KernelSU binary
set ksud="%~dp0bin\ksud.exe"
set magiskboot="%~dp0..\bin\magiskboot.exe"

REM Define the folder where the boot image is located
set "BOOT_IMG_DIR=%~dp0.."  

REM Look for any boot image in the specified directory
set "BOOT_IMG="
for %%f in ("%BOOT_IMG_DIR%\boot.img") do (
    set "BOOT_IMG=%%f"
    goto :found_img
)

:found_img
if "%BOOT_IMG%"=="" (
    echo "No boot image found in the specified directory."
    exit /b 1
)

echo "Found boot image: %BOOT_IMG%"


REM Patch the boot image using KernelSU
echo "Patching the boot image using KernelSU..."
"%~dp0../bin/ksud.exe" boot-patch -b "%BOOT_IMG%" --magiskboot "%~dp0..\bin\magiskboot.exe" --kmi android12-5.10

if %errorlevel% neq 0 (
    echo "Failed to patch boot image."
    exit /b 1
)

echo "Boot image patched successfully: %OUTPUT_IMG%"

REM Patched image
for %%f in ("%BOOT_IMG_DIR%\kernelsu_patched_*.img") do (
    set "PATCHED_IMG=%%f"
    goto :found_patched_img
)

:found_patched_img
if "%PATCHED_IMG%"=="" (
    echo "Patched image not found."
    exit /b 1
)

echo "Patched boot image found: %PATCHED_IMG%"

REM Ask user if they want to flash the patched image
set /p FLASH_CONFIRM="Do you want to flash the patched boot image? (y/n): "
if /i "%FLASH_CONFIRM%"=="y" (
    echo "Flashing the patched boot image using fastboot..."
    "%~dp0..\adb\fastboot.exe" flash boot "%PATCHED_IMG%"

    if %errorlevel% neq 0 (
        echo "Failed to flash patched boot image."
        exit /b 1
    )

    echo "Patched boot image flashed successfully."
) else (
    echo "Flashing canceled."
)

pause
