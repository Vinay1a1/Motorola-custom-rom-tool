#!/bin/bash

# Set the path for KernelSU binary and magiskboot
ksud="./bin/ksud"
magiskboot="./bin/magiskboot.so"

PARENT_DIR="$(dirname "$0")/.."

# Find image files and display them with numbers
count=0
declare -A images
for img in "$PARENT_DIR"/*.img; do
    if [[ -f "$img" ]]; then
        ((count++))
        echo "$count: $img"
        images[$count]="$img"
    fi
done

if [[ $count -eq 0 ]]; then
    echo "No image files found in the parent directory."
    exit 1
fi

# Select boot image to flash
while true; do
    read -p "Enter the number of the boot image to use: " boot_choice
    boot_image="${images[$boot_choice]}"
    if [[ -n "$boot_image" ]]; then
        break
    else
        echo "Invalid choice. Please try again."
    fi
done

# Patch the boot image using KernelSU
echo "Patching the boot image using KernelSU..."
$ksud boot-patch -b "$boot_image" --magiskboot "$magiskboot" --kmi android12-5.10

if [[ $? -ne 0 ]]; then
    echo "Failed to patch boot image."
    exit 1
fi

# Check for the patched image file in the specified directory
PATCHED_IMG=$(find "$PARENT_DIR" -type f -name "kernelsu_patched_*.img" | head -n 1)

if [[ -z "$PATCHED_IMG" ]]; then
    echo "Patched image not found."
    exit 1
fi

echo "Patched boot image found: $PATCHED_IMG"

# Ask user if they want to flash the patched image
read -p "Do you want to flash the patched boot image? (y/n): " FLASH_CONFIRM
if [[ "$FLASH_CONFIRM" =~ ^[Yy]$ ]]; then
	if adb get-state &> /dev/null; then
    		echo "Rebooting to Fastboot..."
    		adb reboot fastboot
	else
    		echo "Device not in ADB mode. Proceeding with fastboot mode..."
	fi
fi

# Reboot into fastbootd mode
echo "Rebooting into fastbootd mode..."
fastboot reboot fastboot

echo "Flashing the patched boot image using fastboot..."
fastboot flash boot "$PATCHED_IMG"

echo "Process complete."

# Prompt for reboot to system
read -p "Flashing complete. Do you want to reboot the device to system now? (Y/N): " REBOOT
if [[ "$REBOOT" =~ ^[Yy]$ ]]; then
    fastboot reboot
    echo "Device is rebooting."
else
    # Ask if user wants to reboot to recovery
    read -p "Do you want to reboot to recovery? (Y/N): " RECOVERY
    if [[ "$RECOVERY" =~ ^[Yy]$ ]]; then
        fastboot reboot bootloader
        fastboot reboot recovery
        echo "Rebooting to recovery."
    else
        echo "Okay"
    fi
fi
