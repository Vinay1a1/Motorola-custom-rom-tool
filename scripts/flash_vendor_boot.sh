#!/bin/bash

# Find image files and display them with numbers
count=0
declare -A images
for img in ../*.img; do
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

# Check if ADB is connected
adb get-state 1>/dev/null 2>&1
if [[ $? -eq 0 ]]; then
    echo "Rebooting to Fastboot..."
    adb reboot fastboot
else
    echo "Device not connected. Please connect a device and try again."
    exit 1
fi

echo "Rebooting into fastbootd mode..."
fastboot reboot fastboot

# Select vendor_boot image to flash
while true; do
    read -p "Enter the number of the vendor_boot image to flash: " vendor_boot_choice
    vendor_boot_image="${images[$vendor_boot_choice]}"
    if [[ -n "$vendor_boot_image" ]]; then
        break
    else
        echo "Invalid choice. Please try again."
    fi
done

echo "Flashing vendor_boot.img..."
fastboot flash vendor_boot "$vendor_boot_image"

# Ask if the user wants to reboot to the system
read -p "Flashing complete. Do you want to reboot the device to the system now? (Y/N): " REBOOT
if [[ "$REBOOT" =~ ^[Yy]$ ]]; then
    fastboot reboot
    echo "Device is rebooting."
else
    echo "Please reboot the device manually when ready."
fi

# Ask if the user wants to reboot to recovery
read -p "Do you want to reboot to recovery? (Y/N): " RECOVERY
if [[ "$RECOVERY" =~ ^[Yy]$ ]]; then
    fastboot reboot bootloader
    fastboot reboot recovery
    echo "Rebooting to recovery."
else
    echo "You can reboot to recovery manually later."
fi

echo "Process complete."
