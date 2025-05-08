@echo off
setlocal enabledelayedexpansion 

REM Flashing images using  fastboot
    echo Flashing images using  fastboot...
 
   fastboot flash gpt PGPT
   fastboot flash preloader preloader.img
   fastboot flash lk_a lk.img
   fastboot flash tee_a tee.img
   fastboot flash mcupm_a mcupm.img
   fastboot flash pi_img_a pi_img.img
   fastboot flash sspm_a sspm.img
   fastboot flash dtbo_a dtbo.img
   fastboot flash logo_a logo.img
   fastboot erase nvdata
   fastboot flash spmfw_a spmfw.img
   fastboot flash scp_a scp.img
   fastboot flash vbmeta_a vbmeta.img
   fastboot flash vbmeta_system_a vbmeta_system.img
   fastboot flash md1img_a md1img.img
   fastboot flash dpm_a dpm.img
   fastboot flash gz_a gz.img
   fastboot flash vcp_a vcp.img
   fastboot flash gpueb_a gpueb.img
   fastboot flash efuseBackup efuse.img
   fastboot flash boot_a boot.img
   fastboot flash vendor_boot_a vendor_boot.img

   for /l %%i in (0,1,18) do (
    fastboot flash super super.img_sparsechunk.%%i
)
   fastboot erase debug_token

set /p FORMAT_DATA="Do you want to format data? (Y/N): "
if /i "%FORMAT_DATA%"=="Y" (
    echo Formatting data...
    fastboot erase userdata
    fastboot erase metadata
) else (
    echo Skipping data format. Proceeding with flashing...
)

echo Flashing complete. 
echo You can reboot now.

pause
