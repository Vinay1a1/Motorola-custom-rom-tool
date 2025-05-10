@echo off
setlocal enabledelayedexpansion

echo =====================================================================
echo Getting device information...
echo =====================================================================
fastboot reboot bootloader
timeout /t 5 >nul
echo ==========================================================================
echo    		[Getting Important Device Information]
echo ==========================================================================
echo.
set "UNLOCKDATA1="
for /f "tokens=*" %%i in ('fastboot oem get_unlock_data 2^>^&1 ^| findstr /v "OKAY Finished"') do (
    set "line=%%i"
    set "line=!line:(bootloader) =!"
    set "line=!line:Unlock data:=!"
    set "UNLOCKDATA1=!UNLOCKDATA1!!line!"
)
echo OEM_UNLOCK_DATA !UNLOCKDATA1!
set VARS=reason iswarrantyvoid: securestate: slot-suffixes carrier_sku ro.carrier: version-bootloader frp-state: current-slot: running-slot: product: ro.build.fingerprint slot-successful:_a slot-successful:_b slot-unbootable:_a slot-unbootable:_b slot-retry-count:_a slot-retry-count:_b serialno: ufs: ram: cpu: factory-modes: pcb-part-no: date uid: cid: channelid: chipid imei imei2 esimid
for %%V in (%VARS%) do (
    for /f "tokens=*" %%A in ('fastboot getvar %%V 2^>^&1') do (
        set "LINE=%%A"
        if not "!LINE!"=="" (
            echo !LINE! | findstr /I /V "Finished. Total time:" | findstr /I /V "version-bootloader: Done" | findstr /I /V "ro.build.fingerprint: Done" >nul
            if !errorlevel! == 0 (
                set "CLEAN_LINE=!LINE::=!"
                set "CLEAN_LINE=!CLEAN_LINE:(bootloader) =!"
                echo !CLEAN_LINE!
            )
        )
    )
)
echo ===========================================================================
echo           [All important device inforamtion extracted is above]
echo ===========================================================================
echo.
