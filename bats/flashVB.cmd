@echo off
setlocal enabledelayedexpansion

REM Check if vendor_boot.img is available in the main folder
if not exist "%~dp0..\vendor_boot.img" (
    echo "vendor_boot.img not found in the main folder. Please ensure it is present."
    exit /b 1
)

echo Rebooting into fastbootd mode...
 "%FASTBOOT%" reboot fastboot

 "%FASTBOOT%" wait-for-device

echo Flashing vendor_boot.img...
 "%FASTBOOT%" flash vendor_boot vendor_boot.img

set /p REBOOT="Flashing complete. Do you want to reboot the device to system now? (Y/N): "
if /i "%REBOOT%"=="Y" (
     "%FASTBOOT%" reboot
    echo Device is rebooting.
) else (
    echo Please reboot the device manually when ready.
)


set /p RECOVERY="Do you want to reboot to recovery? (Y/N): "
if /i "%RECOVERY%"=="Y" (
     "%FASTBOOT%" reboot bootloader
     "%FASTBOOT%" reboot recovery
    echo Rebooting to recovery.
) else (
    echo You can reboot to recovery manually later.
)

pause