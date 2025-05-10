@echo off
setlocal enabledelayedexpansion
echo.
for /f "tokens=2 delims=: " %%i in ('fastboot getvar current-slot 2^>^&1 ^| findstr "current-slot"') do (
    set "current_slot=%%i"
)
if defined current_slot (
    echo Current Active slot: %current_slot%
) else (
    color c
    echo Unable to detect current active slot.
)
echo.
set /p "slot=Enter target slot (a/b): "
fastboot set_active %slot%
echo.
