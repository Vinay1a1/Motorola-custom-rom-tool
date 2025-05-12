@echo off
setlocal enabledelayedexpansion

echo.
echo [1] Reboot to System
echo [2] Reboot to Recovery
echo [3] Reboot to Fastboot(d)
echo [4] Reboot to Bootloader
echo [b] Back to Main Menu
echo.
set /p "reboot_selection=Please select where to reboot: "
if /i "%reboot_selection%"=="1" fastboot reboot
if /i "%reboot_selection%"=="2" fastboot reboot recovery
if /i "%reboot_selection%"=="3" fastboot reboot fastboot
if /i "%reboot_selection%"=="4" fastboot reboot bootloader
if /i "%reboot_selection%"=="b" goto Start
echo.
echo Invalid option. Please try again.
