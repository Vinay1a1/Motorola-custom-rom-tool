@echo off
@setlocal enabledelayedexpansion

echo This will set platform tools to path so that can call it from anywhere. 

echo Checking for admin privileges.

echo Running as admin
cd '%~dp0'
:continue
echo Wait. Downloading platform tools.

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
