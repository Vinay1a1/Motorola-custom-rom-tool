#!/bin/bash

# Set the path to the parent directory
PARENT_DIR="$(dirname "$0")/.."
OTA_ZIP=()
count=0

# Prompt the user to format data
if ! adb devices | grep -q "sideload"; then
    echo "Device is not in fastboot, format manually"
else
    read -p "Do you want to format data? (Y/N): " FORMAT_DATA
	if [[ "$FORMAT_DATA" =~ ^[Yy]$ ]]; then
    	echo "Formatting data..."
    	fastboot -w
	else
    	   echo "Skipping data format. Proceeding with flashing..."
fi

# Reboot the device into recovery mode
echo "Rebooting device into recovery mode..."
if ! adb devices | grep -q "sideload"; then
	fastboot reboot recovery
else
    echo "Device is in adb sideload mode"
fi

# Wait for the device to enter ADB sideload mode
echo "Waiting for device to enter ADB sideload mode..."
while ! adb devices | grep -q "sideload"; do
    sleep 5
done

# Look for any ZIP file in the parent directory
for f in "$PARENT_DIR"/*.zip; do
    if [[ -f "$f" ]]; then
        count=$((count + 1))
        echo "$count: $f"
        OTA_ZIP+=("$f")
    fi
done

# Check if an OTA ZIP file was found
if [[ $count -eq 0 ]]; then
    echo "No zips found in the parent directory."
    exit 1
fi

# Prompt user to select an image file to flash
while true; do
    read -p "Select the zip number to flash: " zip_choice
    if [[ $zip_choice -gt 0 && $zip_choice -le $count ]]; then
        OTA_ZIP="${OTA_ZIP[$((zip_choice - 1))]}"
        break
    else
        echo "Invalid choice. Please try again."
    fi
done

# Start sideloading the ROM ZIP file
echo "Device is in sideload mode. Starting sideload..."
adb sideload "$OTA_ZIP"

echo "Sideloading completed."
