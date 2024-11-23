#!/bin/bash


# Find all .img files in the parent directory and store in an array
IMG_DIR="$(dirname "$0")/.."
image_files=()
count=0

for img_file in "$IMG_DIR"/*.img; do
    if [[ -f "$img_file" ]]; then
        count=$((count + 1))
        echo "$count: $img_file"
        image_files+=("$img_file")
    fi
done

if [[ $count -eq 0 ]]; then
    echo "No image files found in the parent directory."
    exit 1
fi

# Prompt user to select an image file to flash
while true; do
    read -p "Select the boot image number to flash: " boot_choice
    if [[ $boot_choice -gt 0 && $boot_choice -le $count ]]; then
        boot_image="${image_files[$((boot_choice - 1))]}"
        break
    else
        echo "Invalid choice. Please try again."
    fi
done

# Check if device is in ADB mode; if so, reboot to fastboot
if adb get-state &> /dev/null; then
    echo "Rebooting to Fastboot..."
    adb reboot fastboot
else
    echo "Device not in ADB mode. Proceeding with fastboot mode..."
fi

# Reboot into fastbootd mode
echo "Rebooting into fastbootd mode..."
fastboot reboot fastboot

# Flash the selected boot image
echo "Flashing selected boot image..."
fastboot flash boot "$boot_image"

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



