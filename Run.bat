@echo off
@SETLOCAL enabledelayedexpansion

set "FASTBOOT=%~dp0..\adb\fastboot.exe"
set "ADB=%~dp0..\adb\adb.exe"
set "Payload-dumper-go=%~dp0..\bin\payload-dumper-go.exe"

echo.
echo               Scirpt to automate repitive stuff
echo          The flash option flashes the images in fastbootd
echo    (it reboots automatically if the phone is in fastboot mode)
echo                          Made by V
echo.

:startMenu

    echo. ========================================================
    echo.                 FLASH CUSTOM ROM BY                     
    echo. [1] Adb sideload               [2] Fastboot             
    echo. ----------------------------------------------          
    echo. [3] Extract Vendor boot        [4] Extract Boot         
    echo. ----------------------------------------------          
    echo. [5] Patch Boot(KSU)            [6] Patch Boot(Magisk)   
    echo. ----------------------------------------------          
    echo. [7] Flash Vendor boot          [8] Flash Boot           
    echo. ----------------------------------------------          
    echo. [9] Flash stock rom            [10] Exit                
    echo. ========================================================
    echo.

    set selection=
    set /p selection= Please enter the option number: ^>^>

        if /i "%selection%"=="1" cls && call :flashADB
        if /i "%selection%"=="2" cls && call :flashFastboot
        if /i "%selection%"=="3" cls && call :extractVendorBoot
        if /i "%selection%"=="4" cls && call :extractBoot
        if /i "%selection%"=="5" cls && call :patchKSU
        if /i "%selection%"=="6" cls && call :patchMagisk
        if /i "%selection%"=="7" cls && call :flashVB
        if /i "%selection%"=="8" cls && call :flashB
        if /i "%selection%"=="9" cls && call :flashStock
        if /i "%selection%"=="10" cls && call :exit
    cls
goto :startMenu
::
::

:flashADB

    echo This will flash the custom rom using adb sideload
    echo You need to click the adb sideload button manually in recovery.
    echo Ths script will boot into recovery and start sideloading when adb sideload is turned on.
    echo Press any key to continue
    pause > nul

    call "%~dp0bats/flashADB.cmd"
       
    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:flashFastboot

    echo This will flash the custom rom using fastboot
    echo Press any key to continue

    pause > nul

    call "%~dp0bats/flashFastboot.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:extractVendorBoot
    echo Press any key to continue

    pause > nul

    call "%~dp0bats/extractVendorBoot.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:extractBoot
    echo Press any key to continue
    pause > nul

    call "%~dp0bats/extractBoot.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:patchKSU
    echo If you want to flash the boot image then boot in fastbootd mode.
    echo Press any key to continue
    pause > nul

    call "%~dp0bats/patchKSU.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:patchMagisk
    echo Currently this option flashes magisk zip using adb sideload
    echo Press any key to continue
    pause > nul

    call "%~dp0bats/patchMagisk.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0 


:flashVB
    echo Press any key to continue
    pause > nul

    call "%~dp0bats/flashVB.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:flashB
    echo Press any key to continue
    pause > nul

    call "%~dp0bats/flashB.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:flashStock

    echo It will flash stock rom using the commands that are present in flashfile.xml
    echo Extract flashing-AIO and stock firmware in the same folder
    echo Press any key to continue
    pause > nul

    call  "%~dp0bats/flashStock.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0  

:exit
exit
