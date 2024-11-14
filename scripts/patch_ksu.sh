#!/bin/bash

# Set the path for KernelSU binary and magiskboot
ksud="./bin/ksud"
magiskboot="./bin/magiskboot"

# Define the folder where the boot image is located
BOOT_IMG_DIR="../"

# Look for any boot image in the specified directory
BOOT_IMG="${BOOT_IMG_DIR}boot.img"

if [[ ! -f "$BOOT_IMG" ]]; then
    echo "No boot image found in the specified directory."
    exit 1
fi

echo "Found boot image: $BOOT_IMG"

# Patch the boot image using KernelSU
echo "Patching the boot image using KernelSU..."
$ksud boot-patch -b "$BOOT_IMG" --magiskboot "$magiskboot" --kmi android12-5.10

if [[ $? -ne 0 ]]; then
    echo "Failed to patch boot image."
    exit 1
fi

# Check for the patched image file in the specified directory
PATCHED_IMG=$(find "$BOOT_IMG_DIR" -type f -name "kernelsu_patched_*.img" | head -n 1)

if [[ -z "$PATCHED_IMG" ]]; then
    echo "Patched image not found."
    exit 1
fi

echo "Patched boot image found: $PATCHED_IMG"

# Ask user if they want to flash the patched image
read -p "Do you want to flash the patched boot image? (y/n): " FLASH_CONFIRM
if [[ "$FLASH_CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Flashing the patched boot image using fastboot..."
    fastboot flash boot "$PATCHED_IMG"

    if [[ $? -ne 0 ]]; then
        echo "Failed to flash patched boot image."
        exit 1
    fi

    echo "Patched boot image flashed successfully."
else
    echo "Flashing canceled."
fi

echo "Process complete."
