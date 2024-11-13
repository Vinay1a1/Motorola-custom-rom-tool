@echo off
setlocal enabledelayedexpansion

set "FASTBOOT=%~dp0..\adb\fastboot.exe"  

REM Flashing images using  fastboot
    echo Flashing images using  fastboot...
 
   "%FASTBOOT%" flash gpt PGPT
   "%FASTBOOT%" flash preloader preloader.img
   "%FASTBOOT%" flash lk_a lk.img
   "%FASTBOOT%" flash tee_a tee.img
   "%FASTBOOT%" flash mcupm_a mcupm.img
   "%FASTBOOT%" flash pi_img_a pi_img.img
   "%FASTBOOT%" flash sspm_a sspm.img
   "%FASTBOOT%" flash dtbo_a dtbo.img
   "%FASTBOOT%" flash logo_a logo.img
   "%FASTBOOT%" erase nvdata
   "%FASTBOOT%" flash spmfw_a spmfw.img
   "%FASTBOOT%" flash scp_a scp.img
   "%FASTBOOT%" flash vbmeta_a vbmeta.img
   "%FASTBOOT%" flash vbmeta_system_a vbmeta_system.img
   "%FASTBOOT%" flash md1img_a md1img.img
   "%FASTBOOT%" flash dpm_a dpm.img
   "%FASTBOOT%" flash gz_a gz.img
   "%FASTBOOT%" flash vcp_a vcp.img
   "%FASTBOOT%" flash gpueb_a gpueb.img
   "%FASTBOOT%" flash efuseBackup efuse.img
   "%FASTBOOT%" flash boot_a boot.img
   "%FASTBOOT%" flash vendor_boot_a vendor_boot.img
   "%FASTBOOT%" flash super super.img_sparsechunk.0
   "%FASTBOOT%" flash super super.img_sparsechunk.1
   "%FASTBOOT%" flash super super.img_sparsechunk.2
   "%FASTBOOT%" flash super super.img_sparsechunk.3
   "%FASTBOOT%" flash super super.img_sparsechunk.4
   "%FASTBOOT%" flash super super.img_sparsechunk.5
   "%FASTBOOT%" flash super super.img_sparsechunk.6
   "%FASTBOOT%" flash super super.img_sparsechunk.7
   "%FASTBOOT%" flash super super.img_sparsechunk.8
   "%FASTBOOT%" flash super super.img_sparsechunk.9
   "%FASTBOOT%" flash super super.img_sparsechunk.10
   "%FASTBOOT%" flash super super.img_sparsechunk.11
   "%FASTBOOT%" flash super super.img_sparsechunk.12
   "%FASTBOOT%" flash super super.img_sparsechunk.13
   "%FASTBOOT%" flash super super.img_sparsechunk.14
   "%FASTBOOT%" flash super super.img_sparsechunk.15
   "%FASTBOOT%" flash super super.img_sparsechunk.16
   "%FASTBOOT%" flash super super.img_sparsechunk.17
   "%FASTBOOT%" flash super super.img_sparsechunk.18
   "%FASTBOOT%" erase debug_token

set /p FORMAT_DATA="Do you want to format data? (Y/N): "
if /i "%FORMAT_DATA%"=="Y" (
    echo Formatting data...
    "%FASTBOOT%" erase userdata
    "%FASTBOOT%" erase metadata
) else (
    echo Skipping data format. Proceeding with flashing...
)

echo Flashing complete. 
echo You can reboot now.

pause
