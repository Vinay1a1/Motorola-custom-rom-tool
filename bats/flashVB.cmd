@echo off
setlocal enabledelayedexpansion

REM Find images and set the count
set count=0
for %%f in ("%~dp0..\*.img") do (
    set /a count+=1
    echo !count!: %%f
    set image[!count!]=%%f
)

if %count%==0 (
    echo No image files found in the current directory.
    pause
    exit /b
)

adb get -state 1>nul 2>nul
if %errorlevel% equ 0 (
    echo Rebooting to Fastboot...
    adb reboot fastboot 
) else (
GOTO do
)

:do
echo Rebooting into fastbootd mode...
 fastboot reboot fastboot

:select_vendor_boot
set /p vendor_boot_choice="Enter the number of the vendor_boot image to flash: "
if not defined image[%vendor_boot_choice%] (
    echo Invalid choice. Please try again.
    goto select_vendor_boot
)
set vendor_boot_image=!image[%vendor_boot_choice%]!

echo Flashing vendor_boot.img...
 fastboot flash vendor_boot %vendor_boot_image%

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
