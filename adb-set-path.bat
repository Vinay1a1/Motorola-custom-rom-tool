@echo off
@setlocal enabledelayedexpansion

echo This will set platform tools to path so that can call it from anywhere. 

echo Checking for admin privileges.

net session
If %ERRORLEVEL% neq 0 (
echo Run this script as an administrator 
pause)
goto continue

echo Running as admin

echo Wait. Downloading platform tools.

:continue
curl -o platform-tools.zip https://dl.google.com/android/repository/platform-tools-latest-windows.zip
echo Unzipping

powershell -Command "Expand-Archive platform-tools.zip '%~dp0'"

echo Creating a folder named platform tools in %USERPROFILE%

mkdir "%USERPROFILE%\platform-tools"

echo copying files
robocopy "%~dp0platform-tools" "%USERPROFILE%\platform-tools" /E


echo setting it to path

setx /M path "%path%;%USERPROFILE%\platform-tools"

echo Done. Now open run.bat

pause
