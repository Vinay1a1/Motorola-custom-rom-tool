@echo off
setlocal enabledelayedexpansion


echo ----------------------------------------------------------------------------------------------------------
echo Are you sure you have the right stock firmware? 
echo If you flash a wrong firmware you may brick your device.
echo It will flash only the stock firmware (no superchunk or eFuseBackup)
echo Please be careful of all anti-rollback features. 
echo As a general rule, DO NOT attempt to FLASH ANYTHING BELOW A14 May 2024 Patch U1TDS34.94-12-7-5 
echo IF your phone is CURRENTLY HAVING BOOTLOADER HIGHER than OR EQUAL to A14 May 2024 Patch U1TDS34.94-12-7-5
echo you may find your current bootloader version using option i. Get Device Info to assist you
echo if unsure, please ask for help before proceeding further.
echo ----------------------------------------------------------------------------------------------------------
pause

echo Rebooting into bootloader mode to be able to flash stock firmware.
fastboot reboot bootloader
timeout /t 2 >nul
echo.
fastboot flash gpt PGPT 
fastboot flash preloader preloader.img

fastboot flash lk_a lk.img
fastboot flash lk_b lk.img
fastboot flash lk lk.img

fastboot flash tee_a tee.img
fastboot flash tee_b tee.img
fastboot flash tee tee.img

fastboot flash mcupm_a mcupm.img
fastboot flash mcupm_b mcupm.img
fastboot flash mcupm mcupm.img

fastboot flash pi_img_a pi_img.img
fastboot flash pi_img_b pi_img.img
fastboot flash pi_img pi_img.img

fastboot flash sspm_a sspm.img
fastboot flash sspm_b sspm.img
fastboot flash sspm sspm.img

fastboot flash dtbo_a dtbo.img
fastboot flash dtbo_b dtbo.img
fastboot flash dtbo dtbo.img

fastboot flash logo_a logo.img
fastboot flash logo_b logo.img
fastboot flash logo logo.img

fastboot flash spmfw_a spmfw.img
fastboot flash spmfw_b spmfw.img
fastboot flash spmfw spmfw.img

fastboot flash scp_a scp.img
fastboot flash scp_b scp.img
fastboot flash scp scp.img

fastboot flash vbmeta_a vbmeta.img
fastboot flash vbmeta_b vbmeta.img
fastboot flash vbmeta vbmeta.img

fastboot flash vbmeta_system_a vbmeta_system.img
fastboot flash vbmeta_system_b vbmeta_system.img
fastboot flash vbmeta_system vbmeta_system.img

fastboot flash md1img_a md1img.img
fastboot flash md1img_b md1img.img
fastboot flash md1img md1img.img

fastboot flash dpm_a dpm.img
fastboot flash dpm_b dpm.img
fastboot flash dpm dpm.img

fastboot flash gz_a gz.img
fastboot flash gz_b gz.img
fastboot flash gz gz.img

fastboot flash vcp_a vcp.img
fastboot flash vcp_b vcp.img
fastboot flash vcp vcp.img

fastboot flash gz_a gz.img
fastboot flash gz_b gz.img
fastboot flash gz gz.img

fastboot flash vcp_a vcp.img
fastboot flash vcp_b vcp.img
fastboot flash vcp vcp.img

fastboot flash gpueb_a gpueb.img
fastboot flash gpueb_b gpueb.img
fastboot flash gpueb gpueb.img

fastboot flash boot_a boot.img
fastboot flash boot_b boot.img
fastboot flash boot boot.img

fastboot flash vendor_boot_a vendor_boot.img
fastboot flash vendor_boot_b vendor_boot.img
fastboot flash vendor_boot vendor_boot.img
echo.

echo.
echo Stock firmware flashing process completed, No data was reset, nor superchunk images flashed.
echo. 
