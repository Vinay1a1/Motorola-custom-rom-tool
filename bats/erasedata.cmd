@echo off
setlocal enabledelayedexpansion

echo.
echo Are you sure you want to be Erasing your Data? 
echo if so continue, and phone will boot into bootloader mode to erase data.
pause
fastboot reboot bootloader
timeout /t 2 >nul
fastboot erase nvdata
fastboot erase userdata
fastboot erase metadata
fastboot erase debug_token
echo Data Format process completed.
