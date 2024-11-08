@echo off
setlocal enabledelayedexpansion

set "FASTBOOT=%~dp0..\adb\fastboot.exe"
set "ADB=%~dp0..\adb\adb.exe"

echo Connect in fastboot/bootloader mode
echo It will sideload magisk.zip using recovery(for now atleast)
echo (Can't patch image on PC because I can't find the binaries yet)
echo Remeber to turn on adb sideload

REM Reboot to recovery

"%FASTBOOT%" reboot recovery

echo Waiting for device to enter ADB sideload mode...

:wait_for_sideload
REM Check if sideload is available (output includes 'sideload')
"%ADB%" devices | findstr "sideload" >nul
if %errorlevel% neq 0 (
    timeout /t 5 >nul
    goto wait_for_sideload
)

echo Downloading magisk
cd "%~dp0..\bin\"
wget https://github.com/topjohnwu/Magisk/releases/download/v28.0/Magisk-v28.0.apk
REN Magisk-v28.0.apk Magisk-v28.0.zip
cd "%~dp0.."

echo Starting sideloading....
"%ADB%" sideload  "%~dp0..\bin\Magisk.zip"

pause

REM TODO

REM 1. Create an script
REM 2. Compile binaries for windows (2>1)
