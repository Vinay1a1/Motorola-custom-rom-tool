@echo off
@SETLOCAL enabledelayedexpansion

set adb="%~dp0adb\adb.exe"
set payload-dumper-go="%~dp0..\bin\payload-dumper-go.exe"
set "FASTBOOT=%~dp0..\adb\fastboot.exe" 

echo.
echo Scirpt to automate repitive stuff
echo.

:startMenu

    echo. -------------------------------------------------------------------------------
    echo.
    echo. [1] Flash custom rom using adb sideload
    echo. [2] Flash custom rom using fastboot
    echo. [3] Extract vendor boot
    echo. [4] Extract boot image
    echo. [5] Patch boot image using KSU
    echo. [6] Patch boot image using Magisk
    echo. [7] Flash vendor boot using fastbootd
    echo. [8] Flash boot image using fastbootd
    echo. [9] Flash stock rom
    echo. [10] Exit
    echo.
    echo -------------------------------------------------------------------------------
    echo.
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
    echo Press any key to continue
    pause > nul

    call "%~dp0bats/patchKSU.cmd"

    echo.
    echo Press any key to return to the Main menu.
    pause > nul
exit /b 0


:patchMagisk
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