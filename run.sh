#!/bin/bash
# Set the path for the scripts
SCRIPTS_DIR="$(dirname "$0")/scripts"
chmod +x $SCRIPTS_DIR/*.sh
#Main menu
show_menu() {
    echo =================================================
    echo            Flashing AIO By V
    echo =================================================
    # Flash Custom ROM Section
    echo == Flash Custom ROM ==
    echo [1] Adb sideload    [2] Fastboot
    echo -----------------------------------------------
    # Extract Section
    echo == Extract ==
    echo [3] Vendor Boot    [4] Boot
    echo -----------------------------------------------
    # Patch Section
    echo == Patch Boot ==
    echo [5] KSU            [6] Magisk
    echo ----------------------------------------------
    # Flash Images Section
    echo == Flash Images ==
    echo [7] Vendor Boot    [8] Boot    [9] Stock ROM
    echo -----------------------------------------------
    # Miscellaneous Section
    echo == Miscellaneous ==
    echo [10] Exit
    echo =================================================
    read -p "Please select an option (1-10): " selection
    case $selection in
        1) "$SCRIPTS_DIR/flash_adb_sideload.sh" ;;
        2) "$SCRIPTS_DIR/flash_fastboot.sh" ;;
        3) "$SCRIPTS_DIR/extract_vendor_boot.sh" ;;
        4) "$SCRIPTS_DIR/extract_boot.sh" ;;
        5) "$SCRIPTS_DIR/patch_ksu.sh" ;;
        6) "$SCRIPTS_DIR/patch_magisk.sh" ;;
        7) "$SCRIPTS_DIR/flash_vendor_boot.sh" ;;
        8) "$SCRIPTS_DIR/flash_boot.sh" ;;
        9) "$SCRIPTS_DIR/flash_stock.sh" ;;
        10) exit_script ;;
        *) echo "Invalid option. Please try again." ; sleep 2; show_menu ;;
    esac
}
# Function to exit the script
exit_script() {
    echo Exiting the script...
    exit 0
}
# Run the menu
show_menu
