@echo off
setlocal enabledelayedexpansion

REM Check if boot.img is available in the main folder
if not exist "%~dp0..\boot.img" (
    echo "boot.img not found in the main folder. Please ensure it is present."
    exit /b 1
)

echo Rebooting into fastbootd mode...
fastboot reboot fastboot

fastboot wait-for-device

echo Flashing boot.img...
fastboot flash boot boot.img

set /p REBOOT="Flashing complete. Do you want to reboot the device to system now? (Y/N): "
if /i "%REBOOT%"=="Y" (
    fastboot reboot
    echo Device is rebooting.
) else (
    echo Please reboot the device manually when ready.
)


set /p RECOVERY="Do you want to reboot to recovery? (Y/N): "
if /i "%RECOVERY%"=="Y" (
    fastboot reboot bootloader
    fastboot reboot recovery
    echo Rebooting to recovery.
) else (
    echo You can reboot to recovery manually later.
)

pause