$FASTBOOT = "$PSScriptRoot\..\adb\fastboot.exe"
$ADB = "$PSScriptRoot\..\adb\adb.exe"
$PayloadDumperGo = "$PSScriptRoot\..\bin\payload-dumper-go.exe"



function Show-Menu {
    Write-Host ""
    Write-Host "=================================================" -ForegroundColor DarkCyan
    Write-Host "             Flashing AIO By V       " -ForegroundColor White
    Write-Host "=================================================" -ForegroundColor DarkCyan

    # Flash Custom ROM Section
    Write-Host "== Flash Custom ROM ==" -ForegroundColor Yellow
    Write-Host "[1] Adb sideload   [2] Fastboot" -ForegroundColor Red

    Write-Host "-----------------------------------------------" -ForegroundColor DarkGray

    # Flash Images Section
    Write-Host "== Flash Images ==" -ForegroundColor Yellow
    Write-Host "[7] Vendor Boot     [8] Boot    [9] Stock ROM" -ForegroundColor Cyan

    Write-Host "-----------------------------------------------" -ForegroundColor DarkGray

    # Extract Section
    Write-Host "== Extract ==" -ForegroundColor Yellow
    Write-Host "[3] Vendor Boot    [4] Boot" -ForegroundColor Green

    Write-Host "-----------------------------------------------" -ForegroundColor DarkGray

    # Patch Section
    Write-Host "== Patch Boot ==" -ForegroundColor Yellow
    Write-Host "[5] KSU            [6] Magisk" -ForegroundColor Blue


    Write-Host "-----------------------------------------------" -ForegroundColor DarkGray

    # Miscellaneous Section
    Write-Host "== Miscellaneous ==" -ForegroundColor Yellow
    Write-Host "[10] Exit" -ForegroundColor Magenta

    Write-Host "=================================================" -ForegroundColor DarkCyan
    Write-Host ""

    $selection = Read-Host "Please select an option (1-10)"
    
    switch ($selection) {
        "1" { Clear-Host; Flash-ADB }
        "2" { Clear-Host; Flash-Fastboot }
        "3" { Clear-Host; Extract-VendorBoot }
        "4" { Clear-Host; Extract-Boot }
        "5" { Clear-Host; Patch-KSU }
        "6" { Clear-Host; Patch-Magisk }
        "7" { Clear-Host; Flash-VB }
        "8" { Clear-Host; Flash-Boot }
        "9" { Clear-Host; Flash-Stock }
        "10" { Clear-Host; Exit-Script }
        default { Write-Host "Invalid selection. Please try again." -ForegroundColor Red; Show-Menu }
    }
}

# Function to flash using adb sideload
function Flash-ADB {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Flashing Custom ROM with ADB Sideload " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "You will need to manually select 'adb sideload' in recovery." -ForegroundColor Green
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\flashADB.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to flash using fastboot
function Flash-Fastboot {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Flashing Custom ROM with Fastboot " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\flashFastboot.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to extract vendor boot
function Extract-VendorBoot {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Extracting Vendor Boot Image " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\extractVendorBoot.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to extract boot image
function Extract-Boot {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Extracting Boot Image " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\extractBoot.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to patch KSU
function Patch-KSU {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Patching Boot with KSU " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Boot into fastbootd mode for patching." -ForegroundColor Green
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\patchKSU.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to patch Boot with Magisk
function Patch-Magisk {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Patching Boot with Magisk " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\patchMagisk.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to flash Vendor boot
function Flash-VB {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Flashing Vendor Boot " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\flashVB.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to flash Boot
function Flash-Boot {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Flashing Boot Image " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\flashB.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to flash Stock ROM
function Flash-Stock {
    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host " Flashing Stock ROM " -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Extract flashing-AIO and stock firmware in the same folder." -ForegroundColor Green
    Write-Host "Press Enter to continue..." -ForegroundColor Magenta
    $null = Read-Host
    & "$PSScriptRoot\bats\flashStock.cmd"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "Press Enter to return to the Main Menu." -ForegroundColor Green
    $null = Read-Host
    Show-Menu
}

# Function to exit the script
function Exit-Script {
    Write-Host "===================================" -ForegroundColor Red
    Write-Host " Exiting the Script... " -ForegroundColor White
    Write-Host "===================================" -ForegroundColor Red
    exit
}

# Start the Menu
Show-Menu
