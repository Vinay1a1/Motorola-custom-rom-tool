#!/bin/bash

# Set the path for the scripts
SCRIPTS_DIR="$(dirname "$0")/scripts"

# Function to print text with color
print_with_color() {
    local text=$1
    local color=$2
    case $color in
        "cyan") echo -e "\033[36m$text\033[0m" ;;
        "yellow") echo -e "\033[33m$text\033[0m" ;;
        "green") echo -e "\033[32m$text\033[0m" ;;
        "blue") echo -e "\033[34m$text\033[0m" ;;
        "red") echo -e "\033[31m$text\033[0m" ;;
        "magenta") echo -e "\033[35m$text\033[0m" ;;
        "darkgray") echo -e "\033[90m$text\033[0m" ;;
        *) echo "$text" ;;
    esac
}

# Main menu
show_menu() {
    clear
    print_with_color "=================================================" "cyan"
    print_with_color "            Flashing AIO By V" "white"
    print_with_color "=================================================" "cyan"
    
    # Flash Custom ROM Section
    print_with_color "== Flash Custom ROM ==" "yellow"
    print_with_color "[1] Adb sideload    [2] Fastboot" "red"
    print_with_color "-----------------------------------------------" "darkgray"

    # Flash Images Section
    print_with_color "== Flash Images ==" "yellow"
    print_with_color "[7] Vendor Boot    [8] Boot    [9] Stock ROM" "cyan"
    print_with_color "-----------------------------------------------" "darkgray"

    # Extract Section
    print_with_color "== Extract ==" "yellow"
    print_with_color "[3] Vendor Boot    [4] Boot" "green"
    print_with_color "-----------------------------------------------" "darkgray"

    # Patch Section
    print_with_color "== Patch Boot ==" "yellow"
    print_with_color "[5] KSU            [6] Magisk" "blue"
    print_with_color "-----------------------------------------------" "darkgray"

    # Miscellaneous Section
    print_with_color "== Miscellaneous ==" "yellow"
    print_with_color "[10] Exit" "magenta"
    print_with_color "=================================================" "cyan"
    
    echo
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
    print_with_color "Exiting the script..." "red"
    exit 0
}

# Run the menu
show_menu
